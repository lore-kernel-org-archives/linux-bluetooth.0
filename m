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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B1EC33CB6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F14222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNv/w9L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAOB72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38076 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAOB71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so6842241pje.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=gNv/w9L+W7Sg55wI7GUw52tozwce7scfNWnozrlp4E+smD40Bj3++XRyEm+DnAtCCm
         E+ciGIZnxYoRgT76LfsW+UB5z6E4fklg9uUpVXf2VXpxZ9GUo11yHB7M5hEA2GXLWIN/
         XJTPVBvqle0Oq4e7LgN7A//nanufPcb0nGVrH3n97zigPX8pjKLGJlH+8kEjnP+xSkB0
         tmXuGryBitptgO0t9DUKY368ewSYP2mWKe7Wohy5Eve1KzgB8szewZHR+rpYWiFkAVBP
         tm4jW5swwGBZF6eUKsGaPKaxlj/+y6ZVTS+GxYfPt9RauwtzGvfym+Dk4QHtprA1911m
         nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=Ft4AZmAjHHPFd7DsdmdxD4b16quTcdHUDD1sgu3ikkTc5PfCAc69MYZq6+e82QfjqB
         Zye9XwkEiNCr841H+YFzhPagghguQi//gLhIKay1f7ViE5n9a/LFu+hDrAYeryBgTxxb
         K5FEW8UFOypq9trVTTeK8ue/V92CyE9LFTOCL4ARW8zC/2gomt0/MmZPcxeoMO6x15KW
         hk+24xtTZ8CNh8qELdLXhlH+QyGAgcD4zrs6s84m9qUkTq33jsk1k6fqnpG0ZYnONSsw
         Ovs6Mb060bu0Gv8IpUWYWQjqUQb76nLAvJDlTBZOaTqHkJcleYUJDleOYnMM/Wi8sTgy
         MsUw==
X-Gm-Message-State: APjAAAWwUyWA2+zqbRYCtGyg0TXthhovrO1mOg5eyWM2BtUGB9e3JfiS
        8JDOzugwvheT/3ZklVTKX//i2C0kdFQ=
X-Google-Smtp-Source: APXvYqx491y7HknDU0E9IWoBo44q5eHnD4oGAgMAA2BqH5IgXzb1X6QS5ufJKfpUCF4uCPP1P/5qTw==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr23096064plq.292.1579053566733;
        Tue, 14 Jan 2020 17:59:26 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] Bluetooth: monitor: Add support for ISO packets
Date:   Tue, 14 Jan 2020 17:59:16 -0800
Message-Id: <20200115015918.1187-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115015918.1187-1-luiz.dentz@gmail.com>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
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

