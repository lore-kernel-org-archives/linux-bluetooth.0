Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A9ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiH3Rld (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiH3RlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 13:41:15 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9EA163B48
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 10:38:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id m7so7597768lfq.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QiAu41j95S61VvwDiXH9jV89BeVkZowQlCO4mkpEKbs=;
        b=fssIIQzWRZNlk04WcCS5Xu8Zvlre/ALg3qGoGsBOaLXWUMe8+p3FdFIc5ymkXeKYPN
         i0IDVLtfDuLZ34VKFuX3k1mEjM973zcybiuyHfAxkH2wM+Wu7xOIdLGJKRbQSgpdXW6K
         Hq7KPCSKdnQaxH6DoRWlWT3YVpUlF8XKD5QFMOorptGwA554A0+O0xdn+MXhnKAJmR69
         cgUB0knG4LV26t21rtmzhtWCtzfFQK5+TJ+N/5953DOAWGQEuJaXyT+pKSADz7ydOMws
         MDUtkQUPXrdR9tpDhpAHpZ610nBImmMlE5/g68FYLXxNSRzu3sfp+HTJaLrMtwdw0mqD
         9d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QiAu41j95S61VvwDiXH9jV89BeVkZowQlCO4mkpEKbs=;
        b=74mxkIiumStbdztW1BGM9Ea8N636J3SkPq5BZi4nbsj9VIaThd6ZAhbhIaueEFMPsg
         TGhpyNN6OxGCRO2sQwvhvgFaqSY/a5PbbY8bf68SVijqCOzvQ+nz8MmrGl1FgkWOYmGy
         MEBYlVDu1pVdE0CJe6ZlIgOjivALZuwEkc5GcadD0CzX1ORNMHVIGDbP6aoOFYcYgJiE
         aFKyW1KOpwrGXyRzpRD7LJCvMNJoBs52HnVEmvd3nS90xKXz8xxplQEq6wsmUp2E23UG
         acDsjFztY+zBKpsYoS7b22VLR4qTy9XBEnDB+XuX8sWhsZ9egypWEEN8yfoDeZ8BHL5P
         1T1g==
X-Gm-Message-State: ACgBeo2vDSB5aSH1sHeGXb7I4wlwMqDXzh5c8RuNfygnY/D7L8n7n1CJ
        9rCIdHAHNiPLh02yQpizyD5tz7elIPhS8LH0cfiZuDMY
X-Google-Smtp-Source: AA6agR60HvdXRwhOK51G7KlDO1EmAfuGgzzGh+XkwJfeEZcRxf8a0a2a7Fd26aoxLlRj4O4+ngMObzdb25mhDYDa1sE=
X-Received: by 2002:a05:6512:1044:b0:48b:49b1:cc85 with SMTP id
 c4-20020a056512104400b0048b49b1cc85mr8276831lfb.57.1661880958277; Tue, 30 Aug
 2022 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
 <CABBYNZL+NZ_NR8bx+CaayZis4oRywGvqYN8umqaCYEpp3uOwMw@mail.gmail.com>
 <039331637535e9cb0c1f9df777cd18d5e34cfe27.camel@hadess.net> <7cc9c749f6e87e5feff30c16422665f10549def6.camel@hadess.net>
In-Reply-To: <7cc9c749f6e87e5feff30c16422665f10549def6.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Aug 2022 10:35:46 -0700
Message-ID: <CABBYNZJEJJRnu+O9F2ow6WrnTGdV0Qxt5VSSM4oKbQQc+Ruq8g@mail.gmail.com>
Subject: Re: [PATCH] adapter: Implement PowerState property
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Tue, Aug 30, 2022 at 9:59 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Mon, 2022-08-29 at 11:47 +0200, Bastien Nocera wrote:
> > The rfkill calls made by GNOME are usually sent to all the rfkill
> > devices, rather than targeted at blocking a single adapter. So the
> > adapter state isn't super interesting in this case, as all the
> > devices
> > will be either blocked (computer with no platform rfkill), or gone
> > from
> > the USB bus (computer with a platform rfkill).
> >
> >
> > The good thing about using a string property here is that we can
> > extend
> > it. One thing we can do though, to make extensibility easier, is take
> > a
> > leaf out of the icon naming specification, and use prefixes to encode
> > the expected state in case the software isn't new enough to know
> > about
> > a property.
> >
> > For example:
> > - "on"
> > - "off"
> > - "on-disabling" (transitioning from on to off)
> > - "off-enabling" (transitioning from off to on)
> >
> > So we could easily add:
> > - "off-rfkill" (off and blocked)
> >
> > Let me know what you think.
>
> Poking again, as I really need to land this soon (and by soon I mean
> last week ;)

off-rfkill sounds fine to me, btw introduce it as experimental so we
can still make changes if need to.

-- 
Luiz Augusto von Dentz
