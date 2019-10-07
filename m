Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D2C47404
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86F72173B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN0P5+R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfJGOdL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:33:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGOdK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 10:33:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so15616170wrj.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2019 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dDIm4ahBv2skerw2lSvf8A55RpMdMMYKPUXMFQ+9MtU=;
        b=cN0P5+R0URQRG1Yc8JOJq3pS2L16D2sOd09otLQSbWVZLHEZ85puzXzGPFk1vWqIHK
         8pl+Z4DIfZwYArUwKPEsBtET8MdLaR6A75uymd0t/NPoK66e+ptd0NtR3O4Uf0774Iog
         1FWKJWqz+hxtn4NXMwT/kw/RSHcyZYGtZaFRJ//qBm5AOLs7Dqs352UsZMdN8wzjy0Lu
         Q0ZUQYAvhmOGL02Do0ZE+FnHthknURqzPpHEjivBK0C4YIuff7QY12ZaS3CHfEdp6sQw
         C5ZxS2Fejn31Gfcy/WKOuxxvu8h1LLGKIobrGX0yXopdgGgA7Uy77AKietfSZkL69xAN
         sBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dDIm4ahBv2skerw2lSvf8A55RpMdMMYKPUXMFQ+9MtU=;
        b=YXsn84XjNPQViqIB7A9ihudu0pW1hzRHYkg+E05wd7MVIJn/ZpGXQyloGjQmtZLG1t
         ACTtqk4YI363IYhAki1eRpfGatCdLXokT+ZFa9+g2EaihYzQIUcyg9517Dse3EisvopJ
         uNj1W6ERrwBFSeg7eZqLIH1v7zg9WCPp2tqF7z7ngZYiN9OvQxfJZRcjDI3e0ne4Dam7
         pm6D1XA9kNRyyGvPPvIw+hhIYl09ryAf7kY6IpRrFTYbsx5dAum4Q+lDMJO/20U7KVqL
         9wx2/lH8Mf7N50tqiBj5/H77rvUV0XCLhMXBBA4iEEk/hmQMTtY9tUsAElAyTmYnDfF6
         pB+g==
X-Gm-Message-State: APjAAAUE0gk3ja4kRFalIE5mCtv7dkuxRBvTtIM+3yxatUw5TRw2DqpA
        6ynXFRDUj23QxFQpbALUIic=
X-Google-Smtp-Source: APXvYqw6eAlXUQbxfSnA/e7E4PF1sRLXdGFCCr3wtggmvrFN1o3zbkMqrOyDwzKkXWG0mRCY32Lf6w==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr11010030wro.140.1570458788698;
        Mon, 07 Oct 2019 07:33:08 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm11898698wmc.38.2019.10.07.07.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 07:33:07 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:33:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191007143307.ez6g466afu3trlxn@pali>
References: <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191006120245.tkrooh45q7irtm6l@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 06 October 2019 14:02:45 Pali Rohár wrote:
> On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Sun, Oct 6, 2019 at 1:05 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Thursday 03 October 2019 21:18:55 Pasi Kärkkäinen wrote:
> > > > Hi,
> > > >
> > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Rohár wrote:
> > > > > On Thursday 29 August 2019 15:57:34 Pasi Kärkkäinen wrote:
> > > > > > Pali: How does it look with porting the PA patches to use the new interfaces?
> > > > >
> > > > > Hello, I have not had a time yet to play with these pulseaudio patches
> > > > > and porting to the new interface. I guess that I could have more free
> > > > > time in the last week of next month.
> > > > >
> > > >
> > > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org/release-of-bluez-5-51/)
> > > > So now at least the new interfaces are in a released bluez version.
> > >
> > > Ok! Today I have looked at this new Bluez API, but seems that there is
> > > not only missing some examples or usages with libdbus-1, but also
> > > documentation. I have tried to find something how to register endpoints
> > > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > > usage of it and also unusable documentation for it in libdbus-1. So
> > > currently I'm stuck how to use this exotic API in pulseaudio...
> > 
> > It is just another D-Bus method, the only difference is that it
> > carries the entire object tree, btw I did add an example of how to
> > register Endpoints in python:
> > 
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endpoint
> 
> This example uses undocumented property "DelayReporting". What it is doing?

Also this new Managed Objects API bring some inconsistency. Codec
switching API is available only when bluetoothd was started with
--experimental flag, but this new Object API is available also without
it. So it just complicated implementation.

How could application (e.g. pulseaudio) check if A2DP codec switching is
available and based on this decide if via Managed Objects API export
more codecs or just only default SBC?

> > You can also have a look at how our gdbus internal library (uses
> > libdbus) utilize it:
> > 
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1269
> > 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
