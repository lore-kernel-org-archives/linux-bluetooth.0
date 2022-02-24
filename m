Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF11C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiBXAbL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBXAbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811226E34D
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v4so529866pjh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bes3roHlNFOFnWbovj/EDVIKI3u6AKmdoM06/CCIA4Q=;
        b=HRm0jEfXxqZoJqUld4+rhfSpqyjAfAsuWqS6qBTFnfAQdBg3rETOdjz+fkTkZn3tm8
         CYuL1BMGjWnMyEI5qLlRwX4zQaAmlw3OHqSu5gtJnCLNRenwPLVAe8ESTblSUQ7gQrER
         8nnPfpVEm4IyDpIk6pQxC72DNonqLtBNiUpxKdTC8I41HQaEn9HwwLEfUWLkVfCD7SFX
         k3/i5unMPa9IfFCF9NuPoRiOncTiBCypS0b3Li75jSC+S6lN9tHtmaoWGRY4IUsI7izR
         fcEEvzRIB++dSdAtW4s7/4ILjGIZdDwr+OZs87+4bslUEb7Wt+xGHC7+Cjb2zBfn6ItA
         r+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bes3roHlNFOFnWbovj/EDVIKI3u6AKmdoM06/CCIA4Q=;
        b=Jsh5AYawdwHrAjLil+Ai1TKrkNIckBTA8uqUjfQyAC1qWth5XZWIvtgESOKpo/0Vq+
         IdlF7/dwgogTfmp2fSXc6ay5Bjoyy3+vLjUJqYGmdtekIcxBUPcfT0WSpu00xM5fvijB
         ksa+KWAKh8dSfzkUVrXiOZ/ikCrPGzW0Gt/uCpZ7BlZAFaINg77oCBXUwY5pXbV5idT6
         f2aWmsLMBatXp4N8cn9ZunbjLjvBpa3KQjox9f8FEqkDDxVqBvKjPuoZilGb/hFsIyYy
         yJALzOzJjTUi8eXN3AXUIVf3At1wELBojbTFZ3tPdJx9DMwnzH1VMoU4pL1vV8XYGXtm
         0ypA==
X-Gm-Message-State: AOAM531rWPLewKc3Zhjr+09va13WXULeT/qM66+YeUDNlx5xcGh+hLqC
        nPw4p2DeFjsblzUftG1XrgwkZT71nWs=
X-Google-Smtp-Source: ABdhPJwi2ukGrHR2fKhO0/24BzkmHJhiMZ5AMBF6PHwmChu/x8GAaUvQSb5njynKJZ+eh/pgFUjlFg==
X-Received: by 2002:a17:903:4084:b0:14f:cf98:5515 with SMTP id z4-20020a170903408400b0014fcf985515mr50487plc.124.1645662639621;
        Wed, 23 Feb 2022 16:30:39 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/11] bthost: Add support for Periodic Advertising
Date:   Wed, 23 Feb 2022 16:30:28 -0800
Message-Id: <20220224003029.706163-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_set_pa_params and bthost_set_pa_enable.
---
 emulator/bthost.c | 19 +++++++++++++++++++
 emulator/bthost.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index d751e7dd4..fef542236 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2801,6 +2801,25 @@ void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cp, 6);
 }
 
+void bthost_set_pa_params(struct bthost *bthost)
+{
+	struct bt_hci_cmd_le_set_pa_params cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_SET_PA_PARAMS, &cp, sizeof(cp));
+}
+
+void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_pa_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+	cp.handle = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 868af5469..55a7adf26 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -84,6 +84,8 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
 void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
+void bthost_set_pa_params(struct bthost *bthost);
+void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
-- 
2.35.1

