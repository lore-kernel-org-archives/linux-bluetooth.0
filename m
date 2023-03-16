Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B07C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCPUxa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCPUx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 16:53:29 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA0637C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 13:53:25 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aeb78.dynamic.kabel-deutschland.de [95.90.235.120])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6765761CC457B;
        Thu, 16 Mar 2023 21:53:22 +0100 (CET)
Message-ID: <f2e315f6-c93b-2950-1841-0515d9a03f85@molgen.mpg.de>
Date:   Thu, 16 Mar 2023 21:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH BlueZ 1/2] tools/mesh-cfgclient: Prevent storing duplicate
 models
Content-Language: en-US
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com,
        brian.gix@intel.com
References: <20230316180759.147486-1-inga.stotland@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230316180759.147486-1-inga.stotland@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Inga,


Thank you for your patch.

Am 16.03.23 um 19:07 schrieb Inga Stotland:
> This fixes the situation when subsequent requests to get a node
> composition result in appending element's model list with duplicate models.
> This adds a check for a presence of a model on a element when attempting

a*n* element

> to add a new model ID to a model list on this element.

How can this issue be reproduced?

> ---
>   tools/mesh/mesh-db.c | 17 ++++++++++++-----
>   tools/mesh/remote.c  | 12 ++++++++++++
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
> index c0c05a29a..1d047691d 100644
> --- a/tools/mesh/mesh-db.c
> +++ b/tools/mesh/mesh-db.c
> @@ -1964,28 +1964,35 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
>   
>   		while (len >= 2 && m--) {
>   			mod_id = l_get_le16(data);
> +			data += 2;
> +			len -= 2;
> +
> +			jobj = get_model(unicast, unicast + i, mod_id, false);
> +			if (jobj)
> +				continue;
>   
>   			jobj = init_model(mod_id);
>   			if (!jobj)
>   				goto fail;
>   
>   			json_object_array_add(jmods, jobj);
> -			data += 2;
> -			len -= 2;
>   		}
>   
>   		while (len >= 4 && v--) {
>   			mod_id = l_get_le16(data + 2);
>   			mod_id = l_get_le16(data) << 16 | mod_id;
> +			data += 4;
> +			len -= 4;
> +
> +			jobj = get_model(unicast, unicast + i, mod_id, true);
> +			if (jobj)
> +				continue;
>   
>   			jobj = init_vendor_model(mod_id);
>   			if (!jobj)
>   				goto fail;
>   
>   			json_object_array_add(jmods, jobj);
> -
> -			data += 4;
> -			len -= 4;
>   		}
>   
>   		i++;
> diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
> index cee711dec..ec1476ac9 100644
> --- a/tools/mesh/remote.c
> +++ b/tools/mesh/remote.c
> @@ -54,6 +54,14 @@ struct rejected_addr {
>   static struct l_queue *nodes;
>   static struct l_queue *reject_list;
>   
> +static bool match_mod_id(const void *a, const void *b)
> +{
> +	uint32_t id1 = L_PTR_TO_UINT(a);
> +	uint32_t id2 = L_PTR_TO_UINT(b);

Why not `unsigned int`?

> +
> +	return id1 == id2;
> +}
> +
>   static int compare_mod_id(const void *a, const void *b, void *user_data)
>   {
>   	uint32_t id1 = L_PTR_TO_UINT(a);
> @@ -227,6 +235,10 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
>   	if (!vendor)
>   		mod_id = VENDOR_ID_MASK | mod_id;
>   
> +	if (l_queue_find(rmt->els[ele_idx], match_mod_id,
> +							L_UINT_TO_PTR(mod_id)))
> +		return true;
> +
>   	l_queue_insert(rmt->els[ele_idx], L_UINT_TO_PTR(mod_id),
>   							compare_mod_id, NULL);
>   


Kind regards,

Paul
