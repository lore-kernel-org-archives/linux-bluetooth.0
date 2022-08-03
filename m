Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA48C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 21:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiHCVzc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCVzb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 17:55:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AD6353
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 14:55:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h28so11310738pfq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pknXhGgsHb4suINCmJgPUcDHGxsQV4Z8idpu3OxHY2w=;
        b=SCcVQ6vnX6UC9XY5L4RMFU3NQLSNJHu2mchnhozrS7rA5N/sENP2aFSO4w3pXFzKEx
         de04RzR9p63+SaKXqxMRvyBnKmWoriOy5IK8i7qrH+SqVCHvPIQRDqrGXkzVgDiHuDKg
         6rfyFUM5IBCfE8le+poEGTrLIrNjgeLP59FRwouWwetf+6hnxTAN0DHQfEHV2MZKjuXk
         RI5zschlckqRkqBd5iOspcIz3yHZM1cG+f1+579vcWdfSA5tCNXgqc+2aB7pxQue+T9G
         584H4pqfkKLS7xFtkh5MCKCBvBVA/CXEDRtSe8oYKU+E6DF0R9ROz9H9PshD1KsIntJV
         nZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pknXhGgsHb4suINCmJgPUcDHGxsQV4Z8idpu3OxHY2w=;
        b=IXeRzn7nDXV1eKNqUIB/zMSbivzGG1IKz5ABqRRZqxrFr9pDunQsp47ThLMqXhHbt8
         71JRzfH0XPqDe46jnmc2189ptHLJRxbBU4714SkhyTYzLYrmmVRPPNKhAoYUbQKaLpwX
         +ELzJwLpT/ZxK+On2yj7vGhHaGTCt2yEdFRSZT+EvQq/eyp58bujb1w0P3FxGpTVcgJK
         sWD+WcHMt1jBb8tnhQmqqeq4hsT5AGlMsiAeviQw0LQKrWDArQOVTEYsB4LnhuP8/gFI
         LlcjE1j5ulV+CJByrng7VY85AY4ruFdiscbvKi/twwIYABRThJNJ/z9FSwjg+JcXOr8o
         fFYA==
X-Gm-Message-State: AJIora87j8YI0mbvbNq5OPA16dMF6dmD5pzLwk4P9yXDqqOcDDCOjSO/
        +9+JqHpEuVH37jNtzuKk8c8SqVegspaBVg==
X-Google-Smtp-Source: AGRyM1sd3uYd57mP4Z6FXr9lUEUAHyjIScY1JkURH150Wu7VanKvv7vC1AYvQ45YEMk3MOKJ05ra5g==
X-Received: by 2002:a63:2a89:0:b0:412:6e07:78fd with SMTP id q131-20020a632a89000000b004126e0778fdmr22166413pgq.161.1659563729721;
        Wed, 03 Aug 2022 14:55:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b0016bedcced2fsm2494052pls.35.2022.08.03.14.55.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:55:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Fix build warning with C=1
Date:   Wed,  3 Aug 2022 14:55:26 -0700
Message-Id: <20220803215527.3070932-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning when build with make C=1:

net/bluetooth/hci_event.c:337:15: warning: restricted __le16 degrades to integer

Fixes: a93661203641e ("Bluetooth: Process result of HCI Delete Stored Link Key command")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9ab359b15f57..395c6479456f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -328,14 +328,17 @@ static u8 hci_cc_delete_stored_link_key(struct hci_dev *hdev, void *data,
 					struct sk_buff *skb)
 {
 	struct hci_rp_delete_stored_link_key *rp = data;
+	u16 num_keys;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
 
-	if (rp->num_keys <= hdev->stored_num_keys)
-		hdev->stored_num_keys -= le16_to_cpu(rp->num_keys);
+	num_keys = le16_to_cpu(rp->num_keys);
+
+	if (num_keys <= hdev->stored_num_keys)
+		hdev->stored_num_keys -= num_keys;
 	else
 		hdev->stored_num_keys = 0;
 
-- 
2.37.1

