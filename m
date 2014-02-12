Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] RFCOMM data transfer support in bthost
Date: Wed, 12 Feb 2014 12:41:35 +0100
Message-Id: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Below changes allow to test RFCOMM data transfer and add
simple test to check it. Two new functions are added
to bthost API: bthost_add_channel_hook(), which handles
data received on bthost on specific channel and connection
handle and bthost_send_uih(), which forms RFCOMM UIH frame
and send it.
These changes depends on previous fixes with frame length checks.

Comments are welcome

Regards

Marcin Kraglak (6):
  emulator/bthost: Add api to handle RFCOMM data on bthost
  tools/rfcomm-tester: Add RFCOMM client write test case
  tools/rfcomm-tester: Add RFCOMM server write test case
  emulator/bthost: Add function to send RFCOMM UIH frames from bthost
  tools/rfcomm-tester: Add RFCOMM client read test case
  tools/rfcomm-tester: Add RFCOMM server read test case

 emulator/bthost.c     | 113 +++++++++++++++++++++++++++--
 emulator/bthost.h     |  11 +++
 tools/rfcomm-tester.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 313 insertions(+), 5 deletions(-)

-- 
1.8.3.1

