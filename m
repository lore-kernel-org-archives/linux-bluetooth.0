Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F2C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CA32184C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5trZH8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCNNnm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:43:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34071 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCNNnm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 09:43:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id a16so4678305edn.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2019 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQomnKPP8UMo9Idp+Pct2wIlzNp/HFthVCmHrGYK38w=;
        b=l5trZH8SQBvuu2/rCtRs6LQZ/aP/ohGIzvvbdiYoizsyY+1brjhmXGGpfFnMSmlZ5P
         dU4vDXHJLaiMlxvDiQofrf9bbtGNPh3r+sR0tKdp+exWn5yXonCn2xuZxOrAXkkd10G5
         Klce3an2vcHYgUKpYm6ExQJloCt4JSBla26uaoCvn1NWIy6v9wolB+uV6KY56P3hU1Ll
         wT5tCy1nb+Xdx3yUVJPdntZ9RW7REXr2/CwVupfDR8UKlkX/kGXZL3u3hUE/4lnnivvc
         M86dBcz9xlexlcRpi9mLFtAQF3n1vfaCYOH09McDCiwrGGQ6x4iFGatXpTXnJURftMB7
         /vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQomnKPP8UMo9Idp+Pct2wIlzNp/HFthVCmHrGYK38w=;
        b=HM2d6VkZ/q8wYAG/JyvIbj1xfVU+qqmRwb9km1svP3GCktqiGPSMjQc7ZqJoT/IM7Q
         KQtTl1XbTVOYk1vGaK4IwtseNqZmsbJ7OQp/srUq6QXcaHbnnwCq7eYK2Tjf+vkx1xMO
         GBawJipkyjNwlIkxS7gEoZ1YPgeIpWDvyvm4amfDWJBZ6BdkT6LlPU1Ev8TenxdNcMmA
         AId/onLfEu6/vJskG3oETEKHQK7AvuJHEUqeejM81i7XL1ks/9NI9Lmxv8/mCANhGC3J
         WqEpu71kelwCn5rxJYPe/Yf4igMw4D1F3PJWrP7P5eYOqbQKxiWLAd0oyBSYbmjxLhW+
         kjJA==
X-Gm-Message-State: APjAAAXkpkA9dFA9IOKdx86rcc5MFODwbt8qRm2Jezp8OCwtEWZ4q3cG
        xt1d7YaXz0dQrc8MXNojJwfg0WRQlNQ=
X-Google-Smtp-Source: APXvYqxJhun8SvboGNGLf9M9S7A5ZXMrw3mzaAOC4Njxbz1Dk5+MVeb0/RluNQEFPlZHbwRKIVxcXw==
X-Received: by 2002:a17:906:442:: with SMTP id e2mr31734531eja.76.1552571020073;
        Thu, 14 Mar 2019 06:43:40 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id o42sm1505939edc.49.2019.03.14.06.43.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 06:43:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix not initializing tx_credits
Date:   Thu, 14 Mar 2019 15:43:37 +0200
Message-Id: <20190314134337.26647-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_le_flowctl_init was reseting the tx_credits which works only for
outgoing connection since that set the tx_credits on the response, for
incoming connections that was not the case which leaves the channel
without any credits causing it to be suspended.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f17e393b43b4..b53acd6c9a3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -510,12 +510,12 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
-static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
+static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
-	chan->tx_credits = 0;
+	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
 	/* Give enough credits for a full packet */
@@ -1281,7 +1281,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
 		return;
 
-	l2cap_le_flowctl_init(chan);
+	l2cap_le_flowctl_init(chan, 0);
 
 	req.psm     = chan->psm;
 	req.scid    = cpu_to_le16(chan->scid);
@@ -5532,11 +5532,10 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->dcid = scid;
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
-	chan->tx_credits = __le16_to_cpu(req->credits);
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_le_flowctl_init(chan);
+	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;
-- 
2.20.1

