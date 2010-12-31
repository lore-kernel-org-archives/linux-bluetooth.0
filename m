Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix phonebook size issue
Date: Fri, 31 Dec 2010 10:02:59 +0100
Message-Id: <1293786179-17068-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, when only empty default owner vCard was available, phonebook
default size equal to 1 was received and it was always counted when
phonebook size requested. This patch makes that it is equal to 0 as it
should be and it is not counted anymore when phonebook size requested.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index b7acead..071f6d3 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -867,7 +867,7 @@
 	"} "
 
 #define CONTACTS_COUNT_QUERY						\
-	"SELECT COUNT(?c) "						\
+	"SELECT COUNT(?c) - 1 "						\
 	"WHERE {"							\
 		"?c a nco:PersonContact ."				\
 		"FILTER (regex(str(?c), \"contact:\") || "		\
-- 
1.6.3.3

