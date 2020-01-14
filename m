Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579DAC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272D4214AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OcYutmb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANQxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:53:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37741 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgANQxv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 11:53:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so15153853ljg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IZEzWLanQH4rVo4qQbxRTyc4fku34PmYPQmvnCXoUJY=;
        b=OcYutmb53Px86hakZj/4WDBHx1arDoGhbvqadWTyA/XuQGGWnrTXJcL23SUeJp/Nff
         ZUrISkovEk9MxSslPm2uIbcsWtPWUkY7SMot0WQhc72ls4ybWOyoMILCWP9KGfiK/4/t
         UBr+DyMFH97CDWhhopjBCR2P6JYsPmsYamNRiEQE8Wos68kw+SO81+4n8KkfZx3EqFsN
         FUvD40ILgRdd6nQiXASoZjAHtH4TYxX6t52cukD4942y06+hJZOAorV6pnoQ3JQ1SN3X
         HS3LyqN2cBHY67+9vwesE5ABjk0CDaLIlKk0TXfTb5NI1QDwwy5c97BQi1adfZGMrVot
         HUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IZEzWLanQH4rVo4qQbxRTyc4fku34PmYPQmvnCXoUJY=;
        b=JOzF8sKlZd1PTlxSFkc7VgxSTQOhVmcfeOzejIpf6M4/5ISXTiLiGbLE8DeBlcYg41
         zl/uRZpl30Ho5Qu58k+FVakn7TjVTBScyNrfuRprs6elB0aWdw82lu+GyQatcL0i57gl
         Ecp8cLS9lrPt/KKvRNOYyxPohHAXl8tl8Kpz286ID5ZZZ26BpBETPGiFnA9JmJNL+2lc
         lz+QTrpz2dFhyZc+Y6Cn28yofhMRfO4jSWWYq+706W2u//YiJov8yPQA5QN4LL2OPNsA
         q/1FpbTZMNSHIUpHPgFZDcKuL12dsogDLXe6BOvjldiSoT+zU91QO7DxpqAi8fnbKC/M
         w8ow==
X-Gm-Message-State: APjAAAW13OEjzqV7MO3zBf3WyIOZPlOag8ya2AsnVo81BDuAfgKqNNXo
        vjpdhGSkZ1BpSg/iaX7FsBwz3qgFGi8=
X-Google-Smtp-Source: APXvYqwX1qZ8E5V0Tj08AsQOKHN43hCKk94FPpxzbmjeMeME+ieli4PSgVpl6orhBj9O0m8RC1VVUw==
X-Received: by 2002:a2e:b4cf:: with SMTP id r15mr13772347ljm.52.1579020829720;
        Tue, 14 Jan 2020 08:53:49 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id d9sm7813228lja.73.2020.01.14.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:53:49 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:53:47 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Message-ID: <20200114165347.62egqps6uejw33a4@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200114114914.25868-1-jakub.witowski@silvair.com>
 <1382d00407f6c7836f7983e374d6c504931f6e9e.camel@intel.com>
 <20200114154012.gixnyhceabg2lrsp@mlowasrzechonek2133>
 <73e50268c7a5289a20adc8cffc3de2e04ef93acd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73e50268c7a5289a20adc8cffc3de2e04ef93acd.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 01/14, Gix, Brian wrote:
> I have some serious discomfort with an API to increase sequence numbers.  On import,
> the sequence number should be part of the data being imported, so I don't see a
> direct need there to bump up the value afterwards.
> 
> Plus, we handle sequence numbers differently than many other settings in the
> system.  To prevent storage thrashing, we "Pre-Reserve" a chunk of sequence
> numbers that we store in node.json, and then real-time use these sequence
> numbers for outbound packets without having to write to storage each time
> (a power failure or other reset would then pick up after the reserved chunk).
> And then it also feeds into the IV Index update feature as well.
> 
> Giving an App the ability to arbitrarily increase it's sequence number puts
> it into conflict with the natural usage of sequence numbers, and when we request
> the IV Index Update.

Ok, I appreciate that. Let's take a look from a different angle.

As I mentioned some time ago, we're working on an automated test suite
for the daemon. We need to know the current value of sequence number to
verify payloads send to radio adapter. One can say that we're
*eventually* aiming for, is a "test mode" of sorts.

A significant part of the suite is checking the IV Update logic. As
you've seen, there was/is a fair number of issues with the current
implementation. We know from (painful) experience, that this part of the
system is notoriously difficult to implement correctly and efficiently.
One of the problems is verifying time-based behaviour.

Mesh spec actually mandates that the device shall implement the test
mode by removing state timers, but it doesn't say anything about
triggering the node to start IV Update.

So maybe we in the end we could enable SequenceNumber etc. access only
when daemon is running with a certain configuration option (either
commandline, of from the file)?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
