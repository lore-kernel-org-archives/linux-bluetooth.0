Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 22:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiCKWyz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiCKWyj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748928CF93
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:28:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g19so9047802pfc.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5DosLDmv1BAcvPYhR9fh72KPat2snITqbLojqfyqnE=;
        b=hhN1S/buL0EQbOi00QvWxU+OK01NWCnVSQjZ4E/1ZOYfKsIpyOr+VcLnVtUB/2ezqP
         8VXN3RS1zFrAi34rI7sCcHIoXLW2PcqoAjbYGa8mrUVoU4p5+w2y+rUCheNs74lGSH3B
         CUBpyaw/m+ih8vX/LIUYBt/S9qsoLkBce7AYsuHARxUskG3o+A42eAhArIDj+0MXEucY
         4o6/S20iM6cz9pS2CqLx5xFo0rfUeXg6k9bwQMk1deZiFFdU/RbfY1t9SCKzJNuyrYn3
         LX5eR8Pnq29Rn8CecJuZxAEr+qtq0ETof1IPXdjqjM1emKeZ8lO1gF9wmTISI0qNlumX
         Kw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5DosLDmv1BAcvPYhR9fh72KPat2snITqbLojqfyqnE=;
        b=hw8FF88cew9mHTqKRbnVyl0gx7LkWxl6rCLHSTaH2gpKQ15+SsJ4IqgWPSyrsbJImt
         VDER7A+T1NQHiGJuWkNk/+sqZjy/qId1j9vJ169AT2UK24R6CSkDsTiQZW9bJNvOLvRp
         4Dk1FCRAdFQYG9KXpzW6NPUwV+osY5hEj1fs/2o6CppVTqxCAbbz9VkPa4aSA8oI3ASc
         n5LRHwFXYD3WAepKqiDGaRV4xO8iUVpQe/3B8cXLPI5wjO0P1RRvhw+vjYhf0lZ6rbd7
         Csuh6+4hq9cyEx7a2rniIcinrwPm8VavSiUBsGExycZZ0ZuD6u9M8pXsW7cgx/Pyxy06
         U5ag==
X-Gm-Message-State: AOAM533E0Aoo5xDQVbCuyWYk5LUMiwfwPIK+mkxWhWzxjwM5RuGodCT2
        5Rm3yDSRgMr8mXCL8Rm2tM1y35nDSlI=
X-Google-Smtp-Source: ABdhPJyc3LnHz/CPuzjnmAtqLyNPH3A+D13Y/yIgxwWjlh9M4g3K+GYDk7PVhTjDboYvpK8WDalSuw==
X-Received: by 2002:a05:6a00:8cc:b0:4bc:3def:b616 with SMTP id s12-20020a056a0008cc00b004bc3defb616mr12070739pfu.18.1647037699233;
        Fri, 11 Mar 2022 14:28:19 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mt15-20020a17090b230f00b001bf191e6f08sm10284694pjb.9.2022.03.11.14.28.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 14:28:18 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] bthost: Add support for Create CIS
Date:   Fri, 11 Mar 2022 14:28:17 -0800
Message-Id: <20220311222817.3397739-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces bthost_set_cig_params and bthost_create_cis.
---
 emulator/btdev.c  |  2 +-
 emulator/bthost.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  6 ++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 6834ec1c2..09eadd24f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5764,7 +5764,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 	memset(&evt, 0, sizeof(evt));
 
 	evt.status = status;
-	evt.conn_handle = cpu_to_le16(conn->handle);
+	evt.conn_handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
 
 	if (!evt.status) {
 		struct btdev *remote = conn->link->dev;
diff --git a/emulator/bthost.c b/emulator/bthost.c
index f629f2e6e..a7a0b8428 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3127,6 +3127,48 @@ bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 	return false;
 }
 
+void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
+						uint8_t cis_id)
+{
+	struct bt_hci_cmd_le_set_cig_params *cp;
+
+	cp = malloc(sizeof(*cp) + sizeof(*cp->cis));
+	memset(cp, 0, sizeof(*cp) + sizeof(*cp->cis));
+	cp->cig_id = cig_id;
+	put_le24(10000, cp->c_interval);
+	put_le24(10000, cp->p_interval);
+	cp->c_latency = cpu_to_le16(10);
+	cp->p_latency = cpu_to_le16(10);
+	cp->num_cis = 0x01;
+	cp->cis[0].cis_id = cis_id;
+	cp->cis[0].c_sdu = 40;
+	cp->cis[0].p_sdu = 40;
+	cp->cis[0].c_phy = 0x02;
+	cp->cis[0].p_phy = 0x02;
+	cp->cis[0].c_rtn = 2;
+	cp->cis[0].p_rtn = 2;
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_CIG_PARAMS, cp,
+				sizeof(*cp) + sizeof(*cp->cis));
+	free(cp);
+}
+
+void bthost_create_cis(struct bthost *bthost, uint16_t cis_handle,
+						uint16_t acl_handle)
+{
+	struct bt_hci_cmd_le_create_cis *cp;
+
+	cp = malloc(sizeof(*cp) + sizeof(*cp->cis));
+	memset(cp, 0, sizeof(*cp) + sizeof(*cp->cis));
+	cp->num_cis = 0x01;
+	cp->cis[0].cis_handle = cpu_to_le16(cis_handle);
+	cp->cis[0].acl_handle = cpu_to_le16(acl_handle);
+
+	send_command(bthost, BT_HCI_CMD_LE_CREATE_CIS, cp,
+				sizeof(*cp) + sizeof(*cp->cis));
+	free(cp);
+}
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, &mode, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index ae5678009..fd177ac29 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -100,6 +100,12 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
+void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
+						uint8_t cis_id);
+void bthost_create_cis(struct bthost *bthost, uint16_t cis_handle,
+						uint16_t acl_handle);
+
+
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
 				uint8_t addr_type, uint8_t filter_policy);
 void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable);
-- 
2.35.1

