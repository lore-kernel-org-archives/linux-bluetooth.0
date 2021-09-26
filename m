Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FEDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84A461100
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhIZHJe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhIZHJd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 03:09:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17AC061604
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:07:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so10076583pji.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8+qybuPdV2p2L2842TlhuzKJnVmEI/QhcRxK1YwGgr0=;
        b=GFsz4uvGy4omybAXn7UDVf5OuFNKnNJNsIKtYxjEWCXoefNzK4WyncyuoNcFNIvCFt
         NFMoYPmQNmoik12Ii/HWei+xL2VWHYXH/Ov64/vGpiVxsX84pd1tCyzndVGt0BqIjmiT
         WoVKJIDrTB400NpM3r7cSr+BMeFXC+EXFMuGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8+qybuPdV2p2L2842TlhuzKJnVmEI/QhcRxK1YwGgr0=;
        b=aDbIJigxHbkbv87n0u+LCFjKE6Rn8FSD9/8OG3WCERrLln2VJp+EFaqJNjo1Ebs5gO
         A8IEFajhoI42BbyrK5awh8KfZHZnm5x03u87XwbmzIFCCJGF8HSNbnciYXnVshdSmmB7
         ZHZK2inp6d6K/JEdgL9t+/iDB1nZpw7VvEK5AS3PR5Y6fQLlDypC4vw3usQRlMbS6Gc/
         6lZN1ZAMqihuP2Ib7KmcQXT6OIo5i6zLrrQgHgwr3VSkqwx22RJcfEnti7CyYiYWKVhQ
         8L7NC2cYdkky6MW/wCu18Xy2Q8wGe+D9EGqHR3D1neJeyd5/Cm4dsq67zfyV0w+fPAmS
         sVqA==
X-Gm-Message-State: AOAM530km7OwFXSopia9YPfftxZ+IFQ233VVI7jO64TtdVeTwbNN9REu
        phDvH/fNGghD522kVebycDVetaIU1HgOkQ==
X-Google-Smtp-Source: ABdhPJwrTP1ZkgDkGbuIUCYoTLj739Wm0GTfFfMOhXs/g1J285zxL6OLTcSd88aulYpYMb1ikVkFmQ==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr846837pju.230.1632640077115;
        Sun, 26 Sep 2021 00:07:57 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8152:3867:7050:3260])
        by smtp.gmail.com with ESMTPSA id o17sm13796174pfp.126.2021.09.26.00.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:07:56 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: aosp: Support AOSP Bluetooth Quality Report
Date:   Sun, 26 Sep 2021 15:07:46 +0800
Message-Id: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the support of the AOSP Bluetooth Quality Report
(BQR) events.

Multiple vendors have supported the AOSP Bluetooth Quality Report.
When a Bluetooth controller supports the capability, it can enable
the capability through hci_set_aosp_capable. Then hci_core will
set up the hdev->set_quality_report callback accordingly.

Note that Intel also supports a distinct telemetry quality report
specification. Intel sets up the hdev->set_quality_report callback
in the btusb driver module.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v4:
- Move the AOSP BQR support from the driver level to net/bluetooth/aosp.
- Fix the drivers to use hci_set_aosp_capable to enable aosp.
- Add Mediatek to support the capability too.

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.
- Note that the mgmt-tester "Read Exp Feature - Success" failed.
  But on my test device, the same test passed. Please kindly let me
  know what may be going wrong. These patches do not actually
  modify read/set experimental features.
- As to CheckPatch failed. No need to modify the MAINTAINERS file.
  Thanks.

Changes in v2:
- Fix the titles of patches 2/3 and 3/3 and reduce their lengths.

 net/bluetooth/aosp.c     | 79 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/aosp.h     |  7 ++++
 net/bluetooth/hci_core.c | 17 +++++++++
 3 files changed, 103 insertions(+)

diff --git a/net/bluetooth/aosp.c b/net/bluetooth/aosp.c
index a1b7762335a5..c2b22bc83fb2 100644
--- a/net/bluetooth/aosp.c
+++ b/net/bluetooth/aosp.c
@@ -33,3 +33,82 @@ void aosp_do_close(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Cleanup of AOSP extension");
 }
+
+/* BQR command */
+#define BQR_OPCODE			hci_opcode_pack(0x3f, 0x015e)
+
+/* BQR report action */
+#define REPORT_ACTION_ADD		0x00
+#define REPORT_ACTION_DELETE		0x01
+#define REPORT_ACTION_CLEAR		0x02
+
+/* BQR event masks */
+#define QUALITY_MONITORING		BIT(0)
+#define APPRAOCHING_LSTO		BIT(1)
+#define A2DP_AUDIO_CHOPPY		BIT(2)
+#define SCO_VOICE_CHOPPY		BIT(3)
+
+#define DEFAULT_BQR_EVENT_MASK	(QUALITY_MONITORING | APPRAOCHING_LSTO | \
+				 A2DP_AUDIO_CHOPPY | SCO_VOICE_CHOPPY)
+
+/* Reporting at milliseconds so as not to stress the controller too much.
+ * Range: 0 ~ 65535 ms
+ */
+#define DEFALUT_REPORT_INTERVAL_MS	5000
+
+struct aosp_bqr_cp {
+	__u8	report_action;
+	__u32	event_mask;
+	__u16	min_report_interval;
+} __packed;
+
+static int enable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct aosp_bqr_cp cp;
+
+	cp.report_action = REPORT_ACTION_ADD;
+	cp.event_mask = DEFAULT_BQR_EVENT_MASK;
+	cp.min_report_interval = DEFALUT_REPORT_INTERVAL_MS;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int disable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct aosp_bqr_cp cp = { 0 };
+
+	cp.report_action = REPORT_ACTION_CLEAR;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Disabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+int aosp_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	bt_dev_info(hdev, "quality report enable %d", enable);
+
+	/* Enable or disable the quality report feature. */
+	if (enable)
+		return enable_quality_report(hdev);
+	else
+		return disable_quality_report(hdev);
+}
diff --git a/net/bluetooth/aosp.h b/net/bluetooth/aosp.h
index 328fc6d39f70..384e111c1260 100644
--- a/net/bluetooth/aosp.h
+++ b/net/bluetooth/aosp.h
@@ -8,9 +8,16 @@
 void aosp_do_open(struct hci_dev *hdev);
 void aosp_do_close(struct hci_dev *hdev);
 
+int aosp_set_quality_report(struct hci_dev *hdev, bool enable);
+
 #else
 
 static inline void aosp_do_open(struct hci_dev *hdev) {}
 static inline void aosp_do_close(struct hci_dev *hdev) {}
 
+static inline int aosp_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	return false;
+}
+
 #endif
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeec5a3031a6..a2c22a4921d4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1315,6 +1315,21 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	bacpy(&hdev->public_addr, &ba);
 }
 
+static void hci_set_quality_report(struct hci_dev *hdev)
+{
+#ifdef CONFIG_BT_AOSPEXT
+	if (hdev->aosp_capable) {
+		/* The hdev->set_quality_report callback is setup here for
+		 * the vendors that support AOSP quality report specification.
+		 * Note that Intel, while supporting a distinct telemetry
+		 * quality report specification, sets up the
+		 * hdev->set_quality_report callback in the btusb module.
+		 */
+		hdev->set_quality_report = aosp_set_quality_report;
+	}
+#endif
+}
+
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -1394,6 +1409,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (ret)
 			goto setup_failed;
 
+		hci_set_quality_report(hdev);
+
 		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
 			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
 				hci_dev_get_bd_addr_from_property(hdev);
-- 
2.33.0.685.g46640cef36-goog

