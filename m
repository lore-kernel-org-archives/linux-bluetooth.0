Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C46461053
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhHSO6W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:58:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52408 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbhHSO6V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 10:58:21 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 09D47CED16;
        Thu, 19 Aug 2021 16:57:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC 1/3] adapter-api: Add Experimental property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210817010237.1792589-1-luiz.dentz@gmail.com>
Date:   Thu, 19 Aug 2021 16:57:43 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <58749BBA-28F0-464E-8CE0-22FD1FEFBDD9@holtmann.org>
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds Experimental property which indicates what experimental
> features are currently enabled.
> ---
> doc/adapter-api.txt | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 464434a81..13e904425 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -335,3 +335,8 @@ Properties	string Address [readonly]
> 				"peripheral": Supports the peripheral role.
> 				"central-peripheral": Supports both roles
> 						      concurrently.
> +
> +		array{string} Experimental [readonly, optional]
> +
> +			List of 128-bit UUIDs that represents the experimental
> +			features currently enabled.

I wonder if this is the best name.

Do we care about just the enabled experimental features or the overall supported experimental features as well. And please keep in mind that we also have per-adapter vs global experimental features. So we should distinguish here as well.

We also need to document that this property is only available if bluetoothd is started with -E and otherwise this property is omitted.

My proposal would be to at least name it ExperimentalSupport or ExperimentalFeatures to give us a path to nicely extend it if needed.

Regards

Marcel

