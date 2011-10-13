Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 6/7] Remove CCC entries when device is removed
Date: Thu, 13 Oct 2011 11:43:23 -0300
Message-Id: <1318517004-17003-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 082a046..1bd86d0 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1194,6 +1194,22 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 
 	g_slist_free_full(match.keys, g_free);
 
+	/* Deleting all CCC values of a given address */
+	memset(&match, 0, sizeof(match));
+	match.pattern = address;
+
+	create_filename(filename, PATH_MAX, sba, "ccc");
+	err = textfile_foreach(filename, filter_keys, &match);
+	if (err < 0)
+		return err;
+
+	for (l = match.keys; l; l = l->next) {
+		const char *key = l->data;
+		textfile_del(filename, key);
+	}
+
+	g_slist_free_full(match.keys, g_free);
+
 	return 0;
 }
 
-- 
1.7.7

