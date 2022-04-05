Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA74C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Apr 2022 05:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiDEF4p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDEF4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 01:56:42 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79F6972E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 22:54:44 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae8ff.dynamic.kabel-deutschland.de [95.90.232.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BDBC61E64846;
        Tue,  5 Apr 2022 07:54:41 +0200 (CEST)
Message-ID: <da393b75-2e53-47aa-c499-9c66c03abf37@molgen.mpg.de>
Date:   Tue, 5 Apr 2022 07:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC BlueZ] gap: Don't attempt to read the appearance if already
 set
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220404201750.1082470-1-luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220404201750.1082470-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Am 04.04.22 um 22:17 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Devices are unlikely to change appearance over time which is the reason
> why we cache then on the storage so this skips reading it on every

s/then/them/

> reconnection.


Kind regards,

Paul

> ---
>   profiles/gap/gas.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> index ea3249be9..400818d67 100644
> --- a/profiles/gap/gas.c
> +++ b/profiles/gap/gas.c
> @@ -142,6 +142,11 @@ static void read_appearance_cb(bool success, uint8_t att_ecode,
>   
>   static void handle_appearance(struct gas *gas, uint16_t value_handle)
>   {
> +	uint16_t value;
> +
> +	if (!device_get_appearance(gas->device, &value))
> +		return;
> +
>   	if (!bt_gatt_client_read_value(gas->client, value_handle,
>   						read_appearance_cb, gas, NULL))
>   		DBG("Failed to send request to read appearance");
