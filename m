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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A6C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E633218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXVDzu3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGCM4N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:56:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43525 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCM4M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 08:56:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so2669118wru.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wy7UWXPsz2MtPtDmCt3z/3SEmwu3EzorqJejYq39Lwk=;
        b=iXVDzu3yM3/+MpMmARaKcAb/VQWtpNpb4PB3VXZzwlIvlfsw1RRVlaXr7BkvfuRMzH
         Q+S26ZZScEYT2ZqfZ08KesUUZ0aQfMFK7LltJKr2jzcyyToHpQzmlmQi5ye6MCac45pl
         NH4N/VSO8K9bvpJwB8mEXlnr7qkknSU7VZYOBDcjsbdnB1zKndz90hnV9nfeuF83Faay
         Ou5WApa5vxnGpLYSqY2oEOAXAjtGqc59W6MYeklcu23v3t1FoDfMux2wis7b0BF9h3cp
         HwCHBlWBUdeeVMFCNInOY/kL/R0EmQxAm3NeQRmDc/R5Pp+gH9+dZQWDpQBKGZtULfdT
         V8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wy7UWXPsz2MtPtDmCt3z/3SEmwu3EzorqJejYq39Lwk=;
        b=RwxZmi0hvZz6D77Bn+HyqkWQ3+Owd6PjOGiGfjLAZxF0u9VZr7+pdpOWTiROlaVoru
         JHgjdZxcOTQWKlc0cRSRqjjTAjC7gwJXqU3tUztPD4FivwcBJEsl6V14d/+xaWM40J8N
         89wxPSrowfkoMHxNskMlJu3XUVdnuD+Ov+DflvPnLPbft187gTdTHszjgV7dklMAEBXt
         kwrYBUbYQuQgyYsMCgp90/Kzdx90xZwETUASI7RKtLrSosKoLiOnkhS/9m9scZQmuHcE
         Rg0jwi1LaFLfW4eWebv+JLl8kabSxEjdycJdrHfdLIvrW2TrfEHaohcLIft/TvcFSSdq
         GjQg==
X-Gm-Message-State: APjAAAU+UgCONFNVhYpQdEHe30pVcJkQGW9AcptWw5SYTIAXWUx2/4Rp
        GKWa66WJIw89VecmQrsL28o=
X-Google-Smtp-Source: APXvYqw96/9LTA/QX67ctmaPSIDN3w0XD6xqtRZuSCEY0/kdtYP3XNL0V9Y1/tArgduX+TyDmo4ZYA==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr27526985wrw.73.1562158570507;
        Wed, 03 Jul 2019 05:56:10 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f204sm3427715wme.18.2019.07.03.05.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 05:56:09 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:56:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190703125608.nl72umoinhg2kh6k@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali>
 <20190608111553.65s6yoyhmusmr3pc@pali>
 <20190622161837.37mjlsirpoql2plj@pali>
 <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
 <20190622170933.lxuftoxmvtv7ssfo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190622170933.lxuftoxmvtv7ssfo@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 22 June 2019 19:09:33 Pali Rohár wrote:
> On Saturday 22 June 2019 20:01:15 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > I think a better idea would be that we introduce something specific to
> > that, such as the SEID being returned so the next time around you may
> > restore a SEID, this may actually make more sense perhaps if we reuse
> > the RegisterApplication semantics:
> > 
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n464
> > 
> > That means it is no longer required to call RegisterEndpoint as many
> > times as there are endpoints since that is time-consuming due to the
> > D-Bus round trips, instead, the endpoint are discovered with the use
> > of ObjectManager, if the method doesn't exist then you just fall back
> > to the old mechanism since it might be an old daemon.
> 
> Hi! If I understand it correctly, pulseaudio would register itself via
> new dbus method and bluez daemon then discover A2DP SEP endpoints
> automatically, right? And if that new dbus method does not exist
> pulseaudio would know that in system is running old bluez version
> without codec switching support. Seems it is perfectly fine solution.

Hi Luiz! Do you have some patches ready for testing?

-- 
Pali Rohár
pali.rohar@gmail.com
