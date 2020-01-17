Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD0C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000782073A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oN+JegdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQOgo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:36:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37746 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQOgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 09:36:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so22991620wru.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lZFcJOkb9xFI3EaRgQob5TrRRWvhpKiRf5M/zbzi3CM=;
        b=oN+JegdN/E5hIuX55mZMy8h78WkCehD+H7A4FKmvZNeBd9N3fJB4MtJdeaCo0z46I5
         L9Js+oCIoCWTPgU+EFTmsh99FLYGWoelO4uxccNxGQz/C+uGhER9OcSZ0N5t/ZrVkl+A
         vLjArY/XmWymid6yGTBEWBQdd3ypkQM7/ULqB+Nu34PamhTs8ZrGbyHOePsVZ59fJ9Nn
         BFJRxCy7g11ujB0XRnQrZbRNl2BhHEQGPcJmvl9Ob2sh2sX09ZYVpK6kpGqY9GXxYfJ8
         Piwi7n4LXlMT0rZykWSmQhhX9x4Hb9KH/XtpLi44qPp0AY6V304iBuSqhBHmIjkVmQzm
         o6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lZFcJOkb9xFI3EaRgQob5TrRRWvhpKiRf5M/zbzi3CM=;
        b=IDoCon+W0QqALkO675YRHjVimGS/Mn6V1Pku1fywfGGKiXM/YSbWLuVVp0B1lX8DPQ
         nzU93wNmrMOKUYECETp8VvPExD5QeGjkMG49lNVCE2zJGvskrUW61XNkNLJ79DHY+j8a
         0Da8IX20cQfX5EIVxjFWjXetlZIovGyHtvciSgWOm+7jnqsZr43gX3de8WvxpZ9l6iGp
         JyjtufzuLzem/3IDaIX6wTWvmPQPkc6GB9b/6B9TRAhbrabhTuA6EUnP7h3PezfOfaTr
         87cpKu420aDm6qzyeQ3pZA7m1jL8cgtcAM4LSF3873iAHZ1M/U7j7dFsfhexgCcUv+2q
         vx+Q==
X-Gm-Message-State: APjAAAU+6KLyeOpDlN73dMZIJiARjQVcLSec1UH+e7hVr/VmLQ07QipC
        OFcWtubrfO7i/2hhHgVj4EkJDw==
X-Google-Smtp-Source: APXvYqz2cyBpV3zsEXDKToUBcrhneyCit32llLxG4SO2At8mhhIFC0605i5NVvCNJfOk5J9yOqJA2A==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr3257847wrx.141.1579271802236;
        Fri, 17 Jan 2020 06:36:42 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm366671wmk.35.2020.01.17.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:36:41 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:36:40 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Message-ID: <20200117143640.7erexoeo6bsevnky@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200117071604.20675-1-brian.gix@intel.com>
 <20200117133402.jvnrhoect6olamtk@mlowasrzechonek2133>
 <E1B6E49B-2246-4C1E-9C3C-D15CA1B6DF9C@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1B6E49B-2246-4C1E-9C3C-D15CA1B6DF9C@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/17, Gix, Brian wrote:
> > Hm. I can't seem to wrap my head around this backtrace. Do you maybe
> > have a reproduction path?
> 
> The backtrace doesn’t really show what has gone wrong very well,
> because what has happened is a heap corruption. The seg fault occurs
> during a memory alloc sometime later.
> 
> The physics of the problem, is best shown by local config client
> requesting segmented composition data from a local config server.  The
> one request, all response segments, the return seg ACKs all happen on
> the same C calling stack which gets *very* deep, and steps off the
> end, since nothing goes OTA. It does *not* happen during OTA
> operations because each discrete packet starts from a fresh C calling
> stack from main().

Yeah, I got that part - l_idle unwinds the stack so that everything
starts from the beginning, it'a pretty standard technique for main
loops.

What I couldn't find is the exact place where send_msg_pkt recurses, but
I think I've found it now, e.g. in this call chain:

    send_msg_pkt
    net_rx
    packet_received
    seg_rxed
    send_net_ack
    mesh_net_transport_send
    send_msg_pkt <- here

In the end: the patch is fine, but maybe change the commit log and/or a
comment, since, as you remarked, the backtrace doesn't explain much?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
