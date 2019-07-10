Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25987C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 19:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995420844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 19:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZUjott6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGJTc2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:32:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37669 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfGJTc2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 15:32:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so3272159ljn.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2019 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xnCvlWqIHB0jHiV3dyLrVkDe0dM5JbxFMEGeCSV1cfw=;
        b=ZUjott6WbHEJrXXgBYoLp5dTTfCo5WnwkiHZ7OQbHil815wAhCbtDe2JtJL6/t4Flr
         jNFqhi2mF/qcBbEl7b3nIXnhsbY8d1CDXTxS1etrLhsex59+q+ZWYxlApxPrFrvHwzpF
         RwE+5Rp6SyHn7QhZl+1KNdbtTRVH9pum7pKKCGNL24RaQCW22d6Ugk23/JKcijPDkrfv
         li+veqCNA9/SyLqB+iAWhuFyfEgP0ZHvghT++MvNECYzJvwpFNU2qKhyLnSvWIetfxt6
         AXOc8S2HkX0u3/9Fd016jAjs0WK0SDg7kLv5LyeoWQ4uWvmGqxqAZAM7uUFlRfqf9q/o
         hfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xnCvlWqIHB0jHiV3dyLrVkDe0dM5JbxFMEGeCSV1cfw=;
        b=SPTa5C3FD5Mr2e0x9R5Heup30spfSEMIP3TQeueWF249s44Fm4YSKxf3EBvtND+8F8
         XZYVa2aUcIbRXYDgWa4ufwbPTtF1weHhuixkn5PLEmqTzCZpRyFQ1OdysUGu50JQNrHr
         ZpRSPj0WNOJt1mpvcXEvyXDzC4rpUzxGDV2DdvnerF5eDXbFNBcbXEet89Gv2wkswX/S
         UfomFf8mTnjdXA+moBAADGyCiAbf3XpMgfUIZRr/f1zBbmHy09Wkl65wSCQCHijSXzzW
         GZaW1YY478AtKgrbtXo+MsRCaJtUCPOqqoH9EuRGMNqyV1DOZuI7WHZG/vBQsZAVSa/V
         0ebQ==
X-Gm-Message-State: APjAAAUt52ei/EB+CQbePPZMaXn1lcVDUsAKtp0s7lH5HVEkVcz0W4pW
        +q+EuLjvX/d8J9I6uCTWpQDzpw==
X-Google-Smtp-Source: APXvYqxXlQCzNveAjCjsSof2owZ9/axiruIvsUIRiYXYogwP1yLLgV8ub/Nqq96+gsgo++eZEVP25Q==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr18261369ljg.216.1562787146045;
        Wed, 10 Jul 2019 12:32:26 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id p12sm611940lja.23.2019.07.10.12.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 12:32:24 -0700 (PDT)
Date:   Wed, 10 Jul 2019 21:32:22 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: Re: [PATCH BlueZ 6/9] mesh: Define storage format specific
 read/write routines
Message-ID: <20190710193222.obsrzfjgnfmhps4e@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-7-inga.stotland@intel.com>
 <20190710075245.2koao3eyj22wbj7s@mlowasrzechonek2133>
 <DEBB0CAA2616974FAE35E4B560B9A4376CBCC4E9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CBCC4E9@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 07/10, Gix, Brian wrote:
> > I don't like the assumption that each node is stored in a separate file, and there
> > needs to be a backup file.
> 
> I think I understand what you are saying about *How* the node data is
> persevered, and that the underlying storage might not be a typical
> file system.

Precisely.

> We *do* need a mechanism to get to an earlier version of a Node if
> there is corruption detected in the most resent version (perhaps an
> unexpected loss of power during a write operation).  That is the
> purpose of the current backup system.  Whether this is accomplished by
> reading a backup file or "Rolling Back" the history on a journal (or
> git repo, or whatever) we do need that backup.

Yes, I understand that. But, as you noticed, the rollback mechanism
doesn't need to be a backup *file*. This is an implementation detail of
a filesystem-backed JSON storage.

I would even go as far as saying that we don't need a backup - we need
atomicity and durability from ACID. Achieving that is non-trivial, but
is still an implementation detail.

> But we could certainly hide the mechanism of backing up (and of
> reverting to a backed up version).

Yes, this.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
