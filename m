Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1BC4360C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF4921721
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KFK3zbxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfI3JM2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:12:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39835 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3JM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 05:12:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so10345382wrj.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2019 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KtrSaaBbPZQDwU6iq3EZ90XuHfy/QDirjK41HPoMg8o=;
        b=KFK3zbxJwhEZWNBicGbIdat6ZEIM8eu2SeLT7JCI6y2LiX13lg2C25YnLkXD7lou/x
         uYMbN77T/S8ix/BkvJ7Xj1Es8vHp+QD/ftIaV14/l8RbcoaQWUj8YbVsyr5ySuPRVovP
         ZbaOQs4oaeXa0Ve9fluUCSljRH+ck5wDspS2wNryReYJWw5PNg4ySf0FfYiChhx+LHQy
         DHu4/J5tIlLt4sDMXCEGz1sC5pWNCRWnoX+CZxIB7p0l0vITfpPM/9GPmXX5Wj2gx3DF
         kdDG6RHof0Jtx1GpR4PFW4jGe19Oq35BdJ8QBISp74SPrA2hCuKZib/Jgm2Xvb8NGBMg
         vZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KtrSaaBbPZQDwU6iq3EZ90XuHfy/QDirjK41HPoMg8o=;
        b=q80I4dZcOJTiDTWqhC5mRTcAaYcR8MCTs4yU9Jp0tUru1doxwmUQV54XxJ1cb+oAql
         kvnc9fmBdJMh660cyC7OOgpUO4LQOKPMvejZtf2tIKUdH1wqTMAmbzZakAmqGeQBmN7R
         FEgGpsVzrLFOWTjHgyjBtO8OJzaEBO1XT4W4mjILKG0Zg4Pe089y0E7VB81cg0nxZleT
         /2CpqHgQFNrykH1NQM4AkNDrH+9hU1tAURFAvYPyjwUcLacT48aXHnQ8TZpgVXksPSXG
         aTI+d5Iuct5HNcwvX+0pOrR+dFgHyl5LThHlISIWQHbK/GBQJiOgiWWK8PS7eaxf0HCH
         m7Lg==
X-Gm-Message-State: APjAAAUHk+dvuCxlJROMworYcSPLJFdcxbtB2WoImn/dcSJMbrYT9ODY
        nROd5odq4NnyTaKBtiIyLsiFogE07tg=
X-Google-Smtp-Source: APXvYqznpQTahP3p5uEbjtjgqbWGB/IVGdWS7DVGvKn2aVGRX1nhIchdHRJ5IUyzP7qDFU3FQ82SZA==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr12488331wrq.305.1569834744169;
        Mon, 30 Sep 2019 02:12:24 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x2sm15967808wrn.81.2019.09.30.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 02:12:23 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:12:21 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Message-ID: <20190930091221.zr47jb2qeoiwqp6w@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
 <20190917065513.ibenc7hxd7x77geg@mlowasrzechonek2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917065513.ibenc7hxd7x77geg@mlowasrzechonek2133>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 09/17, Michał Lowas-Rzechonek wrote:
> On 08/19, Michał Lowas-Rzechonek wrote:
> > This patch-set is a cleanup of redundant and/or unused parts of
> > mesh/crypto, making both the usage and the implementation a bit
> > more consistent.

Ping?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
