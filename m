Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 1/2] Remove unnecessary ordering from single vCard query
Date: Wed, 26 Jan 2011 12:01:04 +0100
Message-Id: <1296039665-3948-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously ordering for query called CONTACTS_QUERY_FROM_URI was applied.
It is not needed since always only one vCard (with id specified)
is fetched.
---
 plugins/phonebook-tracker.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e60cf74..aee159c 100644
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
-- 
1.6.3.3

