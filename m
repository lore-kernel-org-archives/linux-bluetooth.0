Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 0/6] android/hal-audio: Fixes
Date: Mon, 3 Feb 2014 17:55:43 +0100
Message-ID: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1 -> v2
fixed build error introduced during rebase


Andrzej Kaczmarek (6):
  android/hal-audio: Remove unsupported mono channel mode
  android/hal-audio: Be more verbose on SBC errors
  android/hal-audio: Print calculated SBC parameters
  android/hal-audio: Fix audio with large omtu value
  android/hal-audio: Fix RTP sequence numbers
  android/hal-audio: Add RTP timestamps

 android/hal-audio.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
1.8.5.3

