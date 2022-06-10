Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F9FC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbiFJLIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbiFJLIW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 07:08:22 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E521451E1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 04:08:18 -0700 (PDT)
Received: (qmail 14172 invoked by uid 990); 10 Jun 2022 11:08:16 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Soenke Huster <soenke.huster@eknoes.de>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: Use skb_trim to trim checksum
Date:   Fri, 10 Jun 2022 13:07:49 +0200
Message-Id: <20220610110749.110881-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-2.920938) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -0.020938
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 10 Jun 2022 13:08:16 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As skb->tail might be zero, it can underflow. This leads to a page
fault: skb_tail_pointer simply adds skb->tail (which is now MAX_UINT)
to skb->head.

    BUG: unable to handle page fault for address: ffffed1021de29ff
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)

By using skb_trim instead of the direct manipulation, skb->tail
is reset. Thus, the correct pointer to the checksum is used.

Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
v2: Clarified how the bug triggers, minimize code change

 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7324764384b6..443b55edb3ab 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1747,7 +1747,7 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
+	skb_trim(skb, skb->len - 1);
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
 	if (__check_fcs(skb->data, type, fcs)) {
-- 
2.36.1

