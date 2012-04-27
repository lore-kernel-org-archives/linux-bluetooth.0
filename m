Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/9] event: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:46 -0400
Message-Id: <1335537412-26478-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |    2 +-
 src/event.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/event.c b/src/event.c
index f576102..514744b 100644
--- a/src/event.c
+++ b/src/event.c
@@ -430,7 +430,7 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint8_t *key, uint8_t master,
 					uint8_t authenticated, uint8_t enc_size,
-					uint16_t ediv, 	uint8_t rand[8])
+					uint16_t ediv, uint8_t rand[8])
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
diff --git a/src/event.h b/src/event.h
index c4ae18f..dfc158d 100644
--- a/src/event.h
+++ b/src/event.h
@@ -46,4 +46,4 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint8_t *key, uint8_t master,
 					uint8_t authenticated, uint8_t enc_size,
-					uint16_t ediv, 	uint8_t rand[8]);
+					uint16_t ediv, uint8_t rand[8]);
-- 
1.7.5.4

