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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7CC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470E2467D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgAXkz4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgAOGfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45659 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAOGfe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so7701517pgk.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=UgAXkz4kvfGdM3U1PK0pS2PslT291kvew8fI0Cc78tx+J3o2H0NaiaEV5joP8C43jp
         573TnjeKsRFacOq8uNQepy2cf1FgxiNV4xAxTAs/5757byFCWphEYYeH2TSe5glcLu6r
         mQbo6QgrCgo25ME1HtbaLFcCT9OIM4Rh80WF1nVd8ITXAy0K2IsznT04NWwF5vt9CDzO
         WDzuqIEtxafyPCHFapn6QQcPOhrngCKGnDZ9MHr18YqmbSRxu4DUp5Zi6CwacJr6eU/L
         2cHUhXB5tl0UP4RCGCUobWZyQELg3eGqvbcJ1z9bNEMN3Lx2p53DcO+BbY/aFeC+mDoh
         mOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=T/0mNU8Wp8l8x1hvDG6zShquqT8YShqjtKhp2Delg+d9Kd5S/HV0ZV9T1GovRPPZTg
         laZwOlwY8mwpvJEhuw0WZGI3qN/Ju4Nhw7FvaEi2HtNzmJaadzNlg6thIZEp0Gz53o0H
         zy88oNlMGCpd8fyj1+o9N0WJBsq6g0EqAjzYzaazzhGUewbXmDhA6UdjJKaa4bVUIjbG
         Ad+X6im51LbVLTq+mySek2txaIhA3dEC0LlknisBcHIixRwki8HnK13OupgjPtagd5B7
         slAkNn0M6jA8WTZIkicJf9V//+TUKTL8vpre3otZgaBPSZy3yKj49j74dpkW1tfoBwDK
         i8iw==
X-Gm-Message-State: APjAAAWNL6f460IruCehA70zrjzWxeTE2MMRIb7BoXDRlh/Nf5ZAkGRw
        984OeIK0Rrht6OQlr8jK4xWLCzCwiS0=
X-Google-Smtp-Source: APXvYqxAXn/QEaCAUsEo3wfRfTGObnOlIcPKQ2I9bSY3RHTzgzcs2D8gjXQybULgq9CsbJlg/j+tYQ==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr29946646pfh.92.1579070133315;
        Tue, 14 Jan 2020 22:35:33 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] Bluetooth: monitor: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:35:16 -0800
Message-Id: <20200115063523.32127-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
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

