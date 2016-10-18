Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v2 0/2] Expose AdvertisingDataFlags in Device API
Date: Tue, 18 Oct 2016 12:10:57 -0700
Message-Id: <1476817861-24158-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

The following patches expose AdvertisingFlags in Device API.
This is need by Android app on ChromeOS as Android normally
should get Advertising data flag from Bluetooth adapter.

v2:
Address Marcel's review to make it more future proof by making it array{byte}.
device->flags is still a uint8 because 1) We don't need it to be bigger now.
and 2) We can easily changed it to bigger type when needed without affecting
the DBus Device API.

Puthikorn Voravootivat (2):
  doc/device-api: Add AdvertisingFlags
  core: Add implementation of AdvertisingFlags

 doc/device-api.txt |  4 ++++
 src/adapter.c      |  2 ++
 src/device.c       | 36 ++++++++++++++++++++++++++++++++++++
 src/device.h       |  1 +
 4 files changed, 43 insertions(+)

-- 
2.8.0.rc3.226.g39d4020

