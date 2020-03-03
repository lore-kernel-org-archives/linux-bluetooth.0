Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A94C3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48145208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jA3lbRTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgCCPzm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:55:42 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45525 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgCCPzm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 10:55:42 -0500
Received: by mail-vs1-f53.google.com with SMTP id m4so2654522vsa.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2020 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DXAgA0BV232zHIduMsuc1xsDnUh5eMDqf5PhGpC/9A=;
        b=jA3lbRTy7cJKHa9xvLbON4NhLI2peCy/qc6y3k5kqmJfaaR+76IFHySznqozXG7EZr
         qd8ZSE/Lh9GEmOZ7OD6hO2axXLNMEGRPq361Iz+XPN/NVRDGcXAI6kUTIJc4ZWU22R+U
         SYOePYPgOIrlXzscUhbebcUYSFJYHQgQw/1Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DXAgA0BV232zHIduMsuc1xsDnUh5eMDqf5PhGpC/9A=;
        b=ALCNB7uFYgDeHjetWyNYB94Dtv3jBEwdBB2KOG4xMt3XOOPx/UkU0+89xZk80uD90Y
         sTPUVj5h2HxZ3wkKMj8NuBL9IKl72YPWYDHKtUFJHAtjW47TV53zGX6ySaO6VzVdMAJu
         2JpmPxGBse3XrbLQi4HGl45+I4U7Ll2SaajXjk4aEScJ3+NGo3fhlmxCgXM3QMYs4FMi
         uWWptq7lO9HHuoOwLPQkOLpm3oQNszAgndW58pnYtiigKFcxy09dxuijgwwGWNiEgVBZ
         dTvk8kqQx1z5h9w84H2vCdzd1L9LhEe5FPo1+tfa0tC7ukwAeXIqJQh6vWEtelxuF9Rq
         /4gw==
X-Gm-Message-State: ANhLgQ0Y2qoIiGtcpnuZUblM0J7UMYiG3HxNHdxOme8yKn9rjJgThF1o
        gkZLE2BKfNfG8oFp4lZE/WRhS7h0OQw=
X-Google-Smtp-Source: ADFU+vs3iQ3TWT7ioPNqwteK9+AVyAWQqEG4DEdsz92RNe5XEbLAefHbZTVYq6QwrMId4H+e6o6ehA==
X-Received: by 2002:a67:fe05:: with SMTP id l5mr2751338vsr.77.1583250939643;
        Tue, 03 Mar 2020 07:55:39 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id v65sm6549559vke.13.2020.03.03.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:55:38 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3] bluetooth: guard against controllers sending zero'd events
Date:   Tue,  3 Mar 2020 15:55:34 +0000
Message-Id: <20200303155534.127645-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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
index 591e7477e925..a40ed31f6eb8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5868,6 +5868,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
+	if (!event) {
+		bt_dev_warn(hdev, "Received unexpected HCI Event 00000000");
+		goto done;
+	}
+
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
@@ -6079,6 +6084,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		req_complete_skb(hdev, status, opcode, orig_skb);
 	}
 
+done:
 	kfree_skb(orig_skb);
 	kfree_skb(skb);
 	hdev->stat.evt_rx++;
-- 
2.25.1.481.gfbce0eb801-goog

