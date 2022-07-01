Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE9C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 23:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiGAXhC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGAXhC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 19:37:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6BB37A3F
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 16:37:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s17so3666568iob.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V20DXpg9bwk7JSpqnxcpozX3gu+tvhOY5YVB8s2B41E=;
        b=e3IiF3EWU4dGVnoi0cdUrp3foSsDlBJ8hp7Z+zcMoJ4OaxvsmQXYIhrcxtnYLzNjc6
         FND7gfTYC7PSBBXGCIgFC7iPkmk+zjmTwMfLFHjpYTau9hcqSUpMkT+X4WuRQo/FbxGO
         Wf2j6hAzF4wAUHpYHFAqmjiy+nslBltqQaQoESJpjr1Q32iEdZdTWn7u8n8MUenFcN1D
         jOmroq0wW9rDEnlWLoaLxXbAhxgXTJmWNnxTmsX4jhfeYsAxUn/0BmU281zWQFzs5CWi
         ff/a6SWuPmRYdK0gg+pBeke1ziAZwQ5agx7KddO6T+dVW+qIwH5f36RFU3l3eHrTcucz
         Q0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V20DXpg9bwk7JSpqnxcpozX3gu+tvhOY5YVB8s2B41E=;
        b=Rwhf/2MvPZiKGKMrfYzBVedRHAoGipoXZDT3CyhyrQGlbTsJySDidjUJO2D9OQcG79
         2cl4K20qG6h3G26xis3Miife8nWP9Fnr9BjbpIpkIuzsbMxybXmoHehPd59QQTeiyhG9
         yvkyPaCYy01U6xtkLtJwJIUYM+Mkkb8oXUAaWVwCRtGbswjIQHEcXYKDXqdQ9E/oIgDE
         9R7w7ZlWtfWlKNJnIuvhpdqVCN2zjJ25VtMgci7amo2nqDSoTWCv5INzAKsBy2QPo35l
         ZUmWiPqliYTnlmUravZjXujoyq6C3r3SbVa6/p0kBKwXxZK9ykxw6Pkshq1reo8DQTLK
         bcyQ==
X-Gm-Message-State: AJIora/NI/XbPLlLzlP6Ca+pBu4hOTaVrW1ocl8jumW7cWaJ9dljMpKz
        KbCeEO4OhetEvvz9NeFWYJO8MPihx7U=
X-Google-Smtp-Source: AGRyM1sHFYi37TF771TG8xZxb9A69w8LNS1hdTpjhm5e8RX1HaLob0hX1Ki5gNW30ZJBp9M/c5rgNA==
X-Received: by 2002:a05:6602:1355:b0:63d:a9ab:7e30 with SMTP id i21-20020a056602135500b0063da9ab7e30mr9196238iov.119.1656718620153;
        Fri, 01 Jul 2022 16:37:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00339d2cd8da1sm10312154jap.152.2022.07.01.16.36.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 16:36:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Fri,  1 Jul 2022 16:36:52 -0700
Message-Id: <20220701233658.966972-1-luiz.dentz@gmail.com>
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

