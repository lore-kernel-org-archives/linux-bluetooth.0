Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE275C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB1A216F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 21:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="g8k00JpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfHNVUr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:20:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37964 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfHNVUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 17:20:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so446408ljg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2019 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6EW+yFHfhHxA42xWVkp3iNxEOcB8Gl9Ta9f69RQeF6U=;
        b=g8k00JpEvAgaS8YaJy6DHIQWezOoz1tcS9Hx4ttKZ8Dd2Ws0pKRXGkl0JNNu8tIOug
         clMQI3fiXimZBMdHuXtfszmkN1Y8Dr+5rCjJTMRnrHLERM83qSdUF98DWslDw6pwL6Lt
         Bg4SQR1D98ET/MtCLXGgWzzy0Q0BKTNM5BEZocDLcw1uJTwGTNag3d0RhTpvqLnTU+l8
         2ogmZ51xlqdzCR42YO1+MJfIkfftpIhCc78MH8VCbv45hUAvaLQFWnScV5T8ovbCL40M
         S1WLt0/C/Uiw+IbuKT+6uHiwmxVZgXLXwGmyZl3rwm/G5lukQVjNHW4AzFMKYICGidBv
         IEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6EW+yFHfhHxA42xWVkp3iNxEOcB8Gl9Ta9f69RQeF6U=;
        b=hHSyXGBYdQcRvIskDGW0C5saDgu+Czdrns4MyiUaSWGVRI009C3xisHZlz18UilOB1
         cXH1qlpMg99ro20LiVTODQJVBuPgcS5eiBZIj2OBCQQ/KIvh6tTaM00uumUVat6fbwLh
         HVhrcPC+EvLjvX6GzFwQaGC02Nwl2QigvtyU5f7Xzhlm0E+NJp0zBK0YRpaH0wSPIgZY
         1fKLovVOGvhQLrx+E+sh2ZoyCp0y90Rpyrfo7EFxUHvRLyuFDb9thn5Sf4LrwDhWNqQJ
         hBw5F1YvNnKB7LAoNJ1kR0SWZccgMzabeuDPv7a3zZFBfCdNiO1rBujXiWJRmSOX7T/s
         aTZg==
X-Gm-Message-State: APjAAAXtcKgdiAaOBtnx6x1c75zfKHOU4Y6dTC3J4lev5FG4UGbuyl2l
        eZAo2AZjfB5OyE5saHteYp1Tww==
X-Google-Smtp-Source: APXvYqwYcBfvklvFHpN0a97EF0i7zoVQ6kC7lmWvnw4hgqmCVQE+HHfh7pbkjhpdFFz4tVDegusOSg==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr964710ljk.138.1565817644959;
        Wed, 14 Aug 2019 14:20:44 -0700 (PDT)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d16sm108891lfl.29.2019.08.14.14.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 14:20:44 -0700 (PDT)
Date:   Wed, 14 Aug 2019 23:20:41 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Message-ID: <20190814212041.ty27uuyolyujaoqe@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190814014357.32453-1-brian.gix@intel.com>
 <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
 <dbffabec9a869204b4de1aab645fd727949e655e.camel@intel.com>
 <20190814205256.xkuqo4zqyl63erhc@kynes>
 <FF0F331A-753C-4A3E-9EFD-E54BD0657DA8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF0F331A-753C-4A3E-9EFD-E54BD0657DA8@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 08/14, Gix, Brian wrote:
> I don't think so.... If a token is leaked, and we offer *any* kind of
> mechanism to export keys, then any permissions that the App with
> legitimate access to the token has, is then conferred on *any* entity
> that obtains access to the token.
> 
> The only way around this is to not allow any access, by any apps, to
> any exportable keys....   or to secure access to the token.
No, not the only way.

We could require additional authentication before attached applicatino
can access export functionality - for example, check that user running
the application belongs to a certain group.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
