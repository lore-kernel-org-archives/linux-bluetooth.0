Return-Path: <SRS0=2Cj2=YN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1607CA9EAD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BCB222C2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 21:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z1URIBeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfJTVR4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Oct 2019 17:17:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:57311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfJTVRz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Oct 2019 17:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571606253;
        bh=roIbpENmIxP4w7WU842plrcJ0VYVDHDaJFUQvtEjZVw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z1URIBeTCZdah6s4j/sKdRv73XsfdJpSmOnpWS/epQ8RrHI72c1HYDoFE+wvHaE3z
         CQyow6f1L56niC1fnkb/SyPdL7WT00eZTT+af3mVkhJjMW3xPLI+uP23N9sxpizPxT
         Q76fGQ2SNYZOah1/Mq72IH1cp0S3g7lXoyGb7dHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1id05A17DB-00J1N0; Sun, 20
 Oct 2019 23:17:33 +0200
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-bluetooth@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
Date:   Sun, 20 Oct 2019 23:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:vAXNLeW3B5iKlKv7LnAYxXpah2Ujax35yKaou7peYeveOh8Bfl3
 GTIPS1NaeC1cJMdYa36LsyR2STBODHsoycgoEwP+G8542RYkQdxAElrhEXuxdsnUAi7liOa
 wS4SGlI/65Cfkj4tunClj/0XRjXDjXgbch8NLBUgrVl6ju/3d7+odcsqVyjjlzKviPYagej
 T90QqRJzev5JXtZ2v7BrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZvVXQvPtsDM=:Rq5rL0CL03Z2b8FC5Z2jzt
 IMZD4nGS529l9VjgJSXNIP5SkKDH6OD11sRP78HHHwK9vvT0s0k+iXuaZF3wOwDmOB3w0fPDc
 97oyAndzL0qEOIRwqdYSUUvQ29+RmiJJk/Yc9+KdVs7XpNzpeWheOGViq1COuLFWfWK4CbsER
 QdNjScNeOE/79coAjarQCv0u8EXAYO7Al36INHpHz5nNnDfUlKqvskBsXN21cZR4DEpgfvatS
 7uAhiVrshIVVHQ/UG+Y+7nIIvqFssB0HsJHeBQv+6IZ45A32ABK/IewFZ3BZg7ClMIBBv0qeG
 +n4zricQibxE0O1cOMKWl918w1rg/Rml2NtrgSI6s18Dd783q/01Xud7S/7Z4eyum9WWOfhQp
 iZjPf5fiPw4eUhbNmUfMT0T0xWttDRGaJIt/A3CYDtkKFvAo/1qP+Mt9BU0QwDqD7iKbN4v0Y
 TXhq1v5oY9T+tUpoVuv6dZMWGsM6R2Qs3zrX1HEe3c/Diyzk/ltFqNbe+WjjbHk3/VupMXLt6
 JdQWZgs9Um6ZQW7q+K2o42tgpxCuZ922KzUCnknE0qtVoHjsqtROILyvjBq21SAOt5NIb5A93
 HWCUEjTqzphXtfoGuiI92F7S+qISKdIRfkeg8L2++MQLSsZ2xxPH3rX4thcGNEQhwYJ9lPOhi
 uRB5EcaYg6YJhbpj2kfTHZESzX8UK+KA2FEjrVuQOFcaQBkcikEq1FhbfNc3s9lbjQeVAXPRL
 au8BC4usnvAxnE8N5C+eBiX0VnLw9WiSRHjdS0y7XtHNK/llgI2A6JsyWxoG0bu848q+38Ky0
 pgwTeWRtj5mxJp9OIKOwSDqh+zMgikMhnpWjzzUVJbYFT0fCsvoS3wwBj2O7E/BXM0SlHY2eB
 1TgrXu9i1++fGRhoS1FohhemCDIsQqtp19PszXDIBEUqZi7SWGJhbZnRK5Gs//xZcaBaxLFJO
 w/UdhsLcyquEgpKcp2YLiuFg73mLHvrmVOs9DqsdoPl/OS3VsmY2lGdN5WDOMaxeaw4yvACpe
 FPDfotLCr6r7CzxRGsWpqd2jELzKQQa5s8X/qRwPcerlChy1qqVk78ksefjNMr8OJkCBp3YQZ
 PUda8HS8TXloj9R1yMuq++VyQz9FH9EavSLfof/g1XqeaC6ewoMULPxlXZLfUA9k5IwiWKSzU
 HF3RYWSLPym91HsCM82SIWOtcaCAJhKcpIIw/A0RoOx4v3zz/jX55LCFwhaE5I2EGMNCFW4Ta
 AiolJFF63DpRR/O53R4biOThQ9pt/Jbphr1hBIgRtDlLbW2VNWmCXz+eHLsg=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,
hi Johan,

Am 06.10.19 um 17:28 schrieb Stefan Wahren:
> The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
> doesn't react to HCI requests during DT probe. The reason is the inproper
> handling of the RTS line during startup. According to the startup
> signaling sequence in the CYW43455 datasheet, the hosts RTS line must
> be driven after BT_REG_ON and BT_HOST_WAKE.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/bluetooth/hci_bcm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 7646636..0f73f6a 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -445,9 +445,11 @@ static int bcm_open(struct hci_uart *hu)
>
>  out:
>  	if (bcm->dev) {
> +		hci_uart_set_flow_control(hu, true);
>  		hu->init_speed = bcm->dev->init_speed;
>  		hu->oper_speed = bcm->dev->oper_speed;
>  		err = bcm_gpio_set_power(bcm->dev, true);
> +		hci_uart_set_flow_control(hu, false);
>  		if (err)
>  			goto err_unset_hu;
>  	}
> --
> 2.7.4

would be nice to get some feedback about this.

Regards
Stefan

