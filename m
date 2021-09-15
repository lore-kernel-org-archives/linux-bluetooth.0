Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D44C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CD661179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhIOIdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIOIdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:33:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BCDC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r6-20020a05622a034600b002a0ba9994f4so1811647qtw.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZT4B0dTuU8s9sedeykOmQ0CQKwWJBoEkx2aEh8AAfh0=;
        b=nAv4hg1VJ2athgC3BHcDBqviZAy3lHceTW4vlNo4qSn6C635tpWwPc/woIi0TDZlYI
         piLj+m+2cDAUvkP0YbypX7QqeZsWMTWLBVJUHiKcqvlpBxHlu5aE/qK39IvzC3hvRKOV
         cqkYOlbf6w6khSxIauLMBJrg70wQ7dV6hQP7qq7+uc1aKsFayJDjRwxzjl0qLtpDjHVW
         rMWQ2WuuO0hiKxfSSiqD/bar50Q4QDcA5sMryj183gPsYV4QP0l7nSfdtlW6hlsjY52Y
         Rlhw4DyLZY/10mG09fJ69FDinswe9FdfdGFwu8nnN0j9GrUrfHNY1wGO/NZinYpSMOcg
         GNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZT4B0dTuU8s9sedeykOmQ0CQKwWJBoEkx2aEh8AAfh0=;
        b=fx5Xz6jXvPdwBXhirKdBKmp9bVuO6J3CLHzSgCuSSo7VLAFcUwW8kiWHpdWHc4PfQI
         ZazeqZTqAuK/CrHD3ODsV0uwFo3V1Loed4wVZiafHWTkTZ0f5XXjVLwc9d1jqji0u1cd
         VBuS22aP6j46ybb9968aIMsKTEd8CO1GfWaHCQuhl82B77g5edgPklAs+OuyN901iKMX
         /MPVunCpp3UJNuvGJ6pg8glbFRNtJI/Eua1NlqkdcOIz9rXCZiDFfLOxOufllemtgnhC
         eyw/sd9iBevTfsRu177vhP1d8+UFfw6FpFGtdqMsPdFDTjGXWbAD1Nn7JAZDwQpl3tVe
         nJMg==
X-Gm-Message-State: AOAM532nbDgUg1AsFDdSZLmDBQubC34rvux+vVQ0YzKL723q8yPiryUj
        ygZ+i/5+6tGi0Fj15dX2nzg0h2bHvExcn5UkoPyQXYp7ozMBr+Wx1W0395y0zbebKtV2XPTzwpm
        YmgtATtvzTItZM63CA/2YM9u5BZlGEWaqG9504nMU93ZrppYwFo0pBpvUB+N3u/faN1XXs5tq9b
        u/
X-Google-Smtp-Source: ABdhPJy8AdBLxrGABBJ/Ke3++yny0e3AH/kgk0CWobalUypZ5Pt7s/xOWmPJliSu5/UomEA6pJ4PfVorTIlg
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:ad4:5506:: with SMTP id
 az6mr9543225qvb.8.1631694746250; Wed, 15 Sep 2021 01:32:26 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:31:55 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 01/13] lib: Inclusive language changes
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

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central", "peripheral", and "accept list".
---

Changes in v5:
* Support the original term as input parameter for tools

Changes in v3:
* Not replacing some terms which belong to libluetooth API

Changes in v2:
* Merging several patches from the same directory into one

 android/bluetooth.c |  4 ++--
 lib/hci.c           | 32 ++++++++++++++++++++------------
 lib/mgmt.h          |  2 +-
 monitor/control.c   |  4 ++--
 src/adapter.c       |  4 ++--
 tools/oobtest.c     |  4 ++--
 6 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c3ad503497..fe956b5d43 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2276,7 +2276,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 		ediv = le16_to_cpu(key->ediv);
 		rand = le64_to_cpu(key->rand);
 
-		store_ltk(&key->addr.bdaddr, key->addr.type, key->master,
+		store_ltk(&key->addr.bdaddr, key->addr.type, key->central,
 				key->val, key->type, key->enc_size, ediv, rand);
 	}
 
@@ -3097,7 +3097,7 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
 	info->ediv = cpu_to_le16(info->ediv);
 
-	info->master = master;
+	info->central = master;
 
 failed:
 	g_free(key);
