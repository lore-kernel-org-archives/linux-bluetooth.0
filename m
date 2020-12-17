Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F24C2BBCA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FB7233FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgLQHSr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgLQHSp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 02:18:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFCEC061282
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t8so18466285pfg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaV7Mr1OnvijXCzI76kMkwYxN05oQ0nopWy4o/r2Ewg=;
        b=le1KgvD0Ngu7bipqD+Nq6mjJXgFX9N1HMtk+AAozLaa1qV4o1yvGfoZ9T1bnYYNXu3
         hVVoHQ8OcEIvcnLioi3njCOaEON+aj3dbrgaG2io1kqV8o1NhlQmsMHQIixeoDCFA5oY
         sjHdNROmoMsFQyiumvITiadI83cXXnYhyTlj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaV7Mr1OnvijXCzI76kMkwYxN05oQ0nopWy4o/r2Ewg=;
        b=pz5AJ4w3ZG8gd637YNxNQKegL6N+w3ItjAbArUEzau92kqZqJlJpuB+1A5h86WNsep
         y4FJuuj7e3hVx1XYtScMBqJfhzA6qui/6vBpfnUOpbqTpPSlglAXhfgKuG3hSWsQDNII
         EoCBuW5n7IBJfUqLhdH0D7yQYhqMV1WMFBFitpPvgCUB9/gumAd1N8M/nNfsjESaQJv9
         T5qEp8WYrrCx4EBwPyJOQ1UzXMHZ4Ia4Juk5fIRc17CKgxeo2BlCAVOZb2jOGk0HO2qC
         c2qaaVGrd9OnuKx/0BpV0mccQQUL/yyYTrVT3jmZITLbSxutFHfIa/Gq8fVpZ72sjTTF
         4aOA==
X-Gm-Message-State: AOAM533D5n+XptjRlEsTmeJZ07P4RsEfGnKKJFi83m3C0yNX8dBIM6ya
        xtZ0ybRipdj9lLpEe0BKtuQbPHpJS9QEbw==
X-Google-Smtp-Source: ABdhPJykaHj4WP+604ATg39BeeQv/AOzg2FemhKqkXxV3Wu7u0KhJIGjmM/P4Xkx1wRocrII4UXVtw==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr21187289pgb.332.1608189484289;
        Wed, 16 Dec 2020 23:18:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id n7sm4602508pfn.141.2020.12.16.23.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:18:03 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x
Date:   Wed, 16 Dec 2020 23:17:29 -0800
Message-Id: <20201216231652.v1.2.I188d99e738b39d9ef36110addbc227837d3c42a7@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following Qualcomm WCN399x Bluetooth controllers support the
Microsoft vendor extension and they are using 0xFD70 for VsMsftOpCode.
-WCN3990
-WCN3991
-WCN3998

< HCI Command: ogf 0x3f, ocf 0x0170, plen 1
  00
> HCI Event: 0x0e plen 18
  01 70 FD 00 00 1F 00 00 00 00 00 00 00 04 4D 53 46 54

The following test step was performed.
- Boot the device with WCN3991 and verify INFO print in dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 drivers/bluetooth/btqca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index f85a55add9be5..ab19963c83616 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -517,6 +517,19 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			return err;
 	}
 
+	/* WCN399x supports the Microsoft vendor extension with 0xFD70 as the
+	 * VsMsftOpCode.
+	 */
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		hci_set_msft_opcode(hdev, 0xFD70);
+		break;
+	default:
+		break;
+	}
+
 	/* Perform HCI reset */
 	err = qca_send_reset(hdev);
 	if (err < 0) {
-- 
2.29.2.684.gfbc64c5ab5-goog

