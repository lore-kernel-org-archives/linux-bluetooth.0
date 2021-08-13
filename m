Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CAC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23500610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhHMMUL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhHMMUK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D93C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d22-20020a379b160000b02903d298616502so4342091qke.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gKyL/fA9NlAN6iVhN4cw+wRKBqvhqPf8DHC59IDmm2I=;
        b=j8UYf6W6/Hg91KvSC2NOoLGpiVh1b9fUk7S15h6ezg0kk8NcgThLRtMpQkI+5Oc29g
         IE6TbtrwD1jbIXgKe30xRJ9mKKmThqJ3CabTEfoT+ZLmns63U+K6G1emTIO0jum4PQs+
         XKIRekMMLUbfPhZ3JFJYYWfBvwusqZahOwZsYvtinhaAAFiEJuzqWEcDp6VCPDGPQOWk
         Vszg6GbjP/vqWojnKDRRxyZd5j7HQSPEnqdPvjlrWfyif0B5MXn98qmTkAP7qLyfyA/z
         l/eOa2BgKihimC9odqehSEEUR3yxVRinwM0MklJx5aB81hQzi6LNIET6MnY6XpGQlYIy
         o89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gKyL/fA9NlAN6iVhN4cw+wRKBqvhqPf8DHC59IDmm2I=;
        b=uNkadkKRKvsKB2XngAxr/voh5ES5r2nW5ubQoN8FS3DFYuCjdISl3RmcGOeHNqPLaL
         HOre8iOl5zM1aZbgXn+CS49oP/FVAT6wMvKN/fgiES0iBDQmQFYHLEevMieWSyncXgq8
         rteJg9pAoPJbI37Ui5jrDI2LFTnIikCHQUfRkxD/rzZpoHtzKPO6tGak1SdxXzYFxNe0
         cYUTIleM5QFEi5wxO2NTrHQ0CplWYqaVe/bdC57KyZCTEed7s85zPP1rUzD/FcK9gqKO
         vzwjVgYYva9FnGkoc8GAz8a5oTJS48G5twic+1swTPU+fb/THkiHXe2okoB74nxlcuDj
         xSVA==
X-Gm-Message-State: AOAM530E3jxSE1N8V0HdjFpv45VJCeqJvt3K8xkInQEXweNl6meNhv8g
        AwxYSFQHp8qAXLBoTF6/52VM/2GG2qJTMrSlKikuwsTwE+msblzR1POHd+Odq8XCQ+z8QJcX5PN
        OEhs5Qwj7VvBbXn4l6YMOojvgIDzvJzQetC6qeLdIK16oDyzSwZB9IvANPKLKFXbA32IwNnY+NG
        4G
