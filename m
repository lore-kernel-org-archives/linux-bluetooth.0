Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919ADC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGNAWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGNAWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609761583A
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 72so106868pge.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9oZJUV3RpGzSZCa65z3Ze1dKnt/BilmUQkfi4nYEz/8=;
        b=oFIAeR5kEVirnJV0lrh7nJnW85JsQ6vN/qs5fPkVxqsBUluzXylG6LhIs61HnkGYjn
         4cDc2C3AgrPf9VZGAi/SlahJ5AoX9tjiBSf8325JAUuozRCu6fPWI2/2j6PlifhG0nPe
         aOWul+r8dx2/msqqWPN4jz1PUpaYa+HLv5fumNsJV6zktzVBLeQ+YRDd/Y6N6kWK2eEx
         CIqyMmsFz1AhxhwiZwjRMwdSRa2ugQ8gN/52zLNWu0vYaqDimBNsPRCffB1j/tA+A7yv
         dtZI3R2P/y11pRfWyYZFCFTB9k5Rpe7Jyd3WdSAdemmBwmrPMKCLunBt2Ub9k73rkxWI
         SeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9oZJUV3RpGzSZCa65z3Ze1dKnt/BilmUQkfi4nYEz/8=;
        b=a0II2RG12bxmkXsamPVcPODczqhT5/zuqOPXue8mGpexBwfgKfR1JuWbwGimBgtHYB
         SOhUizSCjH02gHFKZ85Zy5mZ1RnC/3rMq9EwpJCDVFZo4Ufbwe9oDW6VpkJOM/oIbFD7
         ratehC4WvXNluxMT+ZhgyCMdnBDT71x3mA8nQGJB98VAB7vzc7DT+VjZNfSsq6kD2BnO
         MlHI90jiF/7NYUnKpXbTgPeH8xHsICxXF+TZ3iDz7Fw/HtPc8DgS/BLS5Oojue1HjBux
         CzmSX/0yu77scYd2+3M7CMYUHs0H+gzjAr0BfDtQgyo6/cUCb38sAgo3DTZyPxAKt3pX
         KpXw==
X-Gm-Message-State: AJIora8EnwMuAoVag/1QsrLQ2IFVSeebgtJyUbmxwMoRkrFbtch2sInV
        2AXdY0OOR8GKizo2LIMxG5HUPOwynKY=
X-Google-Smtp-Source: AGRyM1ub1UVXQpr5pLK7tzxTL5dgid4KMnlesbxEbzKu45YYjpawvJmY9fxg2mAt4Az36yYTTKW6wQ==
X-Received: by 2002:aa7:93a5:0:b0:51b:e0f8:97a6 with SMTP id x5-20020aa793a5000000b0051be0f897a6mr5665794pff.44.1657758147404;
        Wed, 13 Jul 2022 17:22:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b0016c066e566bsm19543plb.164.2022.07.13.17.22.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:22:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Wed, 13 Jul 2022 17:22:17 -0700
Message-Id: <20220714002225.3540241-1-luiz.dentz@gmail.com>
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
v7: Fix setting timeout on connect when DEFER_SETUP is used

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
index 27e90eb4bf4c..baaf2fb969c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2742,6 +2742,7 @@ void hci_release_dev(struct hci_dev *hdev)
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
@@ -3048,6 +3049,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
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

