Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/3 v2] Move freeing contacts data to phonebook_req_finalize
Date: Wed,  2 Feb 2011 12:21:47 +0200
Message-Id: <1296642108-14063-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1296642108-14063-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1296642108-14063-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously data used for generating vcards was freed only in
gen_vcards body. This may result a memory leak, if fetching data
from tracker was cancelled in the middle of process and gen_vcards
wasn't called. Phonebook_req_finalize is better place for this
kind of cleanup.
---
 plugins/phonebook-tracker.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e60cf74..3b61d6b 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1326,10 +1326,6 @@ static GString *gen_vcards(GSList *contacts,
 		struct contact_data *c_data = l->data;
 		phonebook_add_contact(vcards, c_data->contact,
 					params->filter, params->format);
-
-		g_free(c_data->id);
-		phonebook_contact_free(c_data->contact);
-		g_free(c_data);
 	}
 
 	return vcards;
@@ -1789,6 +1785,7 @@ done:
 void phonebook_req_finalize(void *request)
 {
 	struct phonebook_data *data = request;
+	GSList *l;
 
 	DBG("");
 
@@ -1800,6 +1797,15 @@ void phonebook_req_finalize(void *request)
 
 	dbus_pending_call_unref(data->call);
 
+	/* freeing list of contacts used for generating vcards */
+	for (l = data->contacts; l; l = l->next) {
+		struct contact_data *c_data = l->data;
+
+		g_free(c_data->id);
+		phonebook_contact_free(c_data->contact);
+		g_free(c_data);
+	}
+
 	g_slist_free(data->contacts);
 	g_free(data);
 }
-- 
1.7.0.4

