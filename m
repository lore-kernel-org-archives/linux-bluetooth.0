Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A8C48BD6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 08:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1238C2082F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 08:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JcdKKNwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0IZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:25:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43345 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0IZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 04:25:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so1395034ljv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DNAfkzKsEV8MqrScPAYLv+RA9PlvozRcj9mz2DIOnM0=;
        b=JcdKKNwXgY8UcLVNTdbyTq3KfKQDW5jX1yBa9J3raUsaxfvIBaZW9EaCHAsowWkHiV
         bXOSGd9svZ8B4ju1MD1qEujHZJWJsTNMGgsFu13HDTwxRlpYXXe4GyfGW0cRXa0oB6Qj
         6UWUZ7KksGgM9bJFxMoMNLysCxqf9UMB3kqc2Lx7L8zzfbclSMfBwI1YRe9wu6J5NTu2
         TLUcrmtNtEs/8VRcWOY5XmCXXDwPxqGx8sS0+YuNoSzbOrtm8KqWsMKD2uzLeMCnXZIK
         rhRgDGUXFNNudZ9b7jxPmhAT/93LSXe/MDP0b5tWEODyEVTTedQL2Erg+mAsaYJNLkRE
         8+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DNAfkzKsEV8MqrScPAYLv+RA9PlvozRcj9mz2DIOnM0=;
        b=Jw43Aebqzvi6FPsZIU09Bfr36ZaQeUS9UgfrcP8+5x1zcoJsDL9pGBeEoKJJQX9RLq
         rh57SvBecm5MfUxhM1xM4H7sY+CTkTNTB6EaYbXH4qi1H32hn1QEfljbzv/3qtOIyrga
         oAy6cCpxAcjgAuknZS3EO+XAFJLdxtndS5L7WWfVdM1duaEAd12AwynBTpGtvmXMYD9L
         Vqepb2UIqPkoFWlV7Li0jIJHRFsNBcvqmcTeyCztjz8EWLWTDKJQQMmuMxWNC0yR0ma6
         LT26QEHjg6Yzi4rmmvV2/+mbnA2TW75Gt39/IVzkb5deiTNdwrZZQ2qSiGktBrrIcAVD
         EPeA==
X-Gm-Message-State: APjAAAV0fwy+CexdOxAgoeP9/Mx43yZk2t/FMq5GLcK0PsNHXHxTVROY
        fdcI8VQXrdkWkS7GpoVIWJngp9YaXqs=
X-Google-Smtp-Source: APXvYqxM2+PZdxncKA169yFVy2hID/bzz6AsoSY/78u6UkoR19/ts9EO6B3ZJGMT4RXymafOnjcI9g==
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr1793174ljl.235.1561623950700;
        Thu, 27 Jun 2019 01:25:50 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h84sm247247ljf.42.2019.06.27.01.25.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 01:25:49 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:25:47 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
Message-ID: <20190627082547.dpoymsqlufh32ex5@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
 <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/27, Michał Lowas-Rzechonek wrote:
> If we are in IV Update state, packets shall be transmitted using IV
> Index - 1, including relayed packets.
> ---
>  mesh/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mesh/net.c b/mesh/net.c
> index a5693f154..0a6ff8eac 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -2512,7 +2512,7 @@ static void net_rx(void *net_ptr, void *user_data)
>  	relay_advice = packet_received(net, key_id, iv_index,
>  							out, out_size, rssi);
>  	if (relay_advice > data->relay_advice) {
> -		data->iv_index = iv_index;
> +		data->iv_index = mesh_net_get_iv_index(net);

Ew, I misread the spec.

3.4.6.3 explicitly says:

"When a message is retransmitted, as defined below, the IV Index used
when retransmitting the message shall be the same as the IV Index when
it was received"

Please disregard this patch.

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
