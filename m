Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C75C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 06:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbiC3GPk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiC3GPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 02:15:39 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8F403E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 23:13:51 -0700 (PDT)
Received: from [192.168.0.4] (unknown [95.90.232.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 11E5D61EA192A;
        Wed, 30 Mar 2022 08:13:49 +0200 (CEST)
Message-ID: <e8c5b25a-6e4a-d958-c3c0-aa9dad797c8c@molgen.mpg.de>
Date:   Wed, 30 Mar 2022 08:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] Bluetooth: Print broken quirks
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
 <20220329201646.2296314-2-luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220329201646.2296314-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Thank you for your patch.

Maybe as commit message summary:

Warn about broken quirks

Am 29.03.22 um 22:16 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints warnings for controllers setting broken quirks to increase
> their visibility and warn about broken controllers firmware that
> probably needs updates to behave properly.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8f4c5698913d..8994ff1f94e6 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3825,6 +3825,67 @@ static int hci_init_sync(struct hci_dev *hdev)
>   	return 0;
>   }
>   
> +#define HCI_QUIRK_BROKEN(_quirk, _desc) \
> +{ \
> +	.quirk = _quirk, \
> +	.desc = _desc, \
> +}
> +
> +static const struct hci_quirk_broken {
> +	unsigned long quirk;
> +	const char *desc;
> +} hci_broken_table[] = {
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
> +			 "HCI Read Local Supported Commands not supported"),

The user wouldn’t know, that this is a device firmware problem. Could 
something be added to the warning, like:

Therefore, device firmware VERSION violates the spec. Please contact the 
manufacturer.

> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
> +			 "HCI Delete Stored Link Key command is advertised, "
> +			 "but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
> +			 "HCI Read Default Erroneous Data Reporting command is "
> +			 "advertised, but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> +			 "HCI Read Transmit Power Level command is advertised, "
> +			 "but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
> +			 "HCI Set Event Filter command not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
> +			 "HCI Enhanced Setup Synchronous Connection command is "
> +			 "advertised, but not supported.")
> +};
> +
> +static void hci_dev_print_broken_quirks(struct hci_dev *hdev)
> +{
> +	int i;

I’d use `unsigned int`, but no idea, what the subsystem does regarding 
counting variables.


Kind regards,

Paul


> +
> +	bt_dev_dbg(hdev, "");
> +
> +	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> +		const struct hci_quirk_broken *broken = &hci_broken_table[i];
> +
> +		if (test_bit(broken->quirk, &hdev->quirks))
> +			bt_dev_warn(hdev, "%s", broken->desc);
> +	}
> +}
> +
> +static int hci_dev_setup_sync(struct hci_dev *hdev)
> +{
> +	bt_dev_dbg(hdev, "");
> +
> +	hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> +
> +	if (hdev->setup) {
> +		int ret;
> +
> +		ret = hdev->setup(hdev);
> +		if (ret)
> +			return ret;
> +
> +		hci_dev_print_broken_quirks(hdev);
> +	}
> +
> +	return 0;
> +}
> +
>   int hci_dev_open_sync(struct hci_dev *hdev)
>   {
>   	int ret = 0;
> @@ -3887,10 +3948,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>   	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>   		bool invalid_bdaddr;
>   
> -		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> -
> -		if (hdev->setup)
> -			ret = hdev->setup(hdev);
> +		ret = hci_dev_setup_sync(hdev);
>   
>   		/* The transport driver can set the quirk to mark the
>   		 * BD_ADDR invalid before creating the HCI device or in
