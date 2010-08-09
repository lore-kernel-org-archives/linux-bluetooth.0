Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/2] Fix multiple phone numbers problem in vcard-listing
Date: Mon,  9 Aug 2010 14:17:03 +0300
Message-Id: <1281352623-30856-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes displaying problem in vcard-listing when contact had multiple
home or work phone set(one contact was displayed more than one time in
vcard-listing. Now query is changed and additional entries are omitted.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 41d7fde..f2b9649 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -76,7 +76,7 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"?a nco:hasPhoneNumber ?h . "				\
 	"} "								\
-	"}"
+	"} GROUP BY ?c"
 
 #define MISSED_CALLS_QUERY						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
-- 
1.7.0.4

