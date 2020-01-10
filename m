Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438EC282DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9302072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="rcmqgfVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgAJXrO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:47:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34527 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgAJXrO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 18:47:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so3881334ljg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=splxgu4LsMaO+TwCG5UFmZ1b08IbiVGGpmLDH8dQIPQ=;
        b=rcmqgfVeU1jwA3q4Qef2Llsir2MkyVegMqE7bWc6EVYADN13s2wUiU/WyaPwQcC+Mw
         GNNoVXNA6GyMYkT1JAIulLGFArufbHvyJYQ6ty1P9zR7zrupLyUzxRY8Ccx77X9B0dpK
         Hh6941nKvjsmY0vJQzVCL1Ld9iiuGJ4VZfLkpMUQQlgfbvjt8SbOmTc1cgJX7bTdBzW0
         A6fpflspVmZF92zmUwn7Tk3MGb5zviDxr7ayaGdVtnrwZFEdwMgHC5YKR1+K7yw7oPC7
         B7pMMiPlfoHk8inQ+Tkk5y2yHSqiJ6t3tOatcrSdoiiT/C7q31h3lNGynIi2gADdxt/P
         GjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=splxgu4LsMaO+TwCG5UFmZ1b08IbiVGGpmLDH8dQIPQ=;
        b=I9ZjJdxLaMdgxy3uvHeQX3nEY+3QCixL0KBuDnvAY2F8NQE5pfErfPob5mz8+ZdAF/
         QNuOflm2Yj1FBj19BUjTzqfntO6Om+4hOxbeXdbInnICsHxUMkPLOvpl6DQDwLr9gvfY
         czv2C1WAdMOom3Rp4k9kIvytwC3JX52esBo1RpOChTi7Vsrb4cSz1S+26TS/cNmlPNNm
         FTjOovTQn+oenWRSSyw5YQrrZhqL7N1aGZRcibV3K19xAJNcQNwK3KO4Ed5CD9CTI5UC
         ysERPJI6OUqL7c6tzCzWY0dPhhPZGKzRdTBjT7Hu0X8RLkM3mm4xyWPPnHruuNVVRQna
         Kocg==
X-Gm-Message-State: APjAAAWQMTuSgZrAIlgtMpP3eB3TNIz1KZxtFsj9NTJxh0raWnO+rrT2
        ICQSw01F5M7DWkMGNPMXAr78vQ==
X-Google-Smtp-Source: APXvYqyX+8GDkcnDnUgcydrGncVzRCt1r2Ca8dCjS4bJ8Fts81in4AA/+KS1bdDcjElJP/zTzGuWDg==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr3988277ljm.58.1578700032247;
        Fri, 10 Jan 2020 15:47:12 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id w19sm1734702lfl.55.2020.01.10.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:47:11 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Sat, 11 Jan 2020 00:47:09 +0100
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ] mesh: Implement provisioning loop-back
Message-ID: <20200110234709.ihnstfmahenstspp@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200110181437.31167-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110181437.31167-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/10, Brian Gix wrote:
> This allows one App using the mesh daemon to provision another.

This patch contains also some wording cosmetics and other PB-ADV fixes
that don't seem related to the loopback mechanism.

Could you please split this into a patchset?

> +static void loop_adv(struct pb_adv_session *session, const uint8_t *data,
> +								uint16_t len)
> +{
> +	struct idle_rx *rx = l_new(struct idle_rx, 1);
> +
> +	rx->session = session;
> +	rx->len = len;
> +	memcpy(rx->data, data, len);
> +
> +	l_idle_oneshot(idle_rx_adv, rx, NULL);
> +}
(...)
> +	if (session->loop)
> +		loop_adv(session->loop, buf, init_size + 10);
> +	else
> +		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200,
> +							buf, init_size + 10);

This condition check is repeated throughout the code. I think it would
be clearer to replace mesh_send_pkt usages with something like:

static void pb_adv_send(struct pb_adv_session *session, uint8_t count,
				uint16_t interval, void *data, uint16_t len)
{
	if (session->loop) {
		struct idle_rx *rx = ...
	} else {
		mesh_send_pkt(count, interval, data, len);
	}
}

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
