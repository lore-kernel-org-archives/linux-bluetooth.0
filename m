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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E22ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4052133F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoBOlNCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfJINUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:20:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34078 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbfJINUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 09:20:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so2989695wrp.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jJzp0NtLpqqU/jg+WU0v0SBbuoRs7e04lR8XrDTUiN4=;
        b=UoBOlNClKElC1rTBikujaIkiOrDgR8rBYUcyUzDGgpeeWWgBrq+rZgjtirMRU9LhyY
         Q0lnrl986h3BOZ+AmXKk+9TcaZ9NJggLY6+B7Jcr9mUG/YzRAK2WD+QGGdQ5CKIaJnHp
         l4d1UCLzgdTtYrJv57YDZnjsbWu8smQ5OAL7Gyz5USOTYFVsU9++9yqb1t2UJZ3D//u7
         gfxIV2Nu/NFPyFBgYQX6YxTJSt5yt2Uz6GgzTVp1iiyAOS88bxCarmuW+l3J1MrsQn3P
         8JX0RQ7NbGP9ckEM+HTReojZkwfBxLW3unJS2t6aVuXUTo/5+kNH738AAagtqrnnXyJv
         MpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jJzp0NtLpqqU/jg+WU0v0SBbuoRs7e04lR8XrDTUiN4=;
        b=df12Izsplc4+vkm4wx1Vxh++dzskMl7B4b+78sLE5lraUj43uORUxy+dcBxe3w7eRs
         D7g1Q0UhWM+5uKw0ZoLhceTVNq1LFGnFl6yt+sekTzVL2bzcVNGx4+5baVcoqtIsskA0
         QnjK/Cq3cORGiVzD6yxlHIVKvYhwWtqGMCvfeUCnHtgQKKfc3lXJPC54pp1UWmJQx0jw
         Qq8WrxdCo2rDF+E/sKMXgqgOD/nFVnmozVL/MUW2dQnwTCoq0BzKYa0P/tY73zUscufS
         +4HiPu/bqv+goUSADJ+rwovgCOkTlDahQJcCgQD7w0n08c+3oriiXjKmBV80BJaKtapR
         94gQ==
X-Gm-Message-State: APjAAAXIDGTOn8DAFsy6ePpkWRy+pyzztz5wlXtpdo5I8ZRIGNsjFhkf
        Fcx9JUzOKkdw4hrwMXiFtbCA0Ako
X-Google-Smtp-Source: APXvYqwFGhV7WY0xamFZqicB0cXu0BbGbbvmogV7xQz8TnegZglKlXVfVVU2eZnAxTedJqahJm0dYg==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr2893187wrv.18.1570627241725;
        Wed, 09 Oct 2019 06:20:41 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c18sm2623626wrv.10.2019.10.09.06.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 06:20:41 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:20:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191009132040.tqnzfabp3llbg2g3@pali>
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

And I would like to know what is that undocumented DelayReporting is
doing? And to which value should I initialize it in pulseaudio?

> > You can also have a look at how our gdbus internal library (uses
> > libdbus) utilize it:
> > 
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1269
> > 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
