Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378486AbiEDWX0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbiEDWXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 18:23:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9F52E79
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 15:19:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e24so2471922pjt.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYihGH9qceF6yjSjGs6QrGlD7pC4Ldd85EHVOBBXQHM=;
        b=ih3B/9H117zVuBjepeRDj8BbdOiU2tlMi8DSupUJRuRnpJmjLxxu6K7bDiHzm8ciD8
         E2au+erVxRxFv0XKuWn02BRf7r8I6GOdOuioUuQ9u+rsLtDy41bvtGwgn9RClSvIsszF
         mkMuBNWdM0AHjOlEochj5FkcjpMA4qul33qqnyMhV5skorAM6oHUXm3P+UzCUImB1wkT
         ObN+2N6UAR6UDjr3eAmoU1uYRaP93sBOMx01YdTlhZbJha3UE3EEiq9afvZdMSH0IJHJ
         bbdqiRODj+dWcscwAWgWtyN9kaBkQAmGGusINQvI0g17GECHC0gwnkp+EXMWy/faB74w
         YMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYihGH9qceF6yjSjGs6QrGlD7pC4Ldd85EHVOBBXQHM=;
        b=U2eifP6+sWPvgdJoWEKwXsozzSp/ZvmT6jgQT1cQTcd22ylCho0HfI5SMcQCItgB2O
         mLQaiS4M8bcSHSHAD9VxRGL3//6Hx52kzo4eKcE8V3ersxTxE3oxkEdTYeNhxIO8xe9I
         uFrIjED1tU64EF/FCppv0aD5CymLSxZRrBpPMNdUmkQaxkb9oDxtM4tqmUriDw7VO6D0
         3KPceiTWjDSNiDkUF/vFXqzFncGDiD6Z7Vcsre7dhM/ZTrGy//Dp5mCA9oC8mj0u3WTg
         KCFDupHCkhlJkO2p4AbtBVKy1SsDrjMR0kuE0gZ3eBfGMxvNQoo5Ujw0nO6EeUfNA+CO
         yyHQ==
X-Gm-Message-State: AOAM532G9rEuBag4KMUNxo26Hc93VK1S+qusCStMZMLGzc3mdamk1yxA
        hPZbk7dlmwXxv/6xNAbsNOOtlZRgSdvovXAiB0Y=
X-Google-Smtp-Source: ABdhPJyOOJQ57zr72Ru1vxH2Lq3Em5HNrbaA9b1zu5fyB0hMV7pY+YiSoIzP68skJjgjD9TPehDuu28cL2kuKdPQStk=
X-Received: by 2002:a17:90a:528f:b0:1dc:9a7c:4a3 with SMTP id
 w15-20020a17090a528f00b001dc9a7c04a3mr2034370pjh.112.1651702786497; Wed, 04
 May 2022 15:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com> <20220504140940.Bluez.v3.2.I52f3efc7576fd0048437f1419dd2e1e687f7ac65@changeid>
 <6792e558daf326716ac0ac87867367cd91da3b45.camel@hadess.net>
In-Reply-To: <6792e558daf326716ac0ac87867367cd91da3b45.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 May 2022 15:19:34 -0700
Message-ID: <CABBYNZ+4-PPP9veRbDmA4MWiHr7+QNQaHKL1v-q_erRimnpaEw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/3] doc: add "Bonded" flag to dbus property
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, May 4, 2022 at 2:37 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-05-04 at 14:09 -0700, Zhengping Jiang wrote:
> > Bonded flag is used to indicate the link key or ltk of the remote
> > device has been stored.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
> >
> > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > ---
> >
> > Changes in v3:
> > - Move documentation update to a separate patch
> > - Add description to bonded and paired
> >
> >  doc/device-api.txt | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index 1e8590b27d58..c7e217c07526 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -246,7 +246,17 @@ Properties string Address [readonly]
> >
> >                 boolean Paired [readonly]
> >
> > -                       Indicates if the remote device is paired.
> > +                       Indicates if the remote device is paired. Pairing is
> > +                       the process where devices exchange the information to
> > +                       establish an encrypted connection.
> > +
> > +               boolean Bonded [readonly]
> > +
> > +                       Indicates if the remote device is bonded. Bonded means
> > +                       the link key or the ltk from the pairing process has
> > +                       been stored.
>
> "long-term key (LTK)"
>
> Is Paired effectively the same as Bonded for Classic devices? If so,
> would be great to mention.

There are some rare occasion where the link-keys cannot be
persisted/stored (e.g. debug keys), but in the other hand Bonded would
always means Paired, perhaps this is useful if you want to persist
some device information at upper layers otherwise I can't think of any
other use of Bonded over Paired.

> > +                       A PropertiesChanged signal indicate changes to this
> > +                       status.
> >
> >                 boolean Connected [readonly]
> >
>


-- 
Luiz Augusto von Dentz
