Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2] Fix phonebook size issue
Date: Mon,  3 Jan 2011 14:34:04 +0100
Message-Id: <1294061644-7661-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, when only empty default owner vCard was available, phonebook
default size equal to 1 was received and it was always counted when
phonebook size requested. This patch makes that it is equal to 0 as it
should be and it is not counted anymore when phonebook size requested.
---
 plugins/phonebook-tracker.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a5cd8a7..d211660 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -870,8 +870,7 @@
 	"SELECT COUNT(?c) "						\
 	"WHERE {"							\
 		"?c a nco:PersonContact ."				\
-		"FILTER (regex(str(?c), \"contact:\") || "		\
-		"regex(str(?c), \"nco#default-contact-me\"))"		\
+		"FILTER (regex(str(?c), \"contact:\"))"			\
 	"}"
 
 #define MISSED_CALLS_COUNT_QUERY					\
-- 
1.6.3.3

