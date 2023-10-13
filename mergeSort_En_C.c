#include <stdio.h>
void merge(int A[],int inicio, int mitad, int fin){
    int i,j,k;
    int tam1 = mitad-inicio +1;
    int tam2 = fin-mitad;
    int L[tam1];
    int R[tam2];
    for(i=0;i<tam1;i++){
        L[i] = A[inicio+i];
    }
    for(j=0;j<tam2;j++){
        R[j] = A[mitad+j+1];
    }
    i=0;
    j=0;
    k=inicio;
    while(i<tam1 && j<tam2){
        if(L[i]<=R[j]){
            A[k] = L[i];
            i++;
        }else{
            A[k] = R[j];
            j++;
        }
        k++;
    }
    while(i<tam1){
        A[k] = L[i];
        i++;
        k++;
    }
    while(j<tam2){
        A[k] = R[j];
        j++;
        k++;
    }
}
void mergeSort(int A[],int inicio, int fin){
    if(inicio < fin){
        int mitad = inicio + (fin-inicio) /2;
        mergeSort(A,inicio,mitad);
        mergeSort(A,mitad+1,fin);
        merge(A,inicio,mitad,fin);
    }
}

int main()
{
    int A[] = {5, 3, 1, 6, 4, 2, 4, 7, 6, 4};
    int tam = sizeof(A)/sizeof(A[0]);
    mergeSort(A,0,tam-1);
    return 0;
}