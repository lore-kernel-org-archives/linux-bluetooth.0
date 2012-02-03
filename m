Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/2] PBAP/Tracker: Fix searching vCards by phone number
Date: Fri,  3 Feb 2012 12:03:26 +0100
Message-Id: <1328267006-29847-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1328267006-29847-1-git-send-email-lkslawek@gmail.com>
References: <1328267006-29847-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Originally only one of contact's phone numbers was stored in cache,
rendering searching by phone numbers not fully functional.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d358c9f..7ac02f6 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -167,7 +167,7 @@
 			"} "						\
 		"} "							\
 	") "								\
-	"nco:phoneNumber(?h) "						\
+	"GROUP_CONCAT(nco:phoneNumber(?h), \"" MAIN_DELIM "\") "	\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
-- 
1.7.4.1

