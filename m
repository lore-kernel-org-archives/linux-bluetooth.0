Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC0C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDC361436
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 08:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhDUIPL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:15:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36030 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhDUIPK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 04:15:10 -0400
Received: from marcel-macbook.holtmann.net (p4ff9f778.dip0.t-ipconnect.de [79.249.247.120])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6BC45CED1B;
        Wed, 21 Apr 2021 10:22:23 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [BlueZ v4] monitor: Fix the incorrect vendor name
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210421033758.762312-1-hj.tedd.an@gmail.com>
Date:   Wed, 21 Apr 2021 10:14:36 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AD3B62C3-F6FB-4D9D-BD31-3A9117828324@holtmann.org>
References: <20210421033758.762312-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch fixes the vendor name is alwasy shown as "Microsoft" for the
> commands and Unknown name for vendor events.
> 
> < HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
>        Type: Data fragment (0x01)
>> HCI Event: Command Complete (0x0e) plen 4
>      Microsoft Secure Send (0x3f|0x0009) ncmd 31
>        Status: Success (0x00)
> ---
> monitor/msft.h   |   6 +++
> monitor/packet.c | 131 ++++++++++++++++++++++++++++++++++++++---------
> 2 files changed, 113 insertions(+), 24 deletions(-)
> 
> diff --git a/monitor/msft.h b/monitor/msft.h
> index a268f4bc7..7573b5ba1 100644
> --- a/monitor/msft.h
> +++ b/monitor/msft.h
> @@ -24,6 +24,12 @@
> 
> #include <stdint.h>
> 
> +struct msft_ext {
> +	uint16_t opcode;
> +	uint8_t  evt_prefix_len;
> +	uint8_t  evt_prefix[32];
> +};
> +
> struct vendor_ocf;
> struct vendor_evt;
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index d729a01cc..6df96df48 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -265,7 +265,7 @@ struct index_data {
> 	uint8_t  type;
> 	uint8_t  bdaddr[6];
> 	uint16_t manufacturer;
> -	uint16_t msft_opcode;
> +	struct msft_ext msft_ext;

don’t bother with the struct, just add the extra needed variables right here.

Regards

Marcel

