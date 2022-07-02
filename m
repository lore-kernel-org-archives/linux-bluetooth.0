Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD69C43334
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 00:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiGBARy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGBARx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 20:17:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3131E38D87
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 17:17:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o18so2613117pgu.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JDptBZjNtPq0xAZnFwAbSh4HNa+KXts6gfDiOlaQIs=;
        b=THZFEpOkoqvfJWCDYfA6HEaMggnmzZmsTwV7OK2GM9pKbkFynnxPKXWCaa6gwcYQ1+
         OwuhJjgk9B/RDRzCVypFwOUWmgSRlXqKGagtcU0i9ziEYUwmAFu+3Rh9C3cj61yz3iXa
         6PSxwtsdPNfU9AmF1i1P5w0Yw/Zj1JIXCPYlA+pQfgbYgutGRGBNih5cbX53ij4qhtgW
         ArI606vRcpfMCOYtxYEZSZbI46xbJpLIvDO/Sd/ARjJiq4VCDsK6iah5wEeeIM6KWTLn
         hz6BOZtgHuWFu4OGABalGsQyKlkRcyhycV0cCA2NRAKHFuk6JivOf5j3glzcEepw6ftp
         tA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JDptBZjNtPq0xAZnFwAbSh4HNa+KXts6gfDiOlaQIs=;
        b=S3PxwOe5hSxxc5r61ALD+0J/dM0ga+90J9CFr8KEqjAJFaPbqwvZF6mXquW3/GFfve
         D0e3oIxPxzuj/EIH8NKU3Lqs56Q6KsGU1vgG1gW4azKV25b4Gg6q3q//Bri+mxLimeF8
         cMTxUAtCBPIuuTspA2TdC2VyevhMekWZBR/wiwS2Tk4Q6aTDOFyG2ObestAvd32LMOcO
         vrXaSvug+SmBpxdHgG/9XNxFkKjddQNXxRK2/rmtZWx5huS6zDRKnd4432DL7M20K8sU
         zf3q+9GhpNs8j4ZDuwZbA7/usJC+5Juh3Fnh/m8xx4fOS4yuQmNX4XK2Ux2fAAu2lWjj
         aawQ==
X-Gm-Message-State: AJIora8SscHjMnw63Cxkr/ulB69cF2LSSV3xPcmj6xqWJJcVVTGB79Lk
        qDX675EwzoK7P3xECdE4nwhlBI1MHA0=
X-Google-Smtp-Source: AGRyM1vcIxR73v16ssNj6w2XRtW/5Jwfy9Dt0ERH6uiKr3qnDjLf1lCcyLlTd752rKpa8PcO4UFTyw==
X-Received: by 2002:a63:951c:0:b0:40c:f82e:7d36 with SMTP id p28-20020a63951c000000b0040cf82e7d36mr14481965pgd.201.1656721070104;
        Fri, 01 Jul 2022 17:17:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0052089e1b88esm16219667pfe.192.2022.07.01.17.17.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:17:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Fri,  1 Jul 2022 17:17:42 -0700
Message-Id: <20220702001748.1003783-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces hci_recv_event_data to make it simpler to access the
contents of last received event rather than having to pass its contents
to the likes of *_ind/*_cfm callbacks.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fixes CI/kernel test robot findings
v3: Fix crash when disabling ISO Socket experimental UUID.
v4: Fix crashes when running iso-tester Defer and Defer Send tests which just
binds the CIS using DEFER_SETUP without attempting to connect it at first.
v5: Fix kbuild findings
v6: Fix checkpatch findings

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 15237ee5f761..0ce57e1856e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -530,6 +530,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
+	struct sk_buff		*recv_event;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -1755,6 +1756,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05c13f639b94..1ff2c284e867 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2739,6 +2739,7 @@ void hci_release_dev(struct hci_dev *hdev)
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
@@ -3045,6 +3046,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
 
+/* Get data from last received event */
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
+{
+	struct hci_event_hdr *hdr;
+	int offset;
+
+	if (!hdev->recv_event)
+		return NULL;
+
+	hdr = (void *)hdev->recv_event->data;
+	offset = sizeof(*hdr);
+
+	if (hdr->evt != event) {
+		/* In case of LE metaevent check the subevent match */
+		if (hdr->evt == HCI_EV_LE_META) {
+			struct hci_ev_le_meta *ev;
+
+			ev = (void *)hdev->recv_event->data + offset;
+			offset += sizeof(*ev);
+			if (ev->subevent == event)
+				goto found;
+		}
+		return NULL;
+	}
+
+found:
+	bt_dev_dbg(hdev, "event 0x%2.2x", event);
+
+	return hdev->recv_event->data + offset;
+}
+
 /* Send ACL data */
 static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 34bec7446d00..2440275a143c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6936,6 +6936,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	kfree_skb(hdev->recv_event);
+	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+
 	event = hdr->evt;
 	if (!event) {
 		bt_dev_warn(hdev, "Received unexpected HCI Event 0x%2.2x",
-- 
2.35.3