diff --git a/lib/hci.c b/lib/hci.c
index 53af0a1148..5141f20ac7 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -288,7 +288,7 @@ int hci_strtolp(char *str, unsigned int *val)
 static hci_map link_mode_map[] = {
 	{ "NONE",	0		},
 	{ "ACCEPT",	HCI_LM_ACCEPT	},
-	{ "MASTER",	HCI_LM_MASTER	},
+	{ "CENTRAL",	HCI_LM_MASTER	},
 	{ "AUTH",	HCI_LM_AUTH	},
 	{ "ENCRYPT",	HCI_LM_ENCRYPT	},
 	{ "TRUSTED",	HCI_LM_TRUSTED	},
@@ -305,7 +305,7 @@ char *hci_lmtostr(unsigned int lm)
 
 	*str = 0;
 	if (!(lm & HCI_LM_MASTER))
-		strcpy(str, "SLAVE ");
+		strcpy(str, "PERIPHERAL ");
 
 	s = hci_bit2str(link_mode_map, lm);
 	if (!s) {
@@ -320,7 +320,15 @@ char *hci_lmtostr(unsigned int lm)
 
 int hci_strtolm(char *str, unsigned int *val)
 {
-	return hci_str2bit(link_mode_map, str, val);
+	int ret = hci_str2bit(link_mode_map, str, val);
+
+	/* Deprecated name. Kept for compatibility. */
+	if (strcasestr(str, "MASTER")) {
+		ret = 1;
+		*val |= HCI_LM_MASTER;
+	}
+
+	return ret;
 }
 
 /* Command mapping */
@@ -345,7 +353,7 @@ static hci_map commands_map[] = {
 
 	{ "Set Connection Encryption",			16  },
 	{ "Change Connection Link Key",			17  },
-	{ "Master Link Key",				18  },
+	{ "Temporary Link Key",				18  },
 	{ "Remote Name Request",			19  },
 	{ "Cancel Remote Name Request",			20  },
 	{ "Read Remote Supported Features",		21  },
@@ -565,11 +573,11 @@ static hci_map commands_map[] = {
 	{ "LE Set Scan Enable",				211 },
 	{ "LE Create Connection",			212 },
 	{ "LE Create Connection Cancel",		213 },
-	{ "LE Read White List Size",			214 },
-	{ "LE Clear White List",			215 },
+	{ "LE Read Accept List Size",			214 },
+	{ "LE Clear Accept List",			215 },
 
-	{ "LE Add Device To White List",		216 },
-	{ "LE Remove Device From White List",		217 },
+	{ "LE Add Device To Accept List",		216 },
+	{ "LE Remove Device From Accept List",		217 },
 	{ "LE Connection Update",			218 },
 	{ "LE Set Host Channel Classification",		219 },
 	{ "LE Read Channel Map",			220 },
@@ -735,8 +743,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<EV4 packets>",	LMP_EV4		},	/* Bit 0 */
 		{ "<EV5 packets>",	LMP_EV5		},	/* Bit 1 */
 		{ "<no. 34>",		0x04		},	/* Bit 2 */
-		{ "<AFH cap. slave>",	LMP_AFH_CAP_SLV	},	/* Bit 3 */
-		{ "<AFH class. slave>",	LMP_AFH_CLS_SLV	},	/* Bit 4 */
+		{ "<AFH cap. perip.>",	LMP_AFH_CAP_SLV	},	/* Bit 3 */
+		{ "<AFH cls. perip.>",	LMP_AFH_CLS_SLV	},	/* Bit 4 */
 		{ "<BR/EDR not supp.>",	LMP_NO_BREDR	},	/* Bit 5 */
 		{ "<LE support>",	LMP_LE		},	/* Bit 6 */
 		{ "<3-slot EDR ACL>",	LMP_EDR_3SLOT	},	/* Bit 7 */
@@ -746,8 +754,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<5-slot EDR ACL>",	LMP_EDR_5SLOT	},	/* Bit 0 */
 		{ "<sniff subrating>",	LMP_SNIFF_SUBR	},	/* Bit 1 */
 		{ "<pause encryption>",	LMP_PAUSE_ENC	},	/* Bit 2 */
-		{ "<AFH cap. master>",	LMP_AFH_CAP_MST	},	/* Bit 3 */
-		{ "<AFH class. master>",LMP_AFH_CLS_MST	},	/* Bit 4 */
+		{ "<AFH cap. central>",	LMP_AFH_CAP_MST	},	/* Bit 3 */
+		{ "<AFH cls. central>", LMP_AFH_CLS_MST	},	/* Bit 4 */
 		{ "<EDR eSCO 2 Mbps>",	LMP_EDR_ESCO_2M	},	/* Bit 5 */
 		{ "<EDR eSCO 3 Mbps>",	LMP_EDR_ESCO_3M	},	/* Bit 6 */
 		{ "<3-slot EDR eSCO>",	LMP_EDR_3S_ESCO	},	/* Bit 7 */
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321a..0d1678f01d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -179,7 +179,7 @@ struct mgmt_cp_load_link_keys {
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	uint8_t type;
-	uint8_t master;
+	uint8_t central;
 	uint8_t enc_size;
 	uint16_t ediv;
 	uint64_t rand;
diff --git a/monitor/control.c b/monitor/control.c
index 266602a34c..dad23a0e62 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -308,13 +308,13 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 	/* LE SC keys are both for master and slave */
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Unauthenticated)";
 		else
 			type = "Slave (Unauthenticated)";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Authenticated)";
 		else
 			type = "Slave (Authenticated)";
diff --git a/src/adapter.c b/src/adapter.c
index 3f947c42a2..857a298ee0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4208,7 +4208,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->rand = cpu_to_le64(info->rand);
 		key->ediv = cpu_to_le16(info->ediv);
 		key->type = info->authenticated;
-		key->master = info->master;
+		key->central = info->master;
 		key->enc_size = info->enc_size;
 	}
 
@@ -8395,7 +8395,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		rand = le64_to_cpu(key->rand);
 
 		store_longtermkey(adapter, &key->addr.bdaddr,
-					key->addr.type, key->val, key->master,
+					key->addr.type, key->val, key->central,
 					key->type, key->enc_size, ediv, rand);
 
 		device_set_bonded(device, addr->type);
diff --git a/tools/oobtest.c b/tools/oobtest.c
index c095036fe7..0368bc3865 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -133,13 +133,13 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
 
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Unauthenticated, Master";
 		else
 			type = "Unauthenticated, Slave";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Authenticated, Master";
 		else
 			type = "Authenticated, Slave";
-- 
2.33.0.464.g1972c5931b-goog

