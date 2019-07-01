Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4DC5B578
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B2206A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="13OhxiXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfGAUOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:14:12 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42320 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGAUOM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 16:14:12 -0400
Received: by mail-lf1-f43.google.com with SMTP id x144so9657457lfa.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fqsnml90QaMYwjlMKtNYvadpEQIYOHKQC4Emog24gJQ=;
        b=13OhxiXYZphJLwrPTiIF/fBPxFBoGydaz77kf67/QfwtXy60rycSyblQF8G34CPhoB
         j7liNPIi3WTL+ItlnJMFLyOWmUSChgUwEeO5FYO+qLvWjqGJlAAlrFde6gfv3nFA0cCl
         ftk6EqvMCZCY4Wy4ZecC8m++dJNdUj0K7PgKc8i7KUs1usEJ9peLrFUu2uKwxlr1RXkY
         pHRmYrUI974rr7J3AQHGzn8OMX0eomk51Qmb1pBHBXlEADEp5ILNhiNzuC2116B9puR5
         cxCIIFNLtFUs6b6krZttz+1kFFZ8LAEcKXomtEQmOpVkSylsu+/e4v0v4B6vVSPSWNeR
         953Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Fqsnml90QaMYwjlMKtNYvadpEQIYOHKQC4Emog24gJQ=;
        b=Xicuz73I9CWgUlDCdvHCuay9HOP/ImWRxl1xVROzDFEyEeMLrpXhcCatHRpPex9gCW
         BGWgif8MN79046fR22jvT5QXIY+IVxBc/HTbNYA0X5k1W8YBgVe3Ts0I9efmUVX03LW7
         X4LdSuLQPEyePwNlsPl/hMSBBmqhNI+IOoiSGKR8g8bYvrrh5hxNoxX+6oC+abjtw+EH
         SLy71RMQYd9IFtnXkwVNlBgnFBfGC6Jt3ryB2UAngPeeUYzViEBNP4lwAy0MXa+B7NHy
         CqPTXu6BgRdeQEF9Nkgik0d7Kgs9QZRV72CEmhKpmGAnsbNAT2E34UDiiVXM0CvvpIOR
         rPvA==
X-Gm-Message-State: APjAAAXTrwEDgFsMJ9HDYk7som2iozwoyHAxo7G7QzhpFfTyTQZ8ku3F
        gnbQbkkJDIVQkTCMQFkrbgXpuKwpWVs=
X-Google-Smtp-Source: APXvYqysxxFnImym8M+rE6ZFGJaPWEAD5u0OI+xl29mPT426+KNl5kip3t6DafYWvk7/mmqNOnPbaQ==
X-Received: by 2002:a19:f703:: with SMTP id z3mr2136029lfe.171.1562012050489;
        Mon, 01 Jul 2019 13:14:10 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id u22sm3833092ljd.18.2019.07.01.13.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 13:14:09 -0700 (PDT)
Date:   Mon, 1 Jul 2019 22:14:08 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Message-ID: <20190701201408.ofjoj7vg73v2yxwg@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
 <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
 <20190628132932.bhcvcx4tzlfkertu@mlowasrzechonek2133>
 <1561732393.7802.50.camel@intel.com>
 <20190701200024.btxrfm2ndanzx7tm@kynes>
 <1562011734.458.14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562011734.458.14.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 07/01, Gix, Brian wrote:
> I have no problem with functionality being added gradually, but we do eventually
> need to be able send *everything* including all segments on the requested
> subnet (not neccessarily the primary subnet).  And there will be the problem that
> nodes may exist that do not even have the primary subnet key.

Yes, I am aware of that. We even plan to use such configurations on
production.

> Forward progress is forward progress. I don't think any improvements will be
> rejected unless they fundumentally restrict our future ability to make things
> 100% correct.

Thanks, I'll try not to break anything.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
