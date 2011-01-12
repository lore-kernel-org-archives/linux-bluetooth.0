Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix crash after fetching single owner vCard
Date: Wed, 12 Jan 2011 16:15:38 +0100
Message-Id: <1294845338-15655-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes that crash is avoided in case of fetching single owner
vCard (0.vcf) from phonebook. Crash was caused because previous
modifications of other queries wasn't included in query called
CONTACTS_OTHER_QUERY_FROM_URI.
---
 plugins/phonebook-tracker.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 237fb33..311babd 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -757,10 +757,10 @@
 "ORDER BY ?_key tracker:id(<%s>)"
 
 #define CONTACTS_OTHER_QUERY_FROM_URI					\
-	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
-	"fn:concat(\"TYPE_OTHER\", \"\31\", nco:phoneNumber(?t)) \"\" "	\
+	"SELECT fn:concat(\"TYPE_OTHER\", \"\31\", nco:phoneNumber(?t))"\
+	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "			\
 	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "		\
-	" \"NOTACALL\" \"false\" \"false\" <%s> "	\
+	" \"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
 		"OPTIONAL { <%s> nco:hasPhoneNumber ?t . } "		\
-- 
1.6.3.3

