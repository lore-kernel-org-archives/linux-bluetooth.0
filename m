Return-Path: <SRS0=+je2=2F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCDC43603
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3815020726
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 22:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcXxxzkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfLOWLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 17:11:17 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44432 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOWLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 17:11:17 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3so6450904oto.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2019 14:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SA7iF5h5XD6+1plTifL7SquRKv06NiYXm14/2TJVX5s=;
        b=ZcXxxzkIKkaijQew66DyQDyml7Ku2DX2De4XxDxGMKNoncLT2vCfKzB9un7UXDqJ6E
         WLgm087GGbcDdxWgYOH6hXrjv5s0JU4uJC/q3sZoEsdku7dCxG34aqPt9saQdYyVP9WT
         YQX1XbDDnD5X9gXVwypKRfrOGMBBqqR1xJDmydI2fAxSkIG3U824QG9prmPaR7M/eOuJ
         VS4L8VOCkyJQG96yA22kLYi84GKHQFeQqFciwYINug4SZBcYAxArWwjRpx0mvQnPqG6M
         atglKa0VR6aeZptVIwFGdvUmtvPJ1Chrwgnc5VSgCo6txjJ8xNTUquMRBfGK7sJzwGZS
         G7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SA7iF5h5XD6+1plTifL7SquRKv06NiYXm14/2TJVX5s=;
        b=RYMQB9QsTOOL0Sa1B06yH2ZYz2x6P4V0IGdMWk+hbiau+Tfe/7qgESUnSMQzcorcz8
         za2WN/XCZGciahmwor5pEn3fh5pA5z8O6tXUXfIQdiwL/iP4JZtKiBtiLGhgssKCARGE
         FTG09LsimMLhY+QlJQlEmNsKko7MY9NySsIt56FzucFj/B62PqFFO4NoQcr/bRKvr3ee
         OdApn3CQQNFjTk+jPFVRQTUsw3V5nruj2jZLYttj5k/WtynCe6bLH36RrMeT892qHYmb
         eRTMqoU1c765dk4G2qW2BMwsYG+/59yKNQIK1ZAmiB8oc5dBMSIwerJ3/RoFqQEvcOzz
         5N+A==
X-Gm-Message-State: APjAAAWWzn4rGuotSkONzuILpbe0t7VDWTu3/saj1LSJIcjF1vtk1PCW
        X9YS7Uvp4MhRZS07dCdv7xoa5pmMY6T94SVe21nuemK+
X-Google-Smtp-Source: APXvYqwFuc6+g1/mqFQtBvNElbSHId7Thd7T67/80TXFj8jE7F3Dpx+NqtOI8VIPGUBHyWtEmY2i0KVscWvTGVYrGUc=
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr26559094otb.146.1576447876656;
 Sun, 15 Dec 2019 14:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20191201185740.uot7zb2s53p5gu7z@pali> <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali> <20191205093200.x47npi5sxtcphr2o@pali>
In-Reply-To: <20191205093200.x47npi5sxtcphr2o@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Dec 2019 00:11:04 +0200
Message-ID: <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > possible, then that's not possible.
> >
> > I do not know if bluez developers are interested in having this code as
> > part of bluez project, specially when in bluez4 HFP profile was there
> > and in bluez5 was HFP code completely removed.
>
> Hello, could someone from bluez developers comment this Tanu's point?

I would have to say no, we are definitely not interested in yet
another daemon for AT parsing, we actually have too many of these
around, either in a form of Modem Manager, oFono, etc. That said one
simpler way to resolve all of this is to maintain a plugin to
bluetoothd that way HSP/HFP becomes native again, that can either be
maintained in the tree or out of the tree.

--=20
Luiz Augusto von Dentz
