Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B413C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F4207E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gbJy9oa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOTJJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:09:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36339 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAOTJJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 14:09:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so13586190lfe.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mpx/BfaMH53DrJbQQGbvjglxbmBASWfs+0RtN4pfmL8=;
        b=gbJy9oa7yCGe4ttyco0IMgS52VL164H9GJEH1xDRH1Tvz5fTn+BatPlFCOAVeovKm+
         IRMdpf3Kt0VIk/WVnfpNZgJGWGfr8JM7bvS/wAuniHaMZDJOXPJRKTqUGmdBnCzIcq5I
         3N24fxhYmih63Q+mB/1iJ46TXD7YTJkC+Sh8GMPXnO4c3FjXWC4Om755bOVXVqSSgPHN
         pTQ0pIfZ5pBEX74lVUH8BjT87kFsX5vYfa6LYRlh7JRqZmEC+Avb/giNOMAnMmzPIDNV
         q/cn3b4lSo9GVSTxK00ghSZYNVRqMse46QdTzc1pwN472sfyk0xdv12HIuN7uCoCMy93
         TKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mpx/BfaMH53DrJbQQGbvjglxbmBASWfs+0RtN4pfmL8=;
        b=WCLkMo0fn97NGWZMR9M5b97ZAnLx3p8sKkcttOKQUhfu7NhZQaFoDOVY1RFuxOEt6r
         lL0ZGh3MJ9M0xloeEw3j/KxHyTOUc9TJrbt3yFfyi2FsaXzIoA89meio1pJIhAhYIrXF
         JdG32wjIUMjk7QuWk28F9om1WJiZHpZCrh6gk3SATKl+NZpEmWv5eq4U4sO0zAK5qZ4C
         OkObYA9shYyiX8A3MBntiJBqh3pJ9qnp4ABDwhe2MZBPXNuXwIssKOO9vI9aKMO2w+dO
         LyUYRPriaCepCONtvdTRB8O99DjPuO0ZfjW3l5u8ofvC1yVF+guHW24wul5TGsAsIA4m
         jTkg==
X-Gm-Message-State: APjAAAUVybZTpY2M15xdYmNQfVNf0TZzVhkEgKQRcUU0+laAKIxJU4nL
        YSYwxaUpMr6H33oXpcxXRGn+dYt4S30=
X-Google-Smtp-Source: APXvYqxXrykbqIJpy7w13b1PZWPlB6c/J4Mufo2ZuozF1gPKFublWuWqQQRhq0F2XeS/kzGFYNoSBw==
X-Received: by 2002:a19:f519:: with SMTP id j25mr219218lfb.41.1579115347539;
        Wed, 15 Jan 2020 11:09:07 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id y8sm9616715lji.56.2020.01.15.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 11:09:06 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:09:04 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Message-ID: <20200115190904.qcusabsj3ti7sid4@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "istotlan@ingas-xps13.amr.corp.intel.com" <istotlan@ingas-xps13.amr.corp.intel.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
 <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Jakub,

On 01/15, Gix, Brian wrote:
> This is a very dangerous course of action.  The suggested patch might
> potentially cause a node to re-use a sequence number more than once,
> which would cause a "dirty nonce" condition, and allow unauthorized
> entities to derive the encrypted data without the keys.

Good point. Note that his is also possible in the current
implementation: since seq_num is applied to nonce with a 24bit mask,
it's going to wrap around.

> While this is technically possible, especially with a daemon that
> might be looping back messages internally without ever using the OTA
> interface, it is not really possible in an actual BT driven real life
> system.

There is another option to exhaust the 24 bit range: we have the
overcommit mechanism in the storage. Let's say the daemon starts, sends
a few messages (and overcommits the sequence by a certain value), then
either the daemon, or the system crashes.

Do that a few times, and you end up with storage containing sequence
number exceeding 24 bits.

> Beacuse we store sequence numbers internally with a u32 sized data
> type, we should *let* the value go over the max legal sequence
> nunmbver of 0xFFFFFF (perhaps capping it at 0x01000000 to prevent
> "super overflows").  Then we *reject* all send requests with a
> sequence number > 0xFFFFFF.

Sounds good.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
