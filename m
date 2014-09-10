Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/4] android/hf-client: API fixes
Date: Wed, 10 Sep 2014 13:11:30 +0200
Message-Id: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Couple of fixes to hf-client api.

Those patches previously where a part of bigger set
[PATCH 00/39] android: HF Client initial implementation
but on Luiz request I split it into smaller sets.

Lukasz Rymanowski (4):
  android/hal-ipc-api: Use 2 bytes for location in dial memory
  android/hal-ipc-api: Use Tone instead of Code DTMF
  android/hal-ipc-api: Add missing peer features parameter
  android/hal-ipc-api: Fix define for HF-Client

 android/hal-ipc-api.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
1.8.4

