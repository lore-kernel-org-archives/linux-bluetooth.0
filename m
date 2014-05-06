Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/gatt: Trivial style fix of argument list
Date: Tue,  6 May 2014 11:57:04 +0200
Message-Id: <1399370226-19126-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index bbf899f..6262c93 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1832,8 +1832,7 @@ static void send_client_char_notify(const struct characteristic *ch,
 					sizeof(ev), &ev);
 }
 
-static void cache_all_srvc_chars(struct service *srvc,
-							GSList *characteristics)
+static void cache_all_srvc_chars(struct service *srvc, GSList *characteristics)
 {
 	uint16_t inst_id = 0;
 	bt_uuid_t uuid;
-- 
1.9.2

