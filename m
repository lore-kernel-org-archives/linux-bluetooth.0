Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v3 0/2] Expose AdvertisingFlags in Device API
Date: Wed, 19 Oct 2016 19:03:36 -0700
Message-Id: <1476929018-29947-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

v2:
Address Marcel's review to make it more future proof by making it array{byte}.

v3:
Mark AdvertisingFlags as experimental

Puthikorn Voravootivat (2):
  doc/device-api: Add AdvertisingFlags
  core: Add implementation of AdvertisingFlags

 doc/device-api.txt |  4 ++++
 src/adapter.c      |  2 ++
 src/device.c       | 37 +++++++++++++++++++++++++++++++++++++
 src/device.h       |  1 +
 4 files changed, 44 insertions(+)

-- 
2.8.0.rc3.226.g39d4020

