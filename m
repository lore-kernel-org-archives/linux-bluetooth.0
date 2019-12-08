Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C27C2D0BF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 23:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A121739
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLHXmr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:42:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45833 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfLHXmr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 18:42:47 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7C9E9CED16;
        Mon,  9 Dec 2019 00:51:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v3 2/3] Bluetooth: hci_h5: Add DT support for rtl8723bs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191130194719.112335-3-bonstra@bonstra.fr.eu.org>
Date:   Mon, 9 Dec 2019 00:42:44 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F6C9DDF3-AB63-45C3-8EA6-CFEDE15366C6@holtmann.org>
References: <20191130194719.112335-1-bonstra@bonstra.fr.eu.org>
 <20191130194719.112335-3-bonstra@bonstra.fr.eu.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hugo,

> The hci_h5 already supports Realtek controllers discovered via ACPI. This
> commit adds support for discovering via device tree for ACPI-less
> platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
> drivers/bluetooth/Kconfig  |  2 +-
> drivers/bluetooth/btrtl.c  | 75 +++++++++++++++++++++-----------------
> drivers/bluetooth/btrtl.h  |  3 +-
> drivers/bluetooth/hci_h5.c | 65 ++++++++++++++++++++++++++-------
> 4 files changed, 95 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index aae665a3a254..48c9a004b033 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -211,7 +211,7 @@ config BT_HCIUART_RTL
> 	depends on BT_HCIUART
> 	depends on BT_HCIUART_SERDEV
> 	depends on GPIOLIB
> -	depends on ACPI
> +	depends on (ACPI || OF)
> 	select BT_HCIUART_3WIRE
> 	select BT_RTL
> 	help
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 4f75a9b61d09..01b0eb4b57d7 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -17,6 +17,8 @@
> 
> #define VERSION "0.1"
> 
> +#define FW_DIR "rtl_bt"
> +
> #define RTL_EPATCH_SIGNATURE	"Realtech"
> #define RTL_ROM_LMP_3499	0x3499
> #define RTL_ROM_LMP_8723A	0x1200
> @@ -45,7 +47,7 @@ struct id_table {
> 	bool config_needed;
> 	bool has_rom_version;
> 	char *fw_name;
> -	char *cfg_name;
> +	char *cfg_basename;
> };

you need to split this into individual patches. I am not in favor of doing a refactor and then adding DT support in the same patch.

Regards

Marcel

