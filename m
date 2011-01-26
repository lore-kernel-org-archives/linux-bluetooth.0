Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 2/2 v3] Fix fetching non-empty single owner vCard
Date: Wed, 26 Jan 2011 14:26:27 +0100
Message-Id: <1296048387-2854-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously only empty owner vCard fetching was handled.
This patch makes that fetching empty (by default) and non-empty
(filled somehow by the user) single owner vCard is handled.
---
 plugins/phonebook-tracker.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 4e37f1c..ceaef81 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1922,7 +1922,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	data->cb = cb;
 	data->vcardentry = TRUE;
 
-	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
+	if (g_str_has_prefix(id, CONTACT_ID_PREFIX) == TRUE ||
+				g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 					id, id, id, id, id, id, id, id, id);
 	else
-- 
1.6.3.3

