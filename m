Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E5CA90AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 11:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA2520659
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 11:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="PDV6876q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEMLDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgEMLDd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 07:03:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFADC061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 04:03:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d22so7214814lfm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWg7cNImP9jZrfRlq3wIimF92mlBYcFyu3ErzTt+1ls=;
        b=PDV6876qSIc3mhqKXDHAABMnEzkKP1gMKNolfndfIa45za3ZqiBJcKgyC9WhHg3dee
         mGsHF1CTZlVKa3vqB0FWF7B6PqYIb4afpMGgPaZpJcj+sILl2BFYlwAtknAs4Sj0eVJn
         fP3OSPGrvR9YbtvsPRHLlBr1CjmZNmO66iKdYCI3FaEWtb5KAgp8S7DTyx38fL+I1g49
         3k9ykNeFtqA89+x7rjLndk/2g2S77fi7+HizBNgZmRyYzGfo8gG37STYzyQk/I3fq3/y
         OsANbACXZ/s5H3rysyPl4uEj+Ux/TyPVtvouue7Bhcb5RGnZv3Vo4cX+tJ2Ox8eZiMgu
         anNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xWg7cNImP9jZrfRlq3wIimF92mlBYcFyu3ErzTt+1ls=;
        b=BUcXARNPcVKTEE8XtII6GuHnL/wXxwaRrOG5kNCM3/Gd9A84VCCPwOxnx67Qiq5Pmn
         HFDYNelJIU9X0zEiLh5C41QcqtA8ZdITZWh1RrJBLSsLf9aXAnogJqTnxiTVpLSXQtys
         qJ7b/gWSEGCtmfus6Y3FMDPLSGXyGZMY/j7i2xYmADPoX47ohAabPZKGmhvuZ/fakz9g
         2iUUDzSWDF/+Y3q1rgbUA9z5yiQcJaf7bH25ZRLOOzdmuaZqhjViPDSJ+ZGxBJNMttPl
         sjGM3gAc6M5cUo+TQ15rpnfzf6CKfET4vQWpvK0Ty63gah5M0hEGZ+UV6uxLjZaTt+Eb
         uBvw==
X-Gm-Message-State: AOAM533FQT4NzV1jpPiCYkNRbVdE78B443Zf/sYdwB1589Vw8QqmzbHG
        U3gst86i3WhvgZ/8YcJ77wFmHyOizsE=
X-Google-Smtp-Source: ABdhPJw4TQJqGYIuiGFToVgIOy1TxoobiHu+mScs5267QdjzeJGCVzkfqb+2KstJ8p7LECPFv00MWg==
X-Received: by 2002:ac2:5384:: with SMTP id g4mr17770864lfh.1.1589367808338;
        Wed, 13 May 2020 04:03:28 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id s7sm14978991ljm.58.2020.05.13.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:03:27 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        =?utf-8?B?xYF1a2Fzeg==?= Rymanowski 
        <lukasz.rymanowski@codecoup.pl>
Cc:     =?utf-8?B?xYF1a2Fzeg==?= Rymanowski 
        <lukasz.rymanowski@codecoup.pl>
Subject: Re: [PATCH BlueZ] tools/btgatt-client: Add option to set BT_SECURITY_FIPS
Date:   Wed, 13 May 2020 13:03:26 +0200
Message-ID: <4555946.31r3eYUQgx@ix>
Organization: CODECOUP
In-Reply-To: <20200508132349.6495-1-lukasz.rymanowski@codecoup.pl>
References: <20200508132349.6495-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi =C5=81ukasz,

On Friday, 8 May 2020 15:23:49 CEST =C5=81ukasz Rymanowski wrote:
> Need for GAP/SEC/SEM/BI-10-C
> ---
>  tools/btgatt-client.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 82a9e3fe0..bc762dba1 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1492,8 +1492,8 @@ static void usage(void)
>  		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
>  		"\t-t, --type [random|public] \tSpecify the LE address=20
type\n"
>  		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
> -		"\t-s, --security-level <sec> \tSet security level (low|"
> -							=09
"medium|high)\n"
> +		"\t-s, --security-level <sec> \tSet security level (low|
medium|"
> +							=09
"high|fips)\n"
>  		"\t-v, --verbose\t\t\tEnable extra logging\n"
>  		"\t-h, --help\t\t\tDisplay help\n");
>  }
> @@ -1537,6 +1537,8 @@ int main(int argc, char *argv[])
>  				sec =3D BT_SECURITY_MEDIUM;
>  			else if (strcmp(optarg, "high") =3D=3D 0)
>  				sec =3D BT_SECURITY_HIGH;
> +			else if (strcmp(optarg, "fips") =3D=3D 0)
> +				sec =3D BT_SECURITY_FIPS;
>  			else {
>  				fprintf(stderr, "Invalid security=20
level\n");
>  				return EXIT_FAILURE;

Patch applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc


