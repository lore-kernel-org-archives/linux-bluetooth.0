Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F5C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3F20702
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 09:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="pjzgCxmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgA3JLJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:11:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42486 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3JLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 04:11:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so1756929lfl.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 01:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3B4ibiHb7NTG9vF5ZYLUoT6G4t/vaeI73uTmakMo3II=;
        b=pjzgCxmAKnLQgFTruuwgOfFayTrNd+4s6RQtzH29cmqkA9aKWgtAis7ZMSe5nBqK+6
         oVMXDW45sDucbcb3w5I25Uk6XhmsUjn8f/YbcM1wsDu/gzRQS5H7aTcbUOBfnsdQWZG5
         joJnkSDQmGn+qA1/J2aD8wrknPVHFw+0GX05szPI8FnAkHVMmHRhh28fyo29MUNzJz7F
         8I+bEFGkmzZgPwOjjZ+EXRXxPljcqE41nnpwuEU/eJDB30YrrM4MW2+75B173Iqo2hoc
         vIoZNkISxlm/RmUa75M36nXoXETCXRNJ80ossz3F6wXRTJj0L+1ce9HU1EqMNJI5DSCJ
         DW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3B4ibiHb7NTG9vF5ZYLUoT6G4t/vaeI73uTmakMo3II=;
        b=UStXrgASFFQJ+qF/RN65aelUh37hgU2MziCSjtYtl+YozeHWApgNA2PHySB7A/FWOl
         1tHL2d+m8YU0gX8cIod061u+asXYgviSQuBCx7sEP4JAk7Iep9BEGmNB4FtT3njQW/eg
         Z+rdmMK0X2ZQpVK4DgYnLxJ7KB89vMHr2SU9Bj12vthjUirRNdgV3VsLlVA8jeXestPb
         d9q7dAH1Hy+UjeVzEP5N6iVWcM1zA/2Xw6U1uhrtuBFDfoIIBlcVyTMAeHI9MafjYgoF
         1A7qC9dL3+XRoS1VtoULLCJXC48kFPxhfEwz8tvNgsOZ5hKMBsicPV1aF2sUs8jBXFFL
         oC1w==
X-Gm-Message-State: APjAAAVNnlhjX/b4u3G9lBZ+uX6gRBaL5xKOOUGx7XCy3oPDYHRqfqWo
        I9ievIpSOTbkSyk8m+A2BiOMjW0eKXw=
X-Google-Smtp-Source: APXvYqzVQrt2i00PMwX8h6vo/+RfUbbAeUhg0g9r3Gzl7WMNOV6+0Ys/J5iGy7KZ99NNxH8yi0CObQ==
X-Received: by 2002:a19:c014:: with SMTP id q20mr2076974lff.209.1580375465426;
        Thu, 30 Jan 2020 01:11:05 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e30sm2406011ljp.24.2020.01.30.01.11.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 01:11:04 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Add missing HCI command error code decoding
Date:   Thu, 30 Jan 2020 10:11:02 +0100
Message-ID: <92965788.m85OPsEE2A@ix>
Organization: CODECOUP
In-Reply-To: <20200128110740.41133-1-szymon.janc@codecoup.pl>
References: <20200128110740.41133-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tuesday, 28 January 2020 12:07:40 CET Szymon Janc wrote:
> Packet Too Long (0x45 ) status code was missing.
> ---
>  monitor/packet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 6e7cc5e85..07c92ca07 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -519,6 +519,7 @@ static const struct {
>  	{ 0x42, "Unknown Advertising Identifier"			},
>  	{ 0x43, "Limit Reached"					
	},
>  	{ 0x44, "Operation Cancelled by Host"				
},
> +	{ 0x45, "Packet Too Long"					
},
>  	{ }
>  };

Applied.


-- 
pozdrawiam
Szymon Janc


