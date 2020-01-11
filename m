Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3BC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4999C206ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 06:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hrZD/g2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgAKGcN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jan 2020 01:32:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38402 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgAKGcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jan 2020 01:32:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4403469ljh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=289g/enBdyYu5XozjsxWGgfcBGwpSi0P/u9O+wXwM6E=;
        b=hrZD/g2Fjmd+AfRCcBtxx1OtfziNJ8W3OaQxkyX3Doh2Nwt/eB1mEVjEwet3pteMxF
         +WzptiLNk78UuumlefWqpggpxsKgkRiHPrd/MNsuSm4obHlZQiBTefyySjsSDMoXIfPp
         qt4s8hfNnBqY9eJ9wKI+rzYPTDIUOkzSd1neDPJuTXj7D91U9ZNluFL9EhsKIENbltZ6
         t6dnP3OfJj/DuKNp9RNnLkwlaczHRdTTKKS7uPTgSUh5sZyWcBttiOF8y57XF+PxfFP5
         EIBvdxhH9bO5UyhXSE/GfX3b1CeSTaLNe+JlEhs3ipNPa+oiQherJ1LJ8VeuGaInETop
         0zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=289g/enBdyYu5XozjsxWGgfcBGwpSi0P/u9O+wXwM6E=;
        b=VnSdpg3ueUlDqVcde+HfjIzc/Vo6ErxYu6l6bqwX/HAT3WIzbPAMpG5vXdwhrqO3/j
         z0sbZL3fEGgnF8zoJeLFsP7NAdgCJ9T0+vJqsWPt0zpqZYz8aa6aHaPAjZYrkyTt6Q3z
         Qii+1igaxAPt2zgMddk/wdKDsEQC8e5JPe7Tqgv/OIE0fTdn66GypdTQ4MjTiGJGJJvP
         8usCUqD8L8gpEchr5yRuN/oS+yX+J5HYFXLCuSHgzTD+QmmUZqJeI2kKUCEhX0XO2pSI
         8goDY5bYNFqc1ZMtU5nBMCpakBJhFa1wC3Q12d1u0tCYLXWHdf792UCN2tmvtKd5sghr
         q4FQ==
X-Gm-Message-State: APjAAAWAh+xFmX16xNNhz1SKl7SjIphSU/sAqCWvdrBpo34Nk5gv2HVc
        olEgkFzkqyogJRhSKUzB1tAJtA==
X-Google-Smtp-Source: APXvYqw85IZbB5EEmYSIj9kl2znIkpZu8QBZLNsnYJHGC+YnApsUZsRfYG+9rYnRXcdA9k+kqXSXWA==
X-Received: by 2002:a2e:86c8:: with SMTP id n8mr4754789ljj.205.1578724331345;
        Fri, 10 Jan 2020 22:32:11 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id e8sm2295686ljb.45.2020.01.10.22.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 22:32:10 -0800 (PST)
Date:   Sat, 11 Jan 2020 07:32:08 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v3 0/1] Add Mesh Provisioning Loop-Back mechanism
Message-ID: <20200111063208.e7ntybymg5fdrf5j@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200111013856.32675-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200111013856.32675-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 01/10, Brian Gix wrote:
> Cosmetic changes reversed, as they added nothing important to the
> functionality.

For the record, I'm all for cosmetics, as I think that readability
matters (a lot!), so feel free to do these renames etc. even (or:
especially if) then don't affect the functionality.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
