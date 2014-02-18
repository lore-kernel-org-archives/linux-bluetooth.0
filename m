Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/6] RFCOMM data transfer support in bthost
Date: Tue, 18 Feb 2014 08:50:49 +0100
Message-Id: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:
 - Added rfcomm prefixes in API functions and internal structs
 - Values returned by read() and write stored in local variables
for clarity
 - Few coding style fixes

Marcin Kraglak (6):
  emulator/bthost: Add api to handle RFCOMM data on bthost
  tools/rfcomm-tester: Add RFCOMM client write test case
  tools/rfcomm-tester: Add RFCOMM server write test case
  emulator/bthost: Add function to send RFCOMM UIH frames from bthost
  tools/rfcomm-tester: Add RFCOMM client read test case
  tools/rfcomm-tester: Add RFCOMM server read test case

 emulator/bthost.c     | 167 ++++++++++++++++++++++++++++++++++++++-
 emulator/bthost.h     |  13 ++++
 tools/rfcomm-tester.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 387 insertions(+), 5 deletions(-)

-- 
1.8.3.1

