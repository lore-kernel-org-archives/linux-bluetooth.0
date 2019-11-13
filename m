Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC29C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45442206ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 19:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="dFp5Sirs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfKMT6a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:58:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41940 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMT6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 14:58:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so2969184lfb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 11:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eMqTEUJLMNu+OIkKckHbaR74tuwJgWVmslb/DegCxzc=;
        b=dFp5SirscTIM2N+Kcvf5ClYH/R7KaScoA6lCKLvXkS3DyyYzEpOGSYwBXmD2ylQF0o
         Qr2lKGaO2OnIrrtrYWPdz4a9NQxV9JM+qdm6d4TwwDD7isCEt3H9hm0lZCq5zqD0vC3U
         f8yYYuIPQ6s5GdBoPy0Ku/oEVicwbvYsJ0KlZc0eWyUVle6XvTJ3alsIn7/FtDDiUM+m
         C38wT5Sx9SqwWX3ojF0CoKvm9twkbL4CScOBf186Lfs00hzppb9GQpLv8MAfdRq/jAbu
         Ei72EAeClHw4svPUGhjyZHj9WDjFy59WvpWQYzudxEyPSuLYITynxsp2A6XH/0lUSKtW
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eMqTEUJLMNu+OIkKckHbaR74tuwJgWVmslb/DegCxzc=;
        b=fEPTKjWEAuYC02Q7ctoySSKwkuyODjbdSgzPmICcya6RRZSUjQ1exL76n2dD5FYCpz
         bzZ/eTMHnnXYzp2fBBjbOyxP7wPb5Aj2XdH5xMIBPUhmVlulXooxVHrFQeXr+g2AUqFe
         qWAU9BClepKhqHGbvmztI0bO7TuXngrJmUTUIH4/bcQeRhV1XY8bGSm+cwA21ZNCUSzE
         UFqozKT14EqphuhR5zZoWN3Gsw8vvGakGCN72BCYmaTsklHkVnLkZTKFv6StrN6wM+cS
         E6zuIilhsMBebdKouwuOBrzQJCTj0h4Rgjs8ACkJ0D5L/7t04qdBphj7AtBEN2qVPgjI
         J6sQ==
X-Gm-Message-State: APjAAAVBHTRmATVN208+SWwLAJEAbC2aNokmcETuH8AoXBEsEMfoDHKY
        Bh7CmO7AC8p6KzfoluQ4wJpBkw==
X-Google-Smtp-Source: APXvYqx7gfumoApA6RjMAcIEMng5AF6DbkUxcAownxvAXgNcdbuLUprOLWWBMLvI1QPq32oM7AOv0Q==
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr3919948lfp.82.1573675107958;
        Wed, 13 Nov 2019 11:58:27 -0800 (PST)
Received: from kynes (apn-77-112-62-33.dynamic.gprs.plus.pl. [77.112.62.33])
        by smtp.gmail.com with ESMTPSA id p193sm2019276lfa.18.2019.11.13.11.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 11:58:27 -0800 (PST)
Date:   Wed, 13 Nov 2019 20:58:25 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Add missing property interface to node
 objects
Message-ID: <20191113195825.d5d2g4obgij2xzas@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20191112104327.13109-1-michal.lowas-rzechonek@silvair.com>
 <7390c6e30fcd8c01205fb29bb3e725b56b5dce4a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7390c6e30fcd8c01205fb29bb3e725b56b5dce4a.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/13, Gix, Brian wrote:
> Applied with style-guide corrections:
> Reduce max line length to <80 charactors

Thanks, and sorry about the formatting.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
