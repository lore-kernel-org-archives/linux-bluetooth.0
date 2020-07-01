Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3B720747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593592558;
	bh=UGtkda44woteFt7TyX2UWVAkG5/EtKAmYzl2P6Jfs7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cheyOGI55y8SmK7IX0Dj3Xp7B8ak/fqwVO8ED/A3gcCuYwMU+xm9JLMHE73rMB2t3
	 6qUimDtnizJqg+ZG4a4BQEZlY6AHOUgrJ9HXZnKE9Fq5Tr/+49zXS7aJOaOHn1gZPj
	 0pIqk29EbT9F6Hx927AHYY/9QzL4b5FbtMH7QODk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgGAIf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgGAIf5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 04:35:57 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7F22074D;
        Wed,  1 Jul 2020 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593592556;
        bh=UGtkda44woteFt7TyX2UWVAkG5/EtKAmYzl2P6Jfs7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ol7WRkadln57KsG/emeb4pCHG8a3PejXP5/bKCrWlJKm2b6RmHj/APPzc4kJs3r1B
         uc/iZvd6p69y1MRV/vqfZzBmTMo9PnODSV9qko5i2iSUZgsN6zr6qbM2Q074dXG4NH
         OmtHSaUvGyB7k/UoAi/HHhrfO3YHDJF/oMSEC9eU=
Received: by pali.im (Postfix)
        id F0A49102D; Wed,  1 Jul 2020 10:35:54 +0200 (CEST)
Date:   Wed, 1 Jul 2020 10:35:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] avinfo: Print more A/V capabilities
Message-ID: <20200701083554.bk6xlm7la6ap7qt3@pali>
References: <20200512165112.24006-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512165112.24006-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello! Could you look at following patch?

On Tuesday 12 May 2020 18:51:12 Pali Rohár wrote:
> ---
>  tools/avinfo.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/avinfo.c b/tools/avinfo.c
> index e45b50918..576981a5e 100644
> --- a/tools/avinfo.c
> +++ b/tools/avinfo.c
> @@ -65,6 +65,7 @@
>  #define AVDTP_HEADER_COMPRESSION	0x05
>  #define AVDTP_MULTIPLEXING		0x06
>  #define AVDTP_MEDIA_CODEC		0x07
> +#define AVDTP_DELAY_REPORTING		0x08
>  
>  /* SEP types definitions */
>  #define AVDTP_SEP_TYPE_SOURCE		0x00
> @@ -696,13 +697,33 @@ static void print_caps(void *data, int size)
>  
>  		switch (cap->category) {
>  		case AVDTP_MEDIA_TRANSPORT:
> +			printf("\tMedia Transport: Supported\n");
> +			break;
>  		case AVDTP_REPORTING:
> +			printf("\tReporting: Supported\n");
> +			break;
> +		case AVDTP_DELAY_REPORTING:
> +			printf("\tDelay Reporting: Supported\n");
> +			break;
>  		case AVDTP_RECOVERY:
> +		case AVDTP_HEADER_COMPRESSION:
>  		case AVDTP_MULTIPLEXING:
> -			/* FIXME: Add proper functions */
> -			break;
>  		default:
> -			printf("\tUnknown category: %d\n", cap->category);
> +			switch (cap->category) {
> +			case AVDTP_RECOVERY:
> +				printf("\tRecovery:\n");
> +				break;
> +			case AVDTP_HEADER_COMPRESSION:
> +				printf("\tHeader compression:\n");
> +				break;
> +			case AVDTP_MULTIPLEXING:
> +				printf("\tMultiplexing:\n");
> +				break;
> +			default:
> +				printf("\tUnknown category: %d\n", cap->category);
> +				break;
> +			}
> +			/* FIXME: Add proper functions */
>  			printf("\t\tData:");
>  			for (i = 0; i < cap->length; ++i)
>  				printf(" 0x%.02x",
> -- 
> 2.20.1
> 
