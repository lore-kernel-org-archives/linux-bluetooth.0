Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/9] lib: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:44 -0400
Message-Id: <1335537412-26478-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c     |    2 +-
 lib/hci_lib.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 269c021..66b2d5f 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2829,7 +2829,7 @@ int hci_le_set_advertise_enable(int dd, uint8_t enable, int to)
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
-		uint16_t min_interval, 	uint16_t max_interval,
+		uint16_t min_interval, uint16_t max_interval,
 		uint16_t latency, uint16_t supervision_timeout,
 		uint16_t min_ce_length, uint16_t max_ce_length,
 		uint16_t *handle, int to)
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 725eb05..cf4a0ff 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -123,7 +123,7 @@ int hci_le_set_advertise_enable(int dev_id, uint8_t enable, int to);
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
-		uint16_t min_interval, 	uint16_t max_interval,
+		uint16_t min_interval, uint16_t max_interval,
 		uint16_t latency, uint16_t supervision_timeout,
 		uint16_t min_ce_length, uint16_t max_ce_length,
 		uint16_t *handle, int to);
-- 
1.7.5.4

