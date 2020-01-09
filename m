Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF94C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C0520721
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="YiuBPurr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgAIVAM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:00:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41795 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAIVAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:00:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so6248794lfp.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 13:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8UU+DJpOWw3Zqcq0Xnzgp9M7z6448NeFbIQSwFRzi14=;
        b=YiuBPurrBBzyrd0inyadXjuxvsHnGwBfd+mg1c9z6FtLDifRXaF4/tAlOqjGfO9WhR
         Ifx+5pqEZV9TQr6BZvfQ4Dzpf7blgvoJYHE+o+lw4PIZ499Eiehzw7ov88k/Mb3XcZwy
         cIlsp4r9j6KlIG0ERfH1zN+hAGpsNZ64voD7HsAt4OsiElAtFZQXbKK8dJ9ZlC8jA2TQ
         KoCycqjFqJDDKwXRbpgVNiiQOE1a7TftVNyS1j7AjQJC9LW0YVq/VwAkwgvA/Ych/Nlq
         3IutNZpjjAG9uhqYZlGUcTPeDNJd6aC7FVTatBmH7Qvcl73Y45F1SiaghfTwmC+2lmDA
         2GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8UU+DJpOWw3Zqcq0Xnzgp9M7z6448NeFbIQSwFRzi14=;
        b=lKlJREVxh9hucnqd5PWM+aNqany91MGE4tvZhg6uXM9a+yz/UV6I9WGQJFGausMwXI
         U5yaGyXtAly/+xEJN/0NyKAfEmghYjHqEh9wwt9t/gIhLZzO3KY93dCaq9S30NpaE3h8
         DwDbXlVZOrJ02Ume61t0ZKNhCGKEb7Ie2QOqbZzakyLMYK3kmJp80ZmaOPwxxhjSc/fd
         AOXdhIgK4QJVdhzanFfOryTSpGbAlPfdbpVACYyDDqgmZb5wkQBOTc+MYAA6x+1Jn2Nx
         SCir1WoQuIFsl3KQXu134XX49HUIB7UpYKCJKPCjU70hIiw11uuijX9Tk5UD8lv0HFD4
         wAkA==
X-Gm-Message-State: APjAAAVUy+raO4flyKfhXvPHxLY3uv9Ak349JJ/stdH/0Aff99Uk7odT
        G+0iersE9vfr28T3pcG8PHHIbg==
X-Google-Smtp-Source: APXvYqw3FF6e1r3S5qKAd65sDus/EI3y7VfAgk13kfgXNfsD7p+/GT2N5Or/mysHl16egocqchRlKw==
X-Received: by 2002:ac2:4212:: with SMTP id y18mr7300914lfh.2.1578603609487;
        Thu, 09 Jan 2020 13:00:09 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id y10sm3527806ljm.93.2020.01.09.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:00:08 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Thu, 9 Jan 2020 22:00:06 +0100
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Message-ID: <20200109210006.e3qv6uxnr2w3isc5@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20200109175715.22925-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109175715.22925-1-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 01/09, Inga Stotland wrote:
> When responding with NetKey List Status, packed NetKey indices into
> 3 octets per pair. If number of NetKeys is odd, append the last key
> index as a 2-octet value.
> ---
>  mesh/net.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/mesh/net.c b/mesh/net.c
> index 0a4d2e72c..90ebdf496 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -1065,26 +1065,46 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
>  bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *size)
>  {
>  	const struct l_queue_entry *entry;
> -	uint16_t n, buf_size;
> +	uint16_t num_keys, req_size, buf_size;
> +	struct mesh_subnet *subnet;
>  
>  	if (!net || !buf || !size)
>  		return false;
>  
>  	buf_size = *size;
> -	if (buf_size < l_queue_length(net->subnets) * 2)
> +
> +	num_keys = l_queue_length(net->subnets);
> +	req_size = (num_keys >> 1) * 3 + (num_keys % 2) * 2;

Please don't use bit shifts for division.

Also, I think it's clearer to write this as:
    req_size = num_keys * 3 - num_keys % 2

> +
> +	if (buf_size < req_size)
>  		return false;
>  
> -	n = 0;
> -	entry = l_queue_get_entries(net->subnets);
> +	*size = req_size;
> +
> +	/* Pack NetKey indices in 3 octets */
> +	for (entry = l_queue_get_entries(net->subnets); num_keys > 1;) {
> +		uint32_t idx_pair;
>  
> -	for (; entry; entry = entry->next) {
> -		struct mesh_subnet *subnet = entry->data;
> +		subnet = entry->data;
> +		idx_pair = subnet->idx;
> +		idx_pair <<= 12;
> +
> +		subnet = entry->next->data;
> +		idx_pair += subnet->idx;
> +
> +		l_put_le32(idx_pair, buf);
> +		buf += 3;
> +
> +		num_keys -= 2;
> +		entry = entry->next->next;
> +	}
>  
> +	/* If odd number of NetKeys, fill in the end of the buffer */
> +	if (num_keys % 2) {
> +		subnet = entry->data;
>  		l_put_le16(subnet->idx, buf);
> -		n += 2;
>  	}
>  
> -	*size = n;
>  	return true;
>  }

Tested-by: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
