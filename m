Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/2] Remove unnecessary empty line in phonebook-tracker
Date: Tue, 26 Oct 2010 11:29:51 +0300
Message-Id: <1288081792-15296-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-tracker.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a6e21f8..277290c 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -531,7 +531,6 @@
 		"}"							\
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
-
 #define CONTACTS_QUERY_FROM_URI						\
 	"SELECT ?v nco:fullname(<%s>) "					\
 	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "			\
-- 
1.7.0.4

