Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] Next skeleton patches for audio plugin
Date: Thu, 9 Jan 2014 12:45:52 +0100
Message-ID: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those patches adds function to handle send/receive msg on audio IPC.
Also do some small changes.

Not that since we do not yet support AUDIO_OP_OPEN, audio socket will be
reseted just after connect.

Lukasz Rymanowski (4):
  android/audio: Prefix error log with "a2dp"
  android/audio: Change mainloop handle in ipc_handler
  android/audio: Add skeleton for open_endpoint_cmd function
  android/audio: Add audio_ipc_cmd

 android/Makefile.am |   1 +
 android/hal-audio.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 186 insertions(+), 11 deletions(-)

-- 
1.8.4

