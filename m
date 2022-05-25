Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6562C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiEYKq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbiEYKqE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:46:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7B996A7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:46:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so18219830plg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ofo/7h9jTqDyo9qc7SprA/31bAIMjSHKkGlFIJBjtU=;
        b=TeUELpsl0qygv6an9+IanVzO/AhwABBrwsmA/RI7ueZ/CeYY3B1AOxvpqAJobMZsAt
         x6vNP4zOYGH+sIE+GQHuf3wZwpvHZ07KZ+//P/0tQQJ3mS7M8H/OdOAO9xbMGZOhPzGX
         UdZqFteuTa9gn6NpDkrVNlr0Ytm4a9RgDbyao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ofo/7h9jTqDyo9qc7SprA/31bAIMjSHKkGlFIJBjtU=;
        b=wIwvUyGToefo7oZAJRtWM2PQhWIxRJnpZf8wPHZnVSI4rV0lKBPdDsZBb5qISdSxQt
         w4QP7rCaeo2WCVhX+0xC0xIZb8yyD14EHDwbuIXqD81TY7by4zNYG6ngI6/sISORfU3L
         Sub1cBR0n1HaxXNwGZuEczn3wT/XN3nxiR4uzsW3PbNdhkLHUPvt46h9nVTmvwEeUlKf
         Uj1uHVqaLgAI5pVaTKrvVCnHIJ92hCKsmF1PSHP2bEEMH8Zb08nDm5VTaGQQipF4stTy
         idGGBzMzpg4PNKKYjHWosRhgdlSGcZOCtD1ob3fbiENdNHm+5pyTK6bD0SjF18mgiOgJ
         gTxA==
X-Gm-Message-State: AOAM531v4Vwr5KH8a08WL/uI0eG//4uZ/mfffS+G93D2gujgUNd5sQ5e
        V/MeMvVUH66kEVGMyL+PSTcSbXkC6wpbNw==
X-Google-Smtp-Source: ABdhPJxFWtMiLdt3inmv5SF2An7nZ6tXfMV4+KvuSSv6gpk5/webo18YWqJH1RqSyHuynlDm1DYb1w==
X-Received: by 2002:a17:902:b90b:b0:15f:bd0:18b5 with SMTP id bf11-20020a170902b90b00b0015f0bd018b5mr32864403plb.97.1653475561444;
        Wed, 25 May 2022 03:46:01 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id b8-20020a6541c8000000b003f64036e699sm8155876pgq.24.2022.05.25.03.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:46:01 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v5 3/5] Bluetooth: hci_event: Add vendor functions to handle vendor events
Date:   Wed, 25 May 2022 18:45:43 +0800
Message-Id: <20220525184510.v5.3.I63681490281b2392aa1ac05dff91a126394ab649@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525104545.2314653-1-josephsih@chromium.org>
References: <20220525104545.2314653-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds vendor_get_prefix and vendor_evt in the evt_prefixes
table so that any vendor driver can set up the functions to handle
particular vendor events.

The hci_vendor_evt function checks if a vendor event matches
the vendor prefix returned by vendor_get_prefix. If yes, the
event is pushed down to the driver's vendor_evt function to handle.
The driver function will call hdev->hci_recv_quality_report to
pass data through mgmt if needed.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v5:
- Use vendor_get_ext_prefix and vendor_evt to invoke callbacks from
  drivers to handle vendor events.
- Use hdev->hci_recv_quality_report to pass vendor event data
  from drivers back to the kernel. The mgmt_quality_report is then
  used to surface the data through the mgmt socket.
- Remove the unnecessary "void *data" portion from vendor_evt.
- The Intel specifics are pushed down to the driver and are
  implemented in a separate subsequent patch.

Changes in v3:
- Move intel_vendor_evt() from hci_event.c to the btintel driver.

Changes in v2:
- Drop the pull_quality_report_data function from hci_dev.
  Do not bother hci_dev with it. Do not bleed the details
  into the core.

 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_event.c        | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f89738c6b973..9e48d606591e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -642,6 +642,11 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
+	struct ext_vendor_prefix *(*vendor_get_ext_prefix)(
+							struct hci_dev *hdev);
+	void (*vendor_evt)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*hci_recv_quality_report)(struct hci_dev *hdev, void *data,
+				       u32 data_len, u8 quality_spec);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ad4f4ab0afca..3e22b4b452f1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2650,6 +2650,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	idr_init(&hdev->adv_monitors_idr);
 	msft_register(hdev);
+	hdev->hci_recv_quality_report = mgmt_quality_report;
 
 	return id;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c2c6725678ec..f9b03d7b4a22 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4260,6 +4260,20 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, void *data,
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+static struct ext_vendor_prefix *vendor_get_ext_prefix(struct hci_dev *hdev)
+{
+	if (hdev->vendor_get_ext_prefix)
+		return hdev->vendor_get_ext_prefix(hdev);
+
+	return NULL;
+}
+
+static void vendor_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (hdev->vendor_evt)
+		hdev->vendor_evt(hdev, skb);
+}
+
 /* Every distinct vendor specification must have a well-defined vendor
  * event prefix to determine if a vendor event meets the specification.
  * Some vendor prefixes are fixed values while some other vendor prefixes
@@ -4276,6 +4290,11 @@ struct ext_vendor_event_prefix {
 	{ aosp_get_ext_prefix, aosp_vendor_evt },
 	{ msft_get_ext_prefix, msft_vendor_evt },
 
+	/* Any vendor driver that handles particular vendor events should set
+	 * up hdev->vendor_get_prefix and hdev->vendor_evt callbacks in driver.
+	 */
+	{ vendor_get_ext_prefix, vendor_evt },
+
 	/* end with a null entry */
 	{},
 };
-- 
2.36.1.124.g0e6072fb45-goog

