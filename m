Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D12C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 07:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjEQHeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEQHeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 03:34:00 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4280C49C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 00:33:24 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5aebba.dynamic.kabel-deutschland.de [95.90.235.186])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0EF3661E4052B;
        Wed, 17 May 2023 09:33:18 +0200 (CEST)
Message-ID: <9c4c67d0-7a51-5dbf-a05c-46103c694f39@molgen.mpg.de>
Date:   Wed, 17 May 2023 09:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
References: <20230517072706.5988-1-iulia.tanasescu@nxp.com>
 <20230517072706.5988-2-iulia.tanasescu@nxp.com>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230517072706.5988-2-iulia.tanasescu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Iulia,


Thank you for your patch.

Am 17.05.23 um 09:27 schrieb Iulia Tanasescu:
> It is required for some configurations to have multiple BISes as part
> of the same BIG, which is now covered by iso-tester in the following test
> case:
> 
>      ISO Broadcaster AC 13 - Success

Thank you for adding a test. Did you also test it on hardware? If so, 
please document your test setup.

A diffstat over hundred lines should have a more elaborate commit 
message. Could you please add a short note about the implementation?

> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>   include/net/bluetooth/bluetooth.h |   2 +
>   include/net/bluetooth/hci.h       |   7 ++
>   include/net/bluetooth/hci_core.h  |  32 ++++++-
>   include/net/bluetooth/iso.h       |  14 +++
>   net/bluetooth/hci_conn.c          | 150 ++++++++++++++++++++++++------
>   net/bluetooth/hci_core.c          |  18 ++++
>   net/bluetooth/hci_event.c         |  98 +++++++++++++++----
>   net/bluetooth/iso.c               |   4 +
>   8 files changed, 277 insertions(+), 48 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 1b4230cd42a3..28a3b105fdf3 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -198,6 +198,8 @@ struct bt_iso_bcast_qos {
>   	__u8  sync_cte_type;
>   	__u8  mse;
>   	__u16 timeout;
> +	__u8  dummy[2]; /* Dummy octets for padding compatibility with old BlueZ */
> +	__u8  num_bis;
>   };
>   
>   struct bt_iso_qos {
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 07df96c47ef4..7567cbecf937 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1,6 +1,7 @@
>   /*
>      BlueZ - Bluetooth protocol stack for Linux
>      Copyright (C) 2000-2001 Qualcomm Incorporated
> +   Copyright 2023 NXP

Above, Copyright is followed by (C). Should it be consistent?

[…]


Kind regards,

Paul
