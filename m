Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 21:30:15 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Workqueue patches merged
Message-ID: <20111218233015.GD2621@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Everyone,

I would like to inform you that conversion from tasklets to workqueues are now
merged into bluetooth-next. Those patches move all Bluetooth processing to the
process context, thus it makes the manipulation of Bluetooth data much more
easier. We were able to make locking more sane, and some of them were even
changed to use RCU.
In the end only the rx/tx works were kept at the hdev->workqueue, all others
works were moved to the system workqueue. In the future, if the need arises we
can create a global workqueue for random works.

Some work is still missing, like:

 - make sure SCO, SMP, BNEP and HIDP are working.
 - work on mod_delayed_queue() to improve our timers usage
 - proper chan_put/chan_hold in l2cap_set_timer/clear_timer
 - use GFP_KERNEL where possible
 - Look for improvements in the locking system
 - some other places needs move to workqueue, like the security timer in l2cap

I also would like to ask you to rebase your code on top of this and re-submit
it to the mailing list. I know this a is a bit painful now, but it will help
development a lot from now on. If we move fast here we still can make 3.3 for
most of your patches. I'm waiting your patches!

And please, test this. We need to make sure we are not breaking anything here.

These are the workqueue patches btw:

Gustavo F. Padovan (22):
      Bluetooth: Replace spin_lock by mutex in hci_dev
      Bluetooth: Use delayed_work for connection timeout
      Bluetooth: Use delayed work for advertisiment cache timeout
      Bluetooth: hci_conn_auto_accept() doesn't need locking
      Bluetooth: Move L2CAP timers to workqueue
      Bluetooth: Don't use spin_lock socket lock anymore
      Bluetooth: Remove sk_backlog usage from L2CAP
      Bluetooth: move hci_task_lock to mutex
      Bluetooth: convert chan_lock to mutex
      Bluetooth: Use RCU to manipulate chan_list
      Bluetooth: convert conn hash to RCU
      Bluetooth: Don't disable tasklets to call hdev->notify()
      Bluetooth: Move command task to workqueue
      Bluetooth: convert tx_task to workqueue
      Bluetooth: convert info timer to delayed_work
      Bluetooth: invert locking order in connect path
      Bluetooth: Change l2cap chan_list to use RCU
      Bluetooth: move power_off to system workqueue
      Bluetooth: Use new alloc_workqueue()
      Bluetooth: Remove work_add and work_del from hci_sysfs
      Bluetooth: Use system workqueue to schedule power_on
      Bluetooth: Add ProFUSION's copyright

Marcel Holtmann (1):
      Bluetooth: Process recv path in a workqueue instead of a tasklet

	Gustavo
