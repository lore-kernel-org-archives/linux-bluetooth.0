Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] src: fix typo
Date: Mon, 14 Feb 2011 18:34:44 -0300
Message-Id: <1297719284-13410-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index 0659fd1..a415468 100644
--- a/src/event.c
+++ b/src/event.c
@@ -731,7 +731,7 @@ void btd_event_le_set_scan_enable_complete(bdaddr_t *local, uint8_t status)
 	}
 
 	if (status) {
-		error("Can't enabled/disable LE scan");
+		error("Can't enable/disable LE scan");
 		return;
 	}
 
-- 
1.7.4

