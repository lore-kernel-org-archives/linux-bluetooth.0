Return-Path: <SRS0=rXBD=UF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1AEC04AB5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB672083D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 07:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JZ/uwpBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfFFHFV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:05:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34398 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHFV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jun 2019 03:05:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id y198so748395lfa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2019 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I6eoTCRoGN1ihLZussVO2rXcsg0C8cDyb8f3ygQYUWY=;
        b=JZ/uwpBP2I2N58XOyP8kKUjmb07hd0gllBDpg42NJdQ6ZAKRNDdAsdm0Bz/lLIgagQ
         +ZpZittQNWgfkkXQYioe1XCIkEeiGVjap34NWCe12Y5t5DO0idU6WAkFDl2lnBd4Ahf1
         klTMq8418rJJ9TlsZKfy26IrrYA1NfTpqpRsb7rwKCT9zTbnvQiyuYmzmypbPl3IqNHq
         WRfmQhTUvforqE8yAQOgwPYnz4NxSMiKtGeoAdXncXowJdpYTALrODJ4wPMcTQpGvQEs
         maBCWTdxAsX5jsQvLeVLN/RJWIOqHB6OJoO8u83hZcBtq4GrByi/+EdFWJMa+4C6Txi8
         3KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I6eoTCRoGN1ihLZussVO2rXcsg0C8cDyb8f3ygQYUWY=;
        b=TMmPuyOWamTTIWXpMz7si+44DUrCNvryPXNGnB5EFUpjCMtAGatexXV9wwzN8CUtuq
         5r7vvwv6ujzNCHadoCsBVFGvho4NB05dHw/FXNjM+8TyjwBQkPd9xF2GFyqhQcf7sLKB
         9c1tgDSlwW4sYUaxdEgN4JQSmpBZRGzbC/maDE+Ya7tFc5GUTrZuNOMVkA/1hk1KSA2y
         cHfGw5HmEC5oqWmohMnGMUpeFMe0HCo7ukmuVeOfQiC6IJS9Dr3TSJJ89sfNtst3VZj2
         Npke26/A+XT5olksnM84SUAjlYceJ3TpeVbOiCXCScfaIY1PUVVQXiHZ0wE3RiRL0PRL
         uj9g==
X-Gm-Message-State: APjAAAXrKRy3VNNKJf7kwPbSy6+11zSRQJwcFh9R3aSsytv2C1DhRNrf
        cCxr8NsjtyrkkR9krsNyXYKDIA==
X-Google-Smtp-Source: APXvYqzQ2Tsy6YGq96nWs24t4dTYqO+FjpcUTxLh+PoIoWJxQ8j4pwPMlU/PYxRKTBzLJts81N6D6A==
X-Received: by 2002:a19:710b:: with SMTP id m11mr17947740lfc.135.1559804719157;
        Thu, 06 Jun 2019 00:05:19 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o184sm159391lfo.37.2019.06.06.00.05.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 00:05:18 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Thu, 6 Jun 2019 09:05:14 +0200
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ 0/3] Json storage refactor
Message-ID: <20190606070514.izogw3k3u3moqwv3@mlowasrzechonek2133>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190605130106.32372-1-jakub.witowski@silvair.com>
 <88230761cfc7650ab44f76f81189d78d3d439aad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88230761cfc7650ab44f76f81189d78d3d439aad.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/05, Stotland, Inga wrote:
> On Wed, 2019-06-05 at 15:01 +0200, Jakub Witowski wrote:
> > Netwrk keys, application keys and elements with models have been
> > simplified in json storage file. Arrays objects are no longer
> > required.
> The proposed change would be okay if not for the fact that we plan to
> re-use the same code for storing the information database for
> provisioner/configuration client. That puts constraints on the format
> in which the json data is stored.
Could you please elaborate?

The patchset doesn't change much in terms of JSON format, it just
replaces thing like:

    "netKeys": [
        { "index": "0000", <params...> },
        { "index": "0001", <params...> }
    ],
    "elements": [
        { "elementIndex": 0, <params...> }
    ]

with:

    "netKeys": {
        "0000": { <params> },
        "0001": { <params> }
    },
    "elements": {
        "0": { <params...> }
    }

The latter format should allow storing exactly the same information, but in a
slightly more straightforward manner.

> (...) use customized routines to implement them.
> That should allow you to keep local node configuration in your own
> format.
We would very much like to avoid vendor patches. From our POV the whole
point of open source collaboration is to make the *mainline* usable for
as many people as possible.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
