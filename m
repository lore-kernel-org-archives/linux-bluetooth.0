Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2063C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974E60F4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhHPQDI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:03:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59329 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHPQDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 12:03:04 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 05666CECC8;
        Mon, 16 Aug 2021 18:02:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] net: bluetooth: delete the redundant refcnt increment
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210815085044.GA70199@nilus-desk>
Date:   Mon, 16 Aug 2021 18:02:31 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A2180CC1-FA05-4439-A721-78A457F5CBC0@holtmann.org>
References: <20210815085044.GA70199@nilus-desk>
To:     Nil Yi <teroincn@163.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nil,

> As the chan's refcnt is increased in l2cap_chan_create,
> no need to increase it again for l2cap_pi(sk)->chan.
> 
> Signed-off-by: Nil Yi <teroincn@163.com>
> ---
> net/bluetooth/l2cap_sock.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c99d65ef1..4804c311d 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1831,8 +1831,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
> 		return NULL;
> 	}
> 
> -	l2cap_chan_hold(chan);
> -
> +	/* chan's refcnt is held in l2cap_chan_create() */
> 	l2cap_pi(sk)->chan = chan;

can you be a bit more specific what this is fixing?

Regards

Marcel

