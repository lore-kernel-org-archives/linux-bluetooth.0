Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66106C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406F760F4B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 08:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhHOIvZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Aug 2021 04:51:25 -0400
Received: from m12-14.163.com ([220.181.12.14]:35986 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOIvY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Aug 2021 04:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=s8BvO
        7mfziwRyqqviF5rlMh9BJ3vGogmNF2i7VoPN+4=; b=Jo1I7CVqC0i6Bqd6JEZa2
        W7VDvUwNp1Fe6jMZa4VwsPFooPH2SyFTfHSvx24T2bMem4U6y14V/oKzoCpilWuc
        tCULBvnQnrnNcT3kK5625V4gnNLkWzqEbU6QEYMk3AHWGWObIVo697K52iBoT60n
        QXGbtWYMzln9NZBNOrOFRo=
Received: from nilus-desk (unknown [120.229.1.29])
        by smtp10 (Coremail) with SMTP id DsCowAD31d5k1RhhCZeZCA--.31068S3;
        Sun, 15 Aug 2021 16:50:45 +0800 (CST)
Date:   Sun, 15 Aug 2021 16:50:44 +0800
From:   Nil Yi <teroincn@163.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] net: bluetooth: delete the redundant refcnt increment
Message-ID: <20210815085044.GA70199@nilus-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CM-TRANSID: DsCowAD31d5k1RhhCZeZCA--.31068S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWxuw1ktFWkuFWDGFWUtwb_yoWxZFX_Ww
        18Za1xuw15G3yFy3y3AF48urW8ta95XF1kJrsaqrWUXa4vgr4UKr1IgFnxJFn2gw4kCFy3
        ArykGas7Jr1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0HSoJUUUUU==
X-Originating-IP: [120.229.1.29]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiSgbvElPAPaDsbgAAs9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As the chan's refcnt is increased in l2cap_chan_create,
no need to increase it again for l2cap_pi(sk)->chan.

Signed-off-by: Nil Yi <teroincn@163.com>
---
 net/bluetooth/l2cap_sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c99d65ef1..4804c311d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1831,8 +1831,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 		return NULL;
 	}
 
-	l2cap_chan_hold(chan);
-
+	/* chan's refcnt is held in l2cap_chan_create() */
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
2.17.1

