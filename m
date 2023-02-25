Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53114C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYAVF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBYAVE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 19:21:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40E703B4
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c1so1190890plg.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XklqBXUzE5TheuIzINkJARoV6rpuGdj5bkX5YZz0Fcs=;
        b=mVKgepDGOOHQ2i21ShdKa2VbzqNPtVnr6fyGjZKJNavTIwb4g/1rpU0DcpT3oozWTn
         E21dvq6xahdYwQJ87u1ZTfO5/l69c+qUG1WDbx0ggo8svtONaqYqUvJhz2y1K2G9bvhy
         MR1XRsPs22tE3sj8xu5JpzOUkDDoJ3YFoxGOv2M4yPxScosDwPB6z/v7gqh2lZ+xwr1i
         GDngrKKL+u7ktZXR0ZOs404ragYussfGV2Po5aL+zlU04ag8TWTG0BNv2FHACmsIFl7F
         3tL0XBtXYqyzfK4rP59T7Jcul21AEA8FNscMD/C9bQ55m3tqC36BSTX04e7uyslbMNbR
         p1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XklqBXUzE5TheuIzINkJARoV6rpuGdj5bkX5YZz0Fcs=;
        b=sqxZlyWdE/UQjPxEyH0QqqSScj2/SjTBnEnmHo+JmTNtrtSWnwxtDx+u8fXsw7/wGi
         ubQv1kQGVMIWHmubONtcApdlh1ooXi9PNTLw2a4DwbPxrgJnqsSXhrPkQ/0oy4/y4v8s
         MqMVhbDfjJ8KS0nF9KLiwRTJ13E8ZGvecFMSt33pmIeLHbrmyg2pE1qJ7Ua4Gp6ELgdd
         k5pSsFgVojU54MQtcKDdU1OaZ92teuVl6MIP5MzttkeC6A1n7I2wdYKB/baJ37Y87E2o
         3Oh+NOqvTFy6Ue8OELzingzEOauLeSGWMmVa4nv1JJMGPBw9sCl8VJ1h0nK8+R7KL2M1
         rj2w==
X-Gm-Message-State: AO0yUKVJrl4u8QEBxXjbKm7jzSg2yc4DS+3P4dAKq/cc8sGqQJTUDa2K
        wy8u3N4McTu3Bo843F9LWfKegcEnJw0=
X-Google-Smtp-Source: AK7set8PBse0S2WXHxodbniDP4ke6aGoG3NHNpEH6mRZdVRZ488yo5gUvIEgxg2RGxl2LYWrEhgl5A==
X-Received: by 2002:a17:903:41c1:b0:19a:a6cd:35a8 with SMTP id u1-20020a17090341c100b0019aa6cd35a8mr1456248ple.25.1677284455618;
        Fri, 24 Feb 2023 16:20:55 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b00196025a34b9sm75008plb.159.2023.02.24.16.20.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:20:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3]  Bluetooth: hci_core: Detect if an ACL packet is in fact an ISO packet
Date:   Fri, 24 Feb 2023 16:20:51 -0800
Message-Id: <20230225002052.3866357-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230225002052.3866357-1-luiz.dentz@gmail.com>
References: <20230225002052.3866357-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Because some transports don't have a dedicated type for ISO packets
(see 14202eff214e1e941fefa0366d4c3bc4b1a0d500) they may use ACL type
when in fact they are ISO packets.

In the past this was left for the driver to detect such thing but it
creates a problem when using the likes of btproxy when used by a VM as
the host would not be aware of the connection the guest is doing it
won't be able to detect such behavior, so this make bt_recv_frame
detect when it happens as it is the common interface to all drivers
including guest VMs.

Fixes: 14202eff214e ("Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b65c3aabcd53..334e308451f5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2871,10 +2871,25 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENXIO;
 	}
 
-	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
-	    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
-	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
-	    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT) {
+	switch (hci_skb_pkt_type(skb)) {
+	case HCI_EVENT_PKT:
+		break;
+	case HCI_ACLDATA_PKT:
+		/* Detect if ISO packet has been sent as ACL */
+		if (hci_conn_num(hdev, ISO_LINK)) {
+			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
+			__u8 type;
+
+			type = hci_conn_lookup_type(hdev, hci_handle(handle));
+			if (type == ISO_LINK)
+				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+		}
+		break;
+	case HCI_SCODATA_PKT:
+		break;
+	case HCI_ISODATA_PKT:
+		break;
+	default:
 		kfree_skb(skb);
 		return -EINVAL;
 	}
-- 
2.37.3

