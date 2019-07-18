Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F36C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9991C21783
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIjWAFsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGRKA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:00:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRKA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 06:00:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so24942270wmj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rhwJiX2z1LOVqIKTUNvBe5qWR4Xa+QosyzTXkER9vUE=;
        b=QIjWAFsxGEL+yfen9xwi4k6WOz9ySDQy4J5aCKT2wJhekFVx4QoiyeiO5eylyMHPIv
         48saymEA5PSUVvXe7EPBbvHVGqSxSm/udKToYPn7xZptd1Gk2QhDk0RrOVh7r5wNQD52
         LQKHhECkHZir7707fkTSWnNCK059/hyKBRCFnJmtxVjrldk4zUFyHFt1ebOnA4O4VAd6
         VA4OT+yLQj9N3A18z0dHLfU9gJb0KFq33kJL12e2rRBmV35JiuJ+0eZ8TRDfrU/UsJlS
         IRuqV4QRxfgVVxPsAfkL0pTGlJfFcccklhlhGsyw4blFsc2S5DnR3At1PN33bJZfN7BF
         SaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rhwJiX2z1LOVqIKTUNvBe5qWR4Xa+QosyzTXkER9vUE=;
        b=ltNU/UmefTmt9SnmEHSRtpMZihlNlaO2HtTI98A/ORdtnLk73a6WC3P40hqDGpLtp8
         D9rY0BvX5IxOa80WFoyOYpcY6czJy8qOP+qW654AOO7XWavKgdbJ+zDXldKcHiPrGuQ1
         Ul/zvR8adlKgAImjQgCHIzfO+iViNBlUMHoUCWi9r6+ZsCrkchYgh7FhE5BsptgHXP35
         FvK769BsKv/+gKY6FgmHi9IE2IBiPcRlM96kh/60V1euIQJBSX7MK9wetcUYz3lBEDBi
         JEOdfz2BnQI5yqwq3EdAuL9gLZuItYIBNfbdTYjr2/2ykzBrzW2u3PKG53WzNV7B+Lw3
         fu8w==
X-Gm-Message-State: APjAAAUnTz4zZF5RI0Uqq6ybxGbT3cVuhXxwF2J0LTSbEzVDSC1IwZ2O
        hbxnayooYvN+3Ox2cvKew7E=
X-Google-Smtp-Source: APXvYqyV0qlgGTIzD7YCw3xC/vSwAolFbPUo34qCBje4douP2yKWKDrPC/85GEsFeWZQ5aSPBHSnJg==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr38926583wmb.173.1563444026437;
        Thu, 18 Jul 2019 03:00:26 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w25sm25104279wmk.18.2019.07.18.03.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 03:00:25 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:00:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20190718100024.ii2igadxb2lmmitm@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 13 July 2019 17:52:46 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Fri, Jul 12, 2019 at 6:13 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This uses application ObjectManager to discover the MediaEndpoint and
> > MediaPlayer object of an application and deprecates the use of
> > RegisterEndpoint and RegisterPlayer.
> > ---
> >  doc/media-api.txt | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > index bca8c9563..07f7ac3e0 100644
> > --- a/doc/media-api.txt
> > +++ b/doc/media-api.txt
> > @@ -66,7 +66,27 @@ Methods              void RegisterEndpoint(object endpoint, dict properties)
> >
> >                         Unregister sender media player.
> >
> > +               void RegisterApplication(object root, dict options)
> >
> > +                       Register endpoints an player objects within root
> > +                       object which must implement ObjectManager.
> > +
> > +                       The application object path together with the D-Bus
> > +                       system bus connection ID define the identification of
> > +                       the application.
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.AlreadyExists
> > +
> > +               void UnregisterApplication(object application)
> > +
> > +                       This unregisters the services that has been
> > +                       previously registered. The object path parameter
> > +                       must match the same value that has been used
> > +                       on registration.
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.DoesNotExist
> >  Media Control hierarchy
> >  =======================
> >
> > --
> > 2.21.0
> 
> Can you try this set?

Hello, I will try it later in next week. To test it would mean to
rewrite pulseaudio bluetooth modules to use this new API, so it would
take me longer time.

-- 
Pali Rohár
pali.rohar@gmail.com
