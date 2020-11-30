Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE21C83018
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8120725
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXJ8KYQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgK3W65 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbgK3W64 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF74C061A55
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so58255ybs.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4qDiDnyb17Vw9FXkd1Zfm99JPk4wP32pSXvTjj58f5k=;
        b=fXJ8KYQ7ajC9rW8UQdKnjadO0vY206M3RMZ0c44XIBcb4uZgVkHOkGkTB0uQfEs6LL
         gHdT1TeKevYiN+C/l+gCfu6iYXpwcvCj/LyaGZ9TMAR+FJEOvgTSZoy7QaxqOsd+i+Y7
         JBsc1IrpgbDICyxCGJX82FzVGi8Amo0vAU+t2t0EHDIGn1UknYaJckiI2hiL92fopGhR
         uhvexjjMBgB2fHwAet7akks6oqS2CecxOTTuEClGvFMAZ/LLmhoiQ87G/PILKElI4uap
         Ulf+VPMvjMRJAubo1cCDnZcqrkMkhOGMA326IBcdDjlLNqxv4k5q8PEVJ5dxNipVz07L
         qiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4qDiDnyb17Vw9FXkd1Zfm99JPk4wP32pSXvTjj58f5k=;
        b=QDmnXkXmY75fmctm1RDUjbdSAv7f3sHb+O/23dzHl4//1GjpGa5Y44L43ic7pzkZNx
         8BY1Xy/Ubfv8NitxculO5xQ3AcJXHPGo6FPX/+R+dfviK0/xoXH6P53Yup5qLmaqZoNf
         lQRBW2B98Ea0N1ACO5xb/c52mU53ElE9WVk9OYPuMdVmqdb7PcgGos8f9cKfz5kvndb9
         +5Ds/ZSoWrf61oILugyDQLxXTCdFSo7vbBISMiV8cp28I/qvVG3czcp7Fd4ZBK2B/sEe
         LzKUsNrJVKWH8hXxNkYfHbKWdyZPzaDGw6pnrMq3zeU+UDQ3jVf3S5RH7vcY/cY2ew9Q
         JWLw==
X-Gm-Message-State: AOAM530YEFiWXja0QKgaIJETI5y05Wbzxj8NOva9ZIAu9Tr/1ANK3bQy
        UmyhRDnCecFP2ShkMiDn6O5MfKBBqxiSW9FNnnm5
X-Google-Smtp-Source: ABdhPJzADFlbZgN/tcy+dIO7sfu1udMotM4/AsVZ9yqWIxA8957LQFznHO+UwbvzqQBKV+eEL6Nro6lM/hnkpqYVuVMZ
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:75c3:: with SMTP id
 q186mr39138388ybc.460.1606777078527; Mon, 30 Nov 2020 14:57:58 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:57:43 -0800
In-Reply-To: <20201130225744.3793244-1-danielwinkler@google.com>
Message-Id: <20201130145609.v6.4.Ibedcb7af24f1c01a680de4cc8cc5a98951588393@changeid>
Mime-Version: 1.0
References: <20201130225744.3793244-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 4/5] Bluetooth: Query LE tx power on startup
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

Changes in v6: None
Changes in v5: None
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
index 3397fc706e87a1..6f7d5ce965d7c8 100644
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
@@ -3656,6 +3662,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
+	hdev->min_le_tx_power = HCI_TX_POWER_INVALID;
+	hdev->max_le_tx_power = HCI_TX_POWER_INVALID;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f193e73ef47c14..67668be3461e93 100644
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
@@ -3582,6 +3596,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
2.29.2.454.gaff20da3a2-goog

