Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108EC38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 00:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2Ac5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Ac4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 20:32:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA1228CD5;
        Fri, 28 Oct 2022 17:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF22B82D96;
        Sat, 29 Oct 2022 00:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1225DC433D6;
        Sat, 29 Oct 2022 00:32:51 +0000 (UTC)
Date:   Fri, 28 Oct 2022 20:33:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [RFC][PATCH v2 08/31] timers: Bluetooth: Use
 del_timer_shutdown() before freeing timer
Message-ID: <20221028203308.31b11af0@gandalf.local.home>
In-Reply-To: <CABBYNZKurkYyv0XAeEnEwzRQ3Fc+-_NJREEv=7YU2+8tGdjXQw@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
        <20221027150926.587581591@goodmis.org>
        <CABBYNZKurkYyv0XAeEnEwzRQ3Fc+-_NJREEv=7YU2+8tGdjXQw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 28 Oct 2022 17:12:44 -0700
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Thanks, but I will be sending a v2 as the naming is going to change.

> 
> Btw, we do seem to have similar problems with the likes of
> cancel_delayed_work/cancel_delayed_work_sync so wonder if it wouldn't
> be the case to introduce something like shutdown_delayed_work before
> freeing the struct/object containing it?

As I stated here:

  https://lore.kernel.org/all/20221028100052.2e392127@gandalf.local.home/

That may be the next endevour I partake in.


Cheers,

-- Steve
