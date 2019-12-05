Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A6C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE05224F8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccwykkmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEJcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:32:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEJcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 04:32:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so2594083wrw.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0gmWUy/i/NQqQwf/lpUor9kvfKc5K8gV+ySvh6DbSiQ=;
        b=ccwykkmKPAWZvHySqdh+LZUVZF7Akt/awiqQjJs2bEcSE9ChfrKGpzAqwqUZtoyeYV
         lrg+tFR4GxQUGi95SKxPeopHJ1MwHGhaEIZDKSZBVHD8KHakpaf2uMkS5NQ40hlzbggG
         NPfManlD4mUjPHCtVLXdz3IC6e/TvfCsF1z7ZJkdXdvRymsBVLNFHcNrAeid8a9fOd5m
         z3okB41Ay0Y6v6UWxFjD2VcgAqjuDrxdWehmlYttf+K9J9Xte+6VyDukS0U8A5zNiWFL
         Obc7GlcsZ8JQdWqeuh5SSMuPj3z1BaV1A41LGxpazA5JTHCki9drA3IXXnke/pV5JC3c
         tMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0gmWUy/i/NQqQwf/lpUor9kvfKc5K8gV+ySvh6DbSiQ=;
        b=pyOtjiMkEQMp/wYvUZE27XQ672W353E4t1P2dBZzMdP1NqxT9QUzPuC4o3ElBFed5P
         130jgroGN29jkkQD/qlCY7bvmboD+2ttsOmnwR6iknkHoYIjeTBhV8gcd9uTM/QNCw24
         dw0eE/X1Dl2Ax52Xe76TAjFm4c7nDVupA+pvjgKHSSQOJEZnpSUpziIpyIyarBrLnG7Y
         vAjFCaN7ddSHg1C4yAzFAyyQ1RUWTy1JHYNWURXx0Vm1rpdu1YyAoJjP4Z4f87HR/JJ0
         MdcpmArzUlXuHBOuVXOXTBNR6OSSBJrKtNGmSm37cqXPGrYmK1Cho4FxGWqKbt+/47KH
         FVaQ==
X-Gm-Message-State: APjAAAVLH5y5Q9dkGJ4p9Lstk/0KFG8M71NDTsy+4Dm5EY+4zoUlCZTY
        UrBdbCfLj15OBdagFJJfUjS7vx2C
X-Google-Smtp-Source: APXvYqwyXAbFJaf+L3erwHssOgXBLs1dCEEs5MHHJvf8j6i0o2GTynXXs+988mhSL+JqjzoIJWVVCg==
X-Received: by 2002:adf:db01:: with SMTP id s1mr8426746wri.372.1575538322043;
        Thu, 05 Dec 2019 01:32:02 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a127sm3139239wmh.43.2019.12.05.01.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2019 01:32:01 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:32:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191205093200.x47npi5sxtcphr2o@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202184512.rx6p63c6axztnwrw@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 02 December 2019 19:45:12 Pali Rohár wrote:
> On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > I think hsphfpd should be part of bluetoothd, but if that's not
> > possible, then that's not possible.
> 
> I do not know if bluez developers are interested in having this code as
> part of bluez project, specially when in bluez4 HFP profile was there
> and in bluez5 was HFP code completely removed.

Hello, could someone from bluez developers comment this Tanu's point?

-- 
Pali Rohár
pali.rohar@gmail.com
