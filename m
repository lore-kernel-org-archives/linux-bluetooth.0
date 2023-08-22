Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738EEE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHVKmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjHVKmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 06:42:05 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523CFD
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 03:42:01 -0700 (PDT)
Received: from [192.168.0.185] (unknown [95.90.238.145])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C6D5561E5FE03;
        Tue, 22 Aug 2023 12:41:54 +0200 (CEST)
Message-ID: <0c05b814-2ec0-4b54-80a3-fc54d753c0d3@molgen.mpg.de>
Date:   Tue, 22 Aug 2023 12:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Fix quirks table naming
To:     Bastien Nocera <hadess@hadess.net>
References: <20230822102033.1169580-1-hadess@hadess.net>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230822102033.1169580-1-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Bastian,


Thank you for the patch.

Am 22.08.23 um 12:20 schrieb Bastien Nocera:
> The quirks table was named "blacklist_table" which isn't a good
> description for that table as devices detected using it weren't ignored
> by the driver.
> 
> Rename the table to match what it actually does.

Maybe mention the new name also in the summary to be more specific? Maybe:

Bluetooth: btusb: Rename blacklist_table to quirks_table

> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/btusb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 764d176e9735..a1be66ef175c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -175,7 +175,7 @@ static const struct usb_device_id btusb_table[] = {
>   
>   MODULE_DEVICE_TABLE(usb, btusb_table);
>   
> -static const struct usb_device_id blacklist_table[] = {
> +static const struct usb_device_id quirks_table[] = {
>   	/* CSR BlueCore devices */
>   	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
>   
> @@ -4113,7 +4113,7 @@ static int btusb_probe(struct usb_interface *intf,
>   	if (!id->driver_info) {
>   		const struct usb_device_id *match;
>   
> -		match = usb_match_id(intf, blacklist_table);
> +		match = usb_match_id(intf, quirks_table);
>   		if (match)
>   			id = match;
>   	}

Thank you for doing this.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
