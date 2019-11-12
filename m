Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957BC17440
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D332621A49
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BoQzFM4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKLXKP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:10:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLXKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 18:10:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so162078pfh.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQ6XcZg7xLQAjI50kff+ffMiPWugeYruhnhm0kHYgB8=;
        b=BoQzFM4B5Luxo3/N/T7knT9+4U9Utp13yw6bmxoP775K884BbudvlNvPgIHTy8RU/R
         RI3maQl8QjSK5cmE8QVCdkJ1mWeBrD7olWFye0ljk5gRRi+CDnUDRLYT3q4m2vHeLnBr
         6+p8lGrqa57zqKmalvdN0Qdqb5Hv6iObSW1aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQ6XcZg7xLQAjI50kff+ffMiPWugeYruhnhm0kHYgB8=;
        b=jrhNSywCIMerrg/QpoJtUuheILASsKw9f1qo4qEwg+fpEjgXAlKrvkunJJzYt8HaFg
         yqk+1RdtSZL3DKquyLA/ZsBWfpXziTabTOtamSPIHwjUfW1rATPuFUW+zd+ESYEbdVgJ
         j0c8n8mH7aXeaNJPo1DvsirYIPDQ+c6z/n2npHkOKqHXgkKcsNGkLFCfSpZBALtvgCcE
         CpuTcg7YCSKmFS3fpMrkqKLNG4aErC1a3F6a3HHK/nkUTWWuVNr1kjn+0dmtFZlo+8XN
         aKH/+rXusNHWsbHnwSv2k6wEVm7ycsUKQU3AHgISLL4TVTBUVJ6I6iGNipF13UEzFMbt
         ab7w==
X-Gm-Message-State: APjAAAXpWSTT9fs+5l6cEBPgNdwWLKvieRFtLg8Wpff2B9eIFleGortf
        TYaioy5I+sLgO4L6IZcF+nXBRA==
X-Google-Smtp-Source: APXvYqyA8hKRz+siswPIfZm9O3js5s4pMMgjEYaTkmv1nD4ncIBueT4uNx6csUaUeaXpDDxF1WqqQw==
X-Received: by 2002:a63:e009:: with SMTP id e9mr55518pgh.222.1573600211829;
        Tue, 12 Nov 2019 15:10:11 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w27sm67694pgc.20.2019.11.12.15.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:10:10 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Tue, 12 Nov 2019 15:09:42 -0800
Message-Id: <20191112230944.48716-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112230944.48716-1-abhishekpandit@chromium.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BCM vendor specific command to configure PCM parameters. The new
vendor opcode allows us to set the sco routing, the pcm interface rate,
and a few other pcm specific options (frame sync, sync mode, and clock
mode). See broadcom-bluetooth.txt in Documentation for more information
about valid values for those settings.

Here is an example trace where this opcode was used to configure
a BCM4354:

        < HCI Command: Vendor (0x3f|0x001c) plen 5
                01 02 00 01 01
        > HCI Event: Command Complete (0x0e) plen 4
        Vendor (0x3f|0x001c) ncmd 1
                Status: Success (0x00)

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/btbcm.c | 18 ++++++++++++++++++
 drivers/bluetooth/btbcm.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..d22a2025f7e1 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -105,6 +105,24 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_pcm_int_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..bf9d86924787 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -54,6 +54,8 @@ struct bcm_set_pcm_format_params {
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +76,12 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

