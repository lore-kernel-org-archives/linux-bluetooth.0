Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C05C43215
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28F24653
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575313440;
	bh=YN9GuRfgXIuurVuKgzNcuNcr1boHSN8O9OuM+vIKERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2eOXUirMxPzexJ2ULyrbcUPldJb8IxDm7m5jzY98F5ayEsSLQqkUwpQ1pQbjPRmnL
	 iCMTZG6OvT/dZu/qYrqv7jXonQ+FofuoQeItmA0cVsqNjWfw6CEuNDLMZzuQCwZpXB
	 1/bpaqURR3aPDKva4VpVb+sNHO9lPNpTkRwFnFPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLBTD7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfLBTD7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 14:03:59 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529672464D;
        Mon,  2 Dec 2019 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575313438;
        bh=YN9GuRfgXIuurVuKgzNcuNcr1boHSN8O9OuM+vIKERw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KT/un5HeTJMSt0OxMkqXRNv0RQbcljBwmtHpUe+qit9pBR/Iu0eiJp63USFvR93Av
         XONKDC2Y+YyS+SfrDRN8DcgJZ0j/MUKZkn/OcGvkBbVOTzp2sYNEClo6L4ux1Uuur5
         4CeiQeG4AJggO0J0zYk6UkuQ6OgeRdRhdqiwCUng=
Date:   Mon, 2 Dec 2019 20:03:56 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: allwinner: a64: Enable Bluetooth on
 Teres-I
Message-ID: <20191202190356.g5aaa2iotrozfirm@gilmour.lan>
References: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
 <20191130202314.142096-4-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ds3wtmj4ifzz5c6h"
Content-Disposition: inline
In-Reply-To: <20191130202314.142096-4-bonstra@bonstra.fr.eu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ds3wtmj4ifzz5c6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 30, 2019 at 09:23:14PM +0100, Hugo Grostabussiat wrote:
> The UART1 on the Teres-A64-I is connected to a rtl8723bs combo
> WLAN/Bluetooth controller, with three GPIOs used for device reset,
> host wake up and device wake up.
>
> Currently, the host wake up feature is not supported by the HCI H5
> driver.
>
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index 1069e7012c9c..b28e6d7cb227 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -325,6 +325,20 @@
>  	status = "okay";
>  };
>
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status = "okay";

You'll need to set uart-has-rtscts too.

Maxime
>

--ds3wtmj4ifzz5c6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXeVgHAAKCRDj7w1vZxhR
xb7hAQDVUoJULA2Q6eKcdWkB1OsAuiM58pn9qGHbjuZ/9ik2NAEAiApjGPIlTlkm
XviRcDU3beEJ0GuqAK8OguvH6No8dAI=
=fmkc
-----END PGP SIGNATURE-----

--ds3wtmj4ifzz5c6h--
