Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 01/18] Fix attrib plugin deregistration
Date: Tue, 21 Dec 2010 19:26:23 -0200
Message-Id: <1292966800-6264-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the comparison method used for find what to de-register was
wrong, it was causing the btd_device reference that the attrib
plugin was keeping never to be dropped.
---
 attrib/client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8e96af4..69e4fb8 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -167,7 +167,7 @@ static int gatt_dev_cmp(gconstpointer a, gconstpointer b)
 	const struct gatt_service *gatt = a;
 	const struct btd_device *dev = b;
 
-	return gatt->dev == dev;
+	return gatt->dev != dev;
 }
 
 static int characteristic_handle_cmp(gconstpointer a, gconstpointer b)
-- 
1.7.3.4

