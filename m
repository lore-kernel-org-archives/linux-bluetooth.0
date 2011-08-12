Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] phonebook-tracker.c: Calls query speed-up
Date: Fri, 12 Aug 2011 15:18:48 +0200
Message-Id: <1313155128-26979-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Another change regarding performance of call history queries. This makes
them non-sensitive (in terms of speed) to the corner case situations when
there are hundreds of contacts all having the same phone number.
---
 plugins/phonebook-tracker.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 8bc070f..875901c 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -164,7 +164,7 @@
 	"?_unb_contact nco:hasPhoneNumber ?_cpn . "			\
 CONSTRAINT								\
 	"OPTIONAL { "							\
-		"{ SELECT ?_contact ?_cpn ?_role ?_number "		\
+		"{ SELECT ?_contact ?_no ?_role ?_number "		\
 			"count(?_contact) as ?cnt "			\
 		"WHERE { "						\
 			"?_contact a nco:PersonContact . "		\
@@ -175,9 +175,9 @@ CONSTRAINT								\
 				"?_contact nco:hasPhoneNumber ?_number" \
 			"} "						\
 			"?_number maemo:localPhoneNumber ?_no . "	\
-			"?_cpn maemo:localPhoneNumber ?_no . "		\
-		"} GROUP BY ?_cpn } "					\
+		"} GROUP BY ?_no } "					\
 		"FILTER(?cnt = 1) "					\
+		"?_cpn maemo:localPhoneNumber ?_no . "			\
 	"} "								\
 "} "
 
-- 
1.7.4.1

