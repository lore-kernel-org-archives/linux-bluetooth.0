Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A348C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D058120657
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="WHPOYbYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D058120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJ3SOg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:14:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35451 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3SOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 14:14:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so6408718ljb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Oct 2018 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moxRxeoiQrILAzxewJz7sp7qmbe+aZlJlipm4UhOj+k=;
        b=WHPOYbYejky9KqpLPtLYVIvhSAU8gQ73jzTmZ9BUP/kvIXSw4cQKJ0GwZp+gL1iRYn
         BkLxa2UATunB9cPnBFrPUrtx+2BerFSRr8MMtAkG+P/2HGGHg0Y6a25Pb1QIxPdLVLJH
         qRxmItMTRPZD3OHa3bGpT0f/qGD1T+MfmkAAyJ3VQGru+ubUaz4WN0SZwdROrhy2vDSq
         +aK/9kKxdljIhbEmk9jeUnGSp8SWvWtlaGAGr2OjEI5X1mlKb/KvmLvfLJl3cu/qasxT
         mV2XZWtasdyhT1BtaoNu1A7KgGA0Gt8zWRa1w21rP82XpzNAv+BVknZyBVd2EQj6g+kq
         SVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=moxRxeoiQrILAzxewJz7sp7qmbe+aZlJlipm4UhOj+k=;
        b=Zs36FiY4jI4CRmOgcxCaUm3JCCIdZgJau+GedZQSScEjamTRjPwHq/p387v1q3Cjhf
         BlJmVQkBtUmcJQR2BCaNj7aaiifCTFWEJ1Ym+B8IaULlg7HR9XVtlYQJJmtxbWRnF9Ng
         6H/Fuo03AbEtxZyTzfZt90wuyC2KZF8xZP5FSteHrizB+b7ko9Fkq/7M0sVFlcW4HDAL
         1bFC5TkyaJCC7414ageCBUDktW6qRGZybkKCleHJS/vsYGomrrTl9cwZq/oOLQ/+z6sf
         oLTqkWJSc7UJ2KtZ/+faCTho8c/x8pGUO/O2yOeL5+/8F0tysEq3Q4gELz6LnfrDBX2E
         Jn4A==
X-Gm-Message-State: AGRZ1gLDY3unZd9l4qcmdfZ3u5V8x48cnnIKgWycX0DcFcxd3ActwFRq
        SO7SRbACF9VJjUPOxfCwxo/C1sDgNuA=
X-Google-Smtp-Source: AJdET5cRNytvcvdbapz2jfbtJCOBNvv682K5vjzhaKlGgKPRw6iezjlRlr/gN8scmiCn6IjRW7nTBg==
X-Received: by 2002:a2e:7e07:: with SMTP id z7-v6mr11553184ljc.84.1540891316199;
        Tue, 30 Oct 2018 02:21:56 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t6-v6sm3369067ljd.2.2018.10.30.02.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:21:55 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     =?utf-8?B?xYF1a2Fzeg==?= Rymanowski 
        <lukasz.rymanowski@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] btmon: Add colors to data status in extended adv report
Date:   Tue, 30 Oct 2018 10:21:53 +0100
Message-ID: <1719606.xSmM3C9bhQ@ix>
Organization: CODECOUP
In-Reply-To: <20181024101718.26695-1-lukasz.rymanowski@codecoup.pl>
References: <20181024101718.26695-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi =C5=81ukasz,

On Wednesday, 24 October 2018 12:17:18 CET =C5=81ukasz Rymanowski wrote:
> This patch gives color indicators to data status in extended
> advertising reports. This gives better visibility on which advertising
> events were completed or truncated.
> ---
>  monitor/packet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/monitor/packet.c b/monitor/packet.c
> index cf4a64362..eabd21914 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -9323,6 +9323,7 @@ static void print_ext_adv_report_evt_type(const char
> *indent, uint16_t flags) uint16_t props =3D flags;
>  	uint8_t data_status;
>  	const char *str;
> +	const char *color_on;
>  	int i;
>=20
>  	print_field("%sEvent type: 0x%4.4x", indent, flags);
> @@ -9343,19 +9344,23 @@ static void print_ext_adv_report_evt_type(const c=
har
> *indent, uint16_t flags) switch (data_status) {
>  	case 0x00:
>  		str =3D "Complete";
> +		color_on =3D COLOR_GREEN;
>  		break;
>  	case 0x01:
>  		str =3D "Incomplete, more data to come";
> +		color_on =3D COLOR_YELLOW;
>  		break;
>  	case 0x02:
>  		str =3D "Incomplete, data truncated, no more to come";
> +		color_on =3D COLOR_RED;
>  		break;
>  	default:
>  		str =3D "Reserved";
> +		color_on =3D COLOR_RED;
>  		break;
>  	}
>=20
> -	print_field("%s  Data status: %s", indent, str);
> +	print_field("%s  Data status: %s%s%s", indent, color_on, str, COLOR_OFF=
);
>=20
>  	if (mask)
>  		print_text(COLOR_UNKNOWN_ADV_FLAG,

Patch applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc


