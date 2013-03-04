Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: rfcomm example setup
Date: Mon, 04 Mar 2013 11:42:56 -0500
Message-ID: <87ip57une7.fsf@randy.site>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Can someone please point me to an example of the bind, listen, and
accept structures and parameters for setting up an RFCOMM socket using
file descriptor (fd) received from the NewConnection() method in
profile-api.txt? 

I tried the setup in "Bluetooth Essentials for Programmers," omitting
the socket() call (since bluez provides the fd) but it's crashing right
at the bind() call (never reaches the "bt 0.1" fprintf()). See
attachment.
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=btsocketthread.c

#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include "tacii-bt.h"
#include "tacii-thread.h"
#include "threadqueue.h"
#include "btsocketthread.h"

#define BTSOCKET_TX_QUEUE_LENGTH 1024 /* just a guess... */
#define BTSOCKET_TX_QUEUE_ENTRY_DATA_LENGTH (BTSOCKET_RECV_BUF_LENGTH + sizeof(BTSOCKET_MSG_TX_T))

void* BTSocketWThread(void* arg)
{
  THREAD_T thisThread;
  THREAD_T* thread;
  sem_t threadDataReady;
  int32_t phoneSocket;
  char  buf[BTSOCKET_RECV_BUF_LENGTH];
  THREAD_QUEUE_ENTRY_T threadQueueEntry;
  uint8_t threadQueueEntryData[BTSOCKET_TX_QUEUE_ENTRY_DATA_LENGTH];
  struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
  uint32_t opt = sizeof(rem_addr);
  uint32_t nBytes;
  BTSOCKET_MSG_TX_T* btsocketMessageTx;

  /* initialize thread structure and pointer */
  thread = &thisThread;
  memset(&thisThread, 0, sizeof(thisThread));

  /* malloc queue entries memory */
  thread->threadQueue.queueEntries = calloc(BTSOCKET_TX_QUEUE_LENGTH, sizeof(THREAD_QUEUE_ENTRY_T));
  /* set queue length */
  thread->threadQueue.queueLength = BTSOCKET_TX_QUEUE_LENGTH;

  /* initialize queue mutexes */
  if (pthread_mutex_init(&thread->threadQueue.queueMutex, 0))
  {
    perror("mutex won't initialize");
    pthread_exit(NULL);
  }

  /* initialize pointers */
  thread->threadQueue.nPut = 0;
  thread->threadQueue.nGet = 0;

  /* initialize threadDataReady semaphore */
  sem_init(&threadDataReady, SEM_SHARED_BETWEEN_THREADS, 0);
  thread->threadDataReady = &threadDataReady;

  /* set the managerDataReady pointer to NULL to get ready to synchronize with the manager */
  thread->managerDataReady = NULL;

  /*
   * set the thread pointer to non-null. this signals to the manager thread that the worker thread is initialized and is ready
   * to go
   */
  *((THREAD_T**)arg) = thread;

  /*
   * wait for the manager thread to set the managerDataReady semaphore pointer to non-NULL
   */
  while (!thread->managerDataReady)
  {
    usleep(100);  /* 100 microseconds */
  }
  fprintf(stderr, "##################btsocket thread synced\n");

  /*
   * setup thread-specific data structures 
   */

  /* initialize thread entry data pointer */
  threadQueueEntry.data = threadQueueEntryData;
  btsocketMessageTx = (BTSOCKET_MSG_TX_T*)(&threadQueueEntryData[0]);
  fprintf(stderr, "bt 0.0\n");

  /*
   * --------------------
   * Setup tacii btsocket
   * --------------------
   */
  loc_addr.rc_family = AF_BLUETOOTH;
  loc_addr.rc_bdaddr = *BDADDR_ANY;
  loc_addr.rc_channel = 5;
  bind(((BTSOCKETWTHREAD_T*)thread->threadData)->fd, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
  fprintf(stderr, "bt 0.1\n");

  // put socket into listening mode
  listen(((BTSOCKETWTHREAD_T*)thread->threadData)->fd, 1);
  fprintf(stderr, "bt 0.2\n");

  // accept one connection
  phoneSocket = accept(((BTSOCKETWTHREAD_T*)thread->threadData)->fd, (struct sockaddr *)&rem_addr, &opt);
  fprintf(stderr, "bt 0.3\n");

  ba2str(&rem_addr.rc_bdaddr, buf);
  fprintf(stderr, "Got RFCOMM connection from remote device %s\n", buf);

  /* queue the accept()'ed fd and bdaddr to the manager thread so he can start BTSocketRThread */
  threadQueueEntry.length = sizeof(BTSOCKET_MSG_TX_ADMIN_CONNECTED_T);
  *btsocketMessageTx = BTSOCKET_MSG_TX_ADMIN_CONNECTED;
  memcpy(&threadQueueEntryData[sizeof(BTSOCKET_MSG_TX_T)], &rem_addr.rc_bdaddr, sizeof(rem_addr.rc_bdaddr));
  memcpy(&threadQueueEntryData[sizeof(BTSOCKET_MSG_TX_T) + sizeof(rem_addr.rc_bdaddr)], &phoneSocket, sizeof(phoneSocket));
  ThreadQueuePutEntryPost(&thread->threadQueue, &threadQueueEntry, thread->managerDataReady);

  /******** main event loop ********/
  while (1)
  {
    /* recv() blocks */
    nBytes = recv(phoneSocket, buf, BTSOCKET_RECV_BUF_LENGTH, 0);

    if (nBytes == 0)
    {
      /* queue a disconnect essage */
      threadQueueEntry.length = sizeof(BTSOCKET_MSG_TX_ADMIN_DISCONNECTED_T);
      *btsocketMessageTx = BTSOCKET_MSG_TX_ADMIN_DISCONNECTED;
      ThreadQueuePutEntryPost(&thread->threadQueue, &threadQueueEntry, thread->managerDataReady);
      /* wait for thread queue count to go to zero, then destruct */
      while (!ThreadQueueEmpty(&thread->threadQueue))
      {
        usleep(100);
      }

      /* free all resources */
      close(phoneSocket);
      close(((BTSOCKETWTHREAD_T*)thread->threadData)->fd);
      free(thread->threadQueue.queueEntries);

      /* note this is a detached thread, so a pthread_join is not necessary in the manager thread */
      return NULL;
    }

    /* queue a client message */
    threadQueueEntry.length = sizeof(BTSOCKET_MSG_TX_T) + nBytes;
    *btsocketMessageTx = BTSOCKET_MSG_TX_CLIENT;
    memcpy(&threadQueueEntry.data[sizeof(BTSOCKET_MSG_TX_T)], buf, nBytes);
    ThreadQueuePutEntryPost(&thread->threadQueue, &threadQueueEntry, thread->managerDataReady);
  }

  return NULL;
}

--=-=-=--
