Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/16] android/gatt: Fix for device type in gatt
Date: Tue,  2 Sep 2014 12:09:46 +0200
Message-Id: <1409652601-28689-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes remote device type in GATT cache, which should be
updated on connect confirm
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ae310f7..aea0a9f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6115,8 +6115,6 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 			error("gatt: Could not create device");
 			goto drop;
 		}
-
-		dev->bdaddr_type = dst_type;
 	} else {
 		if ((dev->state != DEVICE_DISCONNECTED) &&
 					!(dev->state == DEVICE_CONNECT_INIT &&
@@ -6130,6 +6128,8 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 		}
 	}
 
+	dev->bdaddr_type = dst_type;
+
 	if (!bt_io_accept(io, connect_cb, device_ref(dev), NULL, NULL)) {
 		error("gatt: failed to accept connection");
 		device_unref(dev);
-- 
1.8.4

