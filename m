Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27630C7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 13:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCTNKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjCTNKe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 09:10:34 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698D21B31E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 06:10:27 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aedbb.dynamic.kabel-deutschland.de [95.90.237.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CE756244DFBA;
        Mon, 20 Mar 2023 14:10:25 +0100 (CET)
Message-ID: <0c579450-b7bd-dd80-c77b-e5471c30aaa9@molgen.mpg.de>
Date:   Mon, 20 Mar 2023 14:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
Content-Language: en-US
To:     Chethan T N <chethan.tumkur.narayan@intel.com>
Cc:     ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        linux-bluetooth@vger.kernel.org
References: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Chethan,


Thank you for your patch. There is a small typo in the summary/title: 
s/form/from/

Am 20.03.23 um 07:18 schrieb Chethan T N:
> This patch shall enable the LE States quirks by default on all

s/shall enable/enables/

> Intel controller from Solar products on wards.

onwards

Where is it documented, to enable that quirk for all?

> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index af774688f1c0..7a6dc05553f1 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2684,9 +2684,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   		 */
>   		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>   
> -		/* Valid LE States quirk for GfP */
> -		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
> -			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +		/* Apply LE States quirk from solar onwards */
> +		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);

 From the diff it is unclear, if Solar is the first “device”. So I’d be 
nice if you elaborated in the commit message.

>   
>   		/* Setup MSFT Extension support */
>   		btintel_set_msft_opcode(hdev,


Kind regards,

Paul
