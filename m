Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43BC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB8D207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU8+NeXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgAGHlF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43718 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgAGHlF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so28087536pga.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=QU8+NeXG9SML9egqY2PhGbULrKtVCpqYyfyBgGAnap86CXVGs5tbXuSRrzb3BSyPpC
         3sTA1DEATepkrV+us+DEQ4MDHztRZ3PRWHBAx3lrmoRAZgiQoR9vx2j8Q8rSC2dXwBOR
         2bvJoKCdNMrRLU2unJfTDmrwdTL0b6LrsUMr5Z6Hwrb7kVNUvIkYVi/9yuxp3vGKocYd
         R+vHFjp0xP+LJUxxcx+9rFsBJ8Huc3PmvkpJ7XqWFIcUxiIymuVeTcUhqcbnl6XwTV6Q
         15acDchcQnDdWtIkPMV/FjgoIA+6WTL9gim9LNbsjcxHVyFlsb1pLYh5UeMrc/4WaHwp
         msTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=UwxmIinbpDLwSo24v7sqxrXQc1M2b9Wf+vHygUAc2s8LFii1/YezvO5iqcWxWo1q0x
         n9FtL+H1zzUuvMi+kSDRdySeu54U47Em8LFPyUXZTLTfcUodkWyrZHi4ifMZwZa6/j6N
         UAoJZBgeiEUS7ci6eYFcqiCpWs1a4dgwc8Fdq5h9nZ8yA1S+LyKx85xD3bYNuvLYRHs1
         XYcM0Dyq+vxaRpRI8wGLbOExtkeY/lKaYlOeb2wmZH3W7MESyO8zje8r1YgeB+bFdjhf
         6GIixXwds9G9VkF7lGARVXUQVUsuCqmBkUkzU9nTLz7nQ70qflqHI7z7zc6zlt/19eJS
         V9oQ==
X-Gm-Message-State: APjAAAVccbUMr4i8YnWbR51n/I2sd+RHvm085QwpGsyYyaQ4DnPCzU/h
        wenDKOWbPm9QwC+rOFRt8e4X+odLS3Q=
X-Google-Smtp-Source: APXvYqyfCbDQA77peh2WodzecyxSfQgvSkj4SJR0c6666vyJjyL6ultnvQkXBmOuH6RFu2l6mB1rOg==
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr115249698pgh.178.1578382864640;
        Mon, 06 Jan 2020 23:41:04 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: monitor: Add support for ISO packets
Date:   Mon,  6 Jan 2020 23:40:52 -0800
Message-Id: <20200107074056.25453-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
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

