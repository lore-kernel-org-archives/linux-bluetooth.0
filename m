Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED25C6379F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjBNCQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 21:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjBNCQL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 21:16:11 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD031ADCE
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 18:16:10 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id v13so4329478iln.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5uVXaVMHhiVDs4qzCAUHJtOpttw9lBWwp0KsxyPicc=;
        b=GtXYcYmsm692v1WvoATVSeSvcmfD1YkvL/z+8Jt8nhjkczccMwI/HmkC2+k22Cqc0U
         dtnSyUcKF6QeQmDwTw3YN33A1OGU6DPSlFGkGKr9gqioyTM7VbOwXnorEbmGVMDAg2lV
         tO/1lyVwxV4PqWcA2AccFbzLNpHTqWInWTkC+rqgz8J98/dkLGpQmTExxkMYHdeNSLwF
         IBbEzjoX253wfuSIdnrUDjURmLTLzq+O9veY8+55J95fbRiu9XbY+3Vtnb9TvfPcS3vK
         lU2F9Ui+fqQLbdD+eVIjfY/ahAYv9wd3mBVRSuOFfdcPTByXyAh1KrCgwItVxdhPC9OI
         xCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5uVXaVMHhiVDs4qzCAUHJtOpttw9lBWwp0KsxyPicc=;
        b=HZ1/0hU7HNqDjhBBSJPuj8nTOxJAIDYZHPsNbr8nIbG/oEoOJ1Uihc8P/yABjbQpRq
         uCaX1+mDrHJxsFPqoJ41TYjFrCxksadS7akR6CiVfO+A6SMN+TWs+tN2DshkMixf9B2d
         5ZxArX+BFUldD5I71E8RCho9x07KXTnWuTq3x5JP5nn+IoqGDzpGeOYfyjPU2Nveae4M
         giswAOJrrZUHKDnvqDLLF2/M310R4FmgA7o5VXRrAngXPLB7+Qs2bBID459vOXzCpsfj
         PrF+ChPfLCvaz8IB71gd2zX/m8SSdqrVJ23sdbKl9+uOYqYUuZgKAMDk+pa/nI94VDXs
         npWQ==
X-Gm-Message-State: AO0yUKUlzXhXpq4b681+v1Y2T6oFsoaDRgIrHXdZ7Y2gEsa/7BdrlzMX
        EuBI0CnBAGXN8rRhkyDIILvk8zGnMwM=
X-Google-Smtp-Source: AK7set8kj6dG/fienOMipOIt3iTW8V+0u+x/iRpULJZs0T2crrP3olCO7p9/m6FPKXXYXq7roNrzHA==
X-Received: by 2002:a05:6e02:12cf:b0:313:b9d5:7d4a with SMTP id i15-20020a056e0212cf00b00313b9d57d4amr830158ilm.26.1676340968983;
        Mon, 13 Feb 2023 18:16:08 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id q8-20020a02c8c8000000b003a7cadffda7sm4382045jao.2.2023.02.13.18.16.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 18:16:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt: Use BIT macro when defining bitfields
Date:   Mon, 13 Feb 2023 18:16:06 -0800
Message-Id: <20230214021606.647442-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BIT macro when defining bitfields which makes it
clearer what bit it is toggling.
---
 lib/mgmt.h | 117 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 56 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index efbdfb4b17c1..59273c85a69f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -12,6 +12,10 @@
 #define __packed __attribute__((packed))
 #endif
 
+#ifndef BIT
+#define BIT(n)  (1 << (n))
+#endif
+
 #define MGMT_INDEX_NONE			0xFFFF
 
 #define MGMT_STATUS_SUCCESS		0x00
