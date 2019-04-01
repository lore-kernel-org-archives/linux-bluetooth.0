Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92482C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601A720663
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zb+mT81K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfDASHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:07:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46457 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfDASH2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 14:07:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so9033708ljk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2019 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1lKCMSu+yUtXpbeonHggfuZodsrR2XdaEg57sCklMY=;
        b=Zb+mT81K27QtJ9PTbGBiTQ/TpIidhzHhj2JpuWVh3D4wzANvmjxBbZBmL8UOXzsw5N
         i0KInvK4tJXhQ1mX414TnSR36srYk3WeEAk3MX9DeGzxUzJW3A/SZs+07iP6ilo3biLA
         AZ6N3zAyuCOKJi9XZHDLtW6SaCwjTGVzR16hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1lKCMSu+yUtXpbeonHggfuZodsrR2XdaEg57sCklMY=;
        b=RkHQxqiYr4ebHKcdmH5XglsoXoDOEfZjFrdHhXL1nZuinkYWsC8CMpCbQeUNy+O3+4
         RF5VqjyQ4EG5khuuKsaZXjf7VvCt+EwNoPTwxdX80TsO6PlJO+LTV9hKduDx3zsf+44p
         3DpQZpJmle9Ke4lNq/QqZvP6wCdMmxW3XSqVe/XaEqPd0oAXUnI1DXEdc5HqB9v+pz/i
         HSWbxS4WlHJwWdHX5i5m3xIbjZICTVhkq5fUBFjk+SxewR9LSxGgopny022fxxtSc0Je
         fKR0apr23nkF1a2x8W8PQKjKXMe+JX/5WKrclRatAm+WPH03Dr0eyyqs5SUWm7DLthTX
         xVSA==
X-Gm-Message-State: APjAAAXUW3curnZUWo7Bb0ITjsm4EJa1IxlJxwGgcJBhKN/c8p0LOyge
        lmmpHPkXY2cykXsAk9WFHUOK0ZBSY/w=
X-Google-Smtp-Source: APXvYqx8gtxbrU8MHIv43VRlm6sG1ZpOo266I7AMr2PAg9uJtopctFWpcA8xtaBCtAWq+mBIYJI3Kw==
X-Received: by 2002:a2e:9703:: with SMTP id r3mr8570684lji.88.1554142045537;
        Mon, 01 Apr 2019 11:07:25 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q2sm2024348lfj.58.2019.04.01.11.07.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:07:24 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r25so6964067lfn.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2019 11:07:23 -0700 (PDT)
X-Received: by 2002:a05:6512:248:: with SMTP id b8mr25322931lfo.140.1554142043372;
 Mon, 01 Apr 2019 11:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190222003051.127006-1-briannorris@chromium.org> <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
In-Reply-To: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 1 Apr 2019 11:07:11 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9ciP6uxxA1ewhkK-Xh-DSKGzedw1UJH59sC7JsOtHoQ@mail.gmail.com>
Message-ID: <CA+ASDXM9ciP6uxxA1ewhkK-Xh-DSKGzedw1UJH59sC7JsOtHoQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ akpm, in case he can help out

Another week, another buggy 5.1 RC.

On Tue, Mar 26, 2019 at 11:48 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Thu, Feb 21, 2019 at 4:30 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Badly-designed systems might have (for example) active-high wake pins
> > that default to high (e.g., because of external pull ups) until they
> > have an active firmware which starts driving it low. This can cause an
> > interrupt storm in the time between request_irq() and disable_irq().
> >
> > We don't support shared interrupts here, so let's just pre-configure the
> > interrupt to avoid auto-enabling it.
> >
> > Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> Ping! v5.1 is enabling wake support on Scarlet, and without this
> patch, that causes interrupt storms at boot. Please apply this patch
> for v5.1-rc!
>
> See also:
> https://lkml.kernel.org/lkml/CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com

Ping x 2!

Marcel merged my other series first, which enabled this feature,
without applying the bugfix (which was sent first). So right now, my
RK3399/Scarlet board is in very bad shape. Can somebody please merge
this bugfix for 5.1? If not, I'll probably just send Linus a pull
request myself.

Original patch link, in case this helps someone:

http://lkml.kernel.org/lkml/20190222003051.127006-1-briannorris@chromium.org
https://lore.kernel.org/patchwork/patch/1044896/

Thanks,
Brian
