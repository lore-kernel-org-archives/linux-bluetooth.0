Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix pulling phonebook entries without last name
Date: Mon, 28 Feb 2011 16:19:43 +0100
Message-Id: <1298906383-14521-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix problem with pulling phonebook entries using PBAP without
last name filled. Previously last name was used to sort phonebook data
now only tracker id is used.
---
 plugins/phonebook-tracker.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9963aab..bc196b8 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -135,11 +135,10 @@
 "\"NOTACALL\" \"false\" \"false\" "					\
 "?_contact "								\
 "WHERE {"								\
-"	?_contact a nco:PersonContact ;"				\
-"	nco:nameFamily ?_key ."						\
+"	?_contact a nco:PersonContact ."				\
 "	OPTIONAL {?_contact nco:hasAffiliation ?_role .}"		\
 "}"									\
-"ORDER BY ?_key tracker:id(?_contact)"
+"ORDER BY tracker:id(?_contact)"
 
 #define CONTACTS_QUERY_ALL_LIST						\
 	"SELECT ?c nco:nameFamily(?c) "					\
-- 
1.7.0.4

