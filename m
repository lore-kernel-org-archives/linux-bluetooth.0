Return-Path: <SRS0=/e8j=W7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2AC3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6278C22CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 19:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="G8bi5DgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDTsO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:48:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46770 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDTsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Sep 2019 15:48:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id e17so9829401ljf.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2019 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=73RAgDI06S2z4waitXKG+YdGLcK+Sgfb8+gbBum1B4c=;
        b=G8bi5DgTCOW0vc5zG+014H/7z74lebXDvUlyZcxA8TCQ8QinyY/ETAKyzg4qtkW4xh
         DDVKlQUVM47gYnlOhEn1mnCCku25zeUGCVVyspveb7+M/LJh9o+HZPnCcByFURW5UJ0B
         vLUaKcDozH3TMqT1Xd6IJu9tYULE/3KMVvfBJYH1xmHrmD2ZlIidymtN0Q/ZLeBYrl5i
         jtlfrZ6bpwVyvwtRMv8Mr46CWUzgopSy39en58fsZaXjJYrQc6XN9nlPsUK9nmL2b7lp
         JfK069kZspUvyC8CpubFQL8H4R3tgOaOFI6Td/hGWAKl/ZVZXj7I9cT7TApdiYuOwEPi
         B0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=73RAgDI06S2z4waitXKG+YdGLcK+Sgfb8+gbBum1B4c=;
        b=qeMWFBL7CD0GKW+5gbZj+Cy3vcnKBLW1/UJ6xVCNjrL4dUm76PlXyH/MlBF7cKkt9a
         6yM7rvv0co9Ybf4vWnhyJQzHQaFVUZqilug9+OKSC/hjhttAuGfqd4Q+/RuTMDXkFnou
         8oOcV39EcM800/LncdSl1Yi5pI6ohFCEaeLPjYM9Y9M2eKDwk8YraSm2NFW5xVm3Kq1S
         Pp2Vor8QVB2n6IKzFeOCXOhMEb7dAn7MPHVZvnS4ILaOaVlayfqSXND6EMl/7p8TTULj
         E1ZxctZteQ9hp9Cp0QJdN3oes6dE8aARVsdyCcWgu68XwFIstPSQfI1yjp14at8A0mMl
         1HDw==
X-Gm-Message-State: APjAAAV8csQTPHMRmOlH8BSHifkoCdXaOB1PKJKKwqy4S3X5G2P9JQAp
        PDIqliO8yZGXVal5ObCabetuDqV94Zo=
X-Google-Smtp-Source: APXvYqyVB+dCqfGfK7stfJKB28z78eRpa4Nao4RFN6GzGPSJOFnpsPi2OVsg0KXxUbxvzGAhxC3vNQ==
X-Received: by 2002:a2e:a303:: with SMTP id l3mr2664274lje.124.1567626491637;
        Wed, 04 Sep 2019 12:48:11 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id b9sm3520991ljd.52.2019.09.04.12.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 12:48:10 -0700 (PDT)
Date:   Wed, 4 Sep 2019 21:48:08 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190904194808.nu2cy4vp6uh64m4z@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190904192525.2dqyihabxmigb54m@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904192525.2dqyihabxmigb54m@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 09/04, Michał Lowas-Rzechonek wrote:
> The two examples I provided are *not* violating the spec in any way.
> For the record:
>  - a combined server/client sitting on element 1 that receives onoff
>    messages and, depending on the destination address, sends a different
>    onoff messages to a "regular" onoff server sitting on element 0,
>    allowing efficient control over switching scenes involving large
>    number of nodes
>  - a model that acts as a IPv6 gateway and directly maps virtual
>    addresses to IPv6 addresses of nodes living on the other side of the
>    gateway

Another one about virtual addresses:

In CANOpen, there is a concept of a "Protocol Data Object" [1].
Basically, the idea is to pack many pieces of information into a
preconfigured format (down to single bits, because CAN frames are even
shorter than mesh ones) - this is known as "PDO Mapping Parameters" -
then send such payloads to a well-known group address.

In static configurations, this allows to decrease the number (and size)
of packets sent by sensor nodes.

Since PDO payloads are *not* self-describing (unlike mesh sensor
messages), the receiving party must be aware of the mapping in order to
parse the data.

In CANOpen, format is determined by the address - in mesh, it could very
well be a virtual label.

[1] https://www.can-cia.org/can-knowledge/canopen/pdo-protocol/

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
