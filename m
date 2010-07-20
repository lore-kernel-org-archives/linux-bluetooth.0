Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fixed problem with incoming calls query
Date: Tue, 20 Jul 2010 15:30:30 +0300
Message-Id: <1279629030-10504-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>

After making some incoming, outgoing, missed calls, history lists of them
(ich, och, mch) are stored on device. In current implementation queries
towards tracker for incoming calls include also missed calls.
So list for incoming calls displayed on paired BT headset/carkit screen
(e.g. BH-903, CK-200) also contains numbers from missed calls list.

To block adding missed calls list numbers to incoming calls there should
be added info that incoming call is in fact only answered call. So macros
additionally include info: "nmo:isAnswered true ." Without this, missed
calls was treated as incoming calls.
---
 plugins/phonebook-tracker.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 89c612e..ee072d3 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -124,7 +124,8 @@
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
-		"nmo:isSent false . "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
 		"?c a nco:Contact . "					\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
@@ -143,7 +144,8 @@
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
-		"nmo:isSent false . "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
 		"?c a nco:Contact . "					\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
-- 
1.6.3.3

