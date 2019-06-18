Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B40C31E51
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CE62080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="BY/SsPgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfFRHgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:36:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42214 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRHgE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 03:36:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so8446819lfh.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k9obQVqJhJdcEWxTNyyv7zM7pVmu5cowlAzUxzKSDdU=;
        b=BY/SsPgbfiFLE9zULsxD4VxWim0mQhsuow5PSXyfkd4CCrYLpzX3zGMUqU1ztsxXBw
         SREZjIg4hyHjRHFiribU9NhkUFNPDxqjiu0BRGFf1wfOUmIFKES69Qswy/lH+UwSEgn/
         ogr4JXRpxqqPUgiUIUZ2NiOVl6ul2+TiEsocTbLjQb/YpbEdZU5M603YClUFK9dq/br6
         XlrAIINYzobmUZLJlkiHX7XwWCLxuE1Tpqz3hnrb6EsZT/otHCsdD9b1MaBewiF83pA7
         iVvHbZwhZ47ARFHzgpScu7QiFtqLdSSZEUi86acEJ9HiO68og16JmfB8uGiKI4BGIRJK
         OjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k9obQVqJhJdcEWxTNyyv7zM7pVmu5cowlAzUxzKSDdU=;
        b=QxQLH5mAVCp3rbSgde0Ym6S1xEchGRMSD3DONdfiiV+8mPhUuxksgQWsXna/Gu+850
         Pc9RqgPdEeeWPJJhV4ldgXyS2URKKjVqEday/L/9x1gfVhkqYOe1wV6/r05qTe8vEi9J
         38Z7t6HAPJeHbiUkmZ9bs3YkShLpyWYi/EFNmfTB7MRD5TAmwTSGN41+eho7+UWGntxt
         gXcZhHV0imjFRtayU6oCmnKeSCjJ6LRu8i60p94ShDVRaCZKjLkhwg3hMm8O9abaUVA7
         X77IXm40mViqraiEY8xvetviVcOBST+V8d6+7JUUyVwcq+xh8+IW5qNgVHMiRGzP0Nj+
         uVRw==
X-Gm-Message-State: APjAAAVJAisS3Waf4ezRoBYlF8Ns5xwkg7vU+u8jqtlxD0uZuF5WrGuJ
        yt+GTopftL4T+iJb367CHK6yZA==
X-Google-Smtp-Source: APXvYqxXr/jtMCOKtXER6EcvKIgPyJ4wXeB/t85Y2kaac4uQv6cXEDmmj6RuKGCxK+vk8Ta5mqLX3Q==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr29366903lfi.127.1560843362380;
        Tue, 18 Jun 2019 00:36:02 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r11sm2723692ljh.90.2019.06.18.00.36.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 00:36:01 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Tue, 18 Jun 2019 09:35:59 +0200
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ] mesh: Clean up includes
Message-ID: <20190618073559.tmpaj2oellkf5354@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20190617213847.21705-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617213847.21705-1-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/17, Inga Stotland wrote:
> This adds #include for json-c/json.h in mesh-db.h and removes this
> include from the other files that don't need to reference json-c.

While I agree about removal from cfgmod-server, model and node, I don't
think we should remove the include from storage and move it to mesh-db.

I'd rather see #includes follow https://include-what-you-use.org/
approach, that is:

    (...) for every symbol (type, function variable, or macro) that you
    use in foo.cc, either foo.cc or foo.h should #include a .h file that
    exports the declaration of that symbol.

Moreover, I think headers should only be included as-needed (mostly in
.c files), and headers should contain forward declarations of various
types, to make them opaque.

Such an approach cuts implicit dependencies, making code maintenance
easier: when, for example, someone decides to refactor mesh-db not to
use json_object anymore, they shouldn't need to suddenly deal with
missing declarations in other modules (in this case, storage).

Moreover, each header should be self-sufficient: in order to use API
exposed by a given header, it should be enough to include that header
only. At the moment, this is not the case.

A minor side-effect would be faster builds and less rebuilds when code
is being worked on.

If you agree, I am more than happy to fix this throughout the mesh/
codebase.


regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
