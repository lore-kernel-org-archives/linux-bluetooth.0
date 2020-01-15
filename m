Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D7C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D18A207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9Z9NFnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgAOVCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45440 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so8747395pgk.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=a9Z9NFnlGYpxSWcRiA9eX+gybBsNKQyiCKie8GKLskuwDrEvmHpiTCkwjYbxLcPTpK
         v/dnYEsgnyH0V1aoh2QtA+2Z5Bmhzz4MlJVSH1UeTj41aF3c09eANKiyS4WI3znfztg0
         JipwbwkYb6DQ12qmhuI3sHrVN4yxeSRykmx0C+rdhpaXaQtfPfCHmmBoRFCuru7v6Rzh
         karC7XqIstDxVZxmQhayk/CHWbj3qGOBib/CNi8D+MklFI/zyHrlFaZ1ZoFchkTy3ek6
         vHD2WSjERkD5JLF/iW1uAbFMX0h31lTDbrF6JC5OkG+sdLo8aWM1V/00bLM2VNmR1RYo
         bTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=rwrBdsBNtuBTQ0Du1ly/yeCPqo1B3TTRGkkgWaDpYaEPzFLZ9pxniS1LGRl40DfXPs
         z3wMKdiHNngCOamjDcxCb8ts6OknPqtp9ktxIveo7TLy0lmK/DSHpcCTr0sc1VN7Xqcp
         ge6X5VxCJK8xqAHMmGSgfDMAMSuunAS2T/EMAmvCrEhf7R1SfGX1wIcwZfutmsiIbfaE
         y2fxgs7bSVdIs8MwRk1j2y3F9E+MMTSjVR+yyEJzv3QQm8mqjYuOcX0C6WOiDSKMh0MD
         Xw48kU8LQRbnP1flVbDauEYammWTwGycKJvsIscUlZRG1cmnezE8hdaENNO0uKlGSMS4
         zXAg==
X-Gm-Message-State: APjAAAV1o5X8WfISVh+ClVQahqCpra1o4lJ+xL9gygI08KZu0yKwYslr
        +JIOFr/CQF8zaEeceyv5DL8a05H5U7s=
X-Google-Smtp-Source: APXvYqys9ITfVXY8vUactM1yWSL+0VTo2/9+xK5R/Xi3DfxPhunUiJHOqGYdJtV0PF9HpXh1ifG3qg==
X-Received: by 2002:a62:446:: with SMTP id 67mr32074570pfe.109.1579122151520;
        Wed, 15 Jan 2020 13:02:31 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 07/11] Bluetooth: monitor: Add support for ISO packets
Date:   Wed, 15 Jan 2020 13:02:17 -0800
Message-Id: <20200115210221.13096-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables passing ISO packets to the monitor socket.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_mon.h | 2 ++
 net/bluetooth/hci_sock.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 240786b04a46..2d5fcda1bcd0 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -49,6 +49,8 @@ struct hci_mon_hdr {
 #define HCI_MON_CTRL_CLOSE	15
 #define HCI_MON_CTRL_COMMAND	16
 #define HCI_MON_CTRL_EVENT	17
+#define HCI_MON_ISO_TX_PKT	18
+#define HCI_MON_ISO_RX_PKT	19
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5d0ed28c0d3a..3ae508674ef7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -324,6 +324,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			opcode = cpu_to_le16(HCI_MON_SCO_TX_PKT);
 		break;
+	case HCI_ISODATA_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_ISO_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_ISO_TX_PKT);
+		break;
 	case HCI_DIAG_PKT:
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
 		break;
-- 
2.21.0

