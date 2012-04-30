Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20BlueZ=20v2=200/6=5D=20Multiple=20Bluetooth=20SCO=20connections=20=28userspace=29?=
Date: Mon, 30 Apr 2012 10:56:33 +0200
Message-Id: <1335776199-16704-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This third version integrates the review from Luiz affecting patch v1 4/5: an incorrectly squashed change has been fixed and the function media_transport_create has been split in profile-specific functions (patch v2 4/6).

>From original cover letter:

This patch series includes patches that have been useful to connect two HCI-based SCO links simultaneously. This can be used for example to connect to HSP headsets at the same time.

The patch series is divided in three groups: kernel patches, BlueZ userspace patches and PulseAudio patches for module-bluetooth-device.

The kernel patches include some code cleanup and more importantly a dynamically changing alternate setting in btusb driver. These ideas have been taken from the patches I found in [1]. The last patch, “Bluetooth: Remove outgoing MTU check” should be considered with care, since there probably are better approaches to solve this (WIP).

The BlueZ userspace patches add some necessary infrastructure to support such use-cases.

The PulseAudio patches provide some changes to be able to test the rest of the code. The first three patches have been reused from a previously submitted patch series, and only the last two patches are relevant for this purpose. They provide some simple workarounds and should not be considered a proper solution.

As I said, the easiest may to test these patches is by using two Bluetooth headsets. You should use the Media API (Enable=Media in audio.conf), connect both headsets, and use pacmd to set their profile to hsp.

[1] http://bluetooth-alsa.sourceforge.net/future.html

Mikel Astiz (6):
  audio: Fix gateway state check
  audio: Add multiple device search to manager
  media: Support multiple transports per endpoint
  media: Split media_endpoint_create
  media: Create multiple transports if needed
  media: Enable parallel requests to endpoint

 audio/device.c  |    2 +-
 audio/manager.c |   25 +++++-
 audio/manager.h |    6 ++
 audio/media.c   |  271 ++++++++++++++++++++++++++++++++++++-------------------
 4 files changed, 207 insertions(+), 97 deletions(-)

-- 
1.7.7.6

