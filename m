Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:10:31 -0400
Subject: [PATCH 0/7] Fix various lost wakeups
Message-ID: <1311480631.4106.25.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Several kthreads, and some other functions which also wait/sleep, exhibit
race conditions when using set_current_state(TASK_INTERRUPTIBLE). A common,
but incorrect, usage pattern is:

1:  add_wait_queue(...);
2:  while (!condition) {
3:          set_current_state(TASK_INTERRUPTIBLE);
4:          do_work();
5:          schedule();
6:  }
7:  set current_state(TASK_RUNNING);
8:  remove_wait_queue(...); 

The problem here develops after line 2 executes but before line 3 executes.
If, at this point, another task now sets the 'condition' and issues a wakeup
for the first task, it will be 'lost' as line 3 is now executed (ie, the
task is moved off the run queue).

A more robust general pattern is:

 1:  add_wait_queue(...);
 2:  while (1) {
 3:          set_current_state(TASK_INTERRUPTIBLE);
 4:          if (condition)
 5:                  break;
 6:          do_work();
 7:          schedule();
 8:  }
 9:  set current_state(TASK_RUNNING);
10:  remove_wait_queue(...); 

This pattern also allows for multiple-condition tests without further
complications.

Another usage pattern without race conditions:

 1:  add_wait_queue(...);
 2:  set_current_state(TASK_INTERRUPTIBLE);
 3:  while (!condition) {
 4:          do_work();
 5:          schedule();
 6:          set_current_state(TASK_INTERRUPTIBLE);
 7:          if (condition2)
 8:                  break;
 9:  }
10:  set current_state(TASK_RUNNING);
11:  remove_wait_queue(...); 

This approach is required when condition2 is only valid after sleeping,
for example.

Regards,
Peter

PS - I did not fix the usage in l2cap_core.c pending if the new ERTM
reassembly will make that work unnecessary.


Peter Hurley (7):
  Bluetooth: rfcomm: Remove unnecessary krfcommd event
  Bluetooth: rfcomm: Fix lost wakeups waiting to accept socket
  Bluetooth: Fix lost wakeups waiting for sock state change
  Bluetooth: l2cap: Fix lost wakeups waiting to accept socket
  Bluetooth: sco: Fix lost wakeups waiting to accept socket
  Bluetooth: bnep: Fix lost wakeup of session thread
  Bluetooth: cmtp: Fix lost wakeup of session thread

 net/bluetooth/af_bluetooth.c |    6 +++---
 net/bluetooth/bnep/core.c    |    6 ++++--
 net/bluetooth/cmtp/core.c    |    6 ++++--
 net/bluetooth/l2cap_sock.c   |   28 ++++++++++++++--------------
 net/bluetooth/rfcomm/core.c  |   17 +++++++----------
 net/bluetooth/rfcomm/sock.c  |   28 ++++++++++++++--------------
 net/bluetooth/sco.c          |   28 ++++++++++++++--------------
 7 files changed, 60 insertions(+), 59 deletions(-)

-- 
1.7.4.1

