Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 12/16] event: Remove write of LastSeen info
Date: Wed, 24 Oct 2012 16:34:14 +0200
Message-Id: <1351089258-25179-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/src/event.c b/src/event.c
index 3c43135..d7daed2 100644
--- a/src/event.c
+++ b/src/event.c
@@ -221,17 +221,6 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
-{
-	time_t t;
-	struct tm *tm;
-
-	t = time(NULL);
-	tm = gmtime(&t);
-
-	write_lastseen_info(sba, dba, dba_type, tm);
-}
-
 static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 {
 	time_t t;
@@ -256,8 +245,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 		return;
 	}
 
-	update_lastseen(local, peer, bdaddr_type);
-
 	adapter_update_found_devices(adapter, peer, bdaddr_type, rssi,
 					confirm_name, legacy, data, data_len);
 }
-- 
1.7.9.5

