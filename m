Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D380C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB8421881
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITUELWQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfGCNaK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:30:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 09:30:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so2231276wms.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NEuhUrqutmFnz0leHhb1ElCCXd63yvDXYOTr0xCZQZ4=;
        b=ITUELWQ6fYqnWblB+iBJH/SfglySKaXjcx4RI7iNuxG6RR+hIAiHPx0kZaN2m8TSpZ
         QI728i5dD8Cv05cuoPu0ZFTfx4N0tg9iUekANf8efqrERM+pWgL5N7BT7pWXYdoKcxcy
         GAI0Jg9KOCprVbWGpN4sDNZZuY22TMxJibtGBntqY2LwkHUlaQlaiZe/+2nXeT18NsLw
         f7PBj7T34teZLgUA+IoJYTebW3lpOpbRcpMyIGtvt8MBgGAMGbalRLTd73aUuw2VIQRs
         +qXKFM7g+kGAlCTG83YgsQS/U0XeHSb0UowEpB8JYuXK+YcOq4OnQOQxsBUyJWt9qza4
         xpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NEuhUrqutmFnz0leHhb1ElCCXd63yvDXYOTr0xCZQZ4=;
        b=AEjqpokqIO4BaXV2f6pHY6ExJV16/OtRyu3BugDHcCQdX0A5D/oOTjTdWCbFxd1kHg
         Dn4yfrQlpoog5aALtNoUEUcZv5xQuPA17116ugEdhcVeepRLrFMmUaWssfFQN2nIeKQP
         gkwPKqeHizsfJ7G80cvJIknO2H/f+S6xBZ4eVJT4U452u15MsF0phYgPABFzOFhocJPa
         ddLaE27Jshdps4CXV6trbYCuD9ceVqsiksplbvIPZDoJ8ZjZUXSh66qs8xrYX3uYTr3/
         kAaREyZukZ/VqdEWEC7A8G2BcUqSYoKAHuq61+vP9Uwe/Sz7bGEfNv5g0eaLLrSRhR61
         goCQ==
X-Gm-Message-State: APjAAAV7RP4X3pZoGsVSPAZbf3QsvlxmSCX8JaugwGSFH8Ph5bJLOFhr
        Hc52yfh+ktnqPWlY1vNhrEA=
X-Google-Smtp-Source: APXvYqx7COkMXShAXhxaiHLl/+o5Tp2vdt8UBN9mHi0nE60itRsgpF9Y2zDoXqkt7lscL7VtVEbjtw==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr2906330wma.41.1562160608493;
        Wed, 03 Jul 2019 06:30:08 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c1sm3557014wrh.1.2019.07.03.06.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 06:30:07 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:30:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190703133007.ydmxz7sgtwibhznl@pali>
References: <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali>
 <20190608111553.65s6yoyhmusmr3pc@pali>
 <20190622161837.37mjlsirpoql2plj@pali>
 <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
 <20190622170933.lxuftoxmvtv7ssfo@pali>
 <20190703125608.nl72umoinhg2kh6k@pali>
 <CABBYNZL55sB=zG1zkHvTwmTJuSxHwEJ_a+9PjehVpW54tYe9BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZL55sB=zG1zkHvTwmTJuSxHwEJ_a+9PjehVpW54tYe9BQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 03 July 2019 16:26:37 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Wed, Jul 3, 2019 at 3:56 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Saturday 22 June 2019 19:09:33 Pali Rohár wrote:
> > > On Saturday 22 June 2019 20:01:15 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > I think a better idea would be that we introduce something specific to
> > > > that, such as the SEID being returned so the next time around you may
> > > > restore a SEID, this may actually make more sense perhaps if we reuse
> > > > the RegisterApplication semantics:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n464
> > > >
> > > > That means it is no longer required to call RegisterEndpoint as many
> > > > times as there are endpoints since that is time-consuming due to the
> > > > D-Bus round trips, instead, the endpoint are discovered with the use
> > > > of ObjectManager, if the method doesn't exist then you just fall back
> > > > to the old mechanism since it might be an old daemon.
> > >
> > > Hi! If I understand it correctly, pulseaudio would register itself via
> > > new dbus method and bluez daemon then discover A2DP SEP endpoints
> > > automatically, right? And if that new dbus method does not exist
> > > pulseaudio would know that in system is running old bluez version
> > > without codec switching support. Seems it is perfectly fine solution.
> >
> > Hi Luiz! Do you have some patches ready for testing?
> 
> Not yet, will try to arrange time for implementing it next week.

Ok, I will wait for them.

-- 
Pali Rohár
pali.rohar@gmail.com
