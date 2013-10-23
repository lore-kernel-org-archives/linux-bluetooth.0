Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/7] Initial code for hal hid host
Date: Wed, 23 Oct 2013 00:41:52 -0700
Message-Id: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch set is all about initial code for hal hidhost interfaces which
are .virtual_unplug, .set_info, .get_protocol, .set_protocol,
.get_report, .set_report and .send_data. Also includes issue fixes
for .connect and .disconnect interfaces.
---
_v2 is about fixing issues as per Johan comments.

Ravi kumar Veeramally (7):
  android: Return right from hal_ipc_cmd call in hal hid connect
  android: Return right from hal_ipc_cmd call in hal hid disconnect
  android: Add initial code for hidhost virtual unplug
  android: Add initial code for hidhost get and set protocol
  android: Add initial code for hidhost get and set report
  android: Add initial code for hidhost send data
  android: Add initial code for hidhost set hid information

 android/hal-hidhost.c |  126 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 21 deletions(-)

-- 
1.7.9.5

