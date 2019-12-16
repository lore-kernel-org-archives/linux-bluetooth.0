Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED1EC43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203BE207FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNPSUEuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLPJPZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:15:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPJPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 04:15:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so6294857wru.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2019 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hSCueb/riaMbmkulOttNEB3kkApamfcYKm/6vg65cQs=;
        b=iNPSUEuksps94Sfi0/AmC2uA0Emt4mqQq1lhbCd1myP4m83q4iKFmoVovzCuF2v2tG
         u/pXD1C7irjKKMnEbP4lkOuxEJC2aPD5YqVRMVw9uqs/+VbTTASQNV9wCWzTalWgX73u
         yOuQCwGCat5vsOnzXuEb9xbuSDM7OzLMy2Bvk7JZAoPcmLtT6fTUsRdp9Idx1B9WN4Ir
         N4bu5xsQgbCOdbDrL7waKBeDUn9Re3bk4BqSY+cp3m0r4bUDByTCvLKuVti/eNpXYqE+
         2TcriV8i+EshbaPP/nqOkkw/kiBMDwX1/4/U7WaIGqpaYk2CRw2wv+xOksHCt7JOAKzW
         Bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hSCueb/riaMbmkulOttNEB3kkApamfcYKm/6vg65cQs=;
        b=NOYXFo4PW0IUGpUeRhMe+hQyp97dAz8I7ko7xiL5VzQBMXY84MELLSodXmYKcPOYaS
         xcS7XSqtY9XoFJz3optQAwxURj/2yWFq3uyM/qyDHe/DZGUCt/Q7O0kvPEvUsxTFTYIo
         qzgcyWH2zbbmL5Y82gZvwARfkZmF4X6afnseP0r4ZPo0Z3JUTeW1R9hJf/53ippSIcfy
         vwc1O/p/iiXuXDvTKVdpHIGJM1+RRTgRADqyERrxyePoOmExyCEXAj7JhIkZDeD23wpr
         FKAMV6sAWqHXPJ/PcM9laIlFdECkiV4RxnUt9t2D+Bu7A45eZ/cGPel1BFwtNSIejc0w
         zoIA==
X-Gm-Message-State: APjAAAW4tfK4NprTH0oDmRDeXaqIHXSoNHLPVEwwQkT8GVF4mM6I0W79
        683xh6j9vas2pQ8TYz8HdDsG36XN
X-Google-Smtp-Source: APXvYqydDX+h5/1pkcSjSe1w7QwcN2ZPcavAQJWKQx3z2yyGpXGsjxGVq8EuT/JgJ9CxsdRjSUPUUQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr30211442wrv.0.1576487723666;
        Mon, 16 Dec 2019 01:15:23 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t1sm20636404wma.43.2019.12.16.01.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 01:15:22 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:15:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191216091521.reh2urr25husschv@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Thu, Dec 5, 2019 at 11:32 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Monday 02 December 2019 19:45:12 Pali Rohár wrote:
> > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > > possible, then that's not possible.
> > >
> > > I do not know if bluez developers are interested in having this code as
> > > part of bluez project, specially when in bluez4 HFP profile was there
> > > and in bluez5 was HFP code completely removed.
> >
> > Hello, could someone from bluez developers comment this Tanu's point?
> 
> I would have to say no, we are definitely not interested in yet
> another daemon for AT parsing, we actually have too many of these
> around, either in a form of Modem Manager, oFono, etc.

Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
implementing logic around HSP and HFP profiles and export either native
interfaces (linux uinput) or DBus interfaces for features provided by
HSP and HFP specifications and also for current and future vendor
extensions. And part of this HSP/HFP implementation is of course needed
parsing and interpreting some of AT commands. Look into my design and
API proposal. Current daemons which provides AT parsing (like ofono or
modem manager) are not suitable for for whole HSP and HFP profiles with
all those extensions (like all possible ways for reporting battery
level), so for HFP is needed some of custom AT parser.

> That said one
> simpler way to resolve all of this is to maintain a plugin to
> bluetoothd that way HSP/HFP becomes native again, that can either be
> maintained in the tree or out of the tree.

I do not see how could just plain plugin for bluez without AT parser
could help. This seems to just complicate whole implementation. I
already implemented prototype implementation of hsphfpd to see how
complicated it is and what is needed...

So if bluez daemon is not the right place for hsphpfd, it would be
separate daemon outside of bluez.

-- 
Pali Rohár
pali.rohar@gmail.com
