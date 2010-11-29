Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix problem with fetching 0.vcf vCard entry
Date: Mon, 29 Nov 2010 14:51:56 +0100
Message-Id: <1291038716-7244-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously after attempting to get single 0.vcf vCard entry from phonebook
("telecom/pb/0.vcf") "Not Found" status was received and this entry wasn't
downloaded. Now "OK" status is received and valid 0.vcf vCard entry is
downloaded.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 20053f6..a6b9e72 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -943,7 +943,7 @@
 	"nco:phoneNumber(?t) \"NOTACALL\" \"false\" \"false\" <%s> "	\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
-		"<%s> nco:hasPhoneNumber ?t . "				\
+		"OPTIONAL { <%s> nco:hasPhoneNumber ?t . } "		\
 	"} "
 
 #define CONTACTS_COUNT_QUERY						\
-- 
1.6.3.3

