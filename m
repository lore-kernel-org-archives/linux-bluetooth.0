Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/8] IPC negative tester
Date: Thu, 16 Jan 2014 09:38:24 +0100
Message-Id: <1389861512-2326-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patchset adds IPC negative tester framework with few test cases
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

Jakub Tyszkowski (8):
  android/ipc-tester: Skeleton for ipc negative tester
  android/ipc-tester: Run daemon in separate process
  android/ipc-tester: Add IPC initialization
  android/ipc-tester: Add daemon shutdown handler
  android/ipc-tester: Add sending test data with ipc
  android/ipc-tester: Register services
  android/ipc-tester: Add basic test cases for IPC's daemon site
  android/ipc-tester: Add more cases for malformed data

 .gitignore           |   1 +
 android/Makefile.am  |  17 ++
 android/ipc-tester.c | 713 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 731 insertions(+)
 create mode 100644 android/ipc-tester.c

--
1.8.5.2

