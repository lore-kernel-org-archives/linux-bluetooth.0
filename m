Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6DBC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A83C2133D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6t93fkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDJD07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:26:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34179 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDJD06 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 23:26:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so708887ljb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dK1bZLBSj9wXHxBkIORJDKWdgF7zFsKUzg67ztyitJk=;
        b=B6t93fkT6j8fbIIoUKGH7nbLLYM1rN/IdRzchrsJ3usDVSv9ljf8rkP3JPQdI34Q2F
         Q732/uaMhoppyXaMr6YlgTKAPExA7Sz2EPyqB1DX5mD6o+kekEmXzy4OPSDRsXo2B28i
         MLeLPEfxIwKUtloERI1HuqUgJKd76bC342imU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dK1bZLBSj9wXHxBkIORJDKWdgF7zFsKUzg67ztyitJk=;
        b=rfIb5Jm15aYmDpuP0A2zKAiCtL8xcmUjHxAjmxUVvpb1ZPSii4/OiH9ngTPddZ4EkL
         5Ym/gd0dkLtHp/HrSluVMHcAnKOVAzTH0ClGW+j1mKgfQMXRN8DTiLIjIjQ6uLXrGYYd
         SvQn6LEK860QYdGbmfqTNHXTZyHk7UNZn1g4L9XeKtxTGDGPw+9/yfZp6L4OTghq6o/G
         VvTJ3vtvYY3K8h0OPRPgE1gXGHP8B5bw1ulDZeVKKK4Y5qJ3jKMmrSsMAWK5SxuvCity
         9tZLUIYAm3NtvKuYGxgUmpvRz5LhKYnYEV9U0MgLPZ1iQ5VwjO8puBQ140WmanM2aO0O
         DCFw==
X-Gm-Message-State: APjAAAWqxxe/qLJCrkMcmKadGukNJKjTpY2o5aJbs+yds/g0D1RDpVeG
        w2ia4rc5UtiMM7MzxxYqkTKe4vn2V2E=
X-Google-Smtp-Source: APXvYqzFT3UpG8bdFAQF3wXjB3pvdrY9NSLcxv9wdvSzwYbsCvlGzxJndN2LO7PTRDb/XGzfU2UUPg==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr8684670ljg.93.1554866816617;
        Tue, 09 Apr 2019 20:26:56 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m19sm2849281lfl.43.2019.04.09.20.26.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:26:56 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l7so682325ljg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 20:26:55 -0700 (PDT)
X-Received: by 2002:a2e:7114:: with SMTP id m20mr21509140ljc.120.1554866814450;
 Tue, 09 Apr 2019 20:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org> <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Apr 2019 20:26:43 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
Message-ID: <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

Thanks for the reply! It's amusing that you're the only one (well,
besides the gentleman who sits a few feet from me and kindly provided
his Reviewed-by) to review my patch.

On Tue, Apr 9, 2019 at 7:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 9, 2019 at 8:49 AM Brian Norris <briannorris@chromium.org> wrote:
> > Badly-designed systems might have (for example) active-high wake pins
> > that default to high (e.g., because of external pull ups) until they
> > have an active firmware which starts driving it low. This can cause an
> > interrupt storm in the time between request_irq() and disable_irq().
>
> Why is the fix not to move the request_irq() down to below the proper
> initialization sequence?
>
> That's what drivers *should* do: initialize their hardware first,
> request interrupts only after that. Initializing the interrupt handler
> before the hw is actually up seems wrong..

I suppose that's a possible solution. It appears that would involve
moving this IRQ management into btusb_{open,close}, after
->setup_on_usb(). I don't immediately see a good reason why we
couldn't do that.

But the use of NOAUTOEN is still important, because there's not really
any direct way to ack/clear the underlying signal, even when the
hardware is fully initialized. It's just a level-triggered wakeup
signal, which represents "activity" from the device, and we're relying
on the disable_irq_nosync() / BTUSB_OOB_WAKE_ENABLED dance to keep
things in sync. (I'm not proud of that exactly, but I think it's
otherwise correct.) Currently, this is the only window of time where
we trust that the device remains "quiet". Even if we move this until
after full HW initialization, I think we're still trusting the BT
firmware (a bit too much) not to assert this signal.

So, I think the problem is still potentially present no matter when we
request the IRQ. The "uninitialized" state of the hardware (or,
firmware) just exposes the issue extremely clearly.

If you'd rather send this back to the drawing board, I can just send a
revert for commit 5364a0b4f4be ("arm64: dts: rockchip: move QCA6174A
wakeup pin into its USB node") for 5.1 instead. I don't mean to take
too much of your time; I just want my regression fixed, and nothing
further up the MAINTAINERS file helped so far.

Thanks,
Brian
