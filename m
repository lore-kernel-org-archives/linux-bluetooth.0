Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/12] More customization options
Date: Tue, 30 Sep 2014 13:06:15 +0200
Message-Id: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches extend configuration with more options required by DIS and
DID profiles.

Characteristics in DIS that would allow device tracking (serial and system id)
now require pairing before reading.

Proposed Android properties and fallbacks are described in last patch.

Comments are welcome.
Szymon Janc

Szymon Janc (12):
  android: Add support for more configuration options
  android/gatt: Bring back System ID in DIS
  android/gatt: Fix serial number in DIS
  android/gatt: Require encryption for Serial and System ID in DIS
  android/bluetooth: Use configured values for DID
  lib/uuid: Add define for GATT PnP ID UUID
  android/gatt: Add support for PnP ID in DIS
  android/gatt: Use release version for software revision in DIS
  android: Remove few not needed blank lines
  android: Add support for FW and HW revision config options
  android/pts: Update PTS settings and results for DIS
  android/README: Update with new configuration options

 android/README          |  12 ++++
 android/bluetooth.c     |  25 +++------
 android/gatt.c          | 108 +++++++++++++++++++++++++++++++-----
 android/hal-bluetooth.c |  25 +++++++++
 android/hal-ipc-api.txt |   5 ++
 android/hal-msg.h       |   5 ++
 android/main.c          | 145 ++++++++++++++++++++++++++++++++++++++++++++++--
 android/pics-dis.txt    |   4 +-
 android/pixit-dis.txt   |   2 +-
 android/pts-dis.txt     |   8 +--
 android/utils.h         |   8 +++
 lib/uuid.h              |   1 +
 12 files changed, 303 insertions(+), 45 deletions(-)

-- 
1.9.1

