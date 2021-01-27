Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B4C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 20:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377F560C3D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 20:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhA0UQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 15:16:55 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:41718 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231540AbhA0UQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 15:16:41 -0500
X-Greylist: delayed 748 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 15:16:41 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 19AC118013E00
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 20:05:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D41A118015E22;
        Wed, 27 Jan 2021 20:03:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: star19_2017b9a27599
X-Filterd-Recvd-Size: 1713
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jan 2021 20:03:27 +0000 (UTC)
Message-ID: <47bd723d309955f1cbd5be503fa9b895a6381221.camel@perches.com>
Subject: Re: [PATCH] Bluetooth: af_bluetooth: checkpatch: fix indentation
 and alignment
From:   Joe Perches <joe@perches.com>
To:     Tomoyuki Matsushita <xorphitus@fastmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 27 Jan 2021 12:03:26 -0800
In-Reply-To: <20210127150520.3459346-1-xorphitus@fastmail.com>
References: <20210127150520.3459346-1-xorphitus@fastmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2021-01-28 at 00:05 +0900, Tomoyuki Matsushita wrote:
> Signed-off-by: Tomoyuki Matsushita <xorphitus@fastmail.com>

checkpatch is pretty stupid so whatever it recommends needs to
be looked at carefully by a human and fixed appropriately.

> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
[]
> @@ -478,7 +478,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
>  		mask |= EPOLLHUP;
>  
> 
>  	if (sk->sk_state == BT_CONNECT ||
> -			sk->sk_state == BT_CONNECT2 ||
> +	    sk->sk_state == BT_CONNECT2 ||
>  			sk->sk_state == BT_CONFIG)

checkpatch only warns on the alignment of the second line of multi-line statements.
Please make sure all lines of the multi-line statements are aligned.


