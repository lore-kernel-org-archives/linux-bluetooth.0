Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/7] android: Audio improvements
Date: Wed, 9 Apr 2014 16:16:51 +0200
Message-ID: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are few patches which should further improve our audio HAL. I've had
them in my tree for couple of weeks and didn't notice any problems with
streaming (tested on Nexus 4 and 5).

Patches 1-3 are simple fixes/cleanup.

Patch 4 changes L2CAP socket used in audio HAL to non-blocking (with
proper polling on socket state) which enables more sophisticated
audio stream handling introduced in subsequent patches.

Patch 5 changes way in which socket congestion (due to any reason) is
handled by simply skipping some audio data instead of trying to send
data indefinitely. This helps to maintain synchronization between audio
clock and data sent which is crucial for sleeping code to work properly.

Patches 6 and 7 enables dynamic audio quality control (for SBC it's
just bitpool adjustment) which enchances patch 5, i.e we not only skip
audio data but also reduce audio quality and effectively reduce stream
bandwidth which makes more possible that streaming will be smooth.

Patches 4-7 are inspired by current PulseAudio implementation.



Andrzej Kaczmarek (7):
  android/a2dp: Prefer master role on incoming connections
  android/hal-audio: Remove preset with 48000 frequency
  android/hal-audio: Add resume_endpoint helper
  android/hal-audio: Make audio socket non-blocking
  android/hal-audio: Resync audio when lagging too much
  android/hal-audio: Add support to control audio quality
  android/hal-audio: Adjust audio quality automatically

 android/a2dp.c      |   1 +
 android/hal-audio.c | 320 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 232 insertions(+), 89 deletions(-)

-- 
1.9.1

