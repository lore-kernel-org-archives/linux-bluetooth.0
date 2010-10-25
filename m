Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Provide extra query for vCard single call
Date: Mon, 25 Oct 2010 11:04:58 +0200
Message-Id: <1287997498-2576-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes that additional circumstance is recognized - after
making a call with number that is out of phonebook it can be downloaded
as a single vCard containing number with OTHER type.
---
 plugins/phonebook-tracker.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 1c579d1..f25708a 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -55,6 +55,7 @@
 #define COL_SENT 36
 #define COL_ANSWERED 37
 #define ADDR_FIELD_AMOUNT 7
+#define CONTACT_ID_PREFIX "contact:"
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -569,6 +570,16 @@
 	"} "								\
 	"}"
 
+#define CONTACTS_OTHER_QUERY_FROM_URI					\
+	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "\
+	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
+	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
+	"nco:phoneNumber(?t) \"NOTACALL\" \"false\" \"false\" <%s> "	\
+	"WHERE { "							\
+		"<%s> a nco:Contact . "					\
+		"<%s> nco:hasPhoneNumber ?t . "				\
+	"} "
+
 typedef void (*reply_list_foreach_t) (char **reply, int num_fields,
 		void *user_data);
 
@@ -1305,9 +1316,14 @@ int phonebook_get_entry(const char *folder, const char *id,
 	data->cb = cb;
 	data->vcardentry = TRUE;
 
-	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
-						id, id, id, id, id, id, id,
+	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0) {
+		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
+						id, id, id, id, id, id, id, id,
 						id, id, id, id, id);
+	} else {
+		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
+								id, id, id);
+	}
 
 	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 
-- 
1.6.3.3

