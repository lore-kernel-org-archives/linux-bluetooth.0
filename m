Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C5ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 09:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIGJ20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIGJ2Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 05:28:25 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43F910BB
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 02:28:22 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A14261EA1929;
        Wed,  7 Sep 2022 11:28:20 +0200 (CEST)
Message-ID: <02789db1-cc34-62c2-16b0-91b4d7819f80@molgen.mpg.de>
Date:   Wed, 7 Sep 2022 11:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v1] Bluetooth: btintel: Mark Intel controller to support
 LE_STATES quirk
To:     Kiran K <kiran.k@intel.com>
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        tedd.an@intel.com, linux-bluetooth@vger.kernel.org
References: <20220907071945.9925-1-kiran.k@intel.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220907071945.9925-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Kiran,


Thank you for the patch.


Am 07.09.22 um 09:19 schrieb Kiran K:
> HarrrisonPeak, CyclonePeak, SnowFieldPeak and SandyPeak controllers

Harrison

> are marked to support HCI_QUIRK_LE_STATES.

“Supporting” a quirk sounds strange. Maybe better use “need”?

If new platforms need the quirk, do you know if the hardware folks are 
aware of this?


Kind regards,

Paul


> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 818681c89db8..d44a96667517 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2439,15 +2439,20 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   					       INTEL_ROM_LEGACY_NO_WBS_SUPPORT))
>   				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>   					&hdev->quirks);
> +			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
> +				set_bit(HCI_QUIRK_VALID_LE_STATES,
> +					&hdev->quirks);
>   
>   			err = btintel_legacy_rom_setup(hdev, &ver);
>   			break;
>   		case 0x0b:      /* SfP */
> -		case 0x0c:      /* WsP */
>   		case 0x11:      /* JfP */
>   		case 0x12:      /* ThP */
>   		case 0x13:      /* HrP */
>   		case 0x14:      /* CcP */
> +			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +			fallthrough;
> +		case 0x0c:	/* WsP */
>   			/* Apply the device specific HCI quirks
>   			 *
>   			 * All Legacy bootloader devices support WBS
> @@ -2455,11 +2460,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>   				&hdev->quirks);
>   
> -			/* Valid LE States quirk for JfP/ThP familiy */
> -			if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
> -				set_bit(HCI_QUIRK_VALID_LE_STATES,
> -					&hdev->quirks);
> -
>   			/* Setup MSFT Extension support */
>   			btintel_set_msft_opcode(hdev, ver.hw_variant);
>   
> @@ -2530,9 +2530,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   		 */
>   		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>   
> -		/* Valid LE States quirk for JfP/ThP familiy */
> -		if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
> -			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +		/* Set Valid LE States quirk */
> +		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>   
>   		/* Setup MSFT Extension support */
>   		btintel_set_msft_opcode(hdev, ver.hw_variant);
