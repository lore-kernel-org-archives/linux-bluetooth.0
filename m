Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BDDC41513
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 11:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGYLsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjGYLrg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 07:47:36 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2941BE1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 04:47:33 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6E68461E5FE01;
        Tue, 25 Jul 2023 13:46:58 +0200 (CEST)
Message-ID: <7637dd8a-6dc5-eea8-e706-941113ca2f22@molgen.mpg.de>
Date:   Tue, 25 Jul 2023 13:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH BlueZ v3 3/3] shared/vcp: Corrected handle size to
 accommodate included service
Content-Language: en-US
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        pav@iki.fi, luiz.dentz@gmail.com, sathish.narasimman@intel.com
References: <20230725112126.49656-1-nitin.jadhav@nxp.com>
 <20230725112126.49656-4-nitin.jadhav@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230725112126.49656-4-nitin.jadhav@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Nitin,


Thank you for your patch.

Am 25.07.23 um 13:21 schrieb Nitin Jadhav:
> Fix: As per specs VOCS is secondary services hence it should be included

singular: service?

> under a primary service VCS. Current number of handles should be increase

increase*d*

> to accommodate the included service.

I’d always use imperative mood (also in the commit message summary):

Correct handle size to accommodate included service

or

Reserve one more handler in VCS service for VOCS

> ---
>   src/shared/vcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 0408531b2..263da4c30 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -998,7 +998,7 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
>   
>   	/* Populate DB with VCS attributes */
>   	bt_uuid16_create(&uuid, VCS_UUID);
> -	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
> +	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
>   	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
>   	gatt_db_service_set_active(vdb->vocs->service, true);
>   


Kind regards,

Paul
