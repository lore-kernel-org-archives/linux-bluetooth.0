Return-Path: <SRS0=VTGX=35=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C8C35250
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2420733
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbTw6Gug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgBINCq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:02:46 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53553 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBINCq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Feb 2020 08:02:46 -0500
Received: by mail-wm1-f46.google.com with SMTP id s10so6971954wmh.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2020 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LD/dxDdggu0yAA8+pu6gGNggDoxRLXdofBaSyEMSVBY=;
        b=IbTw6Gugfg+gh1G734YNXsw1ta78d4aWXJ2C79lCfAUh3jMwEeWGbFGPoNzcNjsFjH
         mZ5pycMlj4NKKAlfmW9M57Fq9Fd2nVDsVRtysA+6Zd6BbtvdR8KWUy89RkymefGuFsBU
         z2M2e6uOkWEUi+Abti40/npYxRkJbj6LsZ3j8X/EKpqaJF6JEcDfnlostCq/5bTYueXy
         KnTpKaiNia3r485VWVAfw8icv0b83cAgCPC0hgVbD74zrjkGk/mbnRS/VcrorvpPg8hg
         4fkC8LsTqvLyY8vSkeUOfJ8CjoJhy3zvkYtk5ZDNCHBSIOSjrFDH0QZMMCGC+p1/UNwy
         oy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LD/dxDdggu0yAA8+pu6gGNggDoxRLXdofBaSyEMSVBY=;
        b=mVLeZB4roRgbYvyFKeRDGxBHRlWcc+LgFeX3RroyqRQ/aBhm7TuW6Ey3oH7Y71g7NO
         Sov5Y5ijq2IAtRPGkrCvPeJeka4wgmL3TZU69oh/VPOhV1HoAOzbTDWYuetooRja8oA2
         hQ9jpDZxSsUBJClJZ3knKwJ6E7e5jXbvmoG+I5wBfEPdK+twtKnsuhfvhZ8O91TvoqQF
         YXifOYOLZdNZ4NbW0Hpx+8nfbfTWB+qr1/geCWY+IopVf1Nha8VAuzsRGrFvYE3lQ4Dg
         LBTgarN6UzpmyQ/75BPJ+cq4CwZKh5VC90g81AjdyAtrbbnHXSON9AUUikJNyWLd+Qf3
         qHyA==
X-Gm-Message-State: APjAAAUpRpKDDRS7YKp+R0Sqz0NBaJXf4Awfl0GEOWnIh9FcZtCXlySq
        XYiXl/R+YDeydNlYJMAQQTM=
X-Google-Smtp-Source: APXvYqxi9HG9+0JV9UVUsYYGq8gv+dYpVHypUnbfmZWOACuETUNt6nAkC0Xyir0D5UyZp+W59EwKcQ==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr9228862wmk.59.1581253364554;
        Sun, 09 Feb 2020 05:02:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t5sm11680968wrr.35.2020.02.09.05.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 05:02:43 -0800 (PST)
Date:   Sun, 9 Feb 2020 14:02:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP
 profile
Message-ID: <20200209130243.u4kpbj3cwhbdqa56@pali>
References: <20191212172944.hgt6se2qz2hpsbo2@pali>
 <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
 <20191212230314.g5gt6rxkphzpwucd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212230314.g5gt6rxkphzpwucd@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 13 December 2019 00:03:14 Pali Rohár wrote:
> On Thursday 12 December 2019 21:42:27 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Thu, Dec 12, 2019 at 7:31 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > Hello!
> > >
> > > According to HSP 1.2 specification, section 4.7 Remote Audio Volume
> > > Control, Support for remote audio volume control is optional, so an
> > > implementation may support none, either, or both of the controls for
> > > microphone volume and speaker volume.
> > >
> > > According to HSP 1.2 specification, section 5.3 SDP Interoperability
> > > Requirements, bluetooth device with HSP profile announce via SDP "Remote
> > > audio volume control" field information if device itself supports volume
> > > control.
> > >
> > > But currently I did not found any way how to access "Remote audio volume
> > > control" SDP field in (pulseaudio) application as bluez does not export
> > > it.
> > >
> > > Can you please export this field? E.g. for HFP profile all optional
> > > features from SDP are passed to NewConnection() DBus method via
> > > fd_properties dictionary under Features key. Could you export that
> > > "Remote audio volume control" bit for HSP profile in Features key?
> > >
> > > And in same way, this needs to be handled also in RegisterProfile() DBus
> > > method.
> > 
> > Do you have a use case in mind?
> 
> Yes, checking in pulseaudio if remote side announce that supports remote
> volume control or not. And based on this switch to software volume
> level.

Hello Luiz! Is it is possible to export this field?

-- 
Pali Rohár
pali.rohar@gmail.com
