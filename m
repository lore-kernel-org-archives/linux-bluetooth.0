Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2AC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839421734
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 15:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="dYBn0U3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgACPEF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:04:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgACPEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jan 2020 10:04:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so44160203ljg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jan 2020 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t49neiQJNectuU8847rj2bKZr2MdkqK+XPSJMrr9dsA=;
        b=dYBn0U3clFHii3YgTrQ5OfQl0tU9/BTm0KK6iGfO8kjlrlVAD1C/17KU7Tu49G4w/X
         kP1kY2EDT40+He6VIMsxCmHKHUFl2NGxqG+7f/Ko0vfhzSrhmLwFKkRHtn8b4ryHSRhq
         krFDajToDsrHwln9B7lkUYPRyIEcrMR4QnaflEIIkdCF8+SkbyJmI/4CnoOKkDOIEtno
         /8RD54/hB6XT+2t6BKAGwT4nCARo2To05wVwhevPm2jP1zAvccLquidGiUQGB7Ob1tCt
         owoCF0w0bJGrF5kG+f9hDxCzrHkTdPYnkbIvbqjRCQBB4WtlSC5lO23n8tffdMpeYT9d
         1Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t49neiQJNectuU8847rj2bKZr2MdkqK+XPSJMrr9dsA=;
        b=IE7rpabGFZOhFZ90oAG2pB4ae4+n+3egxmVnWFuHg/hoevZQBI4K0T1hE4qVG3LZ+N
         kNQKaMI8qGk5vkN0NJ7jISKeWJsCi/iP84RnPAJgzHEEE5tSogfQZue3YKn3KIqpto3m
         gjBk6+/+/sYvNCeBD9v1/c0LMU2vhXWua0DVPkdj2DUA3pNh+tggaliKiHfH5YBpy00F
         gnnKfKD24UIfOD+81al4uZD21vMIZJO1KBh+CPUhXL2qgRBrrpQYv9tSjNkd/darUhnR
         5j9AbgL1TbjOscHLu7dqvwp3JGRT/D4bdr15vjCsbDHp8WJwk1y9kLqhem4LPwFjXdxt
         4Azw==
X-Gm-Message-State: APjAAAVO66D90/OtcJrUOCdKL3R7q+UPupb/fz/hSCQDVyU4f0OfKRCy
        WR3BExFnn1YK14GSUROQgS6T2Q==
X-Google-Smtp-Source: APXvYqz9XgsT28OP0dmlL8+OU94FUbSHM5vPUpoUoDE46RCeI8DoyUbLCoc+Es64mwKIlgXxJH+hLg==
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr53278185ljo.32.1578063843528;
        Fri, 03 Jan 2020 07:04:03 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id k24sm29268083ljj.27.2020.01.03.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 07:04:02 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Eugene Lavrenov <evgenilv@yahoo.ca>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluez - sixaxis connectivity issue
Date:   Fri, 03 Jan 2020 16:03:32 +0100
Message-ID: <6025610.be7RYOikER@ix>
Organization: CODECOUP
In-Reply-To: <1965121078.20191219234808@yahoo.ca>
References: <1965121078.20191219234808.ref@yahoo.ca> <1965121078.20191219234808@yahoo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Friday, 20 December 2019 05:48:08 CET Eugene Lavrenov wrote:
> Hello everyone,
> 
> I have discovered a strange problem with Bluez. I have two Sony PS3 clone
> devices, which I tried to connect to LEGO EV3 (slow ARM device) powered by
> EV3DEV (ev3dev.org), which is a Debian-based OS. I used a Debian-buster
> version
> (oss.jfrog.org/list/oss-snapshot-local/org/ev3dev/brickstrap/2019-09-08/sna
> pshot-ev3dev-buster-ev3-generic-2019-09-08.img.xz) that includes Bluez 5.50
> 
> It became possible to connect Sony PS3 clone devices after the following
> change was added:
> git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?h=5.48&id=1629c39ededef0
> 7988a5403b27331e0e317f1e08
> 
> When I attempted to connect a single PS3 device, it didn't connect. However,
> when I tried to connect both devices at the same time one of them was
> connected, while another one didn't. The problem occurs each time when I
> attempted to connect these PS3 devices. It is shown in the attached
> "ev3-bluetoothd-log.txt" file. Here device 05:F3:77:B5:63:25 unsuccessfully
> attempted to connects until a second device 06:2A:94:A0:63:25 attempted to
> connect at the same time (line 35). Then device 05:F3:77:B5:63:25
> successfully connected (line 41), while device 06:2A:94:A0:63:25 kept
> trying to connect without any luck.
> 
> I tried to connect these devices to a laptop with Ubuntu and the same
> version of Bluez 5.50. They connect without any problem. See attached
> "ubuntu-bluetoothd-log.txt".
> 
> I would probably add more debug messages to see what exactly is going on,
> but I don't have much experience of compiling such projects in Linux. A
> Bluez package that I built and installed myself on LEGO EV3 device using
> these instructions: git.kernel.org/pub/scm/bluetooth/bluez.git/about/ 
> doesn't work.
> 
> I am wondering whether anyone can take a look and help with this problem? I
> can definitely assist with testing or recording more logs if needed.
> Solving this problem will allow many kids around the world to connect
> inexpensive Sony PS3 clone controllers to LEGO EV3 robots.

My first guess would be that sixaxis plugin isn't loaded.

Could you provide full bluetoothd log on ev3? One that would include pluging 
in DS3 via USB and then connection attempt over BT (preferably from bluetoothd 
start).

If plugin is loaded, would be good to grab btmon traces from connection 
attempt.


-- 
pozdrawiam
Szymon Janc


