Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 00/14] android/handsfree-clien: Second set of HFP HF
Date: Wed, 12 Nov 2014 11:49:23 +0100
Message-Id: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this set all mising signaling part is implemented.
Tested on UPF 49 as well.

SCO part will come in next set.

Lukasz Rymanowski (14):
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
  android/handsfree-client: Implement handling AT+BIND and +BIND
  android/handsfree-client: Implement codec negotiations

 android/handsfree-client.c | 832 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 800 insertions(+), 32 deletions(-)

-- 
1.8.4

