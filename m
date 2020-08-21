Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C64320738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJV1VMO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHUSeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgHUSeg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 14:34:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987ACC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:34:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w14so1755812eds.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fr4MQvR1m+Ep3gAECVru7t5+/T/t18aHUrMbvW+Fi+Q=;
        b=MJV1VMO0bbg6z8FuF9ucxo2muc6KnyEDVNNJti0he6uZFnNPJVI69x6iN7Ins24z2Q
         bKHtGLOz+AYKjihD1NIcibZueaSwkIYbQVvtA9DgqbOjt4SnhYYuT20QjgTLmC3fDwnp
         rFHxVqnoldYL7jVGQDUf988pfHktwX3gL3YUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fr4MQvR1m+Ep3gAECVru7t5+/T/t18aHUrMbvW+Fi+Q=;
        b=eL6LEYN1CjCAfeHa583CRE5btoKr4CCdqj9nAjaYPR4aPYhw+jiL0/LFUO+Wc8qfcm
         HEGE93jMIOXGv1ZaajpctfVCMR1juA8MfaCXNguOj4Yg0MJv1PJ2VzNd9XzZw61EpKnE
         7WU87HdGBR2S8JikirDXqA+zbIBPMtwSYVDK97YirTilRF2UIBE3/z9JSZgMWvsHBqqL
         CK6dBve6j3aY5ITes4sBK/tJNWi+25YfhM3L3/KLKnXfM5E4xLoWG7+zGm4MPwXMTKcu
         greWGa7cZEZuJE0tm7h9ky84RvD8mAU88b6mXEhargSY2SNXo+uDqvHB11I0OlWxcSR3
         M8Mw==
X-Gm-Message-State: AOAM533+0IaLNNa4G1mqteqDkGn28TuFisS3bxxi+buOxAq57eCboIqA
        ccjrSIyHsOlCSPZjdyuN/csCxsF/pVb/nQ==
X-Google-Smtp-Source: ABdhPJy0jPXP4xwX0oVJEkW7cyFlEOlxOHVCcGYE99IKIh4jo/JOeLGN0dvsGKtEB9FPPiuLhTpk3g==
X-Received: by 2002:aa7:c70b:: with SMTP id i11mr4102876edq.272.1598034873870;
        Fri, 21 Aug 2020 11:34:33 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id sb9sm1755758ejb.90.2020.08.21.11.34.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:34:33 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w13so2495940wrk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:34:33 -0700 (PDT)
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr3897237wrr.370.1598034872695;
 Fri, 21 Aug 2020 11:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821063844.17349-1-sonnysasaka@chromium.org> <CABBYNZ+XpOa1btcjGqQiosn_oSOBki1-wF4B9jny=Gxzswz6-A@mail.gmail.com>
In-Reply-To: <CABBYNZ+XpOa1btcjGqQiosn_oSOBki1-wF4B9jny=Gxzswz6-A@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 21 Aug 2020 11:34:20 -0700
X-Gmail-Original-Message-ID: <CAO271mmHSZkzR7FnzQUkxuEQQLciC6tcxyaDGufFuge9EVwuYA@mail.gmail.com>
Message-ID: <CAO271mmHSZkzR7FnzQUkxuEQQLciC6tcxyaDGufFuge9EVwuYA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Cleanup att of a device object before
 assigning a new one.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I sent an incomplete patch. I realized that there was a follow up to
this patch and I have sent the revision titled "device: Disconnect att
before creating a new one". It contains the explanation why the kernel
reports connected 2 times as well. Please ignore this patch and review
the other patch instead. Thanks.

On Fri, Aug 21, 2020 at 10:04 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Aug 20, 2020 at 11:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > For some unknown reason, sometimes the controller replies "Command
> > Disallowed" to a Disconnect command. When this happens, bluez kernel
> > strangely reports 2 MGMT_EV_DEVICE_CONNECTED events to bluetoothd.
> > Unfortunately bluetoothd doesn't handle this case so this situation will
> > lead to bluetoothd crashing due to UAF at later time.
> >
> > This patch protects this situation by always cleaning up the att of a
> > device object before assigning a new one. This way the old att will not
> > at later time fire disconnect event which would operate on the already
> > freed device pointer.
> >
> > Tested by repeatedly connecting/disconnecting to a device until the
> > situation happens and checking that bluetoothd doesn't crash.
> >
> > ---
> >  src/device.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 7b7808405..e696ba1c6 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -5304,6 +5304,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
> >                 return false;
> >         }
> >
> > +       // This may be reached when the device already has att attached to it.
> > +       // In this case cleanup the att first before assigning the new one,
> > +       // otherwise the old att may fire a disconnect event at later time
> > +       // and will invoke operations on the already freed device pointer.
> > +       if (dev->attrib || dev->att)
> > +               attio_cleanup(dev);
>
> It might be better just returning instead of cleaning up just to
> recreate the instance below or is there a problem reusing the existing
> instance? btw we need to investigate why the kernel is reporting
> connected 2 times in a row since that is probably a bug there.
>
> >         dev->attrib = attrib;
> >         dev->att = g_attrib_get_att(attrib);
> >
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
