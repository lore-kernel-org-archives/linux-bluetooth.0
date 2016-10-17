Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH 0/2] Expose AdvertisingDataFlags in Device API
Date: Mon, 17 Oct 2016 15:27:11 -0700
Message-Id: <1476743233-26706-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

The following patches expose AdvertisingDataFlags in Device API.
This is need by Android app on ChromeOS as Android normally
get Advertising data flag from Bluetooth adapter.

Puthikorn Voravootivat (2):
  doc/device-api: Add AdvertisingDataFlags
  core: Add implementation of AdvertisingDataFlags

 doc/device-api.txt |  4 ++++
 src/adapter.c      |  2 ++
 src/device.c       | 30 ++++++++++++++++++++++++++++++
 src/device.h       |  1 +
 4 files changed, 37 insertions(+)

-- 
2.8.0.rc3.226.g39d4020

