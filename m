Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/5] Refactor codec handling
Date: Fri, 28 Feb 2014 19:01:15 +0100
Message-ID: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are few patches to refactor a bit and cleanup hal-audio code. Primary
goal here is to decouple codec abstraction from any write/sync operations so
in case new codec is added, it can just do encoding and does not need to care
about writing anything to socket or dealing with synchronization.

In addition, "sleeping code" is changed to use clock_nanosleep with absolute
time which results in almost perfect distribution of media packets over time,
where previously we had to "catch up" from time to time. This also seemed to
be quite unreliable over long periods of time since after some time playback
became distorted. Now it seems this issue is gone.


Andrzej Kaczmarek (5):
  android/hal-audio: Add open/close_endpoint helpers
  android/hal-audio: Add encode_mediapacket function
  android/hal-audio: Write and sync in common code
  android/hal-audio: Use payload length for codec init
  android/hal-audio: Provide better audio synchronization

 android/hal-audio.c | 409 ++++++++++++++++++++++++++++------------------------
 1 file changed, 220 insertions(+), 189 deletions(-)

-- 
1.8.5.4

