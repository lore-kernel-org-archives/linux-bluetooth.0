Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Fix duplicate characteristics
Date: Thu, 20 Jan 2011 09:27:47 -0400
Message-Id: <1295530067-6022-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Discover() operation (from DBus API) was registering the same
characteristics after running several times. This can be checked using
test-attrib.
---
 attrib/client.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 767d1c1..44638d3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -870,6 +870,13 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	for (l = characteristics; l; l = l->next) {
 		struct att_char *current_chr = l->data;
 		struct characteristic *chr;
+		guint handle = current_chr->value_handle;
+		GSList *lchr;
+
+		lchr = g_slist_find_custom(prim->chars,
+			GUINT_TO_POINTER(handle), characteristic_handle_cmp);
+		if (lchr)
+			continue;
 
 		chr = g_new0(struct characteristic, 1);
 		chr->prim = prim;
-- 
1.7.0.4

