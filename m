Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19AC10F14
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9121D206C2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihehRpkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfJHKdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:33:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfJHKdh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 06:33:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so18810452wrs.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hA+3CSHitYeF10/BtfSUsiRiM2YWgpRoVS8FUNcMeTw=;
        b=ihehRpkjsKvU8HiQmu+DPC5DWROkVsm36k2Zy0sy60L4JHRzqSF7iBX54EE1+aO3Jd
         4DT7bA8kfg4hiJJIli2x9HWe99Rrd5GajO75gw1dCZDKTI5JNQsO8jbQD2C4pBJmvb+m
         euhBejZ03RhASOdZeDto0W0H7l5WKH2z1n9wUS3OXym4a6jhAOivkLOQwZ4vZWjeQ2MO
         kkgUPlNuM3ZPprMzbEN/kDqOt7TjUMQPMt0Mw/b04iWED9pHSM83ACghrUDU9j+rzg4I
         liXpL+4LGN6znBiCl2qtp1bZZRLCmwAihasmHMMW06AX6uMAgicL/QorMhoDyAVHP7Lg
         Jb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hA+3CSHitYeF10/BtfSUsiRiM2YWgpRoVS8FUNcMeTw=;
        b=fPdzlf0ykuL9GsVRegQpsAXVC+bjXts5nKaJpxX3KqOtG/24sonRFoy0c8j6JOv4XV
         0NDEavIoJHIJKxP95ykSd9ArdaFF6CT+1wK9TIsR+33zXX0Z4b+2WU7TreQVm+n+xbRn
         LlBj1DwXxAm/oxWuvIDg43xFcYYd07STr2V8WLBkUdBsUa85bYKfgHOy35Gg3Z8OUPal
         3vXX6w+meBN6H2SDhx1hMwOhqN1sDbrUYcifczG9PsFLuCQiNyLWslK7utmfoyuQU4y8
         j9dxqXW4pY9BndR2s5q3z4g6NbVQexUMw0wFBLi3F5gTmaPbwstOcTobwcwumqTwgpS3
         0QEQ==
X-Gm-Message-State: APjAAAUiSXEBFUSD7M43U5dFd063RnUgcnhrjc0njLxxDM5+LrVfY5H2
        CxqDhcamqrsdywkF0UIjWaM=
X-Google-Smtp-Source: APXvYqwJhuqlxZpXAO7jdy7Ae/17/bZpYhNPH8DziWxY6hyh1Ws6ojHHlgjl9aMPcSwc4oc9G7Vjaw==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr6123955wrn.307.1570530815566;
        Tue, 08 Oct 2019 03:33:35 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x129sm3332574wmg.8.2019.10.08.03.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:33:34 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:33:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191008103333.rqn2btlkwtcrpouo@pali>
References: <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali>
 <20191007143307.ez6g466afu3trlxn@pali>
 <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 08 October 2019 13:28:53 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Oct 7, 2019 at 5:33 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Sunday 06 October 2019 14:02:45 Pali Rohár wrote:
> > > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Sun, Oct 6, 2019 at 1:05 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > >
> > > > > On Thursday 03 October 2019 21:18:55 Pasi Kärkkäinen wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Rohár wrote:
> > > > > > > On Thursday 29 August 2019 15:57:34 Pasi Kärkkäinen wrote:
> > > > > > > > Pali: How does it look with porting the PA patches to use the new interfaces?
> > > > > > >
> > > > > > > Hello, I have not had a time yet to play with these pulseaudio patches
> > > > > > > and porting to the new interface. I guess that I could have more free
> > > > > > > time in the last week of next month.
> > > > > > >
> > > > > >
> > > > > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org/release-of-bluez-5-51/)
> > > > > > So now at least the new interfaces are in a released bluez version.
> > > > >
> > > > > Ok! Today I have looked at this new Bluez API, but seems that there is
> > > > > not only missing some examples or usages with libdbus-1, but also
> > > > > documentation. I have tried to find something how to register endpoints
> > > > > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > > > > usage of it and also unusable documentation for it in libdbus-1. So
> > > > > currently I'm stuck how to use this exotic API in pulseaudio...
> > > >
> > > > It is just another D-Bus method, the only difference is that it
> > > > carries the entire object tree, btw I did add an example of how to
> > > > register Endpoints in python:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endpoint
> > >
> > > This example uses undocumented property "DelayReporting". What it is doing?
> >
> > Also this new Managed Objects API bring some inconsistency. Codec
> > switching API is available only when bluetoothd was started with
> > --experimental flag, but this new Object API is available also without
> > it. So it just complicated implementation.
> >
> > How could application (e.g. pulseaudio) check if A2DP codec switching is
> > available and based on this decide if via Managed Objects API export
> > more codecs or just only default SBC?
> 
> The idea was that this API would be experimental as well but it seems
> it is not,

No, it is not experimental. Managed Objects API is available also when
bluetoothd is started without --experimental argument.

> they should go hand in hand with Endpoint objects to ensure
> they will be available as well so we might have to fix this in 5.52,
> too bad we didn't see this before 5.51 went out.

So... what should applications expects and how they should implement
above decision?

> > > > You can also have a look at how our gdbus internal library (uses
> > > > libdbus) utilize it:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1269
> > > >
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
