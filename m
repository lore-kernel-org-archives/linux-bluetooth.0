Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/5] android/handsfree-client: Add SCO to HFP HF
Date: Tue, 25 Nov 2014 11:47:23 +0100
Message-Id: <1416912448-28177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Last missing piece to HFP HF implementation.

Lukasz Rymanowski (5):
  android/handsfree-client: Add SCO to handsfree client
  android/handsfree-client: Add handle incoming SCO connection
  android/handsfree-client: Implement audio connect/disconnect
  android/handsfree-client: Send AT+BCC to start codec negotiation
  android/README: Update status of HAL HFP HF implementation

 android/README             |   2 +-
 android/handsfree-client.c | 203 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 182 insertions(+), 23 deletions(-)

-- 
1.8.4

