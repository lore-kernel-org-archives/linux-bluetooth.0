Return-Path: <SRS0=W+hJ=YV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA8CA9EC2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6EA214B2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 19:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfJ1TME convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:12:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35700 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJ1TME (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Oct 2019 15:12:04 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id E9522CECD0;
        Mon, 28 Oct 2019 20:21:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 1/3] dt-bindings: net: bluetooth: add DT binding for
 rtl8723bs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191026204116.95119-2-bonstra@bonstra.fr.eu.org>
Date:   Mon, 28 Oct 2019 20:12:02 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E5E89FA4-141A-4096-98FA-42403BAF0ECB@holtmann.org>
References: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
 <20191026204116.95119-2-bonstra@bonstra.fr.eu.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hugo,

> The rtl_bt driver already supports rtl8723bs devices on ACPI platforms.
> This commit adds bindings for DT-only platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
> .../bindings/net/realtek,rtl8723bs-bt.txt     | 25 +++++++++++++++++++
> 1 file changed, 25 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt

please document this in net/realtek-bluetooth.txt in a generic fashion for potentially all Realtek devices. Similar to what has been done for Broadcom etc.

> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt b/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt
> new file mode 100644
> index 000000000000..16b5cf799103
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt
> @@ -0,0 +1,25 @@
> +Realtek rtl8723bs Bluetooth controller
> +======================================
> +
> +This documents the binding structure and properties for the serial
> +attached rtl8723bs Bluetooth controller.
> +
> +Required properties:
> +- compatible: must be "realtek,rt8723bs-bt"
> +
> +Optional properties:
> +- enable-gpio: gpio line controlling the power down (BT_DIS#) signal
> +- device-wake: gpio line controlling the device wakeup (BT_WAKE) signal
> +- realtek,config-name: postfix added to the name of the firmware file
> +  containing the chip configuration

This needs an ACK from Rob before I consider applying it.

Regards

Marcel

