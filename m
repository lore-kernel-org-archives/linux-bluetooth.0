Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF56C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 23:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3042360EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhHDXtR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhHDXtQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 19:49:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41297C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 16:49:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e21so4894902pla.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JeYgHT+3OrusWUlyyHJT6eGPZMPepIhAmE/H0vYYaQ=;
        b=HbZ8D6klBUXZqvAm59LvuSm18qCO6xROvKPwvzEcwx5P29y3LZRlzwH9wwMY6wy8EW
         +FHVDgP102IsheoDurLFpe3bmAtFdrebg+Legcn73Pgxx2p/I01ky7SXfms2/muZ9Fpv
         laLqwSu8Zz5J6pQIFgWdcknWq7lOa8rV9fXh0f6T1/3ioZJq7FlTVzj0LzXuBLnvVgiR
         ThN/iD79TTWYnTAH0tU/ubxgNLRS8lru+xKB+NzPsM/CNbqmeCTQ6ZR58W3Z7tsyU4dD
         Gu1ZZsaBBBeegjDnS8D136c449k9hQdtTlAcFdziBYC3/N5ko3cA7QGK2k+LCesn18At
         CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JeYgHT+3OrusWUlyyHJT6eGPZMPepIhAmE/H0vYYaQ=;
        b=r1B168iefaqbtXgxz9+GgkSyUSDr/F08oQBwqM8TJXb943eAj4ajvrG0bTx+RNduMn
         /sPzPVTPBeC7e4ogO286qFnTVoVpQWpHHQ8erOw0O6zVak5L+VqVpbU5So3r9NX8nnuC
         D0+CrOsteLkRjrAi0S0do/z9uzD1EWnEF3/nHHBan+Oqcd3oOklpcTsMKFGNZNpWxlPa
         327jnFWCd8h01FiTDUooUIT93juwg2ViyPS1tv/YCrtBh+2fUXvUOgxkiNb/kW4O357y
         tGKxykVhKLC0n1dzGiNmtESCJb2ZYUtTITBDHkkRytKDn1KB6Tscm2Rq0nRCvXT8h05t
         YiLQ==
X-Gm-Message-State: AOAM5328BI/oU3tbhqtL21oePd1+3vecVvx0RX9BA4ijYc49OdaaH1SX
        i0N56U2OFMD4X+T5BfEWZfnxRW6dDf0=
X-Google-Smtp-Source: ABdhPJykujqnVQ6L1OCw6bEd6qVTmIkEjCgQiNIy2OyCM4gMIYalOgFM0rZVs254z0wBo5Xy9+Eb8A==
X-Received: by 2002:a17:902:b713:b029:12b:b249:693f with SMTP id d19-20020a170902b713b029012bb249693fmr1425645pls.17.1628120941340;
        Wed, 04 Aug 2021 16:49:01 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s19sm4048874pfe.206.2021.08.04.16.49.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:49:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add proper handling for own_address_type 0x03
Date:   Wed,  4 Aug 2021 16:48:58 -0700
Message-Id: <20210804234858.345329-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When own_address_type is set to 0x03 the host expects the controller to
generate RPAs using the stored IRK from the resolving list and in
addition to that set the generated RPA as Local RPA in LE Enhanced
Connection Complete.
---
 emulator/btdev.c | 86 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c9ec22ebe..f8daf4587 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -83,6 +83,7 @@ struct le_ext_adv {
 	uint8_t direct_addr[6];		/* peer_addr */
 	uint8_t filter_policy;		/* filter_policy */
 	uint8_t random_addr[6];
+	bool rpa;
 	uint8_t adv_data[252];
 	uint8_t adv_data_len;
 	uint8_t scan_data[252];
@@ -298,24 +299,42 @@ static inline struct btdev *find_btdev_by_bdaddr(const uint8_t *bdaddr)
 	return NULL;
 }
 
+static bool match_adv_addr(const void *data, const void *match_data)
+{
+	const struct le_ext_adv *adv = data;
+	const uint8_t *bdaddr = match_data;
+
+	return !memcmp(adv->random_addr, bdaddr, 6);
+}
+
 static inline struct btdev *find_btdev_by_bdaddr_type(const uint8_t *bdaddr,
 							uint8_t bdaddr_type)
 {
 	int i;
 
 	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		struct btdev *dev = btdev_list[i];
 		int cmp;
+		struct le_ext_adv *adv;
 
-		if (!btdev_list[i])
+		if (!dev)
 			continue;
 
 		if (bdaddr_type == 0x01)
-			cmp = memcmp(btdev_list[i]->random_addr, bdaddr, 6);
+			cmp = memcmp(dev->random_addr, bdaddr, 6);
 		else
-			cmp = memcmp(btdev_list[i]->bdaddr, bdaddr, 6);
+			cmp = memcmp(dev->bdaddr, bdaddr, 6);
 
 		if (!cmp)
-			return btdev_list[i];
+			return dev;
+
+		/* Check for instance own Random addresses */
+		if (bdaddr_type == 0x01) {
+			adv = queue_find(dev->le_ext_adv, match_adv_addr,
+								bdaddr);
+			if (adv)
+				return dev;
+		}
 	}
 
 	return NULL;
