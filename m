Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 00/11] IPC negative tester
Date: Mon, 20 Jan 2014 10:35:59 +0100
Message-Id: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patchset adds IPC negative tester framework along with test cases
checking IPC's behaviour on daemon side. Expected daemon's behaviour is to
shut down gracefully in case of receiving invalid IPC data.

v2 changes:
  * fixed few indentation issues
  * fixed missing __attribute__((packed))
  * fixed amount of data written for 'malformed data' test case
  * fixed opcode for 'invalid service' test case
  * added patch(8) with more 'malformed data' cases

v3 changes:
  * changed license to GPL
  * changed 'ipc-negative-tester' name to 'ipc-tester'

v4 changes:
  * fixed typo in first test case and last commit's message
  * fixed daemon shutdown handler function

v5 changes:
  * added clean up in case of setup failure
  * added test execution macro enhancement for easy data creation
  * added test cases for core BT interfaces (Patches: 9, 10, 11)

Jakub Tyszkowski (11):
  android/ipc-tester: Skeleton for ipc negative tester
  android/ipc-tester: Run daemon in separate process
  android/ipc-tester: Add IPC initialization
  android/ipc-tester: Add daemon shutdown handler
  android/ipc-tester: Add sending test data with ipc
  android/ipc-tester: Register services
  android/ipc-tester: Add basic test cases for IPC's daemon site
  android/ipc-tester: Add more cases for malformed data
  android/ipc-tester: Add cases for service opcode boundaries
  android/ipc-tester: Add cases for Core message data size
  android/ipc-tester: Add cases for BT message data size

 .gitignore           |   1 +
 android/Makefile.am  |  17 +
 android/ipc-tester.c | 868 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 886 insertions(+)
 create mode 100644 android/ipc-tester.c

--
1.8.5.2

