Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7692CC10F13
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A0820880
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 16:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="P7tkwX2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfDHQ4B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:56:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:35359 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDHQ4B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 12:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554742556;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PvJh8Tf3T9bN5J08Vw30D1BiL/If4YnDk2m4NkJPeOI=;
        b=P7tkwX2sVQJlcbo+aGMuEHg6xptu73VrzvqZblDF47rSsHEoH3sBLbMqfJKva3lMMb
        nE4McZsmIGpisC8YRBarmpUtC1dQN68sbqvPc38/8IBVuEdYxw1qprFUhKOHTccNOWIM
        1F2umenCIGlQq5GDm6HtN07C+V3/RUaaxr17NmdCqhfsEaRoyQmtvX4VFblZP6Rt6wet
        GqrpoDsica7L9pytXewfJohRjZgReN7Yj4eFAb4GeDGMLGWBrMkUO0yvf3VrP8SaWIQI
        6+3yL8nwxJ7EGlGBPXLJ9CADdaJsPYQW72QL8Xqa8rBeyJpc4uDejhs5Y5hFbHnyZEXN
        uB/g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDdffYtr3yKg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id 60b811v38Gtt8OB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 8 Apr 2019 18:55:55 +0200 (CEST)
Date:   Mon, 8 Apr 2019 18:55:43 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Add entry for BCM2076B1 UART
 Bluetooth
Message-ID: <20190408165542.GA1274@gerhold.net>
References: <20190305130901.56660-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305130901.56660-1-stephan@gerhold.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Hi Johan,

On Tue, Mar 05, 2019 at 02:09:00PM +0100, Stephan Gerhold wrote:
> Add the device ID for the BT/FM/GPS combo chip BCM2076 (rev B1)
> used in the AMPAK AP6476 WiFi/BT/FM/GPS module.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/bluetooth/btbcm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index d5d6e6e5da3b..ea1a20a49f91 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -333,6 +333,7 @@ struct bcm_subver_table {
>  static const struct bcm_subver_table bcm_uart_subver_table[] = {
>  	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
>  	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
> +	{ 0x4204, "BCM2076B1"	},	/* 002.002.004 */
>  	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
>  	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
>  	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
> -- 
> 2.21.0
> 

Is there anything I can change in these two patches to get them applied?
Or should I re-send them?

Thanks,
Stephan
