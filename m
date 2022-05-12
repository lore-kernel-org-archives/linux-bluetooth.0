Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357474AbiELWbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiELWbh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:31:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34156FA9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:31:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 204so6082371pfx.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tS5GuZAPhDArSYGea5NYia/bze9O9vmhRUhWdUMB3E=;
        b=EOCVI00DU37xZgPkTNnXCtU+T77F8yFebR8gMwsaeAJTOraznbikgBDgxGcY4N6BRr
         8UDHXmlc1BbEYzJsZHQzum20hMzHH+gPXxhimTWE5w+iQfiLknijBCut7S+yAI8S+vbf
         4wqBUl6neoCFHIV02tfEUcIZUGaeXEksRn8T/nVFoKXjZatY+j1dTe9RQuMbLP4Hp1lS
         bM9CYdXnpmJQngsyojUOgGAo8pM/KGbyCISENwuKQR3+gy/hOTdDWTsv6h5Bhxfq32QQ
         w63IGmaVsmaD1bvOD2y/I29BWHkaLxvsq+UBEWB/TRnNBleB3n2d1TIONh9mocThqtol
         xJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tS5GuZAPhDArSYGea5NYia/bze9O9vmhRUhWdUMB3E=;
        b=q6+9FQy7J3PY+YFSPlAMrPToYHeZBKRn+2Eune5RxKu+ksJewQS9G4V1+xveRQ6W6Q
         mGK1B9Kt3DbqTBmga2kU7aBt9tmMEX5npxCSzqFFWL+0OE1uQzTISjbxdkjg2RnSHERM
         b4TOT83Z6uy5qmEAh1ahEYelPkAgGEht5cLeSnMdVtwT6EcbQnV7yvd+GaovV191tPN6
         StBWRgKT4YuBR512jqh44fn+OXK9PhrDNQrzBCm8Z8ijHB/jivcmrd5vQxC5GfekUQTl
         ZLrDclpJ6lYLCcLyXlKBDAklTDlvHDozeP40nvwSteg4sjO32Q/q/f3SaWBo79xyIJlM
         2e5A==
X-Gm-Message-State: AOAM531o8JXcg0rrIWIlzeksrIx/NpajqPzs3Gxo7NzBH09i0JUsMK7n
        U96ty/ioBvmWrhsqPJoPdFZrGN91JGc=
X-Google-Smtp-Source: ABdhPJyeV4a2J+N2byaSNHfSfQQ5Jskdv7CRgVcf80dAd44/hsL3P4F1w82g6VYlU15iwF3sgvOdFA==
X-Received: by 2002:a62:ce82:0:b0:50d:512f:7b76 with SMTP id y124-20020a62ce82000000b0050d512f7b76mr1654260pfg.79.1652394695822;
        Thu, 12 May 2022 15:31:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x5-20020a623105000000b0050dc76281fdsm289843pfx.215.2022.05.12.15.31.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:31:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP
Date:   Thu, 12 May 2022 15:31:33 -0700
Message-Id: <20220512223134.1021074-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_CONN_FLAG_REMOTE_WAKEUP can only be set if device can be programmed
in the allowlist which in case of device using RPA requires LL Privacy
support to be enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d390534e54..74937a834648 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4529,6 +4529,23 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 		if (params) {
+			DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
+
+			bitmap_from_u64(flags, current_flags);
+
+			/* Devices using RPAs can only be programmed in the
+			 * acceptlist LL Privacy has been enable otherwise they
+			 * cannot mark HCI_CONN_FLAG_REMOTE_WAKEUP.
+			 */
+			if (test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, flags) &&
+			    !use_ll_privacy(hdev) &&
+			    hci_find_irk_by_addr(hdev, &params->addr,
+						 params->addr_type)) {
+				bt_dev_warn(hdev,
+					    "Cannot set wakeable for RPA");
+				goto unlock;
+			}
+
 			bitmap_from_u64(params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
 
@@ -4545,6 +4562,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 
 done:
-- 
2.35.1

