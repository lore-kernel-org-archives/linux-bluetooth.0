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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543FBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1A2611C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbhIPS4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhIPS4f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 14:56:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D90C043088
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t4so4447426plo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BdKc4Ax9P05al+3resQTTjrI8Gsvugf9kA+LrRNaE9E=;
        b=XBxjQZiJkB0vcUOOf/QNizLPHFz6QBrKhz2V9d47QVncpqfX5F6umt54LHDX5m3ef+
         7swe/pfrfaTeFqfXq2EJCy12HPfelLOkM6udH0nDesibZ+s47FylrWHpvTcs9MFbuXd6
         jvnxK63H23JSVUxhGXBrdRGkuXJ382nc0MomFbh511J0cbHglUJVLidvcqt8NiGtofU0
         DpDGzFsDmroB2N5y2Yk6ZzAErLvY0J80Af7XkKR8FVmsMPpmIQDD8zQCMPjfpkbj5gb5
         9jCxg1hAHZPRhpFbJnDD/OR51oJT3N8k4doLvFPLneWmtdlDQpw9/NkJX94c+4wz3Bjo
         TXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdKc4Ax9P05al+3resQTTjrI8Gsvugf9kA+LrRNaE9E=;
        b=tHDZOxfP7oleUZr9xc34kTaK1hzyd7fTnj6pQe5wIDMQ6l8+C72v7ah2Ba+/Sz00HM
         DpnxgEUQ+SFRgxXVEbdtkKQgHugcX8ZzP7JjoQozWoZ6SqY4WcXQ+WB91qZq4DbBe3rH
         noMMPp1+FLdfEXI201ngcVZilpFQRgRG1XxyGNHMzzGAGf16E3YS3mpxehC1HGOOtEci
         UK58sbzD8+sh64+HluqGv61He18rS14VdigGV03o7WLOgSQRlksd0pRBLqNB+0Ux5Mi1
         m0gHoK/HYkhw7NXVijesZCAuFfup9oeguc/3p+Urt1JPOJhVLosrvWXHcK7PWxy2c5YE
         2QrQ==
X-Gm-Message-State: AOAM5304AWyzXlRH2pArQfr+R6Zif96FFNfI0WO/UdZZT72LNfOif6x6
        VCMSnlYX0E9PaBvzgedre2hkw7hFv2I=
X-Google-Smtp-Source: ABdhPJxu35EqFaTw0BlKiJXPl5B/EqWs7i1Ela9+u740Dbhn73mhd2hiQSAgH2JaHNSnE/8m5CKPiw==
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr16409355pjz.174.1631815418483;
        Thu, 16 Sep 2021 11:03:38 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p24sm3580432pfh.136.2021.09.16.11.03.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:03:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/4] Bluetooth: SCO: Fix sco_send_frame returning skb->len
Date:   Thu, 16 Sep 2021 11:03:35 -0700
Message-Id: <20210916180335.75976-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916180335.75976-1-luiz.dentz@gmail.com>
References: <20210916180335.75976-1-luiz.dentz@gmail.com>
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

