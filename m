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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E5C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 23:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0306F61476
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 23:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhDWXyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhDWXyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 19:54:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891DBC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 16:53:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o16so12378860plg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 16:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J2DionFKjNT4fgCFR+e8Yg0yjQp4gZ2+ESUpauw3qM4=;
        b=cEJxPb0m2qZe63meono/O8VVRuFncz5XkxBs1XyT5GYLIBBhDYqwRFXsxOYFWbQvh9
         o9nkEqv2UD5XRl3xNuwpn9AlQ0iIhlxEuyYFxB3aI4EM6oW8g+PGmRq0FKEY+huTmogI
         tZejxn75z2RUQwuJ7+cNnoAJR1uZN6zULILO6hvSl4alJiqwXdJnx3h4OUi5a6YlL3/U
         yqJosiUm6XQOEnFND//9E0snC2Sh30D7UXSq6DkKZjqAcdOUjK6OtwC4ISx6//R0tP+Y
         ecgWxZNs34Id+aGGVgA0WDODnjBcR5BakZaIbRBu1CRsldioaDmxnCrhfbf+v7cZOAi/
         50LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2DionFKjNT4fgCFR+e8Yg0yjQp4gZ2+ESUpauw3qM4=;
        b=nD5o8OAjc39LZxFKng3oyUNsuvbZ8fS4+RpGp5/Ryuqgzh48iTvU8ffrQ6Mu8CBRl4
         VnlWQ3m6FBtIo+27jPOQ5+DaPTUdWdLIl2G1icfCZJlqfWkVF5tgrBTc1L9Yfo+zhzXN
         vucHIKpb8vydfrvibFbFPx/hqdU/udPa4a//JtIYSojtt1runCZeGOhwCJvSwftFKC7A
         iS1RXTtolerp3yCab5tJhvuu6mAQEMpjV4oplnLNYBCW3vBCT3gqjlDg9aPUmX0/xs+0
         P+NQ2g5T8qip+76+RozRvFPGKOAY65imEf/6lyWQI7kwe9TiBThQTnUQJACeojNN4/hK
         JkCw==
X-Gm-Message-State: AOAM532rgs/Nrbg3dPTP/4DLRljK01YmUIQruN1tWz+1arSqTQezurnG
        7jNaoMY38uwQknKQ9jRaUifLxnjMj5c=
X-Google-Smtp-Source: ABdhPJzGRNAcYK+Gh5mr3GPauw9L49Kek9pTspKzUBg7dUTnH2KYCQUv4vKu79afSCROXYHCT7nDiw==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr8418011pjb.114.1619222034991;
        Fri, 23 Apr 2021 16:53:54 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e1c:a9e3:7268:3bbf])
        by smtp.gmail.com with ESMTPSA id v64sm5792318pfc.117.2021.04.23.16.53.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 16:53:54 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] tools/mgmt-tester: Fix to support emulator spec 5.2
Date:   Fri, 23 Apr 2021 16:53:52 -0700
Message-Id: <20210423235352.33965-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423235352.33965-1-hj.tedd.an@gmail.com>
References: <20210423235352.33965-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the check for supported spec by the BT emulator to
support HCI spec 5.2
---
 tools/mgmt-tester.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index b05ae4f27..de35008ad 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5552,7 +5552,7 @@ static void setup_bthost(void)
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE ||
 		test->client_enable_adv) {
-		if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+		if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
 			bthost_set_ext_adv_enable(bthost, 0x01);
 		else
 			bthost_set_adv_enable(bthost, 0x01);
@@ -8887,7 +8887,7 @@ static void trigger_device_found(void *user_data)
 							test->adv_data_len);
 
 		bthost_set_adv_enable(bthost, 0x01);
-	} else if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50) {
+	} else if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
 		if (test->set_adv)
 			bthost_set_ext_adv_data(bthost, test->adv_data,
 							test->adv_data_len);
@@ -9054,7 +9054,7 @@ static void le_connected_event(uint16_t index, uint16_t length,
 
 	test_add_condition(data);
 
-	if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+	if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
 		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
 					BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
 					test_adv_enable_hook, data);
@@ -9101,7 +9101,7 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+	if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
 		bthost_hci_ext_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
 	else
 		bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
-- 
2.25.1

