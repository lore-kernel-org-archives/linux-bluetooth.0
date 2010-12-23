Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] PBAP tracker-query update for addr fields
Date: Thu, 23 Dec 2010 13:20:08 +0200
Message-Id: <1293103208-17664-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to display many addresses of the same type
(WORK/HOME/OTHER) in different rows in pbap pull response.
Currently in that case all addresses of the same type
were displayed in the same row.
---
 plugins/phonebook-tracker.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 59221cb..b7acead 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -109,7 +109,7 @@
 "tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
 "tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"		\
+"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"		\
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
@@ -191,7 +191,7 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
 	"WHERE {"							\
 	"?_role nco:hasPostalAddress ?aff_addr"				\
 	"}) "								\
@@ -337,7 +337,7 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
 	"WHERE {"							\
 	"?_role nco:hasPostalAddress ?aff_addr"				\
 	"}) "								\
@@ -482,7 +482,7 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
 	"WHERE {"							\
 	"?_role nco:hasPostalAddress ?aff_addr"				\
 	"}) "								\
@@ -621,7 +621,7 @@
 	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
 	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"	\
 	"WHERE {"							\
 	"?_role nco:hasPostalAddress ?aff_addr"				\
 	"}) "								\
@@ -813,7 +813,7 @@
 "tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
 "tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"		\
+"tracker:coalesce(nco:country(?aff_addr), \"\") ),\"\30\")"		\
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
-- 
1.7.0.4