@@ -78,26 +82,26 @@ struct mgmt_rp_read_index_list {
 #define MGMT_MAX_NAME_LENGTH		(248 + 1)
 #define MGMT_MAX_SHORT_NAME_LENGTH	(10 + 1)
 
-#define MGMT_SETTING_POWERED		0x00000001
-#define MGMT_SETTING_CONNECTABLE	0x00000002
-#define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
-#define MGMT_SETTING_DISCOVERABLE	0x00000008
-#define MGMT_SETTING_BONDABLE		0x00000010
-#define MGMT_SETTING_LINK_SECURITY	0x00000020
-#define MGMT_SETTING_SSP		0x00000040
-#define MGMT_SETTING_BREDR		0x00000080
-#define MGMT_SETTING_HS			0x00000100
-#define MGMT_SETTING_LE			0x00000200
-#define MGMT_SETTING_ADVERTISING	0x00000400
-#define MGMT_SETTING_SECURE_CONN	0x00000800
-#define MGMT_SETTING_DEBUG_KEYS		0x00001000
-#define MGMT_SETTING_PRIVACY		0x00002000
-#define MGMT_SETTING_CONFIGURATION	0x00004000
-#define MGMT_SETTING_STATIC_ADDRESS	0x00008000
-#define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
-#define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
-#define MGMT_SETTING_CIS_CENTRAL	0x00040000
-#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
+#define MGMT_SETTING_POWERED		BIT(0)
+#define MGMT_SETTING_CONNECTABLE	BIT(1)
+#define MGMT_SETTING_FAST_CONNECTABLE	BIT(2)
+#define MGMT_SETTING_DISCOVERABLE	BIT(3)
+#define MGMT_SETTING_BONDABLE		BIT(4)
+#define MGMT_SETTING_LINK_SECURITY	BIT(5)
+#define MGMT_SETTING_SSP		BIT(6)
+#define MGMT_SETTING_BREDR		BIT(7)
+#define MGMT_SETTING_HS			BIT(8)
+#define MGMT_SETTING_LE			BIT(9)
+#define MGMT_SETTING_ADVERTISING	BIT(10)
+#define MGMT_SETTING_SECURE_CONN	BIT(11)
+#define MGMT_SETTING_DEBUG_KEYS		BIT(12)
+#define MGMT_SETTING_PRIVACY		BIT(13)
+#define MGMT_SETTING_CONFIGURATION	BIT(14)
+#define MGMT_SETTING_STATIC_ADDRESS	BIT(15)
+#define MGMT_SETTING_PHY_CONFIGURATION	BIT(16)
+#define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
+#define MGMT_SETTING_CIS_CENTRAL	BIT(18)
+#define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -495,23 +499,23 @@ struct mgmt_rp_add_advertising {
 	uint8_t instance;
 } __packed;
 
-#define MGMT_ADV_FLAG_CONNECTABLE	(1 << 0)
-#define MGMT_ADV_FLAG_DISCOV		(1 << 1)
-#define MGMT_ADV_FLAG_LIMITED_DISCOV	(1 << 2)
-#define MGMT_ADV_FLAG_MANAGED_FLAGS	(1 << 3)
-#define MGMT_ADV_FLAG_TX_POWER		(1 << 4)
-#define MGMT_ADV_FLAG_APPEARANCE	(1 << 5)
-#define MGMT_ADV_FLAG_LOCAL_NAME	(1 << 6)
-#define MGMT_ADV_FLAG_SEC_1M		(1 << 7)
-#define MGMT_ADV_FLAG_SEC_2M		(1 << 8)
-#define MGMT_ADV_FLAG_SEC_CODED		(1 << 9)
-#define MGMT_ADV_FLAG_CAN_SET_TX_POWER	(1 << 10)
-#define MGMT_ADV_FLAG_HW_OFFLOAD	(1 << 11)
-#define MGMT_ADV_PARAM_DURATION		(1 << 12)
-#define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
-#define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
-#define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
-#define MGMT_ADV_PARAM_SCAN_RSP		(1 << 16)
+#define MGMT_ADV_FLAG_CONNECTABLE	BIT(0)
+#define MGMT_ADV_FLAG_DISCOV		BIT(1)
+#define MGMT_ADV_FLAG_LIMITED_DISCOV	BIT(2)
+#define MGMT_ADV_FLAG_MANAGED_FLAGS	BIT(3)
+#define MGMT_ADV_FLAG_TX_POWER		BIT(4)
+#define MGMT_ADV_FLAG_APPEARANCE	BIT(5)
+#define MGMT_ADV_FLAG_LOCAL_NAME	BIT(6)
+#define MGMT_ADV_FLAG_SEC_1M		BIT(7)
+#define MGMT_ADV_FLAG_SEC_2M		BIT(8)
+#define MGMT_ADV_FLAG_SEC_CODED		BIT(9)
+#define MGMT_ADV_FLAG_CAN_SET_TX_POWER	BIT(10)
+#define MGMT_ADV_FLAG_HW_OFFLOAD	BIT(11)
+#define MGMT_ADV_PARAM_DURATION		BIT(12)
+#define MGMT_ADV_PARAM_TIMEOUT		BIT(13)
+#define MGMT_ADV_PARAM_INTERVALS	BIT(14)
+#define MGMT_ADV_PARAM_TX_POWER		BIT(15)
+#define MGMT_ADV_PARAM_SCAN_RSP		BIT(16)
 
 #define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
 				 MGMT_ADV_FLAG_SEC_CODED)
