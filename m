Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix query for VCARD listing (work phone issue)
Date: Thu, 22 Jul 2010 15:06:11 +0300
Message-Id: <1279800371-24342-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed tracker query for VCARD listing - previously contacts with only
work phone filled were missing in query result (and in vcard listing).
Now if mobile/home phone number is not available, then trying to get
work phone number.
---
 plugins/phonebook-tracker.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index ee072d3..41d7fde 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -72,6 +72,10 @@
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { "							\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?h . "				\
+	"} "								\
 	"}"
 
 #define MISSED_CALLS_QUERY						\
-- 
1.7.0.4

