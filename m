Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CCC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 11:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD572146E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orcKLOSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfC0LOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:14:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55934 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0LOe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 07:14:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so15706193wmf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2019 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OGmyfdCHp1/nTnK8X6aGTljnzQ8bC2CF5Pe340auTzQ=;
        b=orcKLOSHaGbkuJWmdHKU4Ghqz099UCbnm1CAPw7PmqI3us7QGNGxKMs1qm7MWJVgd+
         RD3ViFtOM5gD0hiZtQoOB3GCQV65IhBNnjBg7k/SCig2TBau4kHJlahjeXdmuWfLiuC0
         /xpdKnVGePypwa36B9GtfeXOxRdRBWWvHBsamDTx4gUsr083QHv6XBAHwQdDN9pVsCoJ
         PEtAnFWbJm5Ls6FTAGHE/cRSc/cKu9xLI3sJKeNXC9OoISQuZiGxj2ObLHxSBXy8q0u2
         EdX8LivluXxSJQwwZcfmOcMa0TkrrnV3zDhoIpd3kYZnKBMJKDOV8UvQcydLIYjAlXSl
         3ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OGmyfdCHp1/nTnK8X6aGTljnzQ8bC2CF5Pe340auTzQ=;
        b=g89YxkpwjvUYs4cikmaKGKz1gRhgSHa9Mk/U89uPifVhaDHpjWm1lAffL6yuI8Dk9O
         ODZJJAFatLs0Id1bgQycW/Lx8ou4w9vb5Upd4ZY9wdZfqbakKOO+fu7BZQA41hvvvfVp
         TmD4rEcGuiYmBedltFF/ulbTVDHMGKXb1mQPtKbaTefc21J4vGunCCJNKyDmjbNya9zY
         uZOnKcKn/Tk5fmtkRFpSRmusmbmqGrFLMvRPZpd3p8MSeLddSTIlTXq7aoRhZl6G/BGY
         cwQWoH2y8NH6kLqK93WMBVM82R0DQGeLD1IrwWid3usFYDCExoOLJbkAbyTE0TbOxSjk
         wX6Q==
X-Gm-Message-State: APjAAAUyQbRv0U49heWwwHvNLRydGEnW553R8UymxRFCejcPXETrcnUA
        JJ5NhnpQ6+pZew6rnwkeCXI=
X-Google-Smtp-Source: APXvYqzQ8SJqKND2349NQcNYviLJodPk8QJlt0gAx+t0SNhA5bA5FKWZjNR11FigiHz43vwhAyp/Hw==
X-Received: by 2002:a7b:c767:: with SMTP id x7mr12930676wmk.6.1553685272036;
        Wed, 27 Mar 2019 04:14:32 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t187sm22735990wma.1.2019.03.27.04.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 04:14:30 -0700 (PDT)
Date:   Wed, 27 Mar 2019 12:14:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190327111430.6gliqodnnojsifjd@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190127020038.q3hm5h7xl2ku6fse@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 27 January 2019 03:00:38 Pali Rohár wrote:
> On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > On Tue, Jan 22, 2019 at 7:56 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > > > interface to allow setting a configuration.
> > > > > ---
> > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > index b5ad2db12..af9485342 100644
> > > > > --- a/doc/media-api.txt
> > > > > +++ b/doc/media-api.txt
> > > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > > >  MediaEndpoint1 hierarchy
> > > > >  ========================
> > > > >
> > > > > -Service                unique name
> > > > > +Service                unique name (Server role)
> > > > > +               org.bluez (Client role)
> > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > -Object path    freely definable
> > > > > +Object path    freely definable (Server role)
> > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
> > > > > +               (Client role)
> > > > >
> > > > >  Methods                void SetConfiguration(object transport, dict properties)
> > > > >
> > > > >                         Set configuration for the transport.
> > > > >
> > > > > +                       For client role transport must be set with a server
> > > > > +                       endpoint oject which will be configured and the
> > > > > +                       properties must contain the following properties:
> > > > > +
> > > > > +                               array{byte} Capabilities
> > > > > +
> > > > >                 array{byte} SelectConfiguration(array{byte} capabilities)
> > > > >
> > > > >                         Select preferable configuration from the supported
> > > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object transport, dict properties)
> > > > >                         endpoint, because when this method gets called it has
> > > > >                         already been unregistered.
> > > > >
> > > > > +Properties     string UUID [readonly, optional]:
> > > > > +
> > > > > +                       UUID of the profile which the endpoint is for.
> > > > > +
> > > > > +               byte Codec [readonly, optional]:
> > > > > +
> > > > > +                       Assigned number of codec that the endpoint implements.
> > > > > +                       The values should match the profile specification which
> > > > > +                       is indicated by the UUID.
> > > > > +
> > > > > +               array{byte} Capabilities [readonly, optional]:
> > > > > +
> > > > > +                       Capabilities blob, it is used as it is so the size and
> > > > > +                       byte order must match.
> > > > >
> > > > >  MediaTransport1 hierarchy
> > > > >  =========================
> > > > > --
> > > > > 2.17.2
> > > >
> > > > Can you try this set?
> > >
> > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > > I tested my setup also with this patch and there is no difference,
> > > pulseaudio is working fine :-)
> > >
> > 
> > Applied.
> 
> Hi! I have one bug report for these patches.
> 
> When I manually disconnect A2DP profile, but let HFP active then all SEP
> paths on D-Bus disappear.
> 
>   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> 
> So pulseaudio would still see bluetooth device as active (because HFP is
> in use), but does not see any A2DP codec as all remote SEPs from DBus
> were removed.
> 
> It is possible to not remove remote SEPs when A2DP sink profile is
> manually disconnected?

Hi Luiz! Have you looked at above problem?

-- 
Pali Rohár
pali.rohar@gmail.com
