Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A48C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D178611F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhDSRNc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRNc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331DC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c3so4824771pfo.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0NTxdqoYwPHoeTx0gB5ac2el154Qlb5ROuxuD9pDuuw=;
        b=kdMT7I2p5XazU9tuDZYKdILJz2s+oI3RlPq4W5mJ6QoQGjwzfwWsqOFIbJ2ubPqUI7
         qKbIPEFMaWsSssWXPTEU7P1cO4zkFQ7gN+0MJoUahrez2U9J/7amMbt/0DBmKvEtczZF
         m9YztVWYEkQgVRLccXByvEorL4cRA6r5jnC0bpAXsRIl90sj8rQLVX3rmf5j9jr8sM8N
         upL0WmvZiV8Gp/Z1PXAfjLGq4HhXaTEcFwHVd+1uVsC9xuaJqPY3ekPR73W4EicEkj8C
         172fueK0SfgPOrTJ9ri2yJJXzK93SMUnOQ1Pxyhky5brvBHMeXKg4Y5AlPVnfeOhsPcd
         gBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NTxdqoYwPHoeTx0gB5ac2el154Qlb5ROuxuD9pDuuw=;
        b=nCzwg2cnXkeZruVbPbC5nnOvzA/Jz3dRTeG2olojaVcs6Mcuouhow2eriDLipoOgIi
         BLVa2sxLIonu3dN2cS4fKGn2sWU5G4YhzCbfB/vukove2Iac9tkVi0RegNrVNKMaptZc
         byiO4zU9jv8hf2nrxhN3f93IPSmKApDEEFy7y46rBvCmBjOIfyGlIuisWeF3QkEgfZgN
         zLneClSDHtZxepJZ/rDur81Z9qm6v/XIMjOOLVXTmK8TxbiF+t9PQUPc9mUQjnw655Fg
         s9Qj9MAhoQJ8CSTB/lK/Rd6/0/tAzUz5t9i4FlANCRDwFTXfFtV+neiSeQdDwFkxZrUo
         ipog==
X-Gm-Message-State: AOAM531GAH9E1WcaBOdzI1gf8IXyUKtWAYhTb47SmAnTT0xAXQkWoFiJ
        EjPwYwoN8JjabEz/lGk4zLusWMM+arpReA==
X-Google-Smtp-Source: ABdhPJzxEGUuMrxsiWdXfbh3NWT6BD33Mx8zVZUSZDktSkCwLuehfly4L6vv0wFz5YRcpWoBKb31eg==
X-Received: by 2002:a65:560d:: with SMTP id l13mr12806984pgs.49.1618852381418;
        Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] Bluetooth: HCI: Use skb_pull to parse Inquiry Result event
Date:   Mon, 19 Apr 2021 10:12:51 -0700
Message-Id: <20210419171257.3865181-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Inquiry Result events received have
the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 19 ++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9251ae3a2ce0..b65205b4d830 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1910,6 +1910,11 @@ struct inquiry_info {
 	__le16   clock_offset;
 } __packed;
 
+struct hci_ev_inquiry_result {
+	__u8    num;
+	struct inquiry_info info[];
+};
+
 #define HCI_EV_CONN_COMPLETE		0x03
 struct hci_ev_conn_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c353dfafb04c..6516538fe238 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2990,13 +2990,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct hci_ev_inquiry_result *ev;
 	struct inquiry_data data;
-	struct inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT, sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT,
+			     flex_array_size(ev, info, ev->num)))
+		return;
+
+	BT_DBG("%s num %d", hdev->name, ev->num);
+
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -3004,7 +3012,8 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--, info++) {
+	for (i = 0; i < ev->num; i++) {
+		struct inquiry_info *info = &ev->info[i];
 		u32 flags;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
-- 
2.30.2

