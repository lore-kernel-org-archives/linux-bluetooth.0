Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E881FC433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 20:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134420651
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 20:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="e4qLSlTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHNUxC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:53:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41129 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHNUxC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 16:53:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so371620ljg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2019 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hmW39kI5b1mZgDBY3u9wKUz40mJZSKCnLJXg2WMB/l4=;
        b=e4qLSlTtRkWDeLIT9lAelQinuDbZKKRsXij1dbjOlcdt5nLFc7c9I5yUrp41HxBusx
         m7Mi56FlLGrg0z6xgzhM8LsBbYRUzumsmdVkcmcrCHYbVh19c+CMVCFQM/CO7V5drcPF
         Meq2sq211O9lWd5IRfbgG7oZtm4q6Q4Y1r1A5VhSLnyBeJY6xjEqeGVqZYUVKRk54GVK
         zKDyxxXTIWMJuR18O5s7eqXKSHfRd+AgMXuhcOltXWVFZWCZ2fgWwplFwGbnJUVtyKDp
         r/fTlO16vIRr9LufZvTmgxzSVDBBhJSHuL2KDlu62smMeZ+OeC/A1VJdSkyESYzvKQaq
         1Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hmW39kI5b1mZgDBY3u9wKUz40mJZSKCnLJXg2WMB/l4=;
        b=Y7UL3iCtncoIOT4omZWuRmpu8eQ/QBhw1shDG8oI9VTLOGtLXNZsLp1KCw1xxBAGrO
         mihwEkmNrAr2o38OfwUTrfSD2ti7XgDgfYiUjivwTHLpeV7/LdOM9RdYysz03k8JxNsk
         PMxUTUj01+EmoQlJ2L/gMFdHLluUT9vLVPjxkI6SR4pt7yaoqc2/s+DZqMjEQmbRFNlR
         TD7uHyuMYUS4eBBaEysojm42rCohC3EdOA9op+NrH6vYwqPRw+CgM2JOxQxXSpaw6AXA
         LJUNksxz8HSvp3VWInELaVcoaAY19MyLMjeftOxDnaQfNMfQ1rD6OTuoXr7Jjs1aiJs0
         yjuA==
X-Gm-Message-State: APjAAAWaozKIzbMZICII4Pt2D870R8ZV+ASw08Hn17q+CnmqHyAjAxG2
        pdqOvaLV6GbyKLpCDE15cHiSkQ==
X-Google-Smtp-Source: APXvYqyKMPSfc4TzOcOFGe02uHy5QoAuEkmjMPD8eWHGaV/6gYwSoeUnl9Nr4GzeRNUBTmu/pB3yIQ==
X-Received: by 2002:a2e:144f:: with SMTP id 15mr827548lju.226.1565815979641;
        Wed, 14 Aug 2019 13:52:59 -0700 (PDT)
Received: from kynes (apn-37-249-121-124.dynamic.gprs.plus.pl. [37.249.121.124])
        by smtp.gmail.com with ESMTPSA id s20sm126416ljg.88.2019.08.14.13.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 13:52:58 -0700 (PDT)
Date:   Wed, 14 Aug 2019 22:52:56 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Message-ID: <20190814205256.xkuqo4zqyl63erhc@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190814014357.32453-1-brian.gix@intel.com>
 <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
 <dbffabec9a869204b4de1aab645fd727949e655e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbffabec9a869204b4de1aab645fd727949e655e.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 08/14, Gix, Brian wrote:
> I would like Marcel to weigh in on this since the security of exposing
> keys via D-Bus was initially a concern raised by him.
Ok.

> Also, we may be able to leave it in the hands of the Application that
> owns the node.  It could be as simple as the Application decides to
> secure the D-Bus channel (for only itself) by performing the Public
> Key Exchange.
For the record - I understand the hesitation to "trust" the applications
to correctly handle security and I don't mean to dispute this. I
understand that once keys are exfiltrated from a network, all hell
might break loose.

Leaking meshd's tokens does not lead to that situation - at worst, one
could impersonate a single node.

I also agree that key export is sensitive and accesing these should
require some kind of authorization scheme.

> If the Application does *not* request a Public Key from the Daemon,
> and/or does not supply a Public Key during Attach/Join/Import, then
> the APIs work the same as they do today (albeit with extra ignored
> parameter(s)).
This sounds complex.

Stefan raised a point about app and net keys being visible in plaintext
when application attempts to configure a node (both local and remote).

This might lead to adding encryption to mesh payloads exchanged between
the daemon and the application. Such a thing would IMO defeat the whole
idea of mesh stack implemented as a system service - it would be easier
to implement this behaviour as a library and do all the crypto on the
application side.

> An app that knows it is opperating in a secure environment can then
> trust the system to provide all needed security, but if for instance,
> some sort of hybrid D-Bus that has an insecure link in the chain, thwe
> App can add the Public Key exchange and encrypt/decrypt as needed.
As far as I know, there are only a handful of D-Bus daemon
implementations out there, and I don't think that any of them is
inherently insecure. Sure, there might be bugs and vulnerabilities, but
I am not aware of any implementation that includes an "insecure link".

Please keep in mind that D-Bus is confined within a single machine -
yes, there is a TCP transport, but virtually all setups have this turned
off, and IIRC freedeskop.org explicitly states that this feature should
not be used in a production environment.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
