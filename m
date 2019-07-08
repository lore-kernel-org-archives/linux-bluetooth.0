Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB7C606AF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DFE20861
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 12:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEBnB41u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfGHMZQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:25:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfGHMZQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 08:25:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so16225436wmj.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X0UwetFXyu5BhSquWNLkVBhwV+HWmVE6FLLfdQY8OEs=;
        b=rEBnB41uy+3uOX3qo4FfTPI8nhQeeRoVyyJ+iRHoeVNur5HEeg4efbOVnUqqdd3s8I
         q6HMTgttxGn3HmF0eaoGak5KUJA4uzSAoviSqk+5bdl7JeSk3PkN+Hv3EY4xWTTk6Vmy
         rX9Gb5KXKBS8OeDfwlZ9LhVKJrH+iIt4bm/b6wnsyd4rN5TklF8uKBJ3fNo8pZPPcZKY
         7bdyjCvyCKUMqAO2WE0Gnbuigsw3iMz4FBqifXNkA5SwZoX+BpexIhPt9Q6VnnGjtfxz
         EPv9xvkHfPIgVUgbAhuDmPbYcVgg8YkuidkwxOMgqk2xV8SF5xHQtKb22Lzd9CvGpPKE
         Ltnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X0UwetFXyu5BhSquWNLkVBhwV+HWmVE6FLLfdQY8OEs=;
        b=VJ2YdxXLYSxdk4J+28G2NaKcKSuTv4IPn76wTxTFMpp2tM0yiR2C66Kv2gudCpZe0S
         eJiNdCe7B0h8C+0vl59RQ9rTS1+xnKxhh4R6G86/5+Z/hCSNN4xD/3oIXDhw+o6qKdqR
         tD/a/1OMEKRuXVR8pKXVOweAT+4sLdd0mUST2TvBkIP4O3Hs5zeHVCSiWU1FohW7MBDT
         ZSslG1GTErywCtLggp6+s8i12ZNsqvXmFubvrs0EJSAYhOMVJipNXjMuHXnuFCOIQ45g
         2UuMi0FD7MWhKE5bw/hEl55q2TNSl2zcepxDOHUexFVHap81wq4ZZUG7olN4EhUuBhyD
         IoDA==
X-Gm-Message-State: APjAAAVKH30Xt+exMHmJcckcST78z5hd4BcUj4vXa0mG8sMQ+UrKAy17
        z+nttqYdjbnlzUfh3NqT4Ik=
X-Google-Smtp-Source: APXvYqz7eThhioFWWQrS4vRARVgoo06ti8r5ARRD1nr1AFhWg0XaVu7Tm2zRiWscQTapf5ZyDrlkZA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr16125673wmj.71.1562588713864;
        Mon, 08 Jul 2019 05:25:13 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v5sm19128117wre.50.2019.07.08.05.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 05:25:13 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:25:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190708122512.qqfvtm455ltxxg3h@pali>
References: <20190504171550.llqfv5674gxd3bnn@pali>
 <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali>
 <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 06 July 2019 15:45:03 Marcel Holtmann wrote:
> Hi Pali,
> 
> >>>>> to be honest, I would rather see WBS implementation finally
> >>>>> reach PA before we start digging into this.
> >>>> 
> >>>> First I want to finish improving A2DP codec support in pulseaudio. Later
> >>>> I can look at HSP/HFP profiles. Ideally it should have modular/plugin
> >>>> extensible design. So the aim is that adding new codec would be very
> >>>> simple, without need to hack something related to mSBC/WBC, AuriStream
> >>>> or any other codec.
> >>> 
> >>> Well HSP don't have support for codec negotiation, but yes a modular
> >>> design is probably recommended.
> >>> 
> >>>> But for AuriStream I need to set custom SCO parameters as described
> >>>> below and currently kernel does not support it. This is why I'm asking
> >>>> how kernel can export for userspace configuration of SCO parameters...
> >>> 
> >>> We can always come up with socket options but we got to see the value
> >>> it would bring since AuriStream don't look that popular among
> >>> headsets, at least Ive never seem any device advertising it like
> >>> apt-X, etc.
> >> 
> >> Pali clearly has such device and he is willing to work on it. Surely
> >> that means it is popular enough to be supported...?
> > 
> > Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
> > not only I have such device...
> > 
> > So I would really would like to see that kernel finally stops blocking
> > usage of this AuriStream codec.
> 
> we need to figure out on how we do the kernel API to allow you this specific setting.

Hi Marcel! Kernel API for userspace should be simple. Just add two
ioctls for retrieving and setting structure with custom parameters:

  syncPktTypes = 0x003F
  bandwidth = 4000
  max_latency = 16
  voice_settings = 0x63
  retx_effort = 2

Or add more ioctls, one ioctl per parameter. There is already only ioctl
for voice settings and moreover it is whitelisted only for two values.

> We have kept is really simple since there was only CVSD and mSBC as of now.

Seems that custom codecs are already widely used, so it would be great
it Linux kernel allows to use also other codecs in future without need
to explicitly whitelist them.

> I am also curious on what the assumptions are for the USB driver alternate settings are when using a different codec.

I did all above tests and kernel changes with USB bluetooth chip which
is integrated in notebook's combo bt+wifi intel minipci-e card.

-- 
Pali Rohár
pali.rohar@gmail.com
