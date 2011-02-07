Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH] Update gatt listen mode.
Date: Mon,  7 Feb 2011 17:11:36 -0300
Message-Id: <1297109496-26609-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update gatt's listen-mode flag whenever connect_cb() is called again.
---
 attrib/client.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 44638d3..ec5fcf2 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -356,6 +356,7 @@ static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
 
 	if (gatt->attrib != NULL) {
 		gatt->attrib = g_attrib_ref(gatt->attrib);
+		gatt->listen = listen;
 		return 0;
 	}
 
-- 
1.7.1

