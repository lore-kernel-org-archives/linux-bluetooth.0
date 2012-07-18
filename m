Return-Path: <cyrus@holtmann.org>
From: Harald Schmitt <linux@hschmitt.de>
To: linux-bluetooth@vger.kernel.org
Cc: Harald Schmitt <linux@hschmitt.de>
Subject: [PATCH 1/2] irmc: Fix phonebook contacts query
Date: Wed, 18 Jul 2012 16:53:07 +0200
Message-Id: <1342623188-10796-2-git-send-email-linux@hschmitt.de>
In-Reply-To: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At the moment IRMC fails to connect for phonebook_ebook and
phonebook_tracker usage because the name parameter for phonebook_pull
is not an absolute path.
---
 plugins/irmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 87f3b6c..2283fe6 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -226,7 +226,7 @@ static void *irmc_connect(struct obex_session *os, int *err)
 	param->maxlistcount = 0; /* to count the number of vcards... */
 	param->filter = 0x200085; /* UID TEL N VERSION */
 	irmc->params = param;
-	irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
+	irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
 					phonebook_size_result, irmc, err);
 	ret = phonebook_pull_read(irmc->request);
 	if (err)
@@ -312,7 +312,7 @@ static void *irmc_open_pb(const char *name, struct irmc_session *irmc,
 
 	if (!g_strcmp0(name, ".vcf")) {
 		/* how can we tell if the vcard count call already finished? */
-		irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
+		irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
 						query_result, irmc, &ret);
 		if (ret < 0) {
 			DBG("phonebook_pull failed...");
-- 
1.7.9.5

