Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC0C43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A8820874
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BLmHf8lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIQWWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgIQWWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:22:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36296C06178A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a16so3146855qtj.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vpeQrnRyFpcso3Go0c148N2CAz5LUM7IS8DzIr9rjw0=;
        b=BLmHf8lgtfZH6kZGQJD85ea4x92p5W0Yy2wtHHE7cbeP71+j/9wB+ylAEY8FUYx2XK
         WrVYu5jcC0DQrL8RT6sPc++G8E4dgPy5XU9Uiwe2SgdtIBbE1ywecTulk0/lhO8kGBY/
         dBlMhhYocv74bKTKdGXyG1akZltRpNNsZblefuNvoDr9Zewg57YW3sGKzuf6xu76HWdi
         /MI8eAeYYAFMeptwyXixLDbqLf0KFFQjQev3/I4vIB42jLEHwFT31PlytmaVYTHikoiO
         lg0M74zZBNG/RlmNbJFAhhjzDLXKft32m+uXXFZtFHb70lwB1xQKe+wSX4gkr8Omuupx
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vpeQrnRyFpcso3Go0c148N2CAz5LUM7IS8DzIr9rjw0=;
        b=RXGbxMFJkHSbvXXz2+QaLKmiDJdrLLlO8Ntt3FTJ8ZNyqgLASD1+khgcUUjpKTAQ4T
         jbTogvTFTmCeM/7u8gH0JTlHgQNH3Es4QIX7fhnMLyhseVu/Xx1Rmq2PDArvqTajyA4V
         kLUK+rpG4K9pAk3V/SrNEeZbfj5ejbCxqkY/qzaVbeMqSuvOQVe7SZQRq8WICJbXS4eI
         LRhkLv46HFELnRzvwVzsnxhszqmZAqHq+rrFPo9AFR4ls6BQeqNiWDqtZdh86QjOnsJ1
         WiOvOgcl9VawrLQaeQSSGY8fZi8tniNrGZv4aSdKktYBDdlz+cZZwc3qCZ28suCTsvzU
         cUug==
X-Gm-Message-State: AOAM533flewbrGk9SHHtnD2pMX9bVIRSbsi0bHDH8Jhh4ebRxwpf+Zl8
        +45r1Gyb92CuYyqpfx7M3TFFABJP+7Zl/IitBqu7
X-Google-Smtp-Source: ABdhPJznIHjupkbf9wVia6kDLIjZPmdFNgfta/zP0S9Q5V+F8qxpYjCEIkdpcN5nLq6im/rgnFZsstI2TGdYwcwZNK7s
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5745:: with SMTP id
 q5mr30565379qvx.29.1600381359399; Thu, 17 Sep 2020 15:22:39 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:22:17 -0700
In-Reply-To: <20200917222217.2534502-1-danielwinkler@google.com>
Message-Id: <20200917152052.v2.6.I5068c01cae3cea674a96e103a0cf4d8c81425a4f@changeid>
Mime-Version: 1.0
References: <20200917222217.2534502-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 6/6] Bluetooth: Add MGMT command for controller capabilities
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

For advertising, we wish to know the LE tx power capabilities of the
controller in userspace, so this patch adds a new MGMT command to query
controller capabilities. The data returned is in TLV format, so it can
be easily used to convey any data determined to be useful in the future,
but for now it simply contains LE min and max tx power.

The change was tested by manually verifying that the new MGMT command
returns the tx power range as expected in userspace.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v2:
- Fixed sparse error in Capabilities MGMT command

 include/net/bluetooth/mgmt.h |  9 +++++++++
 net/bluetooth/mgmt.c         | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index db64cf4747554c..9aa792e5efc8d0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -815,6 +815,15 @@ struct mgmt_rp_add_ext_adv_data {
 	__u8	instance;
 } __packed;
 
+#define MGMT_CAP_LE_TX_PWR_MIN	0x0000
+#define MGMT_CAP_LE_TX_PWR_MAX	0x0001
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0056
+#define MGMT_OP_READ_CONTROLLER_CAP_SIZE	0
+struct mgmt_rp_read_controller_cap {
+	__u8     capabilities[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9347ff1a1e961..fd36acb973ba1f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -124,6 +124,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_REMOVE_ADV_MONITOR,
 	MGMT_OP_ADD_EXT_ADV_PARAMS,
 	MGMT_OP_ADD_EXT_ADV_DATA,
+	MGMT_OP_READ_CONTROLLER_CAP,
 };
 
 static const u16 mgmt_events[] = {
@@ -181,6 +182,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
 	MGMT_OP_READ_DEF_RUNTIME_CONFIG,
+	MGMT_OP_READ_CONTROLLER_CAP,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -4356,6 +4358,42 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int read_controller_cap(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	u8 i = 0;
+
+	/* This command will return its data in TVL format. Currently we only
+	 * wish to include LE tx power parameters, so this struct can be given
+	 * a fixed size as data types are not changing.
+	 */
+	struct {
+		struct mgmt_tlv entry;
+		__s8 value;
+	} __packed cap[2];
+
+	BT_DBG("request for %s", hdev->name);
+	memset(cap, 0, sizeof(cap));
+
+	hci_dev_lock(hdev);
+
+	/* Append LE tx power bounds */
+	cap[i].entry.type = cpu_to_le16(MGMT_CAP_LE_TX_PWR_MIN);
+	cap[i].entry.length = sizeof(__s8);
+	cap[i].value = hdev->min_le_tx_power;
+	i++;
+
+	cap[i].entry.type = cpu_to_le16(MGMT_CAP_LE_TX_PWR_MAX);
+	cap[i].entry.length = sizeof(__s8);
+	cap[i].value = hdev->max_le_tx_power;
+	i++;
+
+	hci_dev_unlock(hdev);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_CONTROLLER_CAP,
+				 MGMT_STATUS_SUCCESS, cap, sizeof(cap));
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -8208,6 +8246,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN },
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ read_controller_cap,     MGMT_OP_READ_CONTROLLER_CAP_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.28.0.681.g6f77f65b4e-goog

