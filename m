Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54CCA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0355B21734
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572596858;
	bh=UGrR3iRTKwrbEPN+BHW52XhDbxZkXvMXHC6V2nHaiuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cgrFue0kHuj2AuXBeur1WnGYIwHYaXiJTmH0nJkuuxPVlFNtjpx5teTZ86Sde4FDY
	 gjZZWwFq0BrQbtVflitjsNsye+s/Wpx1un2Vsw9Tywj61Gxyky0xHr/m8dgXyBllbm
	 u+91VIV8WJd3FSQSIfDJr1byzSCZ1qcc9y4Qbsn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfKAI1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfKAI1h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 04:27:37 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E34208CB;
        Fri,  1 Nov 2019 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572596856;
        bh=UGrR3iRTKwrbEPN+BHW52XhDbxZkXvMXHC6V2nHaiuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmNAWnJ4mnMMumb5K9Z5TPfbVMVSG14pUOCb3DPJ2XA3W3x2H1DIt1TB7ofMdQf/9
         xPDRzfPxGa0pirP3JilU8xsrw6ZA13MRWl7fwDeFP0EsYSKwGnLb8Rpw92376oeBOC
         5oB8tSHl21zhhbFjvyD42aR6cbPogZi4FsIaQY2k=
Date:   Fri, 1 Nov 2019 09:02:56 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: add DT binding for
 Realtek controllers
Message-ID: <20191101080256.gjc4tacltehro3iw@hendrix>
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
 <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hugo,

On Wed, Oct 30, 2019 at 11:43:31PM +0100, Hugo Grostabussiat wrote:
> The rtl_bt driver already supports some Realtek controllers on ACPI
> platforms.
> This commit adds bindings for DT-only platforms.
>
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
>  .../bindings/net/realtek-bluetooth.txt        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

You should write that binding using a YAML description. Free-form
device tree bindings are more or less deprecated now.

> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> new file mode 100644
> index 000000000000..01d4ed146705
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> @@ -0,0 +1,25 @@
> +Realtek Bluetooth controllers
> +=============================
> +
> +This documents the binding structure and properties for the serial
> +attached Bluetooth controllers from Realtek.
> +
> +Required properties:
> +- compatible: currently, only "realtek,rt8723bs-bt" is supported
> +
> +Optional properties:
> +- enable-gpio: gpio line controlling the power down (BT_DIS#) signal
> +- device-wake: gpio line controlling the device wakeup (BT_WAKE) signal
> +- config-name: postfix added to the name of the firmware file
> +  containing the chip configuration
> +
> +Example:
> +
> +&uart1 {
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bt";
> +		enable-gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
> +		device-wake-gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +		config-name = "teres_a64_i";

IIRC, that has been discussed before and the standard "model" property
was to be preferred.

Maxime
