Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 0/6] Exploit btd_service's userdata pointer
Date: Mon, 27 May 2013 14:04:03 +0200
Message-Id: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

With the adoption of btd_service, profile implementations can benefit from the provided userdata pointer which can replace the previously necessary lists to associate services with custom private types.

The proposed change not only removes boilerplate code but also data redundancy, presumably making the codebase more robust.

This patchset addresses the first examples which looked like more obvious to refactor. Note that some of the profiles were not tested due to lack of hardware.

Patch 2/6 fixes an issue that I came across during this work.

Mikel Astiz (6):
  network: Remove duplicated search
  network: Fix missing NULL check for given UUID
  network: Remove find_connection()
  deviceinfo: Use btd_service userdata pointer
  scanparam: Use btd_service userdata pointer
  input: Use btd_service userdata pointer

 profiles/deviceinfo/deviceinfo.c | 46 ++++++----------------------------------
 profiles/input/device.c          | 37 +++++++++-----------------------
 profiles/network/connection.c    | 38 ++++++++++++---------------------
 profiles/scanparam/scan.c        | 36 ++++++-------------------------
 4 files changed, 35 insertions(+), 122 deletions(-)

-- 
1.8.1.4

