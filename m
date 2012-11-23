Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 0/3] Only create the uhid device when PNP info is available
Date: Fri, 23 Nov 2012 17:30:29 -0300
Message-Id: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Some input drivers require that the input device is created with the
correct product and vendor ids.

So we have a race condition between the DIS (Device Information)
profile and the HoG profile, this series aims to solve this particular
problem by adding a mechanism to notify the interested parties that
PNP information is ready, the HoG plugin uses this to only create the
uhid device when that information arrives.

Patch 1/3 should be considered for inclusion even if this idea doesn't
make sense.

Cheers,

Vinicius Costa Gomes (3):
  device: Add btd_ prefix to device_set_pnpid()
  device: Add a way to be notified that PNP information is present
  hog: Fix registering HoG devices without vendor information

 profiles/deviceinfo/deviceinfo.c |  2 +-
 profiles/input/hog_device.c      | 75 ++++++++++++++++++++++++++++------------
 src/device.c                     | 45 ++++++++++++++++++++++--
 src/device.h                     |  7 +++-
 4 files changed, 103 insertions(+), 26 deletions(-)

-- 
1.8.0

