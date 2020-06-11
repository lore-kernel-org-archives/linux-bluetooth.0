Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E422065C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZt6Vw1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgFKO0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFKO0P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 10:26:15 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6ABC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 07:26:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v25so2160817uau.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQDXtrStnVos/LlqQyOSKYMP2pT/eyHgs6Tku5covdQ=;
        b=TZt6Vw1sV2VsDpJpOj1Th674IxePFoLW5a7rpp9LzQEbH0401nzfk/YRerw6aCiO1j
         /pkgR1IhHLyO2blfFZSu1hIXf4UrbYPTCD4T/a/DBe7KC6hIfmaS1LOJVjOrZ2P7toIk
         ZyLNkfT103rDY+CO5dWRY8uL4u7y8EqPeVQQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQDXtrStnVos/LlqQyOSKYMP2pT/eyHgs6Tku5covdQ=;
        b=jlV26A582k2M2tavCpTeI1t/z1skyAbI3Cuakm04FhpbggDguBNsvCUFMrF6HvQAqP
         upbkhWh8UViO2bP6beBLVg3bKSNIAIaZELp3r8QiTvO5Dqj5KsgBPNlIrvKjK5L5GasQ
         cH0zzFH1olEmSKxOuuQyoqU4Rq+8bTpzWTGivit/VRtbFYyS5A38YzxmRs0yps2Yu8bv
         zHDA+ICMREtIG5i6Cy9Dos/X5v4IC81Z1x71h00UQ97BtZ7E85+GuDPKjZ/MdBS014tb
         Vfk0yNQaK+2dwpX4MiVNf5hGZ+e1El+O5Hr39Fxi6bNrkpsoj8IrSioRECz5Rix61MNC
         WhkA==
X-Gm-Message-State: AOAM530umFLYMEMwLr9WOdW8ZxjyrjjHRdL1wg1oFHJgcThuYs0sjnum
        BnNp36pMznuqC5f+K3322XD7YI33cqM=
X-Google-Smtp-Source: ABdhPJzosMcj6D9Rvx7oHT7zg7mXxpwEg7M0xyP/caVgGLo1fDZ6cUQtBVRpxTtpAIIIGQmoajAYjw==
X-Received: by 2002:ab0:5398:: with SMTP id k24mr6513678uaa.2.1591885573798;
        Thu, 11 Jun 2020 07:26:13 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id l84sm450608vke.15.2020.06.11.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:26:13 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth:using 8bits for the hci cmsg state flags
Date:   Thu, 11 Jun 2020 14:26:10 +0000
Message-Id: <20200611142610.18125-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change implements suggestions from the code review of the sco cmsg
state flag patch.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_sock.h | 4 ++--
 net/bluetooth/hci_sock.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 9352bb1bf34c..9949870f7d78 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -31,8 +31,8 @@
 #define HCI_TIME_STAMP	3
 
 /* CMSG flags */
-#define HCI_CMSG_DIR	0x0001
-#define HCI_CMSG_TSTAMP	0x0002
+#define HCI_CMSG_DIR	0x01
+#define HCI_CMSG_TSTAMP	0x02
 
 struct sockaddr_hci {
 	sa_family_t    hci_family;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index caf38a8ea6a8..d5627967fc25 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -52,7 +52,7 @@ struct hci_pinfo {
 	struct bt_sock    bt;
 	struct hci_dev    *hdev;
 	struct hci_filter filter;
-	__u32             cmsg_mask;
+	__u8              cmsg_mask;
 	unsigned short    channel;
 	unsigned long     flags;
 	__u32             cookie;
@@ -1399,7 +1399,7 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 			  struct sk_buff *skb)
 {
-	__u32 mask = hci_pi(sk)->cmsg_mask;
+	__u8 mask = hci_pi(sk)->cmsg_mask;
 
 	if (mask & HCI_CMSG_DIR) {
 		int incoming = bt_cb(skb)->incoming;
-- 
2.27.0.290.gba653c62da-goog

