Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v3 1/2] doc/device-api: Add AdvertisingFlags
Date: Wed, 19 Oct 2016 19:03:37 -0700
Message-Id: <1476929018-29947-2-git-send-email-puthik@chromium.org>
In-Reply-To: <1476929018-29947-1-git-send-email-puthik@chromium.org>
References: <1476929018-29947-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

This exposed Advertising Flags to BlueZ Device API

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
---
 doc/device-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index f5cac49..13b2881 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -230,3 +230,7 @@ Properties	string Address [readonly]
 
 			Indicate whether or not service discovery has been
 			resolved.
+
+		array{byte} AdvertisingFlags [readonly, experimental]
+
+			The Advertising Data Flags of the remote device.
-- 
2.8.0.rc3.226.g39d4020

