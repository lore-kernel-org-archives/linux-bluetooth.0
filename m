Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 02/12] storage: Use g_free() instead of free()
Date: Wed, 23 May 2012 21:27:22 +0530
Message-id: <1337788652-23697-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is important to match g_*() memory allocation with g_free()
---
As per the glib documentation, the memory allocated using the glib
api's needs to be freed using corresponding glib free api's and not
libc api's, otherwise undefined behaviour can happen. This is because
the libc allocation and glib allocation uses different memory pools.

 src/storage.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 973d545..a91ee2d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -732,7 +732,7 @@ int write_trust(const char *src, const char *addr, const char *service,
 	else {
 		char *new_str = service_list_to_string(services);
 		ret = textfile_caseput(filename, addr, new_str);
-		free(new_str);
+		g_free(new_str);
 	}
 
 	g_slist_free(services);
@@ -817,7 +817,7 @@ int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
 	err = textfile_put(filename, key, str);
 
 	free(buf.data);
-	free(str);
+	g_free(str);
 
 	return err;
 }
@@ -839,7 +839,7 @@ sdp_record_t *record_from_string(const gchar *str)
 	}
 
 	rec = sdp_extract_pdu(pdata, size, &len);
-	free(pdata);
+	g_free(pdata);
 
 	return rec;
 }
-- 
1.7.4.1

