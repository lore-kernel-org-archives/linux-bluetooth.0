Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBAEE49AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 20:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHVUBc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHVUB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 16:01:29 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE0CE3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:01:26 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae84c.dynamic.kabel-deutschland.de [95.90.232.76])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 603D861E5FE01;
        Tue, 22 Aug 2023 22:01:17 +0200 (CEST)
Message-ID: <fe9b42b3-6a9d-41dc-9532-5f7358c422ed@molgen.mpg.de>
Date:   Tue, 22 Aug 2023 22:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20230822191444.3741307-1-luiz.dentz@gmail.com>
Cc:     Bruno Pitrus <brunopitrus@hotmail.com>,
        linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230822191444.3741307-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[CC: +Bruno]

Dear Luiz,


Thank you for the patch.

Am 22.08.23 um 21:14 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces HCI_QUIRK_BROKEN_LE_CODED is is used to indicate that

…. It is used …

> LE Coded PHY shall not be used, it is then set for some Intel models
> that claims to support it but when used causes many problems.

that claim to …

> Link: https://github.com/bluez/bluez/issues/577
> Link: https://github.com/bluez/bluez/issues/582
> Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   drivers/bluetooth/btintel.c      |  2 ++
>   include/net/bluetooth/hci.h      | 10 ++++++++++
>   include/net/bluetooth/hci_core.h |  4 +++-
>   3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 9b239ce96fa4..3ed60b2b0340 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2776,6 +2776,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   		case 0x11:      /* JfP */
>   		case 0x12:      /* ThP */
>   		case 0x13:      /* HrP */
> +			set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
> +			fallthrough;
>   		case 0x14:      /* CcP */
>   			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>   			fallthrough;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c58425d4c592..767921d7f5c1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -319,6 +319,16 @@ enum {
>   	 * This quirk must be set before hci_register_dev is called.
>   	 */
>   	HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
> +
> +	/*
> +	 * When this quirk is set, LE Coded PHY is shall not be used. This is

s/is shall/shall/

> +	 * required for some Intel controllers which erroneously claim to
> +	 * support it but it causes problems with extended scanning.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_BROKEN_LE_CODED,
>   };
>   
>   /* HCI device flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6e2988b11f99..e6359f7346f1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1817,7 +1817,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
>   		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
>   
> -#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
> +#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED) && \
> +			       !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
> +					 &(dev)->quirks))
>   
>   #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
>   			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))

Will this be future proof, once firmware for the broken controllers are 
fixed?


Kind regards,

Paul
