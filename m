Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629002065D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsYs6t8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgHQUwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHQUwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 16:52:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA1C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:52:41 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so16008569oij.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1TlfCFtQ6IMhqvDIaQBuJ7PSjmH9A7KNtubVPP5Vy8=;
        b=nsYs6t8lfteW1b9b7M32XQ2plfYDvWY96zi5FRPslaJhGhNxdxvAH3uDs75t6wvKIz
         No3YsR/DteReY/XO6/OlrG3N3zP6irjw5zKJwNpQ4FcKlOC6S8jkPP1zsWzbGqdbYSV4
         gmyUfj0LCeCjLzRDZUx7j0Q47KcXxrS6DEr+SZN6A9wOmZsGp2WMecbVaEIQINvFC9rG
         aR6jGPSo+duDYkc4e6gsdQ6p32cL/vPYHF+BB+rKL+DkmOYJtFHA7FcjMVR0toubmuRS
         hDDALkZT442A/381AlagfGjUmWYkOwpFuRK6MsQpWEzaMagQsHUd+THoOIMqs2ZdLweI
         4fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1TlfCFtQ6IMhqvDIaQBuJ7PSjmH9A7KNtubVPP5Vy8=;
        b=fT1htq/C+8CZxbfKfIy2tiPB50TksrfouaOh5JFZ6GRWYrCj7LXIyfpS415fNxjHJ8
         pfHMQuY5rUf35LU7S204HzwY2Nq1qRGPOdgkqfqqPb1Z0T0qKG61qK5B3oLn0rQr7GfP
         m5m4xZXNXb50eoBi9kDbSqB5FZHiq73Ox9+CgGicAs9GICTVxd8eonEdydglp+JQ4Nss
         KDcRw4cELarGOovleTLWCUIeONsONuhxWnTZ/YJjbl0nGgr2ttOVTQqA6J6A2NvcPsOb
         yhj8RQoE7nvY6HZM3SmEedLsot5jLC6fhlFk9zDAZiWyzSjgU9koT+awcV9D8SnlGd6m
         Wesg==
X-Gm-Message-State: AOAM5331F0duW850toepe1Lg5qg3U9dFiSSg4OE/tZXZYblksVUtDX13
        DNWppwZXj97K6b8wTNSlfWXGrYYhuojBjDqk9Tg=
X-Google-Smtp-Source: ABdhPJx/DP+ppyBgWh1MVUhgCmYVsaMyRid2zeBz5wS6ZdpHd0vsYyXVc+Z6ZKYNf8twtzVgHfuE18K9vUX5WKDi+VU=
X-Received: by 2002:aca:f504:: with SMTP id t4mr11006198oih.137.1597697560997;
 Mon, 17 Aug 2020 13:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200807142429.BlueZ.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
 <CABBYNZL4s151e-a+X0fEA73RM54aA--m+on7as4dLrJX0xevQQ@mail.gmail.com> <CAGPPCLDFUgPU+XqNPxUBgH9kKUSEb+DvFO0PhAKTUZUToXCi4Q@mail.gmail.com>
In-Reply-To: <CAGPPCLDFUgPU+XqNPxUBgH9kKUSEb+DvFO0PhAKTUZUToXCi4Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 13:52:30 -0700
Message-ID: <CABBYNZK_dvQPetyJ=fi_2u3bLzLe9bayBD4PZ7yL0KskN_2nhA@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Disable auto-connect on cancel pair
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Aug 17, 2020 at 12:37 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Hi Luiz,
>
> On Mon, Aug 17, 2020 at 10:11 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Manish,
>>
>> On Fri, Aug 7, 2020 at 2:24 PM Manish Mandlik <mmandlik@google.com> wrote:
>> >
>> > While pairing process is in progress, service discovery starts in the
>> > background. If HOG profile is detected, auto connect is enabled for
>> > that device. This causes future advertisement from that device to
>> > trigger a pairing even if the user has already cancelled the pairing.
>>
>> So it looks like something is not right if the user cancel the pairing
>> process I would expect the device to be removed if this happens when
>> setting up a new device or at least call Disconnect method which would
>> disable auto_connect if the device is not trusted.
>
>
> Earlier there was another patch related to pairing cancel issue: https://patchwork.kernel.org/patch/11608271/
> This patch terminates the link when the user cancels the pairing process. Once the link is terminated, the device is removed by disconnected_callback()->dev_disconnected()->btd_adapter_remove_device().
>
> However, the device remove code-path doesn't check for or disable autoconnect. In the current bluez code, autoconnect is disabled only if the disconnect is initiated by the user (in dev_disconnect()).
>
> So, instead of disabling autoconnect while cancel pair, do you think we should disable it during device remove (in device_remove())?

I'm not following you on this part, is there something preventing the
device to be removed? If the devices end up being removed so does its
autoconnect state, if that is not happening then that is the culprit
here and should be fixed.

> Or should we disable it in the cancel pair code-path, but with a check if the device is trusted or not as per your suggestion:
>
>         if (device->auto_connect && !device->trusted) {
>                 device->disable_auto_connect = TRUE;
>                 device_set_auto_connect(device, FALSE);
>         }
>
> Please advise.
>
> Thank you.
>
>>
>> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>> >
>> > Signed-off-by: Manish Mandlik <mmandlik@google.com>
>> > ---
>> >
>> >  src/device.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/src/device.c b/src/device.c
>> > index 470596ee4..ab5bb123e 100644
>> > --- a/src/device.c
>> > +++ b/src/device.c
>> > @@ -2870,6 +2870,15 @@ static void device_cancel_bonding(struct btd_device *device, uint8_t status)
>> >         if (!bonding)
>> >                 return;
>> >
>> > +       /* Auto connect may get enabled during the service discovery even
>> > +        * before the pairing process completes. In such case, disable it
>> > +        * when the user has cancelled the pairing process.
>> > +        */
>> > +       if (device->auto_connect) {
>> > +               device->disable_auto_connect = TRUE;
>> > +               device_set_auto_connect(device, FALSE);
>> > +       }
>>
>> BlueZ has the trusted property so upper layer can actually flag if the
>> device is trusted regardless if it is paired on not, so this seems out
>> of place or we should at least check if if the device has been marked
>> as trusted.
>> >         ba2str(&device->bdaddr, addr);
>> >         DBG("Canceling bonding request for %s", addr);
>> >
>> > --
>> > 2.28.0.236.gb10cc79966-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
