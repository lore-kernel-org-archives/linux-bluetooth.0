Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E5C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E23A221E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dkngZxcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKRQW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgIKRNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 13:13:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A1C061798
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so5070721pgd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mbot9ybxN7CEBjkJx2/zfixlDiQJfoliZ9FJfemsvkc=;
        b=dkngZxcJsfiwaoaeeA5ivGItvOj+ltwumQrEg2V2Fb6waCKmwZnjPEH4f4GucgxVLB
         5dw95RVIXR7dHD+f1E9ucpz2A3/rbkTFTnco1FwjNge2jtemQnNxvrRRKr+KfkzRDqJQ
         +oLDdyDVAapClSi2quq12dscrXXbs1KAohowQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbot9ybxN7CEBjkJx2/zfixlDiQJfoliZ9FJfemsvkc=;
        b=WmNaBEN22Li/Ww0aqALonc3/tBWS29fPWRjT7AI4NAou82BB8tnOTHWRNIkbLbK0Qj
         oscxPPbGNNsv5ldg/nG7FkOAJBjDzKEtkiZ2YmNR5HDxpvhxIsvntzlHNVo/DDZMTQ5s
         QgM46WnhhtJ5OiYAkasfHu+Dkl9O1N+LuNhh2fCe6RuFoCZgKAsp2PtPxYrHbmGelhNL
         ixsAOAj9GdsCl4DZ/C1/2aAbaJ2tYv996wClesRYcW59Ty7InlCuOqwR+Gz4+lr7AuuA
         y+Vxhjy/LpHk72AWWdfVMUuKB8hzisWNiUFYalpOoI6TfY5J0BZMxmUQKJr6J15IypZX
         DaGg==
X-Gm-Message-State: AOAM5325nj0hG7G1zGA9fIVqqsEtTS3YhbJZcSIawthFBuvuXOCjZazM
        01HsnPusRi8IpPxlVNuYBOvZJg==
X-Google-Smtp-Source: ABdhPJxZSSZY4mIQBJ0os+Tl+NKbSD61XqIC+eZsymowPVyQeWCMOMXGMvOnS58X3crxD9bFA3MAlw==
X-Received: by 2002:a63:b20d:: with SMTP id x13mr385059pge.136.1599844392256;
        Fri, 11 Sep 2020 10:13:12 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id h9sm2787452pfc.28.2020.09.11.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:13:11 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RESEND PATCH 1/3] Bluetooth: Add mgmt suspend and resume events
Date:   Fri, 11 Sep 2020 10:13:04 -0700
Message-Id: <20200911101255.RESEND.1.I1b721ef9da5c79d8515018d806801da4eacaf563@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911171306.3758642-1-abhishekpandit@chromium.org>
References: <20200911171306.3758642-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the controller suspend and resume events, which will signal when
Bluetooth has completed preparing for suspend and when it's ready for
resume.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 include/net/bluetooth/hci_core.h |  3 +++
 include/net/bluetooth/mgmt.h     | 11 +++++++++++
 net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8caac20556b499..02a6ee056b2374 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1750,6 +1750,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+void mgmt_suspending(struct hci_dev *hdev, u8 state);
+void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
+		   u8 addr_type);
 bool mgmt_powering_down(struct hci_dev *hdev);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9ad505b9e694e4..e19e33c7b65c34 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1030,3 +1030,14 @@ struct mgmt_ev_adv_monitor_added {
 struct mgmt_ev_adv_monitor_removed {
 	__le16 monitor_handle;
 }  __packed;
+
+#define MGMT_EV_CONTROLLER_SUSPEND		0x002d
+struct mgmt_ev_controller_suspend {
+	__u8	suspend_state;
+} __packed;
+
+#define MGMT_EV_CONTROLLER_RESUME		0x002e
+struct mgmt_ev_controller_resume {
+	__u8	wake_reason;
+	struct mgmt_addr_info addr;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1d12494d16e14..1475a47edb080b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8874,6 +8874,30 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_suspending(struct hci_dev *hdev, u8 state)
+{
+	struct mgmt_ev_controller_suspend ev;
+
+	ev.suspend_state = state;
+	mgmt_event(MGMT_EV_CONTROLLER_SUSPEND, hdev, &ev, sizeof(ev), NULL);
+}
+
+void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
+		   u8 addr_type)
+{
+	struct mgmt_ev_controller_resume ev;
+
+	ev.wake_reason = reason;
+	if (bdaddr) {
+		bacpy(&ev.addr.bdaddr, bdaddr);
+		ev.addr.type = addr_type;
+	} else {
+		memset(&ev.addr, 0, sizeof(ev.addr));
+	}
+
+	mgmt_event(MGMT_EV_CONTROLLER_RESUME, hdev, &ev, sizeof(ev), NULL);
+}
+
 static struct hci_mgmt_chan chan = {
 	.channel	= HCI_CHANNEL_CONTROL,
 	.handler_count	= ARRAY_SIZE(mgmt_handlers),
-- 
2.28.0.618.gf4bc123cb7-goog

