Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Adjust prefix of contact id for getting pb size
Date: Mon, 28 Feb 2011 14:53:43 +0100
Message-Id: <1298901223-8313-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Getting phonebook size is related to recognizing contacts by their id
prefixes. Previously it was "contact: " and has been changed to
"urn:uuid:". This patch fixes it and allows to get valid phonebook size.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index b204493..99848e3 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -809,7 +809,7 @@
 	"SELECT COUNT(?c) "						\
 	"WHERE {"							\
 		"?c a nco:PersonContact ."				\
-		"FILTER (regex(str(?c), \"contact:\"))"			\
+		"FILTER (regex(str(?c), \"urn:uuid:\"))"		\
 	"}"
 
 #define MISSED_CALLS_COUNT_QUERY					\
-- 
1.6.3.3

