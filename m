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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0075C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EA661164
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhIPUMP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhIPUMO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:12:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D647C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h3so7268414pgb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BdKc4Ax9P05al+3resQTTjrI8Gsvugf9kA+LrRNaE9E=;
        b=Z4YN4iSJP6+MM+wli3iyO5Hfz9p7ppWgWYVTSOzopT1NWef4/s1rUpmyuAioVtOgll
         EcoMN57s+EacD344g6Fzyol/nqqnQcKRT2UIR0b+P6vVb+6qxaGXVgxkyscLZKRqZQQc
         RI6R4WQvSMgRGm2ah1ren3TEWkKN5aEqcJV0V02K0LPNiu+47GIgrkW7lRMABGokNQbO
         XgILmHsKsTvSxzy1/IUjCbqKNG6iIwR/ysyKeSW2BY2mW7BHmfQUtjVRMk1wX5UAk15x
         qmkalIpjfi8lG5IHWS5jZPBqvdAC91NwWGZlGPoKpLziYu5puKzn0IMPJv6vTqbJntyz
         nRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdKc4Ax9P05al+3resQTTjrI8Gsvugf9kA+LrRNaE9E=;
        b=YUxGj+FXtM40hgXs2bNn+VCDgd2QPErZl/styqi9Y5NbKXpgwcPYc+0E50iu2ZcD0+
         B3jAjME5GCWD2xLtM7f9sUVl4qoeWYujdmYfBz6ahf1qfn6oQp5Ap4LRqUBDDV1c+D8s
         SU0KAxRdZf0z95bTqH8J14EazhcqGXrJdvN1a3U1o5rJd0xSKnpfQiXegjl+wKlVZ/M4
         OI8oq2MNVPn8d5xFZ9qJRRJPcGllOpr1nS6T1idwR23tAWnSowt+c12vmoJ89ARIIJyc
         EYsjZ9iRx90S4f2FfvDFH9gFiwsj81Gee7BmALWpA12mKgguhVfpZeFXv3QWUd+fOapy
         rfoQ==
X-Gm-Message-State: AOAM531ohGLUUchTYlZnx0edoF5nKVAX5DdBpnZ6FfO9zWkNuayqyyts
        Ze0jocil4EHH/YTGwQr1+SwLiswLfpw=
X-Google-Smtp-Source: ABdhPJzRjGfjvjyDHEK0QnfyThH2hK7F99PFX14GPvKvnYWMiEtlQcjze47vwu0EgtMRNmfSNqIUYA==
X-Received: by 2002:a63:1352:: with SMTP id 18mr6408443pgt.348.1631823053350;
        Thu, 16 Sep 2021 13:10:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x128sm2500445pfd.203.2021.09.16.13.10.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:10:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 4/4] Bluetooth: SCO: Fix sco_send_frame returning skb->len
Date:   Thu, 16 Sep 2021 13:10:49 -0700
Message-Id: <20210916201049.114392-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916201049.114392-1-luiz.dentz@gmail.com>
References: <20210916201049.114392-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The skb in modified by hci_send_sco which pushes SCO headers thus
changing skb->len causing sco_sock_sendmsg to fail.

Fixes: 0771cbb3b97d ("Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg")
Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f51399d1b9cb..8eabf41b2993 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -284,16 +284,17 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
+	int len = skb->len;
 
 	/* Check outgoing MTU */
-	if (skb->len > conn->mtu)
+	if (len > conn->mtu)
 		return -EINVAL;
 
-	BT_DBG("sk %p len %d", sk, skb->len);
+	BT_DBG("sk %p len %d", sk, len);
 
 	hci_send_sco(conn->hcon, skb);
 
-	return skb->len;
+	return len;
 }
 
 static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
@@ -744,7 +745,8 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = -ENOTCONN;
 
 	release_sock(sk);
-	if (err)
+
+	if (err < 0)
 		kfree_skb(skb);
 	return err;
 }
-- 
2.31.1

