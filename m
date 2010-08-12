Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Use enum from vcard.h for phone types
Date: Thu, 12 Aug 2010 10:49:13 +0300
Message-Id: <1281599353-27811-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed redundant declarations for phone types. Now using values from
phonebook_number_type declared in vcard.h.
---
 plugins/phonebook-tracker.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9cd82e7..8300fc7 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -44,8 +44,6 @@
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
 #define CONTACTS_ID_COL 19
-#define PHONE_ID_HOME 0
-#define PHONE_ID_WORK 3
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
@@ -697,8 +695,8 @@ add_entry:
 
 add_numbers:
 	/* Adding phone numbers to contact struct */
-	add_phone_number(contact, reply[0], PHONE_ID_HOME);
-	add_phone_number(contact, reply[8], PHONE_ID_WORK);
+	add_phone_number(contact, reply[0], TEL_TYPE_HOME);
+	add_phone_number(contact, reply[8], TEL_TYPE_WORK);
 
 	DBG("contact %p", contact);
 
-- 
1.7.0.4

