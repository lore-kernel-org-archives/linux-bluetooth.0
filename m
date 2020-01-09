Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CEC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EBE20656
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fiz2x0hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgAIV4D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:56:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32945 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgAIV4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:56:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so6390622lfl.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 13:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=50l3EQlsHPGDE45IXqaqiY+Z6eWm213wtAcLnmgovY0=;
        b=fiz2x0hVyDbEIvUUW5vih9esaEth7CXrVaiVG1pzHtAwX4+UGVE7CC5jAjhY1X/hZp
         +lznQIcHofB5YFelWZvOno8nmPW5hCWyv2zbRuyaiw+ap7ln45YUdVsbM6LzS7aJiz2G
         RGnPO1+RYKKDC+ZY1H15oHYZ4T3MyuczfF3kWyuW36nYeKO3cU+dBm8RAbcBsklBGi80
         jDIDf0FWbt/+6q4prGTRVb0upCnT/RaTB23kZNMJQtYPvVIBXGI51zQWyJOngoS1uDKg
         +qJjG/z6u+3Eb99NhL+qbVnLnenIAJJZG20nLYocM8F/zTxl9gQXLdSRfvZA67cTFaao
         62ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=50l3EQlsHPGDE45IXqaqiY+Z6eWm213wtAcLnmgovY0=;
        b=bI8QA8bVIO6BqVMgIaCnCnrE1LJvQmf62Lh9fiiHx8aCVo6vzowTpdjAJS8Fs3nUqH
         mplvMRrYZW5AeHE3znTXaGA48XPFAvxwWrVw6TqJvG3UI6eMsWylMiKmGBRbLTSB7Zi7
         XlhhILFk6q+jVgiGpxGXLHc42lpbnKsuetnXp4Pcu8u2xBJdnGxCEOeaG9CEBaKuoVDc
         MXPB0IWao9DZGODPS1Roju85tasBSf3LWBhwS0EYTKPZBtdA79WkVZqjcI78AuAUmtX6
         5usNMgdHLUtYFNV7PA76vjKwadiyFlkF4rljXeNDsz1p7IETEn/Ry1Rm6WM1c25BISnh
         ZxMQ==
X-Gm-Message-State: APjAAAUD7ikFZGz0yY9vQjJgIaW+hDkCYwaNqU7KHogn2hiN4v/1ClA3
        F6zQhbvIq1L9iM4swMkSiJ7REdizGqc=
X-Google-Smtp-Source: APXvYqxGP3Hh0e4rru1ytm5M44ZwAdD0nh2NhcP7AscwO+pmyh/ODFFwTN5n72LUaA68jkpKUOEH8g==
X-Received: by 2002:a19:7b0a:: with SMTP id w10mr7538743lfc.90.1578606961246;
        Thu, 09 Jan 2020 13:56:01 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id w20sm3599502ljo.33.2020.01.09.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:56:00 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:55:59 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Message-ID: <20200109215559.jsqfuybaztjnfe72@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200109175715.22925-1-inga.stotland@intel.com>
 <20200109210006.e3qv6uxnr2w3isc5@kynes>
 <31a576190ecbd1ba3f7e779d746baf35815fbed9.camel@intel.com>
 <20200109212935.6dn5ivmnupfd5f2d@kynes>
 <7347c54a1ffa3cf45195b0d8ca53d59613f946b8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7347c54a1ffa3cf45195b0d8ca53d59613f946b8.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/09, Stotland, Inga wrote:
> Well, shift is a less expensive operation than a division (I believe,
> some compilers may substitute integer division by 2 with a shift).

So leave this to the compiler. In 99.999% cases it knows better.

http://www.linux-kongress.org/2009/slides/compiler_survey_felix_von_leitner.pdf slide 36

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
