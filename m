Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB18ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B00206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyWa0dWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfJINTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:19:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfJINTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 09:19:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so2968634wrt.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YaM8fhy18G1P6uKLYZbozutaWLTC0GV8S8nfs/crPCk=;
        b=eyWa0dWU+R2FdVG27j2d+H7mEdf3pnA13tQg6TVVAK36AqPvSV1rbw49DsVVpQEabw
         7XggjzfpzOpd3ebIppfAdvnoGbaJvf5Awy23fXJuMouX/u/yQAzBYirXoC751AvNGsld
         FGn6Mly0feEFqReBpR6TpFfr4MmZ/XsYKqWtCWXohmV+OIFoeo9Ngr2Fk29TF7vkBVRO
         sIu0Aa45/KarvcKgV1BV90AnEEkZIEngAhtRHHqcJtOeDk6zHT/uQNhXMcl9VlfVFRXn
         EGBnIrDFRmWOYB+0vdQdFQ3tf6Sb3DgKjgN3RAQBmyAiCRxUUEC3igoIT0fjkQEjUcvW
         XsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YaM8fhy18G1P6uKLYZbozutaWLTC0GV8S8nfs/crPCk=;
        b=DGczx2s5SPPy0TcRnCXMSVKyA1D6aihW98n2UOZxWMWZEhiV23JIX/YSwtGez6RQHA
         mcOMAqbkUQbD0RUwQEBcVdymDb0x34bYVlZfcKD+G6dwf6WY62YtuBdvGgHPoiS6HK7y
         6nJrOtPjGIo/RejQExaJKYTN0lIi00U105QIkPaKt6Xl4R592c41WEifNluN/xWVNONU
         96UNVXdRxYN3IaRCNvSQAA9F6hQvXKXYAx/jN7YCdbrGWStObcJAJSh2OeIfzhWslWF1
         8glP1UyLaI/ol7C+FG7CjhJz4kMnLZQKbuuI56/yHxrel2AZEk4xZRWKO/A5FVFl4Ey1
         WPEQ==
X-Gm-Message-State: APjAAAURVpj0Peuq6AXSpvdmRapvmvurhndLo85j6mcrf89VsejRTrFm
        D04z/w4temQ9TfM/LX9gVEw=
X-Google-Smtp-Source: APXvYqwkvoeqpJuuLotvzeD56XAeIopBjhd25h9UCTPs2WlQ2D9ns1ib8e78D5LjQiCojPhbnJljEA==
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr3093342wro.385.1570627162540;
        Wed, 09 Oct 2019 06:19:22 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o70sm3671173wme.29.2019.10.09.06.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 06:19:21 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:19:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191009131921.ysl3ianpv5e4m677@pali>
References: <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali>
 <20191007143307.ez6g466afu3trlxn@pali>
 <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
 <20191008103333.rqn2btlkwtcrpouo@pali>
 <CABBYNZKKUf6-FPBEGjuC5GbsNzNsDLy7LgCHxqiW_g98BaX+QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKKUf6-FPBEGjuC5GbsNzNsDLy7LgCHxqiW_g98BaX+QA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 09 October 2019 16:15:59 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Tue, Oct 8, 2019 at 1:33 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Tuesday 08 October 2019 13:28:53 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Mon, Oct 7, 2019 at 5:33 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > >
> > > > On Sunday 06 October 2019 14:02:45 Pali Rohár wrote:
> > > > > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Sun, Oct 6, 2019 at 1:05 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thursday 03 October 2019 21:18:55 Pasi Kärkkäinen wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Rohár wrote:
> > > > > > > > > On Thursday 29 August 2019 15:57:34 Pasi Kärkkäinen wrote:
> > > > > > > > > > Pali: How does it look with porting the PA patches to use the new interfaces?
> > > > > > > > >
> > > > > > > > > Hello, I have not had a time yet to play with these pulseaudio patches
> > > > > > > > > and porting to the new interface. I guess that I could have more free
> > > > > > > > > time in the last week of next month.
> > > > > > > > >
> > > > > > > >
> > > > > > > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org/release-of-bluez-5-51/)
> > > > > > > > So now at least the new interfaces are in a released bluez version.
> > > > > > >
> > > > > > > Ok! Today I have looked at this new Bluez API, but seems that there is
> > > > > > > not only missing some examples or usages with libdbus-1, but also
> > > > > > > documentation. I have tried to find something how to register endpoints
> > > > > > > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > > > > > > usage of it and also unusable documentation for it in libdbus-1. So
> > > > > > > currently I'm stuck how to use this exotic API in pulseaudio...
> > > > > >
> > > > > > It is just another D-Bus method, the only difference is that it
> > > > > > carries the entire object tree, btw I did add an example of how to
> > > > > > register Endpoints in python:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endpoint
> > > > >
> > > > > This example uses undocumented property "DelayReporting". What it is doing?
> > > >
> > > > Also this new Managed Objects API bring some inconsistency. Codec
> > > > switching API is available only when bluetoothd was started with
> > > > --experimental flag, but this new Object API is available also without
> > > > it. So it just complicated implementation.
> > > >
> > > > How could application (e.g. pulseaudio) check if A2DP codec switching is
> > > > available and based on this decide if via Managed Objects API export
> > > > more codecs or just only default SBC?
> > >
> > > The idea was that this API would be experimental as well but it seems
> > > it is not,
> >
> > No, it is not experimental. Managed Objects API is available also when
> > bluetoothd is started without --experimental argument.
> >
> > > they should go hand in hand with Endpoint objects to ensure
> > > they will be available as well so we might have to fix this in 5.52,
> > > too bad we didn't see this before 5.51 went out.
> >
> > So... what should applications expects and how they should implement
> > above decision?
> 
> Actually the decision should be based on the presence of
> RegisterApplication method, if that exists then endpoint switching
> should be supported as well, so has nothing to do the
> GetManagedObjects API of the bluetoothd. That said RegisterApplication
> was not made experimental which kind makes 5.51 broken because it
> would appear that it endpoint objects would be exposed but when in
> fact there are not, anyway lets finally have the code to use this
> interface and then we can remove the experimental flag from
> MediaEndpoint.

Ok, so can pulseaudio do following?

Call RegisterApplication. If success then expects that codec switching
is possible and via GetManagedObjects exports all available codecs.
If RegisterApplication fails then fallback to RegisterEndpoint, expects
that codec switching is not possible and so register only one SBC codec.

> > > > > > You can also have a look at how our gdbus internal library (uses
> > > > > > libdbus) utilize it:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1269
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Pali Rohár
> > > > pali.rohar@gmail.com
> > >
> > >
> > >
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
