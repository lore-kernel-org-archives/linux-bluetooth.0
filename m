Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2FC31E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 17:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0E2166E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 17:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hnlnTQ/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFSRoI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:44:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSRoI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 13:44:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so268850lfa.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6KTItril6hQ+E5/uBSPn0qyoO+cdLTA7UA8viNvLfdA=;
        b=hnlnTQ/ZhWE8NR+2UlipayGS0ROFKqBDQ0PTXkoB7ebCVBBJbdBdDz8LCQ+XIb214K
         drtEsqWfp8+cW29yVczV7XOEqu1nMBvQjnPOemcMHTkX9/sU9bjQgAytdShrAc2FgAVT
         0Q2oA33z3VkVz7QLkrvotTckSSSgwAd1dcJzR5O/dCtxcwMQ1Lh7i4rp8iKgHjYhC1jt
         SkdUq9HtzIJzkQzTDYI8m87ns4Uc7bTmHBROk4mzZHw+djN3dHB381HpGCk8X9ITKrr7
         TQqurnQTv/gHdOW5G5yUaQbBVhp+FPcxs6jsC7CgWjdK+PM855Qj+bfY3Scz5jdzLI8S
         qTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6KTItril6hQ+E5/uBSPn0qyoO+cdLTA7UA8viNvLfdA=;
        b=l9ULdH/Zyc6g+NEmWxXBPsGooI7HeTOvBzkuAjQNlHnVDcsMeQQxVRaKkQMSxQCRcW
         xDAQqpeiAO6PhQLBfj9X7DKhN9MYSSY2Egeep+4Q6R9sNlTwFf1Cfw+dIixkVIcgv0Se
         AMfxK00uL5cTFV5cTEwgdngSC2FQUnaZJT6qUCzHDXyU7LgfSdlIY5E1Jy4G44PMK1kh
         PjkZtpdR3rMDmFGboormW7IbSHFHvUxeK44M5aM0QauqlvenujyGxCUT8PgzkdAFRBWV
         PpgjB17acD//TDb5nhheg+3b67HqKVJvv95G15vSmCQBVe5TBpMv/hTnsXEga5caTcAq
         nUrw==
X-Gm-Message-State: APjAAAXqH5W1Gihgxw4qh4bs46Oga+J6D4hbLlfA7G9LEIVqB4L7S/j0
        HRcTauDPfzaTk8dnJuCNbNFHRA==
X-Google-Smtp-Source: APXvYqy2GSodbRtiOSfJt2QmGcM0PtOVAKKHl3eQ7rpj8nTfWBn8OF8KtLsT/LzwXE0lki2bMm+gog==
X-Received: by 2002:a19:f00a:: with SMTP id p10mr26727046lfc.68.1560966246449;
        Wed, 19 Jun 2019 10:44:06 -0700 (PDT)
Received: from kynes (apn-46-76-45-65.dynamic.gprs.plus.pl. [46.76.45.65])
        by smtp.gmail.com with ESMTPSA id y6sm3155954ljj.20.2019.06.19.10.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:44:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:44:03 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Clean up includes
Message-ID: <20190619174403.yhrey4dkxges2ggi@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190617213847.21705-1-inga.stotland@intel.com>
 <20190618073559.tmpaj2oellkf5354@mlowasrzechonek2133>
 <6b160fc3a67b72495bd533a884ae7edd2d39c47b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b160fc3a67b72495bd533a884ae7edd2d39c47b.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/18, Stotland, Inga wrote:
> I don't disagree, this was sort of an "intermediate" patch. I'd prefer
> to remove the reference to json from storage.c and the rest of the code
> and localize it in only one file that would deal with json-related
> processing.
> 
> So I might just as well go ahead and make mesh-db.h a generic API to
> allow for different storage formats (even though for now we have only
> json defined format).

Sounds good! If that's the goal, please go ahead with the patch and any
further ones. I'm very much interested in using non-JSON storage, as
more granular format might be better suited for embedded devices (flash
wear, power failures and whatnot).

FYI, you've probably noticed I'm attempting a similar thing with mesh-io
layer.

best regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
