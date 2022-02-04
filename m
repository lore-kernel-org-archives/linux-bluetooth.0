Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiBDVMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiBDVMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 16:12:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE1C06173D
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 13:12:39 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 192so6135378pfz.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TcS4cAXewV7IfVVTDFrxr+BDHcxa7h+kgX1AP6pfqFI=;
        b=npioEXda55NeU4BQqxvEP82PkXRuAAILzfFtN+kGpfh6yqEFnbbnlpgceITRgPkASe
         mu0z3UbjxA1O71jEVhWxJzU6OKut41TP9ru0L6Z9izU5esbRx7jxLCa9GMvzAFJvaGL9
         QW1EMrKEJUq/FJgwJZvBymFebgWUn6P58IHVv1A1KHCCcQ4h0bpfeR/8vSp31g2sxsKX
         WBNDQ0Hldf8vqoA026BPiHahNBAOARzrfL9KlJblmJ46QKNGIHVLDnEf0QL7qYVAg4b9
         61csW8cWQBMAAznwclytXJM9GnFvdRC0PPybG66wJ4IZKLaNcTV+MGg0b7LL5+Uj1F53
         w53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcS4cAXewV7IfVVTDFrxr+BDHcxa7h+kgX1AP6pfqFI=;
        b=55K9PyQFj4s7cr16Pp9LPOU0p00x8OkeXvvOJgUETXEIfmS1PgMsBwbkxH2n+kMK/Q
         UrDyfSczXcqhHm6TGucIK3/XiMGJGeNiRT9uQAsjMVGAiXPd+0j/wQviLTLa4h+/50cE
         DLmv0g8wlh+L9hQq1FByfROCOfY1hl3pD39fLgGz/W9Z77U34qBfoQc0QpVSOeervR6b
         eZkWdMiSBxsw7yldL9OuuxA85ueb4IHIOw4mEcuM8l8lNdGAr6O51qzxNxZRQjAVdkgr
         joTd9cSuxeiTYh9q997XJfKi8CS0zriNPx8aiD7fUc6mZCS4XLsGzqB7jefIVvv3H+s7
         pIkQ==
X-Gm-Message-State: AOAM531TKiNSxXlwgqF2ewFPqQdjn1fDMr+HLpzL5CIjcIReEV8ywef4
        uacgy6NlBXGJLm+flQkD5Ag1dokuvmdQGw==
X-Google-Smtp-Source: ABdhPJyitS73zVxdFCn/+y/Vm/ATK5DEn+Nl6dp8Fny50GJqjPquHSSRSzGc1HOh6k/D+Nxo1OcM6w==
X-Received: by 2002:a05:6a00:80d:: with SMTP id m13mr4979501pfk.48.1644009158655;
        Fri, 04 Feb 2022 13:12:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z17sm2142267pgf.91.2022.02.04.13.12.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:12:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Fri,  4 Feb 2022 13:12:36 -0800
Message-Id: <20220204211236.2690926-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204211236.2690926-1-luiz.dentz@gmail.com>
References: <20220204211236.2690926-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f5caff1ddb29..c454913794bf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -516,6 +516,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
+	struct sk_buff		*recv_event;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -1727,6 +1728,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b4782a6c1025..5d1167b67a47 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2740,6 +2740,7 @@ void hci_release_dev(struct hci_dev *hdev)
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
@@ -3024,6 +3025,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
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
+	hdr = (void *) hdev->recv_event->data;
+	offset = sizeof(hdr);
+
+	if (hdr->evt != event) {
+		/* In case of LE metaevent check the subevent match */
+		if (hdr->evt == HCI_EV_LE_META) {
+			struct hci_ev_le_meta *ev;
+
+			ev = (void *) hdev->recv_event->data + offset;
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
index 63b925921c87..613050bd80cc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6898,6 +6898,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	kfree_skb(hdev->recv_event);
+	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+
 	event = hdr->evt;
 	if (!event) {
 		bt_dev_warn(hdev, "Received unexpected HCI Event 0x%2.2x",
-- 
2.34.1

