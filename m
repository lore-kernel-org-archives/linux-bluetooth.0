Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 0/6] Audio HAL plugin concept
Date: Mon, 30 Dec 2013 11:17:21 +0100
Message-ID: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is the set od some startup patches for audio hal plugin plus some trivial
fixes which are not RFC actually.

As we want audio plugin to register endpoint we need some special way to
handle it having in mind that audio device is open on the system startup
and closed on system down. We need to handle bluetooth daemon start/stop 
in between.

Need your comment on that. For me it does not look bad but we still have
time to consider having some fixed or configurable way (eg. some config file)
to register endpoints in bluetooth daemon instead.

Lukasz Rymanowski (6):
  android/ipc: Remove not needed include
  android/audio: Fix Makefile.am for libaudio
  android: Minor fix to Android Bluetooth Audio protocol API doc
  android: Keep stream_out example in the API doc
  android/audio: Add wrapper stuct for audio structures
  android/audio: Add listener thread on the Audio HAL socket

 android/Makefile.am       |   5 +-
 android/audio-ipc-api.txt |  18 ++--
 android/hal-audio.c       | 242 ++++++++++++++++++++++++++++++++++++++--------
 android/hal-audio.h       |  18 ++++
 android/ipc.c             |   1 -
 5 files changed, 231 insertions(+), 53 deletions(-)
 create mode 100644 android/hal-audio.h

-- 
1.8.4

