Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd] Code clean-up: Remove unnecessary code line breaking
Date: Tue, 25 Oct 2011 13:11:54 +0200
Message-Id: <1319541114-16715-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unnecessary code line breaking.
---
 plugins/phonebook-tracker.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 3be3a89..e4f2383 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1120,8 +1120,7 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 	int i;
 
 	/* Addresses from affilation */
-	aff_addr = g_strsplit(reply[COL_ADDR_AFF], MAIN_DELIM,
-								MAX_FIELDS);
+	aff_addr = g_strsplit(reply[COL_ADDR_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_addr)
 		for (i = 0; aff_addr[i] != NULL; ++i)
-- 
1.6.3.3

