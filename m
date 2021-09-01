Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0FEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 05:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E392061074
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 05:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhIAFpr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:45:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53410 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbhIAFpp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 01:45:45 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 89AAFCECED;
        Wed,  1 Sep 2021 07:44:48 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/4] Bluetooth: Add bt_skb_sendmsg helper
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210901002621.414016-1-luiz.dentz@gmail.com>
Date:   Wed, 1 Sep 2021 07:44:48 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9067109F-D8FD-47E9-AD02-FB6B7DFFDB3E@holtmann.org>
References: <20210901002621.414016-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> bt_skb_sendmsg helps takes care of allocation the skb and copying the
> the contents of msg over to the skb while checking for possible errors
> so it should be safe to call it without holding lock_sock.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 9125effbf448..f858efcf9f40 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -420,6 +420,32 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
> 	return NULL;
> }
> 
> +/* Shall not be called with lock_sock held */
> +static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
> +					     struct msghdr *msg,
> +					     size_t len, size_t header,
> +					     size_t footer)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = bt_skb_send_alloc(sk, len + header + footer,
> +				msg->msg_flags & MSG_DONTWAIT, &err);
> +	if (!skb)
> +		return ERR_PTR(err);
> +
> +	skb_reserve(skb, header);

I am not with you on this one since bt_skb_send_alloc already calls skb_reserve in the first place.

/**                                                                              
 *      skb_reserve - adjust headroom                                            
 *      @skb: buffer to alter                                                    
 *      @len: bytes to move                                                      
 *                                                                               
 *      Increase the headroom of an empty &sk_buff by reducing the tail          
 *      room. This is only allowed for an empty buffer.                          
 */

In addition we have this comment here. So what kind of headroom do we need with this SKB?

And wouldn’t it be better to actually assign a tailroom instead of just a large enough buffer?

/**                                                                              
 *      skb_tailroom_reserve - adjust reserved_tailroom                          
 *      @skb: buffer to alter                                                    
 *      @mtu: maximum amount of headlen permitted                                
 *      @needed_tailroom: minimum amount of reserved_tailroom                    
 *                                                                               
 *      Set reserved_tailroom so that headlen can be as large as possible but    
 *      not larger than mtu and tailroom cannot be smaller than                  
 *      needed_tailroom.                                                         
 *      The required headroom should already have been reserved before using     
 *      this function.                                                           
 */              

We also have this capability inside the SKBs.

So while the basic idea of this patchset seems fine, we need to figure out the details and not overload us in spaghetti code by wanting to have a common bt_skb_* helper. Maybe it is actually not helpful in this case since we just have to have a too large parameter list to satisfy all 3 users.

Regards

Marcel