@@ -563,21 +567,21 @@ struct mgmt_rp_get_phy_confguration {
 	uint32_t	selected_phys;
 } __packed;
 
-#define MGMT_PHY_BR_1M_1SLOT	0x00000001
-#define MGMT_PHY_BR_1M_3SLOT	0x00000002
-#define MGMT_PHY_BR_1M_5SLOT	0x00000004
-#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
-#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
-#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
-#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
-#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
-#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
-#define MGMT_PHY_LE_1M_TX		0x00000200
-#define MGMT_PHY_LE_1M_RX		0x00000400
-#define MGMT_PHY_LE_2M_TX		0x00000800
-#define MGMT_PHY_LE_2M_RX		0x00001000
-#define MGMT_PHY_LE_CODED_TX	0x00002000
-#define MGMT_PHY_LE_CODED_RX	0x00004000
+#define MGMT_PHY_BR_1M_1SLOT		BIT(0)
+#define MGMT_PHY_BR_1M_3SLOT		BIT(1)
+#define MGMT_PHY_BR_1M_5SLOT		BIT(2)
+#define MGMT_PHY_EDR_2M_1SLOT		BIT(3)
+#define MGMT_PHY_EDR_2M_3SLOT		BIT(4)
+#define MGMT_PHY_EDR_2M_5SLOT		BIT(5)
+#define MGMT_PHY_EDR_3M_1SLOT		BIT(6)
+#define MGMT_PHY_EDR_3M_3SLOT		BIT(7)
+#define MGMT_PHY_EDR_3M_5SLOT		BIT(8)
+#define MGMT_PHY_LE_1M_TX		BIT(9)
+#define MGMT_PHY_LE_1M_RX		BIT(10)
+#define MGMT_PHY_LE_2M_TX		BIT(11)
+#define MGMT_PHY_LE_2M_RX		BIT(12)
+#define MGMT_PHY_LE_CODED_TX		BIT(13)
+#define MGMT_PHY_LE_CODED_RX		BIT(14)
 
 #define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
 			     MGMT_PHY_LE_CODED_TX)
@@ -891,10 +895,11 @@ struct mgmt_ev_auth_failed {
 	uint8_t status;
 } __packed;
 
-#define MGMT_DEV_FOUND_CONFIRM_NAME		0x01
-#define MGMT_DEV_FOUND_LEGACY_PAIRING		0x02
-#define MGMT_DEV_FOUND_NOT_CONNECTABLE		0x04
-#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	0x10
+#define MGMT_DEV_FOUND_CONFIRM_NAME		BIT(0)
+#define MGMT_DEV_FOUND_LEGACY_PAIRING		BIT(1)
+#define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
+#define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
+#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
-- 
2.37.3

