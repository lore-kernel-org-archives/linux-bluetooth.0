Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE58C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE821D56
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMqI7a1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCBPmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:55 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:34920 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBPmz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:55 -0500
Received: by mail-vs1-f41.google.com with SMTP id u26so226786vsg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OteTlcoT40AfnQ3taw+ymi6bTBR3hPxAWNzsjpYdFFo=;
        b=iMqI7a1cUtzZsdVTAvas6ig9z/vB/0RpMFLq7PvuWp8MkJaTp/2NgVcbvsVwFQgsVp
         fxDpyuVwzq3LpbeF+A5pM4KxWJDjVYO1wvIDkwl3Zq0vtI4GUPug34W7KVEw1iUvm1cp
         e713ICp+YVM20641EsWUQnGHe2dl4LFHPlpD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OteTlcoT40AfnQ3taw+ymi6bTBR3hPxAWNzsjpYdFFo=;
        b=gmTalORoH7T/OBTKvmC46xiTQGJ8a3MskrJEcgvkUMOVNJFdtcJQGfMNgTZhGXm77C
         tuNQoUrsVFjoYBry4KrE3aX1lj01mPfOovYRx+puHXS9Z4ITsE8p9DKGoI9eVQPNfu+j
         nE4f+m2kjG5YIWHQlzuvOrOt+AizRPIwK4LyPKj6sVUc+/p/DiwpVix9Mv4ZxfdJQOuf
         J+u7ipC+OU8davlPqACs5TxluKqCV+gzk/1aHAzfHd0GvwkQxc3YG+Dl2RBSwpjHxAtJ
         MAKAcHtWdFsFl2B+NzCDGVdkd889esin810HIb5hqR/jyS3bFHDPGyVQs2YC3pDwkzg/
         cEYA==
X-Gm-Message-State: ANhLgQ2i3Z2cTz/u37FqliFUa3cPjH+v4UTHgmoGWjcnt02C0VGqiDte
        lDnTpzrvZ8C4feHgsDi3TQ3QQ74o7cM=
X-Google-Smtp-Source: ADFU+vuMir6OzgGXAoSGo/kHHxEJTYFKyfDCZettwXYruC+2bEmRMAgk9D5bCJUpqBFLb47yXye0Cg==
X-Received: by 2002:a67:8704:: with SMTP id j4mr10232732vsd.106.1583163773850;
        Mon, 02 Mar 2020 07:42:53 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id c10sm5728477vkm.29.2020.03.02.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 07:42:53 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth: guard against controllers sending zero'd events
Date:   Mon,  2 Mar 2020 15:42:49 +0000
Message-Id: <20200302154249.25047-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some controllers have been observed to send zero'd events under some
conditions.  This change guards against this condition as well as adding
a trace to facilitate diagnosability of this condition.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 591e7477e925..56305b3a865e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5868,6 +5868,12 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
+	if (!event) {
+		bt_dev_warn(hdev, "Received unexpected HCI Event 00000000");
+		kfree_skb(skb);
+		hdev->stat.evt_rx++;
+	}
+
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
-- 
2.25.0.265.gbab2e86ba0-goog

