Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: puthik@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Puthikorn Voravootivat <puthik@chromium.org>
Subject: [PATCH v2 1/2] doc/device-api: Add AdvertisingFlags
Date: Tue, 18 Oct 2016 12:10:59 -0700
Message-Id: <1476817861-24158-3-git-send-email-puthik@chromium.org>
In-Reply-To: <1476817861-24158-1-git-send-email-puthik@chromium.org>
References: <1476817861-24158-1-git-send-email-puthik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Puthikorn Voravootivat <puthik@chromium.org>

This exposed Advertising Flags to BlueZ Device API

Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
---
 doc/device-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index f5cac49..1985698 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -230,3 +230,7 @@ Properties	string Address [readonly]
 
 			Indicate whether or not service discovery has been
 			resolved.
+
+		array{byte} AdvertisingFlags [readonly]
+
+			The Advertising Data Flags of the remote device.
-- 
2.8.0.rc3.226.g39d4020

