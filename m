Return-Path: <SRS0=QTJ/=UM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD0DC31E45
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623062175B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="R4DCkEnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfFMPjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:39:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36154 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbfFMJy5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jun 2019 05:54:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so17905394ljj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2019 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bo0tl4a9UGSBPcbP4Y30bgplmG5Z1+NSNsMybiRZb7I=;
        b=R4DCkEnd4Y3yQO97WipeO+Sc/LyC6XTodOrHDEvFCknwoHSWzdBGOoGSFwlYs/DOMY
         TqHJcCaroG9/bnMCpg74iMM4CFP6KzveOa07a/q5ZflJtUHiDFmsrBP3tDpjm0mKEHuo
         MnYmexQ6QZ834yU86BvoGdqNCbeq9BoVqVjYsyuewPrwc4TRDUf0BlcNY+pYdFSuRIXo
         h0lBMYmkIusX9aLkCAXSF0YT3u8cg+efrsG052OlxM3ZR9CcE2YE9Wdf527lI8ij65zN
         2PsZLW+6lhn4IyXPHiCtDXj0dD02zk2u5XKLAzceLuJTYuhAKZ+2LmnkhNNyMIP9eWE8
         JMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bo0tl4a9UGSBPcbP4Y30bgplmG5Z1+NSNsMybiRZb7I=;
        b=lovG4KlreJ6hbIgLYz5gjVnmwhFITwWP3FPiirnqqkDHQ9LW/nQrov4VncrmzfEIpZ
         blPrsZI4fTgpqi3pms/rxmca3oEm//dwjAjQVdb4/grr5atDdiPtBcJv3p7QSyIvpSi5
         OcNi7Go6OvadmpMr0z+PlZMYu1Z+SBn6wxiwD/9jNW1JXy0XAK18xnFn+StsdZygsBlZ
         rfvFxJONU/fVzA/VI3jLn+mtNSwDjLTknjoc5HuxQ2TD1QPo/pSJn5hvqmhvtjZBx2Eh
         KhiaaUm4WVHrsOexEU6gWpl2MrAA0bs3O0X+qv8r5OowtyvHCOC1rK/mGjZHxRSik3H/
         eeag==
X-Gm-Message-State: APjAAAWeJS8/WHhCmgpD0cPxRXaWCtbU5A0TM8VM5FNlrKV7hNpydYJU
        qhjMpB/QCdP9lKqb8hU3bdtQVAXmIF8=
X-Google-Smtp-Source: APXvYqzVuN0VBstuICWqF5aGrT8wmRdtME/OV15Io4xfPTvXyi0shr+LAV0TDl4yXhMeyO6tYQ9fWw==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr27382036ljg.33.1560419695304;
        Thu, 13 Jun 2019 02:54:55 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id z12sm502317lfg.67.2019.06.13.02.54.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 02:54:54 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] sixaxis: Fix another problem with already setup devices
Date:   Thu, 13 Jun 2019 11:54:51 +0200
Message-ID: <2507772.q0OjLXfh9R@ix>
Organization: CODECOUP
In-Reply-To: <20190607065411.28502-1-hadess@hadess.net>
References: <20190607065411.28502-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Friday, 7 June 2019 08:54:10 CEST Bastien Nocera wrote:
> If the device went through any kind of pairing once, it might have been
> set as trusted. Make sure to set the device as untrusted before starting
> the cable pairing authorization so that we don't exit early from
> process_auth_queue() (which considers trusted devices to be paired).
> ---
>  plugins/sixaxis.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index fed68d2d8..12638829b 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -365,6 +365,7 @@ static bool setup_device(int fd, const char *sysfs_path,
> 
>  	btd_device_device_set_name(device, cp->name);
>  	btd_device_set_pnpid(device, cp->source, cp->vid, cp->pid, cp-
>version);
> +	btd_device_set_trusted(device, false);
>  	btd_device_set_temporary(device, true);
> 
>  	closure = g_new0(struct authentication_closure, 1);

Both patches applied, thanks.


-- 
pozdrawiam
Szymon Janc


