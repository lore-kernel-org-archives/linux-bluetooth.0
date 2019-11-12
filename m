Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F6C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A012084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="FJ25BbWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKLNsd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:48:33 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38406 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLNsd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 08:48:33 -0500
Received: by mail-lj1-f171.google.com with SMTP id v8so17870376ljh.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAgb4RJXfcmq8pojNPfFnTkebO3OMW3FNrY7Zv/bKdo=;
        b=FJ25BbWBZ9SzDm7wQQCBKHDWTVRSvGYMzHBuumdkuimHONoMcFiXFhlMMAwspN5eRf
         sRBHod7NqAkfWKGJWvuTAh6QnmIDxlozSNfANqYzuvk+1sJnjtNiocH/CTM4LrAb+p8H
         /GnhASdh29JY9ljUuq0Kl0TMu2jbSCX2mRBevNYIzDTnl9mJ6nMIPWkjcIQW2tUALgAm
         MxT3ub54W+5ZQNsvCQKZeR6JR+1uqVqCKXww69Y6DSwBLSS/pq7oawdbziskogkAbicx
         p0tgBtGVT2cHw3iyJgsP7OGjfOhI2qOC2Ollqud0OSS+t/w72ppoeJbEx0leSNQpuj8X
         b9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IAgb4RJXfcmq8pojNPfFnTkebO3OMW3FNrY7Zv/bKdo=;
        b=ekm9KMsUszNAuUBPgFTK17vBVptr7fjfVOY8Nrxf2LIQxJpJZ9SEE40Nlaji+fEh8v
         qtFHXrZ998mXKtDcxHamwPYLhqWmpUTw9WMb/6DYor6jOshncZZTDP0+wN3KOpLwEKQH
         osXKH8GyXJK8UdoiMetytrcHpfJK0NlUgeHG+ZrXIcU2G/Yy3dA6X/sK5MTLCAw1rUmj
         1yeFQN+ly2vtdkE8ACVpoHTZPXorZ6BfEzEAWkS4DU6K3jhWUY6smCcnZaTpYLo05mn/
         Hp0QNYKmcHzyQ+W1xaqqweS2Vwp9FtWmeRpDDnbdiw7K1dA+nKii1YpXdn3Ix0ZrvYNr
         DTHQ==
X-Gm-Message-State: APjAAAV/IVZrQpJ3KTG2v9M27jg5qunK1qvhscIKu4pbH/7/oHekdJvs
        rGrlgtFVFnU9udLm7NVSvlUjyQ==
X-Google-Smtp-Source: APXvYqwmgO9ygy0TM/sb9u40T1qIF3wY9SbdskuqvyCvI//ud87D4UacvISlED1nuzFdy1sa1NIrsA==
X-Received: by 2002:a2e:8ed1:: with SMTP id e17mr12489075ljl.52.1573566511071;
        Tue, 12 Nov 2019 05:48:31 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id k19sm10376145ljg.18.2019.11.12.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:48:30 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     =?ISO-8859-1?Q?Krist=F3f_Horv=E1th?= 
        <horvath.kristof.attila@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Simple SDP and RFCOMM example
Date:   Tue, 12 Nov 2019 14:48:29 +0100
Message-ID: <5852113.xjoqjODIPz@ix>
Organization: CODECOUP
In-Reply-To: <CAMGddftdorPGAzJbQzwLbaKNjfSrbayzGzKFb7iMBSwNQvsf7g@mail.gmail.com>
References: <CAMGddftdorPGAzJbQzwLbaKNjfSrbayzGzKFb7iMBSwNQvsf7g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tuesday, 12 November 2019 10:15:38 CET Krist=F3f Horv=E1th wrote:
> Hello,
>=20
> I started a project with Bluetooth, but most of the resources on the
> internet use older versions of BlueZ (and often mention using
> compatibility mode to hack the legacy code). I think the reason for
> the hacking is that there is not any tutorial for BlueZ 5 (or it is in
> some very hidden place). I browsed the page
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test for
> examples, and I found some interesting codes, but I could not find
> what I was searching for.
>=20
> I would like to see a simple Python code that can register a service
> via SDP and receive the incoming RFCOMM connections. Could you provide
> an example like that?
>=20
> Thank you for your help.

There is test/test-profile and test/test-hfp in BlueZ source code.

=2D-=20
pozdrawiam
Szymon Janc


