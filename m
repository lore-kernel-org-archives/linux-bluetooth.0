Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DCC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 06:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBDC64FFA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 06:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCJG70 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:59:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54767 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhCJG7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Mar 2021 01:59:17 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 363E6CED8C;
        Wed, 10 Mar 2021 08:06:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: SMP: Fail if remote and local public keys are
 identical
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210309183911.514959-1-luiz.dentz@gmail.com>
Date:   Wed, 10 Mar 2021 07:59:15 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <08C85CC7-19F5-461F-A3B3-DBAB5A70588F@holtmann.org>
References: <20210309183911.514959-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fails the pairing procedure when both remote and local non-debug
> public keys are identical.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/smp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b0c1ee110eff..9e7e3655e4ec 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2732,6 +2732,15 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
> 	if (skb->len < sizeof(*key))
> 		return SMP_INVALID_PARAMS;
> 
> +	/* Check if remote and local public keys are the same and debug key is
> +	 * not in use.
> +	 */
> +	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
> +	    !memcmp(key, smp->local_pk, 64)) {

lets use crypto_memneq here.

> +		BT_ERR("Remote and local public keys are identical");

And we need to start using bt_dev_err in SMP. I will apply v2, but then we need a cleanup patch to move this to bt_dev_{err,dbg,info}.

Regards

Marcel

