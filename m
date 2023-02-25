Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA8CC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjBYAVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYAVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 19:21:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193F6F83A
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so915386pjp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEehvGyjyYp8SIKtPtm2hjz1jaUYESC95Csw9+5/Qh0=;
        b=E4mMaTw2G2wR1IuTAHzyp/gRW0sEApZRhJVJIEHDZ+00COJdi0ljz17D7nUkx7+Uo5
         h7gjcHtAogI723UEp1go/NQlSOqTfosRdji0cWfURcB6HFWkOzjA426A5E92FmCu4gF2
         ud+qtWOplYdzdTeM11wNH33swMWVm5V1rmkD4GeR2amdjVzAmzH8E+Ey3TUvF2FkTu1Y
         cnUpztnabwNcmzOSKbWfdXTIDxR1OcmZTyaTIBpYlhlRWgUweKjZbQTDQuMQNQ8uFYZ3
         ODk+SMC4ZUJ15qQI2t2LpZ+MwHQJlpAWYbv2qGUE5ZlKvOHh0QHmIfo9hgdtT+Hv2L6A
         xnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEehvGyjyYp8SIKtPtm2hjz1jaUYESC95Csw9+5/Qh0=;
        b=pM+YXGvYahucde/F5ZfUEg/8trgiUQHU8ttwrcA9UIG0XGegLlX1ROaq9oF5zcPQLq
         5sEPOHGHgTn6KdyUGMWj2OaWokFICZJuFWUbRDkjrThLbqsp4xdOZ5aT8OkUbG3soy6W
         1fT9vnS2vHF0SrP9TSCDRnJKdruliEZBLnVagUAcIcfNbs2ENGb5fT38+grD9BiqVJz+
         pMHM9AF265Vw5jHJm+Ly3I2HW96AwA+HvSTQ1FmnAblospdbmapuZy7LN/VAxWtQDI3r
         8GqY1Nbqkar58yyn9KTmE1+1nxRAdw6/vKjvTz7LmwCpz6DCums38+xyxLpLsj79n1XL
         BWUA==
X-Gm-Message-State: AO0yUKViHKlYws2SBc40oIdIBUnqWRG2QOty+8i/z4CAOPH6kUM0So80
        xt0NOksVX2kt+7dSwhvChG62SsnQ1Fw=
X-Google-Smtp-Source: AK7set+t3Gec/i5bemSePE00dOJ7WjRUIsCfzHPEU2G7S1ItuvIpJ8g0VhHoR9nT61cU9cYW9PfJhg==
X-Received: by 2002:a17:902:d4c8:b0:199:30a6:376c with SMTP id o8-20020a170902d4c800b0019930a6376cmr18882926plg.68.1677284457413;
        Fri, 24 Feb 2023 16:20:57 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b00196025a34b9sm75008plb.159.2023.02.24.16.20.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:20:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Remove detection of ISO packets over bulk
Date:   Fri, 24 Feb 2023 16:20:52 -0800
Message-Id: <20230225002052.3866357-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230225002052.3866357-1-luiz.dentz@gmail.com>
References: <20230225002052.3866357-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the code introduced by
14202eff214e1e941fefa0366d4c3bc4b1a0d500 as hci_recv_frame is now able
to detect ACL packets that are in fact ISO packets.

Fixes: 14202eff214e ("Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6273a93defd2..4ca91c033d2f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1050,21 +1050,11 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
-			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__le16 dlen = hci_acl_hdr(skb)->dlen;
-			__u8 type;
 
 			/* Complete ACL header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
-			/* Detect if ISO packet has been sent over bulk */
-			if (hci_conn_num(data->hdev, ISO_LINK)) {
-				type = hci_conn_lookup_type(data->hdev,
-							    hci_handle(handle));
-				if (type == ISO_LINK)
-					hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
-			}
-
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
-- 
2.37.3

