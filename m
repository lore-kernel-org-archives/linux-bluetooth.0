Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB08C43219
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407E76103D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhIZHJl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhIZHJk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 03:09:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53611C061714
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:08:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r7so9486015pjo.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcIEd4ZvWF+aMbmrEEJnlNTin4YD1gvu+ViZoUNmNvo=;
        b=jJAV9mLyVsaIXtIiQW1QM4n5E6tb/RywIYfDaKvTYWIViLwMH+ctv9FfDe9PCJqUJn
         LNQaLlGohM+VgiSQO5SPCAhOuIQZs3uFJk/lHmn+o2lwVMR+x77VttLZps7YvMMviJss
         f+gtZoMb5jcbtBBvxtOsjGVEXSywDeiC7Uv3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcIEd4ZvWF+aMbmrEEJnlNTin4YD1gvu+ViZoUNmNvo=;
        b=GVi/iUrWQnRYC5jGBeEgUNs4xBqQJh/Zjn+gr/LhCmycgIVce/Jtsg9OFkWHDfP+A7
         RRaF2uOKJYm3DmDOuqrGqKO94RBsiwxfcEG/H9GSLIMsd+05YYjMuqAgcfBPwEy2lumQ
         kIU9VTTn10bqV2gz2m8co8yvBZz0FkbjZBUAp6tQEO99OR3eJcNPDSzXPpLf0OXhyBbH
         WLLWxViDwi+ehdPaCRxpE7ZrOf+TiNGgiQsT3XcjhARJZ1cCE7AcZZ7kz2hkefTZUDH/
         HjJNgpwflwU/8orC9F8CNas+mD5bHv9DfWmekEQnT6WvJMmj9rCohAomnL8O6vrA1jJd
         a/3A==
X-Gm-Message-State: AOAM530OaErC+9m1AeCqeQEZRn3d6AfKhIysaiRpv0kAFkKFsNBERwqg
        ZwWaQG6dLGT4yj4S2y6yjm9f+Nqb2O+5hA==
X-Google-Smtp-Source: ABdhPJyA3JwkzYmaC5UlPk3wMvfiBiwsns5IfJ/Y/qNO9U61quLxc2j2ZNekzpefLokQyCU2vOUYRg==
X-Received: by 2002:a17:90a:680c:: with SMTP id p12mr12119779pjj.33.1632640083723;
        Sun, 26 Sep 2021 00:08:03 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8152:3867:7050:3260])
        by smtp.gmail.com with ESMTPSA id o17sm13796174pfp.126.2021.09.26.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:08:03 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: btusb: enable Mediatek MT7921 to support AOSP extension
Date:   Sun, 26 Sep 2021 15:07:49 +0800
Message-Id: <20210926150657.v4.4.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables Mediatek MT7921 to support the AOSP extension.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v4:
- Call hci_set_aosp_capable in the driver.
- This patch is added in this Series-changes 4.

 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index da85cc14f931..de0228e2245b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
+#define BTUSB_AOSP		0x8000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -394,6 +395,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK |
+			 BTUSB_AOSP |
 			 BTUSB_WIDEBAND_SPEECH |
 			 BTUSB_VALID_LE_STATES },
 
@@ -407,6 +409,7 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Additional MediaTek MT7921 Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_AOSP |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3563), .driver_info = BTUSB_MEDIATEK |
@@ -3867,6 +3870,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btusb_recv_acl_mtk;
+
+		if (id->driver_info & BTUSB_AOSP)
+			hci_set_aosp_capable(hdev);
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.33.0.685.g46640cef36-goog

