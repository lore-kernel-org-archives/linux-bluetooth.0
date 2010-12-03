Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/5] Make bt_name2class static on glib-helper
Date: Fri,  3 Dec 2010 11:28:52 -0300
Message-Id: <1291386532-4985-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/glib-helper.c |    6 +++---
 src/glib-helper.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 2db307e..9871c5b 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -586,7 +586,7 @@ static struct {
 	{ }
 };
 
-uint16_t bt_name2class(const char *pattern)
+static uint16_t name2class(const char *pattern)
 {
 	int i;
 
@@ -636,7 +636,7 @@ char *bt_name2string(const char *pattern)
 		return g_strdup(pattern);
 
 	/* Friendly service name format */
-	uuid16 = bt_name2class(pattern);
+	uuid16 = name2class(pattern);
 	if (uuid16)
 		goto proceed;
 
@@ -683,7 +683,7 @@ int bt_string2uuid(uuid_t *uuid, const char *string)
 
 		return 0;
 	} else {
-		uint16_t class = bt_name2class(string);
+		uint16_t class = name2class(string);
 		if (class) {
 			sdp_uuid16_create(uuid, class);
 			return 0;
diff --git a/src/glib-helper.h b/src/glib-helper.h
index 018ff92..5bb20a6 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -38,7 +38,6 @@ int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 					bt_destroy_t destroy);
 
 gchar *bt_uuid2string(uuid_t *uuid);
-uint16_t bt_name2class(const char *string);
 char *bt_name2string(const char *string);
 int bt_string2uuid(uuid_t *uuid, const char *string);
 gchar *bt_list2string(GSList *list);
-- 
1.7.3.2

