Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/15] android/handsfree-clien: Second set of HFP HF
Date: Wed, 19 Nov 2014 10:43:33 +0100
Message-Id: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this set all mising signaling part is implemented.
Tested on UPF 49 as well.

SCO part will come in next set.

v2:
* Addressed Szymon comments
* Added patch fixing index type in IPC call action command (01/15)

Lukasz Rymanowski (15):
  android/handsfree-client: Fix index type in call action command
  android/handsfree-client: Add handle start/stop vr
  android/handsfree-client: Add volume control handling
  android/handsfree-client: Add handling dial command
  android/handsfree-client: Add call action implementation
  android/handsfree-client: Implement query current calls
  android/handsfree-client: Add handling +CLCC
  android/handsfree-client: Add support for +CIEV events
  android/handsfree-client: Send indicators val we got during SLC setup
  android/handsfree-client: Add support to get operator name
  android/handsfree-client: Send to AG that we do support long name
  android/handsfree-client: Retrieve subscriber number information
  android/handsfree-client: Implement send DTMF codes
  android/handsfree-client: Implement handling AT+BINP and +BINP
  android/handsfree-client: Implement codec negotiations

 android/hal-msg.h          |   2 +-
 android/handsfree-client.c | 833 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 802 insertions(+), 33 deletions(-)

-- 
1.8.4

