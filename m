Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2AC4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AD420796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjrbFFZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgJAXEp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733247AbgJAXES (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:04:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA7C061787
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:04:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v4so547496ybk.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m3yi1dYg0De53HWOeGwrrfVixnnxwRN+NlpTXCn7/v4=;
        b=pjrbFFZD0pLSRUSuVnFFrgjqRDKzEK/x8htCiauoliTrkWwnUp4TIecq6X5BTfaXgC
         jBNikGet+GZhi759zlH6zQ9lMrphRRYaIf5jkaq9hpDcxoCSmzGQXF6Xyp9KyARGbFiF
         byPpkhT4jO2LMntX8dixKYwEQTN38tOWxPInrN8YuyMgvbKBk6ywvepMoQYhkzgdOqit
         tiVNEWXMRchwaNNTSeT9Txc/ec+rYZSqmvCB0iW24gmp5xnRgqiy0QtaYaB0RSbNQH3v
         ykJRmdMRcVQKn8vCEzy7TE0s+sJf4WPWcThRG4vSaVY1n4Rm3AuAMOuLVR33CthQHQHQ
         iQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m3yi1dYg0De53HWOeGwrrfVixnnxwRN+NlpTXCn7/v4=;
        b=bEIb8+9D53Bg+wB1RbRWvLIYLcTajGYxVkvm/tNgLShb1DzeYvutE7tI6GD5wnJuXd
         FZ8LZcj5FoCp4fv8KBl8re8XPI8ua57h/a60efZbaesa+3zhJ8amB/mHkAWP5W8FEwpu
         uIPDbSrFIgWeaTyK+jwHYR5JETVYKx4mx0lp76qJofX7monC7xGffrDGSSuFQqiGHyDV
         vHBgaAygfvEWhfs44O4Xcq5RoGXaqkXFgeI/gRUHhb72n+WCOSyZ5DhcJBwXNPc4Q+cX
         rHIssM6xKwD7f15B1Kp9iW/9NANuFhf6IgkzgXJmozAClh5fFE6KgQehaffFtG1EjRs3
         eWaA==
X-Gm-Message-State: AOAM532xProImPA3zeshNzSaxvVRLCGbOCGX6By+4SYZK1fdCxXGjRK9
        NNfTi+lQb8vweLwzufvnMGHIo6KL/tYo0HwrhCI8
X-Google-Smtp-Source: ABdhPJwHmgE/iATWoB38o4y2JKjfVIYGyMQoFZgm6Smr4u7Rv+N4qHoRt5R91P2XGGZO33ypTEfNj9Qmq8vOskEcpy9D
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:dc92:: with SMTP id
 y140mr14300457ybe.113.1601593456211; Thu, 01 Oct 2020 16:04:16 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:04:02 -0700
In-Reply-To: <20201001230403.2445035-1-danielwinkler@google.com>
Message-Id: <20201001160305.v4.4.Ibedcb7af24f1c01a680de4cc8cc5a98951588393@changeid>
Mime-Version: 1.0
References: <20201001230403.2445035-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 4/5] Bluetooth: Query LE tx power on startup
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Queries tx power via HCI_LE_Read_Transmit_Power command when the hci
device is initialized, and stores resulting min/max LE power in hdev
struct. If command isn't available (< BT5 support), min/max values
both default to HCI_TX_POWER_INVALID.

This patch is manually verified by ensuring BT5 devices correctly query
and receive controller tx power range.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         |  8 ++++++++
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c8e67042a3b14c..c1504aa3d9cfd5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1797,6 +1797,13 @@ struct hci_cp_le_set_adv_set_rand_addr {
 	bdaddr_t  bdaddr;
 } __packed;
 
+#define HCI_OP_LE_READ_TRANSMIT_POWER	0x204b
+struct hci_rp_le_read_transmit_power {
+	__u8  status;
+	__s8  min_le_tx_power;
+	__s8  max_le_tx_power;
+} __packed;
+
 #define HCI_OP_LE_READ_BUFFER_SIZE_V2	0x2060
 struct hci_rp_le_read_buffer_size_v2 {
 	__u8    status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab168f46b6d909..9463039f85442c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -381,6 +381,8 @@ struct hci_dev {
 	__u16		def_page_timeout;
 	__u16		def_multi_adv_rotation_duration;
 	__u16		def_le_autoconnect_timeout;
+	__s8		min_le_tx_power;
+	__s8		max_le_tx_power;
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3a2332f4a9bba2..6bff1c09be3b42 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -741,6 +741,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
 
+		if (hdev->commands[38] & 0x80) {
+			/* Read LE Min/Max Tx Power*/
+			hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
+				    0, NULL);
+		}
+
 		if (hdev->commands[26] & 0x40) {
 			/* Read LE White List Size */
 			hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE,
@@ -3654,6 +3660,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
+	hdev->min_le_tx_power = HCI_TX_POWER_INVALID;
+	hdev->max_le_tx_power = HCI_TX_POWER_INVALID;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4281f4ac6700d4..de51188a3dc15d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1202,6 +1202,20 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_le_read_transmit_power *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->min_le_tx_power = rp->min_le_tx_power;
+	hdev->max_le_tx_power = rp->max_le_tx_power;
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -3574,6 +3588,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_adv_set_random_addr(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_TRANSMIT_POWER:
+		hci_cc_le_read_transmit_power(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
-- 
2.28.0.709.gb0816b6eb0-goog

