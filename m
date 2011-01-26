Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 1/2 v2] Remove unnecessary ordering from single vCard query
Date: Wed, 26 Jan 2011 13:33:06 +0100
Message-Id: <1296045187-28072-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously ordering for query called CONTACTS_QUERY_FROM_URI was applied.
It is not needed since always only one vCard (with id specified)
is fetched.
---
 plugins/phonebook-tracker.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e60cf74..4e37f1c 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -788,11 +788,9 @@
 "\"NOTACALL\" \"false\" \"false\" "					\
 "<%s> "									\
 "WHERE {"								\
-"	<%s> a nco:PersonContact ;"					\
-"	nco:nameFamily ?_key ."						\
+"	<%s> a nco:PersonContact ."					\
 "	OPTIONAL {<%s> nco:hasAffiliation ?_role .}"			\
-"}"									\
-"ORDER BY ?_key tracker:id(<%s>)"
+"}"
 
 #define CONTACTS_OTHER_QUERY_FROM_URI					\
 	"SELECT fn:concat(\"TYPE_OTHER\", \"\31\", nco:phoneNumber(?t))"\
@@ -1926,8 +1924,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 
 	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
-						id, id, id, id, id, id, id, id,
-						id, id);
+					id, id, id, id, id, id, id, id, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
-- 
1.6.3.3

