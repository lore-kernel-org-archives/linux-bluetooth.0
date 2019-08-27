Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9184C3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 18:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BF217F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tTxjKYiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfH0SYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:24:01 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34500 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SYB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 14:24:01 -0400
Received: by mail-lf1-f49.google.com with SMTP id z21so7492375lfe.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2019 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k8kpShRA3BYL5xzw2Lq8pZfbrji63IOaSI+Vk43FOCs=;
        b=tTxjKYiVniKCgM47IGCcOBOZUGBri2g+GZZq3R8ilgPMTUxd43RCke5KuBfzGuNxdn
         ngta2F4S7tLozvk3ZkTDzXSmbwlUoovSJLCAxQBJwf9PlaM5vuUFat80T9cKSBTOdKoj
         nC7MdkdfLEKIVHon6Q0IIvhG02kiTR/UhOS/TeBmSDQnnjmYwfy65Eci/6xrOx4RSUBR
         F2e+5n7VDyZ5T2k8pLWZ3/KAc7NXsM9VqmWZ+xuhw6/oXao16XwZYCyCNvT3mUFsIUwC
         GRg9nJKngX8YZPi8siKTLwj1vCefVtaSpQbyMHSsRBOCoBIIpwD5tUsaH//REjl23TUi
         Mu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k8kpShRA3BYL5xzw2Lq8pZfbrji63IOaSI+Vk43FOCs=;
        b=q5YzAbWDyqmFGYf5WTwFvdimFfF/ndk+hTnD9cJuqul4ayO/0t2s4IlbyHycrZa2Y5
         e3mqMN6RAmFH0KrqxZbLPHagpEltZQIZXOLHDebn7tYmdMOkSJMV7pTH3SjIMWbX0SV4
         nLvhcW500SIsiwQ+DFCc0hrvRFEOBws8OzIVKby+2NlrnAi8CplV1X1RzVV7ykDwHHzV
         lg2fDs8AtayHeoGyuQ1D7L/9PIpKF7wrkmderfl0aJaAWVIUag05o40pMqKZIV2HpNox
         VD9RFqED10eQWKWD5YgHDSZSo5Q0U4/kWaADPXd4o6r7Xvgjy/zsM+RUtxp+okicSWwL
         15lQ==
X-Gm-Message-State: APjAAAUsFaR5igMmRKtv+vGe+lDwUaN50I1BEzll3qtpXNSmHPqeF/pz
        tBDe0UdNc4rd3ELDJ2z+ZfPeqg==
X-Google-Smtp-Source: APXvYqzuIBNyB9yXlbZ58mYuFWpuJiMaLCQihPNe0pZ3cLrGQGox5IxrzlFYrsnA7nuTVRpeEZpFNA==
X-Received: by 2002:ac2:5c1d:: with SMTP id r29mr13931228lfp.72.1566930238813;
        Tue, 27 Aug 2019 11:23:58 -0700 (PDT)
Received: from kynes (apn-37-7-28-223.dynamic.gprs.plus.pl. [37.7.28.223])
        by smtp.gmail.com with ESMTPSA id y15sm6828lfg.12.2019.08.27.11.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 11:23:58 -0700 (PDT)
Date:   Tue, 27 Aug 2019 20:23:56 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/2] mesh: Implement org.bluez.mesh.Node1 properties
Message-ID: <20190827182356.2pbseooolxfazg3g@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
 <4f4cc80d57738604b3b38049a1aecb6b75e57be2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f4cc80d57738604b3b38049a1aecb6b75e57be2.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 08/27, Stotland, Inga wrote:
> > adds two additional properties: list of unicast addresses
> > claimed by the node and the current sequence number value.
> Could you please explain the justification for adding these two new
> properties?

Sure thing.

The address part is useful when application would like to talk to its
own node's Config or Health Server. At the moment the address is known
when calling Import or CreateNetwork (even though the application would
then need to store it somewhere, so we end up with two sources of
truth), but after Join() the application won't know the address assigned
to it.

As for sequence number part, reading is mostly for debugging and
verification. A few our users had trouble identifying a problem in their
setup when their node was listed in other nodes' RPL.

In the end I would like to make it writable (increment-only) to enable
address reuse, but as this stage I'm still looking for a way to
implement this without causing a race condition, so I left it readonly
for now.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
