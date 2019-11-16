Return-Path: <SRS0=UnQ+=ZI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DBC432C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304D820723
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 09:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKPJno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Nov 2019 04:43:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:51024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfKPJno (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Nov 2019 04:43:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF09FAFA7;
        Sat, 16 Nov 2019 09:43:42 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] Add entry for BCM4335A0 UART bluetooth
To:     Mohammad Rasim <mohammad.rasim96@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <20191115165026.19376-1-mohammad.rasim96@gmail.com>
 <20191115165026.19376-2-mohammad.rasim96@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <b22e57eb-978f-9ec8-9ca6-06c0f5e7b9f6@suse.de>
Date:   Sat, 16 Nov 2019 10:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191115165026.19376-2-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 15.11.19 um 17:50 schrieb Mohammad Rasim:
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>

Lacking a commit description. Please add a sentence.

> ---
>  drivers/bluetooth/btbcm.c   | 1 +
>  drivers/bluetooth/hci_bcm.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..22464bf8cda3 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -339,6 +339,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
>  	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
>  	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
>  	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
> +	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
>  	{ }
>  };

Beyond this patch: There appears to be no order in this table at all?
Not alphabetically, not numerically, not by comment.

>  
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 7646636f2d18..7b4bb5dbea1d 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1422,6 +1422,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>  	{ .compatible = "brcm,bcm4345c5" },
>  	{ .compatible = "brcm,bcm4330-bt" },
>  	{ .compatible = "brcm,bcm43438-bt" },
> +	{ .compatible = "brcm,bcm4335A0" },

You can't use compatible strings without defining the binding first. Why
do you need it? If you do, use lowercase names.

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
