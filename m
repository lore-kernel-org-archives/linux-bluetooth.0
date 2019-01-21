Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F966C2F426
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1999320880
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfAUOqR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:46:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40858 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfAUOqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 09:46:16 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6FBB6CEE94;
        Mon, 21 Jan 2019 15:54:01 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 2/2] Bluetooth: dt-bindings: Realtek serial bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190120124046.6715-2-beagleboard@davidjohnsummers.uk>
Date:   Mon, 21 Jan 2019 15:46:13 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <173522CE-3B41-4BDC-AD4B-3AEA963771CE@holtmann.org>
References: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
 <20190120124046.6715-2-beagleboard@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

> Since v2, the compatible binding names have been changed to end in
> -bt, as requested by robh. Also the example has been expanded.
> 
> As before, for these Realtek devices, are typicaly joint wifi and
> bluetooth devices; with seperate interfaces which will be
> independently wired to the cpu. For these devices wifi is sdio, whilst
> bluetooth is a uart. This patchset just sets the device tree links for
> the bluetooth interface.
> 
> The example device tree source code, alas hasn't been tested. It is a
> copy of that used on the ASUS Tinker Board:
> 
> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
> 
> If these patches are accepted, my next job will be to mainline the
> rest of the Tinker Board patches - so if this element of the device
> tree has to change, I will also update the example here.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
> .../bindings/net/realtek-bluetooth-serial.txt | 32 +++++++++++++++++++
> 1 file changed, 32 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> new file mode 100644
> index 000000000000..119f9db4f87f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> @@ -0,0 +1,32 @@
> +Realtek bluetooth devices connected via a UART.
> +These devices typically also have a wi-fi connected via sdio - the
> +compatible described here is used just for referencing the bluetooth.

If it is not in a file name or code, I prefer you write it Bluetooth since that is the approving naming in written text. Same as Wi-Fi and SDIO etc. The tendency to lower-case everything in written text is just bad style.

> +
> +- compatible: should be "realtek,<name>-bt"
> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
> +       "realtek,rtl8723as-bt"
> +       "realtek,rtl8723bs-bt"
> +       "realtek,rtl8723ds-bt"
> +       "realtek,rtl8761atv"
> +       "realtek,rtl8821as-bt"
> +       "realtek,rtl8821cs-bt"
> +       "realtek,rtl8822bs-bt"
> +
> +Example:
> +
> +&uart0 {
> +	status = "okay";
> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bluetooth”;

I think you need to correct the example to also use -bt.

Regards

Marcel

