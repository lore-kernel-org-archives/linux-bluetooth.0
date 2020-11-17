Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85128C63697
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330D0241A7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FixUEFIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgKQWXN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKQWXN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 17:23:13 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89607C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:23:12 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so7456192edl.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiL2Putz/ijHvGCUMJ2Vz7m21F//MPKRGZPnEKU/Sa4=;
        b=FixUEFItkXkp7o01VEI34+30np+zVPM2uQlspNeAkZYngxLrZWtC5z7odCszY1syPS
         Zz5K82c1HRmAElf8UjZ6hq8644rqANjfMXCCBFCiDWMZZySEnk6YUmDgZ3lss63p+kIB
         hEpbZ8ILfPiTCIDA9uq+6cq/bNDBhvavMW/O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiL2Putz/ijHvGCUMJ2Vz7m21F//MPKRGZPnEKU/Sa4=;
        b=igyMMoCySHUbTFo+DT+jrfLi+OcrWQ1mJdQubciOYL2MesDYRq7oNQ8qAe8JaQTViR
         Qm+F4a5wPCG6u9A6B1VWJ8XQruZV+zTSDhtT4aRL5Bg+yiFzZXONfPUADTmgsSj85yQT
         fxzZSOvki6L3QHT05H0yGeJrGJ1KRy1/EJ5eqeD9xlhVgIhs7fVSXNwKlo+KalRnSGeI
         EKjKh0yk2M3IV0OlEkkW2panqnY3N8+z8jChHZUzUl94Cxr4nJRlsV36OiQMEvz2pKs7
         5b7VbgvEv7IuBH3fJoZ6rhc2R64NHDV8G3AHU/XFJ8+qloba/4Y6ebhDftLJfTPj3Xwt
         KXRw==
X-Gm-Message-State: AOAM532cI4YOUV3bAHQZnMo0mhpTkajFDVKkUIAErMcFYBuDaeR4dQcq
        X+zDm20aycULIQRtjwAZeVoEdZiRZLrdHg==
X-Google-Smtp-Source: ABdhPJxr+qIeaCzjrvYtwGnWjx3RYhVzMzsLOANP2zbxKRWkxO1RHVQwkPsZrokH5YRCjyG91WldCA==
X-Received: by 2002:a05:6402:154b:: with SMTP id p11mr23372226edx.217.1605651790958;
        Tue, 17 Nov 2020 14:23:10 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id f24sm12485933edx.90.2020.11.17.14.23.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:23:10 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id k2so25137439wrx.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:23:10 -0800 (PST)
X-Received: by 2002:a5d:518e:: with SMTP id k14mr1614732wrv.253.1605651789761;
 Tue, 17 Nov 2020 14:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net>
In-Reply-To: <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 Nov 2020 14:22:56 -0800
X-Gmail-Original-Message-ID: <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
Message-ID: <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

More responses below.

On Tue, Nov 17, 2020 at 10:01 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2020-11-17 at 11:51 +0100, Bastien Nocera wrote:
> > <
> > <snip> didn't review the code in depth, but, having written this
> > mechanism
> > for Bluetooth battery reporting, I think that this is the right way
> > to
> > go to allow daemons like pulseaudio to report battery status.
>
> It would also be useful to know what external components, or internal
> plugins you expect to feed this API.
BlueZ could have internal plugins to read proprietary battery
reporting, e.g. JBL speakers and Bose QC35.

>
> Apparently HSP/HFP, for example, provide more information that what can
> be expressed with the Battery1 API, whether it is charging or not, or
> whether a battery level is unknown, etc.
>
> So I would say that, even if the current battery API is extended, we
> need to make sure that the D-Bus API to feed new data is extensible
> enough to allow new properties, and they don't need to be added
> separately to org.bluez.BatteryProvider1 or org.bluez.Battery1.
I proposed the API to start simple, but I believe that it can always
be extended as we need in the future so I don't think the additional
features need to be coded now. I documented how this API could evolve
in the future by extending other features as well in this design
document that I shared with Luiz and Marcel:
https://docs.google.com/document/d/1OV4sjHLhTzB91D7LyTVT6R0SX2vXwSG1IA3q5yWQWps.

>
