Return-Path: <cyrus@holtmann.org>
From: Harald Schmitt <linux@hschmitt.de>
To: linux-bluetooth@vger.kernel.org
Cc: Harald Schmitt <linux@hschmitt.de>
Subject: [PATCH] obexd/irmc: Fix folder for LUID requests
Date: Mon, 20 Jan 2014 18:39:18 +0100
Message-Id: <1390239558-6384-1-git-send-email-linux@hschmitt.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The old macro PB_LUID_FOLDER had the folder luid on the second level:
/telecom/luid. But the luid folder occurs per IrMC spec on level three e.g.
/telecom/pb/luid. On the second level the object store e.g. pb is specified.
This bug was introduced with commit 62ebf8d0f345e7722334d852cf7a010b202647e7.
---
 obexd/plugins/irmc.c      | 6 +++---
 obexd/plugins/phonebook.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index d343977..d0e98b4 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -326,7 +326,7 @@ static int irmc_open_nt(struct irmc_session *irmc)
 	return 0;
 }
 
-static int irmc_open_luid(struct irmc_session *irmc)
+static int irmc_open_pb_luid(struct irmc_session *irmc)
 {
 	if (irmc->buffer == NULL)
 		irmc->buffer = g_string_new("");
@@ -381,8 +381,8 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
 		ret = irmc_open_cal(irmc);
 	else if (g_str_has_prefix(path, PB_NOTES_FOLDER))
 		ret = irmc_open_nt(irmc);
-	else if (g_str_has_prefix(path, PB_LUID_FOLDER))
-		ret = irmc_open_luid(irmc);
+	else if (g_str_has_prefix(path, PB_CONTACTS_LUID_FOLDER))
+		ret = irmc_open_pb_luid(irmc);
 	else
 		ret = -EBADR;
 
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 441cff2..015c9a3 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -37,7 +37,7 @@
 #define PB_CALLS_INCOMING_FOLDER "/telecom/ich"
 #define PB_CALLS_MISSED_FOLDER "/telecom/mch"
 #define PB_CALLS_OUTGOING_FOLDER "/telecom/och"
-#define PB_LUID_FOLDER "/telecom/luid"
+#define PB_CONTACTS_LUID_FOLDER "/telecom/pb/luid"
 
 #define PB_CONTACTS "/telecom/pb.vcf"
 #define PB_CALLS_COMBINED "/telecom/cch.vcf"
-- 
1.8.3.2