@@ -3235,12 +3254,13 @@ static void le_set_adv_enable_complete(struct btdev *btdev)
 #define RL_ADDR_EQUAL(_rl, _type, _addr) \
 	(_rl->type == _type && !bacmp(&_rl->addr, (bdaddr_t *)_addr))
 
-static struct btdev_rl *rl_find(struct btdev *dev, uint8_t type, uint8_t *addr)
+static const struct btdev_rl *rl_find(const struct btdev *dev, uint8_t type,
+							const uint8_t *addr)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(dev->le_rl); i++) {
-		struct btdev_rl *rl = &dev->le_rl[i];
+		const struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, type, addr))
 			return rl;
@@ -4291,12 +4311,40 @@ static int cmd_set_default_phy(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static const uint8_t *ext_adv_gen_rpa(const struct btdev *dev,
+						struct le_ext_adv *adv)
+{
+	const struct btdev_rl *rl;
+
+	if (adv->rpa)
+		return adv->random_addr;
+
+	/* Lookup for Local IRK in the resolving list */
+	rl = rl_find(dev, adv->direct_addr_type, adv->direct_addr);
+	if (rl) {
+		uint8_t rpa[6];
+
+		bt_crypto_random_bytes(dev->crypto, rpa + 3, 3);
+		rpa[5] &= 0x3f; /* Clear two most significant bits */
+		rpa[5] |= 0x40; /* Set second most significant bit */
+		bt_crypto_ah(dev->crypto, rl->peer_irk, rpa + 3, rpa);
+
+		memcpy(adv->random_addr, rpa, sizeof(rpa));
+		adv->rpa = true;
+	}
+
+	return adv->random_addr;
+}
+
 static const uint8_t *ext_adv_addr(const struct btdev *btdev,
 						struct le_ext_adv *ext_adv)
 {
 	if (ext_adv->own_addr_type == 0x01)
 		return ext_adv->random_addr;
 
+	if (ext_adv->own_addr_type == 0x03)
+		return ext_adv_gen_rpa(btdev, ext_adv);
+
 	return btdev->bdaddr;
 }
 
@@ -4504,6 +4552,23 @@ static int cmd_set_ext_scan_rsp_data(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static uint8_t ext_adv_addr_type(struct le_ext_adv *adv)
+{
+	/* Converts the address type on advertising params to advertising
+	 * report.
+	 */
+	switch (adv->own_addr_type) {
+	/* LL RPAs shall be advertised as random type or they need to be
+	 * resolved depending on the filter policy.
+	 */
+	case 0x02:
+	case 0x03:
+		return 0x01;
+	}
+
+	return adv->own_addr_type;
+}
+
 static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					struct le_ext_adv *ext_adv,
 					uint16_t type, bool is_scan_rsp)
@@ -4519,7 +4584,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 	memset(&meta_event.lear, 0, sizeof(meta_event.lear));
 	meta_event.num_reports = 1;
 	meta_event.lear.event_type = cpu_to_le16(type);
-	meta_event.lear.addr_type = ext_adv->own_addr_type;
+	meta_event.lear.addr_type = ext_adv_addr_type(ext_adv);
 	memcpy(meta_event.lear.addr, ext_adv_addr(remote, ext_adv), 6);
 	meta_event.lear.rssi = 127;
 	meta_event.lear.tx_power = 127;
@@ -5022,6 +5087,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memcpy(ev.peer_addr, cmd->peer_addr, 6);
 	ev.role = 0x00;
 
+	/* Set Local RPA if an RPA was generated for the advertising */
+	if (ext_adv->rpa)
+		memcpy(ev.local_rpa, ext_adv->random_addr,
+					sizeof(ev.local_rpa));
+
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
 }
@@ -5048,7 +5118,7 @@ static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
 
 		if (ext_adv_is_connectable(ext_adv) &&
 			ext_adv_match_addr(dev, ext_adv) &&
-			ext_adv->own_addr_type == cmd->peer_addr_type) {
+			ext_adv_addr_type(ext_adv) == cmd->peer_addr_type) {
 			le_ext_conn_complete(dev, cmd, ext_adv, 0);
 			return 0;
 		}
-- 
2.31.1

