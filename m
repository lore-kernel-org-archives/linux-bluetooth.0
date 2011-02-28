Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Adjust prefix of contact id for pulling single vCard
Date: Mon, 28 Feb 2011 13:03:52 +0100
Message-Id: <1298894632-30497-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pulling single vCard is related to recognizing it by prefix of contact id.
Previously it was "contact: " and has been changed to "urn:uuid:".
This patch fixes it and allows to pull valid single vCard.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9963aab..b204493 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -73,7 +73,7 @@
 #define COL_SENT 20
 #define COL_ANSWERED 21
 #define CONTACTS_ID_COL 22
-#define CONTACT_ID_PREFIX "contact:"
+#define CONTACT_ID_PREFIX "urn:uuid:"
 
 #define FAX_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#FaxNumber"
 #define MOBILE_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#CellPhoneNumber"
-- 
1.6.3.3

