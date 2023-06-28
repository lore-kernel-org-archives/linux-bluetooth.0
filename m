Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A65EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjF1LgO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:36:14 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44125 "EHLO mx3.molgen.mpg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbjF1LgN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 07:36:13 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B46661E5FE01;
        Wed, 28 Jun 2023 13:34:26 +0200 (CEST)
Message-ID: <2a43ecd8-faf5-11f7-1a01-c114aa16354b@molgen.mpg.de>
Date:   Wed, 28 Jun 2023 13:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for GalePeak
Content-Language: en-US
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
References: <20230628113934.824668-1-kiran.k@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230628113934.824668-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Kiran,


Thank you for your patch.

Am 28.06.23 um 13:39 schrieb Kiran K:
> Hardware variant for GalePeak core (CNVi) is added.

The code names are officially spelled with a space, I believe: Gale Peak.

Maybe also mention 0x1c.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index dd1e48808ee2..f4d096639080 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -480,6 +480,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
>   	case 0x18:	/* Slr */
>   	case 0x19:	/* Slr-F */
>   	case 0x1b:      /* Mgr */
> +	case 0x1c:	/* GaP */

Why not add the full name in the comment? Maybe: Gale Peak (GaP).

>   		break;
>   	default:
>   		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
> @@ -2648,6 +2649,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   	case 0x18:
>   	case 0x19:
>   	case 0x1b:
> +	case 0x1c:
>   		hci_set_msft_opcode(hdev, 0xFC1E);
>   		break;
>   	default:
> @@ -2862,6 +2864,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   	case 0x18:
>   	case 0x19:
>   	case 0x1b:
> +	case 0x1c:
>   		/* Display version information of TLV type */
>   		btintel_version_info_tlv(hdev, &ver_tlv);
>   


Kind regards,

Paul
