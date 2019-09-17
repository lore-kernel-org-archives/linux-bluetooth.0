Return-Path: <SRS0=BfW8=XM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499BC4CECD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB18921670
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 06:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="PDwKpRT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbfIQGxn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:53:43 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:47072 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfIQGxn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Sep 2019 02:53:43 -0400
Received: by mail-lf1-f41.google.com with SMTP id t8so1888872lfc.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RKSy4FQTg9iuem0BofKX6GVPytulTjaT8ZG53h9lgJA=;
        b=PDwKpRT32X/2hNZOz4oxFa/bG6JR/7GzRoxQBbyfDBz+8A0e4ACyMFQSxwNIV+/37F
         haFjP7vk7x4DsQE2VIwizcHSAk/uueAMbBl9KH/6DzCU0EBs5Jp2YPOsfULmD0rJ+biB
         lWIbyjzt4sLcmiO42TfQVXkrPUyfJCkiQXg84wo4fzy7L517M0LY7yXV9wdt/JQ/SBSd
         kXCje9+kJag3fCJF86dxP/ApG8vBCwPNlaCEEu6af6Pla4hFnDPPFWdSo6GbfxJFeZw2
         73yqUMg5dByhxTgYMuDIZgLFLDQKLQ/V2NMgiq66CsZZ/lyFRjXTFsVcZE/95Kc+aULf
         B4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RKSy4FQTg9iuem0BofKX6GVPytulTjaT8ZG53h9lgJA=;
        b=ST4FuJA8gy6R4MC+aH74iYzB0OMzdwMLM/gfqaK0udH1tYpg86POWXnfqr858m+Q+4
         r4kA5D5q6q407XbiUPJxTTmf6WJH2/yZ44YhWFP95WhGhLeOHK4i4zgN0Y4AMTMYT1aG
         NZZLxeAy/JTBSFQNbZqggRzOLr9+Y5iJSXfJOupf+z/aQGRL2ZBmpwo6iuN2RllUP8BC
         mJN7yQYYZTlCF2ZyjIojF1fRdKgFSxOcenNimW8u0GruOEFb/55DraZQ2auwqSg3v1+b
         VPWiD7ThdJn3ASxnOtv4+WWXkQH7uXMvlK0M2HouDo8ybp/OBZlshAiJOmyrWjt0wX5T
         CAQg==
X-Gm-Message-State: APjAAAVoTjG86KV3zVpjndmT7l5LdpS+wZbZIQKCUe4T/3J7c48fbRGA
        fN3Tas+Sxyx3np4NIMlTucSjbhMI16I=
X-Google-Smtp-Source: APXvYqwWx1+IDE6djtevwx2lOYVhh0068owLrD7dtw1YXE7hQvynF8Q+hlImsbCb2GV1GqDnJnhtgg==
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr1186061lfq.37.1568703220443;
        Mon, 16 Sep 2019 23:53:40 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 81sm240318lje.70.2019.09.16.23.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 23:53:39 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:53:38 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Message-ID: <20190917065338.nfwumstizy3yw67d@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>
References: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 09/09, Michał Lowas-Rzechonek wrote:
> This patch ensures that Sequence Number is reset only when IV Index used
> for outgoing messages increases.

Did you have a chance to take a look at this?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
