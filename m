Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68D5C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E6260FEE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhGVOFg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:05:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43138 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGVOFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 10:05:35 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id D8CF8CECE4;
        Thu, 22 Jul 2021 16:46:09 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH BlueZ 1/7] doc/adapter-api: Add SupportedPhyConfiguration
 property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210722052640.5863-2-ayush.garg@samsung.com>
Date:   Thu, 22 Jul 2021 16:46:09 +0200
Cc:     linux-bluetooth@vger.kernel.org, anupam.r@samsung.com,
        nitin.j@samsung.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8D60ECE9-A8DA-46D7-A505-C841AB6330A2@holtmann.org>
References: <20210722052640.5863-1-ayush.garg@samsung.com>
 <CGME20210722052738epcas5p3b6074e49f088159e8282bba3457d56ba@epcas5p3.samsung.com>
 <20210722052640.5863-2-ayush.garg@samsung.com>
To:     Ayush Garg <ayush.garg@samsung.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Aysush,

> This change add a new property to retrieve the PHYs
> supported by the controller.
> 
> Reviewed-by: Anupam Roy <anupam.r@samsung.com>
> ---
> doc/adapter-api.txt | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 464434a81..25e370d75 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -335,3 +335,24 @@ Properties	string Address [readonly]
> 				"peripheral": Supports the peripheral role.
> 				"central-peripheral": Supports both roles
> 						      concurrently.
> +
> +		array{string} SupportedPhyConfiguration [readonly]
> +
> +			List of PHYs supported by the controller.
> +
> +			Possible values:
> +				"BR1M1SLOT"
> +				"BR1M3SLOT"
> +				"BR1M5SLOT"
> +				"EDR2M1SLOT"
> +				"EDR2M3SLOT"
> +				"EDR2M5SLOT"
> +				"EDR3M1SLOT"
> +				"EDR3M3SLOT"
> +				"EDR3M5SLOT"
> +				"LE1MTX"
> +				"LE1MRX"
> +				"LE2MTX"
> +				"LE2MRX"
> +				"LECODEDTX"
> +				"LECODEDRX"

we don’t do string constants like this in D-Bus API. They are lowercase and verbose “br-1m-1slot” etc. at least.

Regards

Marcel

