Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA49C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C79A206B7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="XxHlq2Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQNeH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:34:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33482 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNeG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 08:34:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so22768785wrq.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BH6w80QxTdIP2HHzWV1JLbsVoRn3u0bYkHkZUerB7q0=;
        b=XxHlq2HrtXJ4ywwA3gkdqpYxz3x4N0S6FaifZ7fNVZt2X/BHEgCmZyZi5zEYa3D9fs
         azElc6L3eQKardWGG3krKrZo8GPPNpyALhJfG1rj7ZTgdHktosYlCfEFyKmQ8fCXpGs3
         603KtF6vFtV5uNp0sprU1HGpwWt4Jnm9tc66p0KQBLYzMp/kc8O/q+HaymaEsfDvU4IV
         O9ol1rST0UE70CXat+ahghPr6urJ16PxIGfFQf6XEKtWtp+az9DcHnjMVym5gQCB2Vfn
         y5iMTK6OWcy63hJdFzm2Fv5967eOK/RP5UJq+yuj60MOWrTpmvZ7OfaVKkOz93+6NT7x
         Xrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BH6w80QxTdIP2HHzWV1JLbsVoRn3u0bYkHkZUerB7q0=;
        b=VsWrwFB+2vCuAxpLtBljlM4cpSJaMuBEj5h0MsTsbjGK1S2unwFaAasKr4eNKj1CW/
         joucIcob6dnJQiLhQMiffE7V3YdGNN1Ezygl0+s6YT2GSFhF4mBl7SvGsGS7nhbeSsOy
         njmaNTQlr5i25O44M934n1hCHcdSFjQ1JrLy+3FCsrSaHVQH3bwcU7bnZjYwqOPWLO7U
         7NkIW46BlUIXfRwrTXwbGEK9CYa95FKAiSdH7z9TdCce4m44Bxid3Z/Kua+mRxKux88D
         w96SspOW5vMbzBYtxVCk2WGiExp+5ChtcSO/KhvDQtZfJRoXaPmfXKCak5mmoxCtMo8m
         Dp1g==
X-Gm-Message-State: APjAAAXItbTmpTExMo2NDy5lsSOvXliWAUGQLGj74cvl4Osm9VmfrfcI
        81VGLVFpKCDZYM3tl0hmVZbXxg==
X-Google-Smtp-Source: APXvYqxslLGlE2Z32JrwF68+UT/QTEzc2h4cRU8+oFlfKpGx4lqRoPme+GkRplsBopyQbwZagsOswA==
X-Received: by 2002:a05:6000:1052:: with SMTP id c18mr3041664wrx.268.1579268044819;
        Fri, 17 Jan 2020 05:34:04 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id c2sm34173581wrp.46.2020.01.17.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:34:03 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Fri, 17 Jan 2020 14:34:02 +0100
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Message-ID: <20200117133402.jvnrhoect6olamtk@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200117071604.20675-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117071604.20675-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/16, Brian Gix wrote:
> Any packet that may be handled internally by the daemon must be sent in
> it's own idle_oneshot context, to prevent multiple nodes from handling
> and responding in the same context, eventually corrupting memory.
>
> This addresses the following crash:
> Program terminated with signal SIGSEGV, Segmentation fault.
>  0  tcache_get (tc_idx=0) at malloc.c:2951
>      2951   tcache->entries[tc_idx] = e->next;
> (gdb) bt
>  0  tcache_get (tc_idx=0) at malloc.c:2951
>  1  __GI___libc_malloc (bytes=bytes@entry=16) at malloc.c:3058
>  2  0x0000564cff9bc1de in l_malloc (size=size@entry=16) at ell/util.c:62
>  3  0x0000564cff9bd46b in l_queue_push_tail (queue=0x564d000c9710, data=data@entry=0x564d000d0d60) at ell/queue.c:136
>  4  0x0000564cff9beabd in idle_add (callback=callback@entry=0x564cff9be4e0 <oneshot_callback>, user_data=user_data@entry=0x564d000d4700,
>     flags=flags@entry=268435456, destroy=destroy@entry=0x564cff9be4c0 <idle_destroy>) at ell/main.c:292
>  5  0x0000564cff9be5f7 in l_idle_oneshot (callback=callback@entry=0x564cff998bc0 <tx_worker>, user_data=user_data@entry=0x564d000d83f0,
>     destroy=destroy@entry=0x0) at ell/idle.c:144
>  6  0x0000564cff998326 in send_tx (io=<optimized out>, info=0x7ffd035503f4, data=<optimized out>, len=<optimized out>)
>     at mesh/mesh-io-generic.c:637
>  7  0x0000564cff99675a in send_network_beacon (key=0x564d000cfee0) at mesh/net-keys.c:355
>  8  snb_timeout (timeout=0x564d000dd730, user_data=0x564d000cfee0) at mesh/net-keys.c:364
>  9  0x0000564cff9bdca2 in timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x564d000dd730) at ell/timeout.c:81
>  10 timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x564d000dd730) at ell/timeout.c:70
>  11 0x0000564cff9bedcd in l_main_iterate (timeout=<optimized out>) at ell/main.c:473
>  12 0x0000564cff9bee7c in l_main_run () at ell/main.c:520
>  13 l_main_run () at ell/main.c:502
>  14 0x0000564cff9bf08c in l_main_run_with_signal (callback=<optimized out>, user_data=0x0) at ell/main.c:642
>  15 0x0000564cff994b64 in main (argc=<optimized out>, argv=0x7ffd03550668) at mesh/main.c:268

Hm. I can't seem to wrap my head around this backtrace. Do you maybe
have a reproduction path?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
