Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] attrib/gatt: Minor coding style fix
Date: Tue,  9 Dec 2014 09:40:25 +0100
Message-Id: <1418114425-22455-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 0e633f7..b4be25a 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -942,7 +942,6 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-
 static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 					guint16 iplen, gpointer user_data)
 {
-- 
1.8.4

