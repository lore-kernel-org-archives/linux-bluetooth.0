Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C5DC10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F852082E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iq3SXQXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDJRod (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:44:33 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41372 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfDJRod (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 13:44:33 -0400
Received: by mail-lj1-f177.google.com with SMTP id k8so2918484lja.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWNTa5XtaGcqQddICIj/u1u1P3x6fsMZqIHoPhhy7bI=;
        b=Iq3SXQXSIrTf8ACEKNUw53XQgf2a1eN5kC/uU23V5dIGCAH1kprxy0rRx2iXQ3d3tu
         DmFZlXKCgPahCxlnoXDhGCAtX+ZF3uyx0abT8elvKn9u8LR2Udu+uyrJ1gl21RVKaeDb
         MXsd4naw3YOBCja44JFyC1XxcVEuGoPRdUs7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWNTa5XtaGcqQddICIj/u1u1P3x6fsMZqIHoPhhy7bI=;
        b=EmUSg5RNNF1ZvidIh9hc9drlh9BUoJ+snSyewAXlGNmE++w47iIe3OfWP2cKPkPgf+
         54cDG7ZfnjTBvmQlgZZ6h99Z1AHt5RZ1VsFAZhAOwuqKRTc/XL9kBiio6sO99KPfz7Wu
         WGe5RrPnBQlJmqaG79SxWwEtytSSnbZ5SVLRDmWzV8Ip97kNBcmxhRI7RXD64sQZdN7o
         NllgoBXN7etm24xDR9clbtTEUqxFgKsfDenaW7sJIiXiysya2XTVgnLzC9Guhr276v1E
         BidLhKafdVWncoH41utaq64deKjGq9LnXivFU2vuQOUGsEgZrJpO6pNrl9Sqp6bin0JB
         x0Sg==
X-Gm-Message-State: APjAAAXAvzdjmHV/YjYy/2sxYpX7qF/Fs2dOdHCruJ6OQTOh4QX7e5sb
        zhCulg7VNbF5s52h2WpRKvHjt6shDjE=
X-Google-Smtp-Source: APXvYqzo1/dW0LW3M9jYxn6qJ0z5oDIEd3jRI045uGkeAybhfxiipHW/yo+oCiZrvSZpQBmt+JMFkA==
X-Received: by 2002:a2e:219:: with SMTP id 25mr23624829ljc.34.1554918270977;
        Wed, 10 Apr 2019 10:44:30 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e18sm1904376lfj.39.2019.04.10.10.44.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:44:29 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id p14so2923627ljg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 10:44:29 -0700 (PDT)
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr23555389ljh.80.1554918268885;
 Wed, 10 Apr 2019 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
 <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com> <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
In-Reply-To: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 10 Apr 2019 10:44:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
Message-ID: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
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

On Tue, Apr 9, 2019 at 8:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Either it's edge-triggered and you'll get one possibly spurious
> interrupt for an old issue, or it's level-triggered and setting up the
> hw should bring the irq line inactive and you'll be ok.

I think our key difference here is in how much we trust the device:
knowing the quality of the firmware running on some of these devices,
I wouldn't totally trust that they get it right. (It's not fatal if we
allow a buggy firmware to provide an occasional spurious wakeup, but
it's much less OK to allow it a window for flooding us with
interrupts.) So while your suggestion is indeed correct for
well-behaved devices, I think both approaches have value.

> But I've applied your patch for now simply because it seems to be a
> smaller change.

Awesome, thanks!

> But I think you should look into whether it can be fixed by just
> requesting the irq once the hardware is really up (which may indeed be
> as late as open time).

Yes, I will take a look at that for future release cycles. It's a nice
addition regardless, I think.

Brian
