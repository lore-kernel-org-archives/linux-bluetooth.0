Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] adapter: Fix possible invalid memory access
Date: Fri, 10 Feb 2012 18:47:52 -0300
Message-Id: <1328910472-26550-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

This possible crash was detected by the clang static analysis tool.

 src/adapter.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 60477bb..36073ff 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1906,8 +1906,10 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	bdaddr_t src;

 	info = get_ltk_info(key, value);
-	if (info)
-		keys->keys = g_slist_append(keys->keys, info);
+	if (info == NULL)
+		return;
+
+	keys->keys = g_slist_append(keys->keys, info);

 	if (g_slist_find_custom(adapter->devices, key,
 					(GCompareFunc) device_address_cmp))
--
1.7.8.1