X-Google-Smtp-Source: ABdhPJzeHSRWmdePcWyl73YWSy1zuj2GHQRw+ZkTHFFBYH0faBBz/ukNEWnir6MLV/4Z+cRMPV6giIAz1L4W
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:5bc7:: with SMTP id
 t7mr2388783qvt.10.1628857183146; Fri, 13 Aug 2021 05:19:43 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:47 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.2.Ibb7f04e885ef866b1b00a9ba0514b7da85cfe7f6@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 02/62] lib: Inclusive language in consts and strings
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are preferred, as reflected in the BT
core spec 5.3
---

 lib/hci.c | 16 ++++++++--------
 lib/hci.h | 10 +++++-----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 53af0a1148..3611d3d360 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -288,7 +288,7 @@ int hci_strtolp(char *str, unsigned int *val)
 static hci_map link_mode_map[] = {
 	{ "NONE",	0		},
 	{ "ACCEPT",	HCI_LM_ACCEPT	},
-	{ "MASTER",	HCI_LM_MASTER	},
+	{ "CENTRAL",	HCI_LM_CENTRAL	},
 	{ "AUTH",	HCI_LM_AUTH	},
 	{ "ENCRYPT",	HCI_LM_ENCRYPT	},
 	{ "TRUSTED",	HCI_LM_TRUSTED	},
@@ -304,8 +304,8 @@ char *hci_lmtostr(unsigned int lm)
 		return NULL;
 
 	*str = 0;
-	if (!(lm & HCI_LM_MASTER))
-		strcpy(str, "SLAVE ");
+	if (!(lm & HCI_LM_CENTRAL))
+		strcpy(str, "PERIPHERAL ");
 
 	s = hci_bit2str(link_mode_map, lm);
 	if (!s) {
@@ -345,7 +345,7 @@ static hci_map commands_map[] = {
 
 	{ "Set Connection Encryption",			16  },
 	{ "Change Connection Link Key",			17  },
-	{ "Master Link Key",				18  },
+	{ "Temporary Link Key",				18  },
 	{ "Remote Name Request",			19  },
 	{ "Cancel Remote Name Request",			20  },
 	{ "Read Remote Supported Features",		21  },
@@ -735,8 +735,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<EV4 packets>",	LMP_EV4		},	/* Bit 0 */
 		{ "<EV5 packets>",	LMP_EV5		},	/* Bit 1 */
 		{ "<no. 34>",		0x04		},	/* Bit 2 */
-		{ "<AFH cap. slave>",	LMP_AFH_CAP_SLV	},	/* Bit 3 */
-		{ "<AFH class. slave>",	LMP_AFH_CLS_SLV	},	/* Bit 4 */
+		{ "<AFH cap. perip.>",	LMP_AFH_CAP_PRP	},	/* Bit 3 */
+		{ "<AFH class. perip.>",LMP_AFH_CLS_PRP	},	/* Bit 4 */
 		{ "<BR/EDR not supp.>",	LMP_NO_BREDR	},	/* Bit 5 */
 		{ "<LE support>",	LMP_LE		},	/* Bit 6 */
 		{ "<3-slot EDR ACL>",	LMP_EDR_3SLOT	},	/* Bit 7 */
@@ -746,8 +746,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<5-slot EDR ACL>",	LMP_EDR_5SLOT	},	/* Bit 0 */
 		{ "<sniff subrating>",	LMP_SNIFF_SUBR	},	/* Bit 1 */
 		{ "<pause encryption>",	LMP_PAUSE_ENC	},	/* Bit 2 */
-		{ "<AFH cap. master>",	LMP_AFH_CAP_MST	},	/* Bit 3 */
-		{ "<AFH class. master>",LMP_AFH_CLS_MST	},	/* Bit 4 */
+		{ "<AFH cap. central>",	LMP_AFH_CAP_CEN	},	/* Bit 3 */
+		{ "<AFH class. cent.>",	LMP_AFH_CLS_CEN	},	/* Bit 4 */
 		{ "<EDR eSCO 2 Mbps>",	LMP_EDR_ESCO_2M	},	/* Bit 5 */
 		{ "<EDR eSCO 3 Mbps>",	LMP_EDR_ESCO_3M	},	/* Bit 6 */
 		{ "<3-slot EDR eSCO>",	LMP_EDR_3S_ESCO	},	/* Bit 7 */
diff --git a/lib/hci.h b/lib/hci.h
index 9d3cdfd06b..4c039830d5 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -241,8 +241,8 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
-#define LMP_AFH_CAP_SLV	0x08
-#define LMP_AFH_CLS_SLV	0x10
+#define LMP_AFH_CAP_PRP	0x08
+#define LMP_AFH_CLS_PRP	0x10
 #define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
 #define LMP_EDR_3SLOT	0x80
@@ -250,8 +250,8 @@ enum {
 #define LMP_EDR_5SLOT	0x01
 #define LMP_SNIFF_SUBR	0x02
 #define LMP_PAUSE_ENC	0x04
-#define LMP_AFH_CAP_MST	0x08
-#define LMP_AFH_CLS_MST	0x10
+#define LMP_AFH_CAP_CEN	0x08
+#define LMP_AFH_CLS_CEN	0x10
 #define LMP_EDR_ESCO_2M	0x20
 #define LMP_EDR_ESCO_3M	0x40
 #define LMP_EDR_3S_ESCO	0x80
@@ -281,7 +281,7 @@ enum {
 
 /* Link mode */
 #define HCI_LM_ACCEPT	0x8000
-#define HCI_LM_MASTER	0x0001
+#define HCI_LM_CENTRAL	0x0001
 #define HCI_LM_AUTH	0x0002
 #define HCI_LM_ENCRYPT	0x0004
 #define HCI_LM_TRUSTED	0x0008
-- 
2.33.0.rc1.237.g0d66db33f3-goog

