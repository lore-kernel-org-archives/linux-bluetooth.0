Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix handling nco affiliation fields
Date: Fri, 29 Oct 2010 11:30:19 +0200
Message-Id: <1288344619-18133-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously when contact record was divided into separate replies,
phonebook-tracker would use first reply and merge only phone numbers,
addresses and emails from next. Now it's merging all fields dependent on the
nco:hasAffiliation as well.
---
 plugins/phonebook-tracker.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 96290a4..f37ed5a 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -982,6 +982,14 @@ static void add_phone_number(struct phonebook_contact *contact,
 	contact->numbers = g_slist_append(contact->numbers, number);
 }
 
+static void add_affiliation(char **field, const char *value)
+{
+        if(strlen(*field) != 0 || value == NULL || strlen(value) == 0)
+                return;
+
+        *field = g_strdup(value);
+}
+
 static struct phonebook_email *find_email(GSList *emails, const char *address,
 								int type)
 {
@@ -1196,6 +1204,13 @@ add_numbers:
 	g_free(home_addr);
 	g_free(work_addr);
 
+        /* Adding fields connected by nco:hasAffiliation - they may be in
+         * separate replies */
+        add_affiliation(&contact->title, reply[33]);
+        add_affiliation(&contact->company, reply[22]);
+        add_affiliation(&contact->department, reply[23]);
+        add_affiliation(&contact->role, reply[24]);
+
 	DBG("contact %p", contact);
 
 	/* Adding contacts data to wrapper struct - this data will be used to
-- 
1.7.0.4

