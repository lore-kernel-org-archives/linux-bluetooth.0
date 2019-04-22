Return-Path: <SRS0=/BwN=SY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9DC282E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69020811
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 07:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZCMTlq36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfDVHhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:37:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34622 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfDVHhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Apr 2019 03:37:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so9585652ljb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2019 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xtVvXxiMHAfyi/HOFf7gqFNYXaSzzXdh1Tf10O9YzPc=;
        b=ZCMTlq364BAEF+Y1N6VNJ8zRJjieWmoFiOO5K3xnl6D0LsIi+adU+/uTroIYm6DVi8
         eut/bssnKYe8D0o+L6n51MaEU9OXr9r8f+9tTrKP5P366DzzszCt5uzhM8Zcon9mKqCq
         bYP68Na2DGyDQ3QYgem9M/De8JHETd2Yqau/CW90/KKg66UivjMioef3T57rKISFQxT/
         bm5c0smMcwg2z3JD2a21dn8BLDTH6nVvpZE0iGjtqWy7h0ZCyujx6YkSDPWVcdZf/ZS0
         cXDBHcGIwLxMIyCMvBDW1iewfn7bTuqZLWIEj4WowLmzxBtcOZCaMj6qJNsBzQcSzBai
         gJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xtVvXxiMHAfyi/HOFf7gqFNYXaSzzXdh1Tf10O9YzPc=;
        b=WoDebs4sqTDSlxmSfTdd2oi3hrnQ1g/KUsQ8IAxUBnxHhVkIq9aVriAXf+mKsZtN8Y
         c8Yw7I9EDsmBcD3ACGJDCrzutMOX16BwnXJLrVKBsKndDaObbCAYVcWquDj/D9QdLzdp
         YOJci8LYd2TTj3t2VPCnTJ0n873zB1Jo/CPSa4+UHlR7wDujboKiEMoVtF2AG4RSw/Vz
         EjYRQsU948kgRQP83C0zjbs0XT1wvvDO3WQ8dHsjmBRu/3Mv0tmoIlH4J9WKkAE/tSNY
         mS/nyviKA67PGiVXu5hx3C6vaKNPn4CBcc6v4b4ezMA3TMLqoygt3cxNXVhvwO5cWrD8
         fu0Q==
X-Gm-Message-State: APjAAAUP5NE/Slh7xpnPmh2lXfFFYeOf1LqHnL1XpQNLcMdAq04nZFFM
        UldKqgYyCxPXE7h8KeW4oOMDYA==
X-Google-Smtp-Source: APXvYqwDbiitW4pZ+GipBioN0PAM84R5DmfuLJ2nQQbau5kJym2/ui/Mb0fbK06t38QnwWjWcF3ngw==
X-Received: by 2002:a2e:5bcc:: with SMTP id m73mr9607812lje.100.1555918668307;
        Mon, 22 Apr 2019 00:37:48 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id v21sm2840421lfg.26.2019.04.22.00.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 00:37:47 -0700 (PDT)
Date:   Mon, 22 Apr 2019 09:37:45 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190422073745.vjkrvg7hm74aq4bt@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190415194946.13121-1-brian.gix@intel.com>
 <20190415194946.13121-2-brian.gix@intel.com>
 <20190417055132.scxvzhusx2suasdv@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
 <20190418092738.wdohlkvcej5ffw5x@scytale>
 <1555623863.31619.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555623863.31619.4.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 04/18, Gix, Brian wrote:
> > Another point would be adding explicit ImportNetKey and ImportAppKey
> > operations, so that an application using external provisioning database
> > would be able to inject keys into the daemon's database without sending
> > raw Config Client messages. This is similar to Import*Node operations we
> > discussed before.
> 
> Yes, This ^^^^

Thank you!

I have no further comments about the API at this point.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
