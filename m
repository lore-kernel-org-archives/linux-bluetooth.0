Return-Path: <SRS0=2Aeq=X3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2450BC352AA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 11:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B0E21920
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 11:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="LKMf2vN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfJBLYV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:24:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43564 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBLYV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Oct 2019 07:24:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so12431484lfl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2019 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIVAhEc+aED2PL3PFqTqxHnMKJi7xBN6y9veQCT8VAw=;
        b=LKMf2vN4zDiFfwnIylNQWlOmyEK224w0Tz4Gig8JHkIJMHWLF6DBGHrPG0PMhuv9j0
         WhMHJywsTrNHVJPFLLbJNDgvflh9/pN/Bem0wAurZ6J8OrZOb5Sthu1nhziP33cx4ODH
         xXlcvaHgx8NuERvh9vW082Yc0SUHqTXpTgkv4chCtvIgQPIJb2ewnu0Y2E6MC8LMmf4Z
         nk9x6ebxFa8rYW+U99RTEJmG9P+7zXQjV4jcBQ9dLv9EghMBG/8rHwAQBbAvgKwfwbjF
         039UiWAovZEOTQ6CGsvWz6lvgCm57w5BtpQ/pEQNtcGzKTuZse2jw+YrgBo6ISZCJy1S
         WkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aIVAhEc+aED2PL3PFqTqxHnMKJi7xBN6y9veQCT8VAw=;
        b=PsvcvzcQRMAEwWb8OhDa9+GLuIQUtW6OREYeEbgtbLmh5G8SRGc7cQ9hfUizGLqh7V
         Z2l1PNrQvYUxVF+EpwL5ASPFQLn/Jse7/HJpHyidbvgxPhkTxPudURYdihnyUzbff5n1
         wStCX4ZmmbXBo64+xdrB7b5wVmB4ucgRNAshhnOHjyCve/2dx8dyzfUkyH/N5cw4Op+W
         BRNmFICDnibGkvewzPFlQxBaJXTfQlJcBk5cOCjgEXozly6qZNLiJMijAeLVtVeSiuog
         YfkBN7D4daBLxKsSjJ4bjJZ6kh06z+zkZoS7OsN7nKr0p0hSHDo7Mu2+pPvkZ9vPp8Dy
         jIog==
X-Gm-Message-State: APjAAAUQQ04cZCMhdrP1+guoBbZHfWJfCb16gw2yUP/IhN80AorX/HPR
        +0m/kIOSnKz+l8Gl8JzjR4/yCsXU324=
X-Google-Smtp-Source: APXvYqxYMH/SPab4yMw+bncNWalv7KLSl/4QQO0yWVA1b/HQcJ2p1Exe/DjlBl9raQcXdo0GSQB1fg==
X-Received: by 2002:a19:c396:: with SMTP id t144mr2069234lff.14.1570015458805;
        Wed, 02 Oct 2019 04:24:18 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q11sm4610884lje.52.2019.10.02.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:24:18 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Ordit Gross <ordit.gross@orcam.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: recommended way to register on bluetooth event
Date:   Wed, 02 Oct 2019 13:24:16 +0200
Message-ID: <1580531.MKZco2byVY@ix>
Organization: CODECOUP
In-Reply-To: <CAB+bgRaH+Vw1xDNQdOuG26v=QPvnporuo9waBeoxi7NTUE+8YA@mail.gmail.com>
References: <CAB+bgRaH+Vw1xDNQdOuG26v=QPvnporuo9waBeoxi7NTUE+8YA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tuesday, 1 October 2019 15:36:19 CEST Ordit Gross wrote:
> hi all,
> I would like to register on encryption changed event.
> As far as I could tell mgmt-api does not consist of such capability.
> I think that reading from an HCI socket may enable me to read all
> events (and the needed one as well).
> is there a better way of registering on encryption changed event?
> 
> The reason I need this capability in the first place is that I want to
> enable repairing if BLE Peripheral Removes Pairing keys.
> currently, when the peripheral deletes his side of keys and attempt to
> connect to master, the master will get  encryption changed event with
> error  "PIN or Key Missing".
> that's why I want to be notified on application that we got this
> event, so I can delete my side of keys as well..
> 
> any suggestions?
> thanks in advance!!
> Ordit

Ha, I was working on that few years back but unfortunatelly it never got in... 
mostly due to objections about dropping old keys before new pairing (which I 
don't think is necessary with proposed Agent consent-based approach but others 
were not sharing my view on this ;-).

Kernel part with reporting proper error to userspace is done so userspace has 
all the information it needs. For bluetoothd I've sent RFC [1] which might 
give you a bit of headstart while working on this. In short, it extends Agent 
API with new call used to consent re-bond of remote device.

[1] https://marc.info/?l=linux-bluetooth&m=147031736607899&w=2

-- 
pozdrawiam
Szymon Janc


