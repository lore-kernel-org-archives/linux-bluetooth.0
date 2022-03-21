Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F026C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 04:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiCUEdQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 00:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbiCUEdL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 00:33:11 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32F31DEB
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 21:31:36 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef4e.dynamic.kabel-deutschland.de [95.90.239.78])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 87CB261E6478B;
        Mon, 21 Mar 2022 05:31:33 +0100 (CET)
Message-ID: <c33b9cf1-7805-b318-c246-fba441d20ffc@molgen.mpg.de>
Date:   Mon, 21 Mar 2022 05:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BlueZ PATCH 5/9] monitor: Display AdvMonitor DeviceFound/Lost
 events
Content-Language: en-US
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Miao-chen Chou <mcchou@chromium.org>
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <20220320183445.BlueZ.5.I53ad1b66c8f8a65e5950354cd20417d812ad9c72@changeid>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220320183445.BlueZ.5.I53ad1b66c8f8a65e5950354cd20417d812ad9c72@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Manish,


Thank you for the patch.

Am 21.03.22 um 02:36 schrieb Manish Mandlik:
> Display information about MGMT_EV_ADV_MONITOR_DEVICE_FOUND and
> MGMT_EV_ADV_MONITOR_DEVICE_LOST events in the btmon output.

If you should reroll this patch, could you please add example messages 
to the commit message?


Kind regards,

Paul


> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
>   monitor/packet.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index b7431b57d..6f615f7ba 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -14103,6 +14103,31 @@ static void mgmt_device_found_evt(const void *data, uint16_t size)
>   	print_eir(data + 14, size - 14, false);
>   }
>   
> +static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
> +{
> +	uint16_t handle = get_le16(data);
> +	uint8_t address_type = get_u8(data + 8);
> +	int8_t rssi = get_s8(data + 9);
> +	uint32_t flags = get_le32(data + 10);
> +	uint16_t data_len = get_le16(data + 14);
> +
> +	print_field("Handle: %u", handle);
> +	mgmt_print_address(data + 2, address_type);
> +	print_rssi(rssi);
> +	mgmt_print_device_flags(flags);
> +	print_field("Data length: %u", data_len);
> +	print_eir(data + 16, size - 16, false);
> +}
> +
> +static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
> +{
> +	uint16_t handle = get_le16(data);
> +	uint8_t address_type = get_u8(data + 8);
> +
> +	print_field("Handle: %u", handle);
> +	mgmt_print_address(data + 2, address_type);
> +}
> +
>   static void mgmt_discovering_evt(const void *data, uint16_t size)
>   {
>   	uint8_t type = get_u8(data);
> @@ -14414,6 +14439,10 @@ static const struct mgmt_data mgmt_event_table[] = {
>   			mgmt_controller_suspend_evt, 1, true },
>   	{ 0x002e, "Controller Resumed",
>   			mgmt_controller_resume_evt, 8, true },
> +	{ 0x002f, "Adv Monitor Device Found",
> +			mgmt_adv_monitor_device_found_evt, 16, false },
> +	{ 0x0030, "Adv Monitor Device Lost",
> +			mgmt_adv_monitor_device_lost_evt, 9, true },
>   	{ }
>   };
>   
