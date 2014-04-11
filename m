Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/gatt: Remove not needed empty line and redundand tab
Date: Fri, 11 Apr 2014 12:29:48 +0200
Message-Id: <1397212190-3240-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 15e788a..4e548c8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -126,7 +126,7 @@ static bool scanning = false;
 
 static struct queue *gatt_clients = NULL;
 static struct queue *gatt_servers = NULL;
-static struct queue *conn_list	= NULL;		/* Connected devices */
+static struct queue *conn_list = NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
@@ -140,7 +140,6 @@ static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
 
 	for (i = 0; i < 16; i++)
 		dst->value.u128.data[i] = uuid[15 - i];
-
 }
 
 static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
-- 
1.9.1

