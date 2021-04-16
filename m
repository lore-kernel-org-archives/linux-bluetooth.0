Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C11C43460
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7F6613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbhDPVWF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbhDPVVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB20C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z22so9524944plo.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w2i2EkuiHwy6UHQHgCZ3FLK8RP21LjHU09eKxBWV+Qk=;
        b=LKP60iXdPnxLEoEawkgbIaYdUPjAxJVb2OggEQ8d1Ptv2zeIBw5VkalauqIMElSGs9
         r6el0LAd7TeS8Oa3vmSTozkAUMWPST58nh7ZON+LSxDivqAxN6ToYShuxZwbKslUtJeP
         p9EY2+qpjDswwx09y0EREiNBTzTVZLsjjTFI/lmQMQMnrB3KCHXC119M0nDbIU2jVZdM
         fJDg+h4I0emKb6eHFEoc2Ao+vYZiJ1nLd7Pggufv4PYUMhSTM0UCyiiO7/3VOvczr3fE
         FP8RXYx80M7Xyt3PYqcpJaZym6jmSb0aV/nXGvbox5qloFQ+ladU1+p48KMGJFv7eos+
         RvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2i2EkuiHwy6UHQHgCZ3FLK8RP21LjHU09eKxBWV+Qk=;
        b=K9wvbP3JUNCCxv5q6q5L00NeDnCRwCC4jC9iX2vs989/CASvhFan4QDpr00YtuzX7I
         rxJ6CQd9qteSoMXsY526Tzi0MPoKaC043oikNzXpTwemYkcWg3BcSnUljsIcB6ZCjqUJ
         uZxJFizrwvye14Z8/7skaCEuYPzbEz7kjWBlkn1PN+OmxiEbymmyBmS27zAN8/icSFkl
         dxXbDuvoFcUmmSJM0QmdQ1FvV+z4CLbZ7vavJky3XZrrfcG4yuXJSfEEPgCu0sLu/fG/
         AdGanAPIPUYwgahMlixQAItRaz6LdtbVDa6RoIIDTfWkZYwEF0NCMzAxW7/0fes4yRoF
         Xrrw==
X-Gm-Message-State: AOAM531hY0sUmoJk6J4Sp4VEsHcaGLGleERHZsrJfaRsHSPAIOvJlBIE
        BJivXD8XgVmKGJd2WeEt6Ek5pamRU4fnUg==
X-Google-Smtp-Source: ABdhPJzYlL7rVdPjEggHShCXXynID21CTdltsVyHpJvrBJHwnBxyxU9e5fP1YiP60R1z+X8uIMLYag==
X-Received: by 2002:a17:902:8f8d:b029:ea:e059:84a6 with SMTP id z13-20020a1709028f8db02900eae05984a6mr11604491plo.35.1618607908725;
        Fri, 16 Apr 2021 14:18:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: HCI: Use skb_pull to parse Number of Complete Packets event
Date:   Fri, 16 Apr 2021 14:18:16 -0700
Message-Id: <20210416211823.3776677-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Number of Complete Packets events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_event.c   | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f1f505355e81..9251ae3a2ce0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2021,7 +2021,7 @@ struct hci_comp_pkts_info {
 } __packed;
 
 struct hci_ev_num_comp_pkts {
-	__u8     num_hndl;
+	__u8     num;
 	struct hci_comp_pkts_info handles[];
 } __packed;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 64f5931bfbbd..65b7194ae1ba 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4265,23 +4265,25 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
+	struct hci_ev_num_comp_pkts *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS, sizeof(*ev));
+	if (!ev)
 		return;
-	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS,
+			     flex_array_size(ev, handles, ev->num)))
+		return;
+
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
-	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	for (i = 0; i < ev->num_hndl; i++) {
+	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
-- 
2.30.2

