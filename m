Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A21C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C1460F43
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhIFIGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhIFIGF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E9C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:01 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id et12-20020a056214176c00b0037279a2ce4cso10523319qvb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vjdv2eDSSQjRfkdcX9Nk4TvGfDPdWk1rKNE7WNnSqEE=;
        b=ofSbZ9IyPYaH+X4JqR9HYZgG5nnBbCtXdbFeYYYEG//MQJ9wSc0UvNyWjeOswZKelo
         BQDq3JDcaXB6nYW6Xi1OhuM62T7J9WGXYWP0SY9T9ywAmzoGV8SHOhwFzv8My4TkqmEk
         MIfFyVXuM2gDjXPcZnzyCCwsDGPqVRldjCG8JP3FxmkhbXdjuHNLBAOG1QRttiy/4Vuc
         HOUnwxaE8GnRPm3m6FlFiHMSR8iz9IUToPxxHgAjIWFxC8vGtceZgxxIv+d8QB6XBE6L
         WPQqAjTLYWLMjTs8571Mq73G1emoNZBO38bt9XrSlC+xJKddG0SAs+BwZjfKbaNbPPYq
         44LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vjdv2eDSSQjRfkdcX9Nk4TvGfDPdWk1rKNE7WNnSqEE=;
        b=DiBDTyrb7Mdo4vBb43U4pES/StUnzU+N81kB1Pqla0ayZkzfP0UIlyIru8rE7gSUX0
         om1aDEu0BDEnQmECd5Z4mE4vpjRUfsZPICsS0rpEwnz0sCOiw5ehLzIYi0270UahoTUc
         cHGYEszOKDMORzFkF+gTwzz9RmwD4aXBKrmCkWyHHV6XtPa/IgW5IpKcK9tamNEoH3pf
         0xf/F0FtSbcUkHIBZPvRvX+SVy3w7C81yAKkWRFNRRmwbapCd1foWvdPQwNaUc5Yz4rF
         CdWpYlkJNQYvuVFMQnYGwhStuAbXpCt1ozp2NfpyR1U9AgEZfw0Y89Nj4WJMr6vJskV5
         eWgQ==
X-Gm-Message-State: AOAM530yaeGTRPR5Sj9Pl0+zYX4Yt+akaAawvHj4AHBNvjXui01i9uXh
        prznc0cZf6aQzx+31aTo2oRKBHbMSpM+WZqkpb/UC8Dmv6nYt7au5qrIrZJd28pOzqlijAFYjYN
        6qHgitSMQwV/lE++dDUAfA2TMQr+wIzSlQW+a/zgMOs2r7eqfqW4/XmAzlX8PWaJDeUt0KivFpt
        bp
X-Google-Smtp-Source: ABdhPJw/cWmKCcamu/+ueVOqZG91FWgrksGVlFHQKC25+jDJNbOXO7m7Y3Gm9av2gjXXB16tnUvx6g5MlKcJ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a05:6214:aaf:: with SMTP id
 ew15mr10782348qvb.14.1630915500417; Mon, 06 Sep 2021 01:05:00 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:39 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 01/12] lib: Inclusive language changes
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

(no changes since v3)

Changes in v3:
* Not replacing some terms which belong to libluetooth API

Changes in v2:
* Merging several patches from the same directory into one

 android/bluetooth.c |  4 ++--
 lib/hci.c           | 22 +++++++++++-----------
 lib/mgmt.h          |  2 +-
 monitor/control.c   |  4 ++--
 src/adapter.c       |  4 ++--
 tools/oobtest.c     |  4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

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
index 53af0a1148..a2dd7a2ae6 100644
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
@@ -345,7 +345,7 @@ static hci_map commands_map[] = {
 
 	{ "Set Connection Encryption",			16  },
 	{ "Change Connection Link Key",			17  },
-	{ "Master Link Key",				18  },
+	{ "Temporary Link Key",				18  },
 	{ "Remote Name Request",			19  },
 	{ "Cancel Remote Name Request",			20  },
 	{ "Read Remote Supported Features",		21  },
@@ -565,11 +565,11 @@ static hci_map commands_map[] = {
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
@@ -735,8 +735,8 @@ static hci_map lmp_features_map[8][9] = {
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
@@ -746,8 +746,8 @@ static hci_map lmp_features_map[8][9] = {
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
index ddd8967515..ac1e02af6c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4122,7 +4122,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->rand = cpu_to_le64(info->rand);
 		key->ediv = cpu_to_le16(info->ediv);
 		key->type = info->authenticated;
-		key->master = info->master;
+		key->central = info->master;
 		key->enc_size = info->enc_size;
 	}
 
@@ -8307,7 +8307,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
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
2.33.0.153.gba50c8fa24-goog

