Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE71C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 09:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19122084D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 09:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="xtZ0/L9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfBYJMK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:12:10 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:40184 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJMK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 04:12:10 -0500
Received: by mail-lf1-f47.google.com with SMTP id a8so476659lfi.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 01:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIfOag/HCHyjWgLtXfiDu41Iqe9eWxtpSGBQZshO4Ho=;
        b=xtZ0/L9I1i7O+K6TB8pecoAbRYd42Z6y9FULj6LWAdBeTrHH4UtOiqVhcSaTWjJmj/
         ibCzyZRhf7SFVwyJVzEp5eVLIHeOax1sH7C0Lx/z7qDBDxBBajpf8YHgLMs0CO2Wr3Nr
         MEh5yUeRFNP5hYMbnyA/QJOkzdp8YVyXyLi6jfBUZ1Pbd7cprbAYmYSm4e0v7oK3LFmB
         CUxvN3CGPyDujGV2ZD/3J2PPcWwrGg8qwNXR8Nk0Hc+q0P+jqBQOgA968By3SyAJ+EjK
         +71Dd7hyn3RHCj/HK64OrqUNfvB8sMnvFkfuREoiGNZtTKsocA0ItN4RpUqTFbinBalE
         7U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PIfOag/HCHyjWgLtXfiDu41Iqe9eWxtpSGBQZshO4Ho=;
        b=nVHkGqYw2kgU1X2Mjh5cu8F+nhupjX/eLsjoVQMh7HIgnn44PfBrfnl6n6a7YyeIqV
         2QmarWf+6412osVA0cce8iV+kdYWxv23IjmdohXQC90H+5I9UZRNV/2RBG3FuALp/niZ
         xekCf6eUMsIVlnvMqssxzP8IQ7hJ/kmWz4eFa9utkGVNEHWiiZWfM9DEuRzsBHznJ/KA
         iFhYUZsWrr5hrbzZaUUb9QOsNMjLyqgAI1DjEh9KJkRz4svyfj4pAmb401ulNL07kUTJ
         jlFAcplUQPqHrsS7qi7EsTpBtTw6JEnCOKe578povY/IQJ78H/PROFAQm4uX7FGTDdcp
         Z44A==
X-Gm-Message-State: AHQUAuYCaJ7zQEozLi9dpxwEWhNDKczAnmgZSJcWRGqMVV7uXycj8j77
        xek1SKbtsgioOxeDh5DFbc7aiI3mEns=
X-Google-Smtp-Source: AHgI3IabdIhK5kmWe1hF9g8DR9/1necWU0Y9CHcNDqYJWkIfBGXWwAwvMzMmwicA2CI/QgHktxHD8Q==
X-Received: by 2002:ac2:5286:: with SMTP id q6mr9781124lfm.119.1551085927701;
        Mon, 25 Feb 2019 01:12:07 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 4sm1551616lfz.94.2019.02.25.01.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 01:12:07 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Edward Jo <challenge.jo@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Does BlueZ support the LE only controller which does not have BR/EDR?
Date:   Mon, 25 Feb 2019 10:12:05 +0100
Message-ID: <1576789.oDElsqhQaV@ix>
Organization: CODECOUP
In-Reply-To: <CALGdn=JFB0yCgWmmo9iMF740wpUapZ-6rU0OKcF73mM+Xw7XbQ@mail.gmail.com>
References: <CALGdn=JFB0yCgWmmo9iMF740wpUapZ-6rU0OKcF73mM+Xw7XbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Edward,

On Monday, 25 February 2019 09:04:17 CET Edward Jo wrote:
> Hi,
> 
> I use CSR chip that support dual mode as LE mode by setting
> 'ControllerMode' in main.conf to 'le'. I'd like to use LE only chip
> which does not have BR/EDR.
> 
> Does BlueZ support the LE only controller which does not have BR/EDR?

Yes it does (I'm using it with nRF52 based controllers running either Apache 
Mynew or Zephyr). Also, starting 5.44 it also supports LE-only controllers 
that come without public address - bluetoothd will assign static random 
address in such case.

-- 
pozdrawiam
Szymon Janc


