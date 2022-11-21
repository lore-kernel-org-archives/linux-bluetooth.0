Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35856C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKUUIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKUUIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 15:08:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF07C72D1;
        Mon, 21 Nov 2022 12:08:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1195BB80FB3;
        Mon, 21 Nov 2022 20:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16BFC433C1;
        Mon, 21 Nov 2022 20:08:35 +0000 (UTC)
Date:   Mon, 21 Nov 2022 15:08:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [patch 04/15] timers: Get rid of del_singleshot_timer_sync()
Message-ID: <20221121150833.61ab3b01@gandalf.local.home>
In-Reply-To: <20221115202117.212339280@linutronix.de>
References: <20221115195802.415956561@linutronix.de>
        <20221115202117.212339280@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 15 Nov 2022 21:28:39 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> del_singleshot_timer_sync() used to be an optimization for deleting timers
> which are not rearmed from the timer callback function.
> 
> This optimization turned out to be broken and got mapped to
> del_timer_sync() about 17 years ago.
> 
> Get rid of the undocumented indirection and use del_timer_sync() directly.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>


> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1164,7 +1164,7 @@ xprt_request_enqueue_receive(struct rpc_
>  	spin_unlock(&xprt->queue_lock);
>  
>  	/* Turn off autodisconnect */
> -	del_singleshot_timer_sync(&xprt->timer);
> +	del_timer_sync(&xprt->timer);

And this was not even a single shot timer. It used the
del_singleshot_timer_sync() function because of incorrect assumptions.

Link: https://lore.kernel.org/all/20221105060155.047357452@goodmis.org/

  0f9dc2b16884b ("RPC: Clean up socket autodisconnect")
  55c888d6d09a0 ("timers fixes/improvements")

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  	return 0;
>  }
>  

