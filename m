Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/6] Set of patches implementing missing IPC functionality
Date: Mon, 21 Oct 2013 14:28:31 +0300
Message-Id: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is my set of patches rebased against very recent bluez.git
(most probably there might be some issues related to style used).

These patches add some missing capability to the process, add basic IPC server
and client. Daemon listens for incoming connections from HALs so it acts
as a server, while HALs connect and act as client. Please advise what
are better names for hal-msg and hal-msg-client, should some code be moved
to adapter.c?

Andrei Emeltchenko (6):
  android: Add capabilities and set userid
  android: Handle mgmt changed events
  android: Implement basic HAL server
  android: Add HAL message helpers
  android: Add helper to send fd using SCM_RIGHTS
  android: Add Android HAL callback task

 Makefile.android         |    2 +-
 android/Android.mk       |    9 ++
 android/adapter.c        |  129 ++++++++++++++++++++++
 android/bt-sock.c        |   64 +++++++++++
 android/hal-cb-thread.c  |   86 +++++++++++++++
 android/hal-msg-client.c |  123 +++++++++++++++++++++
 android/hal-msg-client.h |   25 +++++
 android/hal-msg.c        |  267 ++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h        |    5 +
 android/main.c           |   69 ++++++++++++
 configure.ac             |    4 +
 11 files changed, 782 insertions(+), 1 deletion(-)
 create mode 100644 android/bt-sock.c
 create mode 100644 android/hal-cb-thread.c
 create mode 100644 android/hal-msg-client.c
 create mode 100644 android/hal-msg-client.h
 create mode 100644 android/hal-msg.c

-- 
1.7.10.4

