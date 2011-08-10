Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Fix memory leak on opp plugin
Date: Wed, 10 Aug 2011 11:17:50 +0300
Message-Id: <1312964270-8806-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Folder and name can point to allocated memory so they need to be freed
before returning.

Thanks for Daniele Forsi <dforsi@gmail.com> for reporting it.
---
 plugins/opp.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index 644a2c6..fd78af4 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -142,8 +142,10 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 		name = g_strdup(obex_get_name(os));
 
 skip_auth:
-	if (name == NULL || strlen(name) == 0)
-		return -EBADR;
+	if (name == NULL || strlen(name) == 0) {
+		ret = -EBADR;
+		goto failed;
+	}
 
 	if (g_strcmp0(name, obex_get_name(os)) != 0)
 		obex_set_name(os, name);
@@ -155,6 +157,8 @@ skip_auth:
 	ret = obex_put_stream_start(os, path);
 
 	g_free(path);
+
+failed:
 	g_free(folder);
 	g_free(name);
 
-- 
1.7.6

