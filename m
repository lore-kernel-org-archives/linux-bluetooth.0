Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71FC48BD6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC72054F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="uDBBLAUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0P6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:58:19 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44918 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0P6T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 11:58:19 -0400
Received: by mail-lf1-f54.google.com with SMTP id r15so1903049lfm.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HpCMC7TUABljT51JTu3RzvvF/L5Hk52YfzurL3ch5qI=;
        b=uDBBLAUQ+rVcFp6lupJGvpjiC73gK/CN4ikpiXKWxEJEO0Q3MMoKXT+V7zLYSgQSgs
         zZYKf1a4rcAHuw6qgEOX8myAjPXlkZivIGwPYuTbkb1QkYsmnxzZrNHcEMnpzbYTybCI
         BWdyGefQ3esZO/U21nseXGoNXX6rP9cUeHZ4/kMbLdBqopbVhfLnwh31mxpKITbQnQP/
         +Rag2/80hCnmByQjhNOCN4W35RpMpvkcxsneygNq0/Cg+A5FrdE0Mdo5tZ/vwOciK4O3
         Sv1bX1Ih92IlCZYPWCQJpNskUcAWtzUlrYa+pEQK4ItnJmDpoYyHW8w3jkfSI0Sehu+K
         jfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HpCMC7TUABljT51JTu3RzvvF/L5Hk52YfzurL3ch5qI=;
        b=OhkxX70O81hxBZx6HxieuQHgAjZCwtEsW5pK/lxzW7bDsjjcYY/JWIci/6vDvDoh7I
         PGrMrT7BjHnL9Lb67lohVgPJ7BxTrFfVOltzqYR8iyauMKKrmgl7McFvHZYafomddSWB
         hdo8voSopsRzYBlGj+f60pQ9omQYHbWVPIaKePB6yVBtvCN1TeRG7V2YJRxaNfwf+Yp8
         Z0vuy1dSSPny4mmkzcDxbcNXufjk9Mn1ek4ROm92faE1hCiqUBheDLqXj6hB0oB1Opa9
         +9FwbYadDpTcR0RJ9GBamo+aKATnX62BHwXxiZhTtD1/lizeYU/qjIcIjpEEMKHaW3ts
         bqqQ==
X-Gm-Message-State: APjAAAWHRp5fcAInvj3S/E/vZLUNVDZB9UERBC+XQmVNh1bGt7Yv6AGx
        ejymbacNOZTGHlPyDT0ugDVOuscACho=
X-Google-Smtp-Source: APXvYqwIAdBraE9de9Hc8u7VGMJO+qv4B6Une4t9V6vxC3jLhhIm8M+opVrDvTaTzmvAq/pWl3vhlg==
X-Received: by 2002:a19:490d:: with SMTP id w13mr2421367lfa.58.1561651096924;
        Thu, 27 Jun 2019 08:58:16 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id y12sm500761lfy.36.2019.06.27.08.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 08:58:16 -0700 (PDT)
Date:   Thu, 27 Jun 2019 17:58:14 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
Message-ID: <20190627155814.iyxx3a6vezpvlney@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
 <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
 <DEBB0CAA2616974FAE35E4B560B9A4376CBB1464@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CBB1464@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 06/27, Gix, Brian wrote:
> I don't think this is correct.  *relayed* packets must preserve the
> originators IV_Index...

Correct. I realized my mistake and quoted the appropriate section of the
spec - there is a message about it on the list.

The other patch stands, though - as it happens, our network is in the
middle of IV Update at the moment and I've been getting failures about
decrypting application payloads.

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
