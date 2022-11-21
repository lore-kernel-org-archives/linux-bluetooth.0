Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCA9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiKUVJR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 16:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKUVJF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 16:09:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107CC6BD1;
        Mon, 21 Nov 2022 13:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D3C61491;
        Mon, 21 Nov 2022 21:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298CDC433D6;
        Mon, 21 Nov 2022 21:09:01 +0000 (UTC)
Date:   Mon, 21 Nov 2022 16:08:59 -0500
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
Subject: Re: [patch 09/15] timers: Rename del_timer() to timer_delete()
Message-ID: <20221121160859.6e7e6378@gandalf.local.home>
In-Reply-To: <20221115202117.497653635@linutronix.de>
References: <20221115195802.415956561@linutronix.de>
        <20221115202117.497653635@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 15 Nov 2022 21:28:48 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> The timer related functions do not have a strict timer_ prefixed namespace
> which is really annoying.
> 
> Rename del_timer() to timer_delete() and provide del_timer()
> as a wrapper. Document that del_timer() is not for new code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

BTW, I did a: git "grep del_timer Documentation" and there's a lot of
references to the old name. Perhaps you want to update those too (for both
del_timer() and del_timer_sync()).

-- Steve
