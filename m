Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 1/4] Code clean-up: Remove unnecessary empty lines
Date: Thu, 22 Sep 2011 09:52:45 +0200
Message-Id: <1316677968-3494-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unnecessary empty lines.
---
 plugins/phonebook-tracker.c |    1 -
 plugins/vcard.c             |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 47ce878..da2e2bb 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1003,7 +1003,6 @@ static void add_affiliation(char **field, const char *value)
 static void contact_init(struct phonebook_contact *contact,
 							const char **reply)
 {
-
 	contact->fullname = g_strdup(reply[COL_FULL_NAME]);
 	contact->family = g_strdup(reply[COL_FAMILY_NAME]);
 	contact->given = g_strdup(reply[COL_GIVEN_NAME]);
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 0522c96..e5e1de1 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -825,7 +825,6 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	vcard_printf_end(vcards);
 }
 
-
 static void field_free(gpointer data)
 {
 	struct phonebook_field *field = data;
-- 
1.6.3.3

