Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v4 3/6] client: fix incorrect error check
Date: Fri, 17 Feb 2012 13:55:33 +0100
Message-Id: <1329483336-25853-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous statement always returned success.
---
 client/pbap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 4910536..dd5642d 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -287,6 +287,7 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
 					const char *item, GError **err)
 {
 	char *path;
+	guint id;
 
 	path = build_phonebook_path(location, item);
 	if (path == NULL) {
@@ -300,8 +301,9 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
 		return TRUE;
 	}
 
-	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
-	if (err != NULL) {
+	id = obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap,
+									err);
+	if (id > 0) {
 		g_free(pbap->path);
 		pbap->path = path;
 		return TRUE;
-- 
1.7.6.5

