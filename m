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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE445C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E544610E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhHMMXm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbhHMMXl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:41 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD9C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s3-20020a1709029883b029012b41197000so6001561plp.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7xzETMpxEZ8vnD37Y2B29yZwHfn1Z3ER/O6TYDfKNsE=;
        b=Mhfoes5LM9KiWL/M4IHNjbn2JEzgk4pEngILipR7iAm7ZcHEGF5ivPW678yZYW2c1f
         DYqGkSPwo0B0pfwm+UW2t0ruBHhjroeXWQHz2ga/c8+4SWoBzUZ5djSvlEpSZowA9RUQ
         Inhv7rAW8Tkiwt5L45KtYMlHb0QcyP4CqgIK1AivSjc2QXx87x0NGZ2VigNrlfxpjWy+
         jqMit502NZkiZUflkxuMGetA0BAP0DP4rhHL6Cb5ChVjNSg7BqXgq/O6hF71uU117WRF
         /Sx8JG2/dbQPHomTAkXg4+ubIZmxPK4SQpQq7LDomOTSx1cNL0X7puDoVXVhYmFkNEey
         VZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7xzETMpxEZ8vnD37Y2B29yZwHfn1Z3ER/O6TYDfKNsE=;
        b=SYOoJST0YU3BqdfYMQ9RGzo9RaEtVtyhGd5zkqK5agzFVi0lVJO0DAsKWjtYR+ZBWx
         Y7klLTsL/Drx7jKFiPuk5AK2qK5sav+vXReBLWfOPDRC9QvYAw0ZVRbMd4KjlUljP4p7
         DvjgzxUj6HnVXZ29VCK3h19QkMwLnOrpEeLY+l8GCLF4Vuna6ulnDXrm7ZiiZ5+aMJmg
         0fl02LyHWFrJ+VZBlk8IN7plzi3G6n89x5hlCfW0D3rHWbfto/TFPNkvgii/wrYvrcF2
         OnidQRK7G3Co1gFRaO6ULG1NeWMOGIXIE+E4REe53OCr+UMAcmjn6B2WDVFQ5BnK0J+T
         xk7A==
X-Gm-Message-State: AOAM532HrwoVnFpLxvojimVa42RLvJKaXuQdasHHuKHoU8X2g5qdNklI
        F7ZavQ+8UHVuT6NjWDRiYvisOpFWumDzoaphGaAytEveDvFLd3hqdqshzXEQXvsy+IIG9z/Ldin
        NMp+djbUlb5LhmkcpSRqgTZuvxBE8+ZmJETAVQkRWzb9eC8lTDTZAE+L2GK01h/7xHP7gzV+9Vd
        O5
X-Google-Smtp-Source: ABdhPJzPV548mJF9OXykGwcClcLAxdIHHgHUiJNjLw9j+U3GGvoswf6XOBmTA7Lj8ZDv25CgJQQSmi6lmHpG
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP
 id p12-20020a170902a40cb029012c17cfab6fmr1937025plq.71.1628857394616; Fri, 13
 Aug 2021 05:23:14 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:45 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.60.I8ce98773a3c7b07aa598fa6601215cac02fd7d31@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 60/62] android: Inclusive language for describing relation
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

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 android/bluetooth.c   | 40 ++++++++++++++++++++--------------------
 android/tester-main.c |  8 ++++----
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fe956b5d43..b5f584eea2 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2198,7 +2198,7 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 	dev->in_white_list = false;
 }
 
-static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
+static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool central,
 			const uint8_t *key, uint8_t key_type, uint8_t enc_size,
 			uint16_t ediv, uint64_t rand)
 {
@@ -2218,11 +2218,11 @@ static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
 
 	ba2str(dst, addr);
 
-	key_s = master ? "LongTermKey" : "SlaveLongTermKey";
-	keytype_s = master ? "LongTermKeyType" : "SlaveLongTermKeyType";
-	encsize_s = master ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
-	ediv_s = master ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
-	rand_s = master ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+	key_s = central ? "LongTermKey" : "SlaveLongTermKey";
+	keytype_s = central ? "LongTermKeyType" : "SlaveLongTermKeyType";
+	encsize_s = central ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
+	ediv_s = central ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
+	rand_s = central ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
@@ -3059,18 +3059,18 @@ failed:
 }
 
 static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
