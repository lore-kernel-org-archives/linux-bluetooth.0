Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76CCC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EAE20823
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfARK5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:57:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38763 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfARK5U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:57:20 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3BAFCCEE14;
        Fri, 18 Jan 2019 12:05:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCHv2] Patch to add the realtek bluetooth device tree refs to
 the code
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
Date:   Fri, 18 Jan 2019 11:57:17 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

> This patch adds the necessary device tree hooks to the realtek
> bluetooth driver for serial connections.
> 
> The realtek devices that are listed btrtl.c are searched on the
> realtek web site for the version that have serial connections.
> 
> Most of these devices also have wi-fi connected via sdio, that is not
> covered by the bluetooth driver - but as that interface will also be
> needed in the device tree, the hocks here have "-bluetooth" added. The
> exception to this is the rtl8761atv, which only has a serial
> bluetooth.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
> drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..2fec7ff2ce7c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
> };
> #endif
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +       { .compatible = "realtek,rtl8723as-bluetooth"},
> +       { .compatible = "realtek,rtl8723bs-bluetooth"},
> +       { .compatible = "realtek,rtl8723ds-bluetooth"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bluetooth"},
> +       { .compatible = "realtek,rtl8821cs-bluetooth"},
> +       { .compatible = "realtek,rtl8822bs-bluetooth"},
> +#endif

I really need an Ack from Rob on the naming here.

Regards

Marcel

