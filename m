Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B7C6FA9D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 16:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCAQBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAQBU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 11:01:20 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809F43453
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 08:01:19 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 824AD61CC457B;
        Wed,  1 Mar 2023 17:01:16 +0100 (CET)
Message-ID: <3c07d6d8-336d-67d8-8d64-7126b04f35f2@molgen.mpg.de>
Date:   Wed, 1 Mar 2023 17:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH BlueZ 1/2] lib: Add BASS UUIDs and auxiliary defines
Content-Language: en-US
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
References: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
 <20230301134207.10924-2-iulia.tanasescu@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
In-Reply-To: <20230301134207.10924-2-iulia.tanasescu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Iulia,


Am 01.03.23 um 14:42 schrieb iulia-tanasescu:

Please spell your name like Iulia Tanasescu:

     git config --global user.name "Iulia Tanasescu"

> Added BASS and Audio Announcement UUIDs, added OCF for
> BIG Create Sync.

Please use imperative mood [1], and mention the source for the numbers.


Kind regards,

Paul


[1]: https://cbea.ms/git-commit/

> ---
>   lib/hci.h  | 2 ++
>   lib/uuid.h | 7 +++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index 50f385c1e..d01e6f8ee 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1731,6 +1731,8 @@ typedef struct {
>   } __attribute__ ((packed)) le_set_address_resolution_enable_cp;
>   #define LE_SET_ADDRESS_RESOLUTION_ENABLE_CP_SIZE 1
>   
> +#define OCF_LE_BIG_CREATE_SYNC			0x006B
> +
>   /* Vendor specific commands */
>   #define OGF_VENDOR_CMD		0x3f
>   
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 84ff46cd8..a6bbc3770 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -164,6 +164,13 @@ extern "C" {
>   #define ASE_SOURCE_UUID					0x2bc5
>   #define ASE_CP_UUID					0x2bc6
>   
> +#define BASS_UUID					0x184f
> +#define BCST_AUDIO_SCAN_CP_UUID				0x2bc7
> +#define BCST_RECV_STATE_UUID				0x2bc8
> +
> +#define BCST_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1852
> +#define BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1851
> +
>   #define VCS_UUID					0x1844
>   #define VOL_OFFSET_CS_UUID				0x1845
>   #define AUDIO_INPUT_CS_UUID				0x1843