-								bool master)
+								bool central)
 {
 	const char *key_s, *keytype_s, *encsize_s, *ediv_s, *rand_s;
 	struct mgmt_ltk_info *info = NULL;
 	char *key;
 	unsigned int i;
 
-	key_s = master ? "LongTermKey" : "SlaveLongTermKey";
-	keytype_s = master ? "LongTermKeyType" : "SlaveLongTermKeyType";
-	encsize_s = master ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
-	ediv_s = master ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
-	rand_s = master ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+	key_s = central ? "LongTermKey" : "SlaveLongTermKey";
+	keytype_s = central ? "LongTermKeyType" : "SlaveLongTermKeyType";
+	encsize_s = central ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
+	ediv_s = central ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
+	rand_s = central ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
 
 	key = g_key_file_get_string(key_file, peer, key_s, NULL);
 	if (!key || strlen(key) != 32)
@@ -3097,7 +3097,7 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
 	info->ediv = cpu_to_le16(info->ediv);
 
-	info->central = master;
+	info->central = central;
 
 failed:
 	g_free(key);
@@ -3201,7 +3201,7 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		struct mgmt_link_key_info *key_info;
 		struct mgmt_ltk_info *ltk_info;
 		struct mgmt_irk_info *irk_info;
-		struct mgmt_ltk_info *slave_ltk_info;
+		struct mgmt_ltk_info *peripheral_ltk_info;
 		struct device *dev;
 
 		dev = create_device_from_info(key_file, devs[i]);
@@ -3209,15 +3209,15 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		key_info = get_key_info(key_file, devs[i]);
 		irk_info = get_irk_info(key_file, devs[i]);
 		ltk_info = get_ltk_info(key_file, devs[i], true);
-		slave_ltk_info = get_ltk_info(key_file, devs[i], false);
+		peripheral_ltk_info = get_ltk_info(key_file, devs[i], false);
 
 		/*
 		 * Skip devices that have no permanent keys
 		 * (CSRKs are loaded by create_device_from_info())
 		 */
 		if (!dev->valid_local_csrk && !dev->valid_remote_csrk &&
-						!key_info && !ltk_info &&
-						!slave_ltk_info && !irk_info) {
+					!key_info && !ltk_info &&
+					!peripheral_ltk_info && !irk_info) {
 			error("Failed to load keys for %s, skipping", devs[i]);
 			free_device(dev);
 			continue;
@@ -3235,11 +3235,11 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		if (ltk_info)
 			ltks = g_slist_prepend(ltks, ltk_info);
 
-		if (slave_ltk_info)
-			ltks = g_slist_prepend(ltks, slave_ltk_info);
+		if (peripheral_ltk_info)
+			ltks = g_slist_prepend(ltks, peripheral_ltk_info);
 
 		if (dev->valid_local_csrk || dev->valid_remote_csrk ||
-				irk_info || ltk_info || slave_ltk_info) {
+				irk_info || ltk_info || peripheral_ltk_info) {
 			dev->le_paired = true;
 			dev->le_bonded = true;
 		}
diff --git a/android/tester-main.c b/android/tester-main.c
index ff5ecdf834..05ced5fb4c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2784,17 +2784,17 @@ void emu_remote_connect_hci_action(void)
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
 	struct step *step = g_new0(struct step, 1);
-	const uint8_t *master_addr;
+	const uint8_t *central_addr;
 
-	master_addr = hciemu_get_central_bdaddr(data->hciemu);
+	central_addr = hciemu_get_central_bdaddr(data->hciemu);
 
 	tester_print("Trying to connect hci");
 
 	if (action_data)
-		bthost_hci_connect(bthost, master_addr,
+		bthost_hci_connect(bthost, central_addr,
 						action_data->bearer_type);
 	else
-		bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
+		bthost_hci_connect(bthost, central_addr, BDADDR_BREDR);
 
 	step->action_status = BT_STATUS_SUCCESS;
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

