Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 16/18] Add support for adding services to the Services property
Date: Tue, 21 Dec 2010 19:26:38 -0200
Message-Id: <1292966800-6264-17-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to fill the devices property as each service path gets
registered in the DBus system bus.
---
 attrib/client.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8b5aea8..e717eaa 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -970,6 +970,7 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 		DBG("Registered: %s", prim->path);
 
 		gatt->primary = g_slist_append(gatt->primary, prim);
+		btd_device_add_service(gatt->dev, prim->path);
 		load_characteristics(prim, gatt);
 	}
 }
-- 
1.7.3.4

