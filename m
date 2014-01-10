Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/7]  Next skeleton patches for audio plugin
Date: Fri, 10 Jan 2014 02:24:21 +0100
Message-ID: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1:
Those patches adds function to handle send/receive msg on audio IPC.
Also adds some small changes.

Not that since we do not yet support AUDIO_OP_OPEN, audio socket will be
reseted just after connect.

v2:
Fixes suggester by Luiz
Some additional fixes

Lukasz Rymanowski (7):
  android/audio: Prefix error log with "audio"
  android: Fix error check from pthread_create
  android/audio: Refactor create_audio_ipc
  android/audio: Trivial function move
  android/audio: Add skeleton for ipc_open_cmd function
  android/audio: Add audio_ipc_cmd
  android/audio: Add audio_ipc_cleanup function

 android/Makefile.am |   1 +
 android/hal-audio.c | 304 ++++++++++++++++++++++++++++++++++++++++++----------
 android/hal-ipc.c   |   6 +-
 3 files changed, 250 insertions(+), 61 deletions(-)

-- 
1.8.4

