Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47672C4363D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0665523A1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 22:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j87FngmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIXWMN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXWMN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 18:12:13 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731FC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 15:12:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so669077oif.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTUajlSQAutv76s4VWigr/EvtqNy5/f5iICcF4dhbA0=;
        b=j87FngmAstYZVuMmzt35BveN4yGR9CQo71N/KBv/95Z7KN+VWeoeTdgqwL7SXbhJJy
         b5sGL+BqFKQzGhk5J2vIS0DFkeu3AGBF5x51cgwYiDo9JqvW2IljvFdv4xDUdc0xqMgD
         I2+l6EG7ftEcfRb10S3FudcVdFqpKJSO5BHBAKJV3VNvL0NyXz+Dr3aF2+BxhaixAUs2
         4/kdBKCk+ja9UZqIUCYX4ulXluORXjY7VtZuVevrKtj2UQFJD2/XpMenop/h+v/MNQr6
         OngriykQ2fluTvNQiXjFuDKqqFzMlJjUIEAlUp9MUb0bIP02gdpG5MkB+hCxCCnpX1Ly
         gpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTUajlSQAutv76s4VWigr/EvtqNy5/f5iICcF4dhbA0=;
        b=sOP1tI0ghYDAMkXjPdWy6go8wp8JDGIt/h/0yX2hP57q74KZ6YgZreMIMSLtVO0ahc
         tnS7SlbfmMhg3okSroXDgv5jwfgHUEHeXSCKU/u0lWx0lRAo99KIQv+KQi/Xe3GFejvf
         F1V0ezpS9Ecq0ix2J0XOf74MPNpSdN4PiY4vxosSn/T1KKk9eOCzPh628Is7sTQhRuKO
         8ubM68OY3bRvCDqmgj4lX/wXMN29ufdVYdTrRZpRx5cT3sOoDRNgN3ptIBGVcDusNzOM
         g9hkNhMLf+8RbeAa2MhbRhvmF2eNgbYhi97+yj28loxbfi/otDzOxUoouwUwu/253FGb
         nZcA==
X-Gm-Message-State: AOAM530K9p/BerC5iFBjX2t9UnpXuG1RdYuhru4HuBv1IpbVJRyJeBrm
        EvBEqNnPbRYId6vHtw8wrp0pTD06kV7fSR8omvk=
X-Google-Smtp-Source: ABdhPJy5FaTpD9Z+sN5jK1mIomlya3AYqp14/aSaGFQNqC8f7fvIG+Em34bgcOPYGfBA4fz5jtb9NClbzvZYuD05ODU=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr571024oib.137.1600985532511;
 Thu, 24 Sep 2020 15:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200924140527.Bluez.v1.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
 <CABBYNZKXSKL3jGByvAdbb77UQgrdtejQR92M00d=1d7simCBLA@mail.gmail.com> <CAHC-ybzWgkCjgmgQjxOAPFAvr_LX=YP8Fi4WJ7nvGDu1Tk5ZLQ@mail.gmail.com>
In-Reply-To: <CAHC-ybzWgkCjgmgQjxOAPFAvr_LX=YP8Fi4WJ7nvGDu1Tk5ZLQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Sep 2020 15:12:00 -0700
Message-ID: <CABBYNZL6Q4w_UuAVXgb6RxN4eY7OqA1m64yab4JWc7Vkdfp7Dw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] device: Disable auto connect when pairing failed
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu Liu,

On Thu, Sep 24, 2020 at 2:50 PM Yu Liu <yudiliu@google.com> wrote:
>
> Hi Luiz,
>
> I was thinking about putting this into btd_device_set_temporary as well, so as the short term solution you think this should be the way to go while we look into only making trusted devices auto connectable? I can make the change then.

Yep, lets have it as part of btd_device_set_temporary first.

> On Thu, Sep 24, 2020 at 2:40 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Yu Liu,
>>
>> On Thu, Sep 24, 2020 at 2:08 PM Yu Liu <yudiliu@google.com> wrote:
>> >
>> > When connecting a LE keyboard, if the user input the wrong passkey, the
>> > stack would keep auto connect and thus allow the user to retry the
>> > passkey indefinitely which is a security concern. This fix would
>> > disallow the auto connect if the authentication failed.
>> >
>> > ---
>> >
>> > Changes in v1:
>> > - Initial change
>> >
>> >  src/device.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/src/device.c b/src/device.c
>> > index a4b5968d4..764cca60e 100644
>> > --- a/src/device.c
>> > +++ b/src/device.c
>> > @@ -6033,11 +6033,17 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>> >                 device_cancel_authentication(device, TRUE);
>> >
>> >                 /* Put the device back to the temporary state so that it will be
>> > -                * treated as a newly discovered device.
>> > +                * treated as a newly discovered device; also disable auto
>> > +                * connect.
>> >                  */
>> >                 if (!device_is_paired(device, bdaddr_type) &&
>> > -                               !device_is_trusted(device))
>> > +                               !device_is_trusted(device)) {
>> >                         btd_device_set_temporary(device, true);
>> > +                       if (device->auto_connect) {
>> > +                               device->disable_auto_connect = TRUE;
>> > +                               device_set_auto_connect(device, FALSE);
>> > +                       }
>> > +               }
>>
>> While this looks correct we could perhaps design it in such a way that
>> only trusted device are allowed to set auto connect, though that may
>> need a lot more changes than this one so I would be fine applying this
>> so we can think about the implications, also perhaps this should be
>> incorporated to btd_device_set_temporary since a temporary device
>> should probably not be left in to auto-connect and only a user action
>> to attempt to use it again to restore its auto connect status.
>>
>> To summarize we should answer 2 questions:
>>
>> 1. Should an untrusted device be allowed to be marked as auto-connect?
>> Maybe, though we didn't consider trusted property for auto-connect,
>> but I think using it might make auto-connect more predictable to the
>> upper layer.
>> 2. Should a temporary device be allowed to be marked as auto-connect?
>> Most likely not, it should be removed if the user doesn't take any
>> action during the temporary grace period.
>>
>> >                 device_bonding_failed(device, status);
>> >                 return;
>> > --
>> > 2.28.0.681.g6f77f65b4e-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
