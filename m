Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] IPC negative tester
Date: Mon, 13 Jan 2014 11:36:55 +0100
Message-Id: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patchset adds IPC negative tester framework with few test cases
checking IPC's behaviour on daemon side. Expected daemon's behaviour is to
shut down gracefully in case of receiving invalid IPC data.

Jakub Tyszkowski (7):
  android/ipc-tester: Skeleton for ipc negative tester
  android/ipc-tester: Run daemon in separate process
  android/ipc-tester: Add IPC initialization
  android/ipc-tester: Add daemon shutdown handler
  android/ipc-tester: Add sending test data with ipc
  android/ipc-tester: Register services
  android/ipc-tester: Add basic negative test cases for IPC's daemon
    site

 .gitignore                    |   1 +
 android/Makefile.am           |  17 ++
 android/ipc-negative-tester.c | 675 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 693 insertions(+)
 create mode 100644 android/ipc-negative-tester.c

--
1.8.5

