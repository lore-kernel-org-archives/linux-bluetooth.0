Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/2] Add X-IRMC-CALL-DATETIME to single vCard pull
Date: Wed, 13 Jul 2011 16:20:04 +0200
Message-Id: <1310566804-26748-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1310566804-26748-1-git-send-email-bulislaw@linux.com>
References: <1310566804-26748-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously when pulling single vCard there was no difference between
pulling contact or call, now there are separate queries and additional
previously missing data are being sent.
---
 plugins/phonebook-tracker.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index cab3822..d1f4cd7 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -75,6 +75,7 @@
 #define COL_ANSWERED 21
 #define CONTACTS_ID_COL 22
 #define CONTACT_ID_PREFIX "urn:uuid:"
+#define CALL_ID_PREFIX "message:"
 
 #define FAX_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#FaxNumber"
 #define MOBILE_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#CellPhoneNumber"
@@ -181,7 +182,7 @@ CONSTRAINT								\
 "} "
 
 #define CALLS_LIST(CONSTRAINT)						\
-"SELECT ?_contact nco:nameFamily(?_contact) "				\
+"SELECT ?_call nco:nameFamily(?_contact) "				\
 	"nco:nameGiven(?_contact) nco:nameAdditional(?_contact) "	\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
@@ -277,6 +278,10 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 "	?_call nmo:isSent true "		\
 "} "
 
+#define CALL_URI_CONSTRAINT	\
+COMBINED_CONSTRAINT		\
+"FILTER (?_call = <%s>) "
+
 #define MISSED_CALLS_QUERY CALLS_QUERY(MISSED_CONSTRAINT)
 #define MISSED_CALLS_LIST CALLS_LIST(MISSED_CONSTRAINT)
 #define INCOMING_CALLS_QUERY CALLS_QUERY(INCOMING_CONSTRAINT)
@@ -285,6 +290,7 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 #define OUTGOING_CALLS_LIST CALLS_LIST(OUTGOING_CONSTRAINT)
 #define COMBINED_CALLS_QUERY CALLS_QUERY(COMBINED_CONSTRAINT)
 #define COMBINED_CALLS_LIST CALLS_LIST(COMBINED_CONSTRAINT)
+#define CONTACT_FROM_CALL_QUERY CALLS_QUERY(CALL_URI_CONSTRAINT)
 
 #define CONTACTS_QUERY_FROM_URI						\
 "SELECT "								\
@@ -1611,6 +1617,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
 				g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 					id, id, id, id, id, id, id, id, id);
+	else if (g_str_has_prefix(id, CALL_ID_PREFIX) == TRUE)
+		query = g_strdup_printf(CONTACT_FROM_CALL_QUERY, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
-- 
1.7.4.1

