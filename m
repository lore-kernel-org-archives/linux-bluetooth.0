Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F9C4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB7620772
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJLxJHgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCRVuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:50:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42561 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRVuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:50:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so81784plz.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=CJLxJHgONRzuK73+T+Robt/S4uDq075ur+3vN29mF4YW6k+JGvNhhYewhEn/Dzto3p
         0tBeyp5nM7/BA9EMWjAFiIivjxs/zw4qGnhvGJkfhXRcLE9CGC/3Y6mb8lYCvLg5n1xP
         NN18K3yVfBMOMISZsExJvwrTaUgoKpVHqlnn0FHMHwLshGoHiVo3W8osNAp9TvjS6rXE
         XVCdAwhq60WRNDs+N6C0KA5a5k6Tv7meoxJZDu5OXqQu4TT44B3cpiAJlNaeYDJwU4Jd
         E4vqZZse/zWiTRkjkbHnCTE1HG1lPeAdzAbRahA7YRBUdwGE6FSdwEqnI4U2McTM90Ul
         q2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=tAwa2KMW3H8CohF24w2S76FZ61CGfR5kxGePZY1xaEFg7jb1XwRgEwGQueoklrAGTH
         f/Pl/3kZAV1udqtH324+nNyjnQFo76NC6oQF8TgSmBjUf+Y/wPfAZfA7iNX0sD/n6LRs
         CKS//TsSw7BYX1Vba1yxYZS7ZpyaMbnqNv1loQF94K7lLMEhxnBbUhdpNRNKix4ibBit
         Js80DiFr5/1EmI1pFErgShNaqCi6L/pY2Q/LcuLi8JRBENDaqZSVcdZqSCKNf0MiAdid
         HOQg//dZdJFSaxWoylqAO6Uij2ErVx4j1rDBvwrVpuwT9ob2fXeGHHsyFZUd0KcvB044
         CbDA==
X-Gm-Message-State: ANhLgQ01SzxwhVfU6Ql61dY57zrOWhNyB2+X+jPhtLkjsiqQWgkIQnB2
        zSRqnlp2di3Tnp6j78DPndfle/o4
X-Google-Smtp-Source: ADFU+vtxv4OM0vh+Q78Pe9+TYuqoxLek5RE6PelFugEK8fFawR/M71yCDNdBkZLu3J2eIXQTWuLo/A==
X-Received: by 2002:a17:90b:8f:: with SMTP id bb15mr247075pjb.186.1584568222424;
        Wed, 18 Mar 2020 14:50:22 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l11sm3273191pjy.44.2020.03.18.14.50.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:50:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: L2CAP: Add get_peer_pid callback
Date:   Wed, 18 Mar 2020 14:50:17 -0700
Message-Id: <20200318215019.21494-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215019.21494-1-luiz.dentz@gmail.com>
References: <20200318215019.21494-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a callback to read the socket pid.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 537aaead259f..2d7d28474d34 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -660,6 +660,7 @@ struct l2cap_ops {
 	void			(*suspend) (struct l2cap_chan *chan);
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 40fb10b591bd..117ba20ea194 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1504,6 +1504,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return sk->sk_sndtimeo;
 }
 
+static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	return sk->sk_peer_pid;
+}
+
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1525,6 +1532,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

