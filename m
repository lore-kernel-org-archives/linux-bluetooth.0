Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5754C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863023428
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bX8P3lbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3Snz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:43:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42763 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfH3Sny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 14:43:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id u13so6070345lfm.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2019 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o+9xyIHuDDNEKuuOGOezuJYQ0RsMdm4BR49dZwS54nY=;
        b=bX8P3lbnU+SznMrDBb47L2130ygUEpNVOS8oQoiFetHwh5sVCyxiEqOMJf05d/4l9m
         9vPjtt2P6vkRPcRhgAsT8M36b6fohjVsDrj1BvtFdBu0fzjdP6k8QUt/Au4tx6nPbgVt
         vHnY3oPx18cKcNRLORPOPEwT/UWuLGV/LOsf6Tk1TpmucqBcnOf85B2Qvodg7IfXwTF9
         f6UeBP5bXUMPDqRAzbt8Np4Ao091o5FownZUZAVx5pdX4gwACdhkAL5jKKJWCNoj+xoc
         GxHzBVymoA8DhQzaT2LtKBxUvwu7F1SXSjWb1pxPGp27Irn/zaaFjCPYvV2yMxxotSrW
         RLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o+9xyIHuDDNEKuuOGOezuJYQ0RsMdm4BR49dZwS54nY=;
        b=LCBV8pK5l/0lH/Dxs+hU7uosJkhsaHO7+g69be3ISeTax/SmKW5szf6UkzLdIhEqHz
         J9K/Sk7CD6rYJsaUqW4c7CTcxWeow1RY55eyUBqgevqiy56kokc4x2VJId8afxHpcCSm
         9E7CiqTjf1UUzBVg4F7V74CgODCJx3A5kx6wNN4/K3QDgS4JcwdSytjs8k5fOMlSc/Xx
         Mwe7NmoHKy2c2fIfpe449qgGTwMEPZs8CP0KTVaZReOC2HaMkXzH3sx7qWRBySKgv4YJ
         DL0XZtGipzB1BFfFTxF9hZORbAWVQdc4QJBQQfCrKfGpFo7hKkz4m9+W4ad821pqhEFH
         fWCw==
X-Gm-Message-State: APjAAAUU4uwQva+a8OtQq30Yvuzlbn8IKXMvGDb35z1o9KdDmnwWUASn
        MSTa6TebHTI4ERbJfpw0eSY1Yw==
X-Google-Smtp-Source: APXvYqxTwOc8SmE8Bbq1dmU/mndy1RcKWg5EItWjhlrRHxacoUdbygGAr1aAcFvu4YFiYnW+ldjScA==
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr10663385lff.48.1567190632822;
        Fri, 30 Aug 2019 11:43:52 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id r20sm1041497lfm.41.2019.08.30.11.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 11:43:52 -0700 (PDT)
Date:   Fri, 30 Aug 2019 20:43:50 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: test AEAD at startup to check kernel support
Message-ID: <20190830184350.y2q7ajvqxfes5ula@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190830173902.19953-1-brian.gix@intel.com>
 <20190830182316.fo3nmzfvzk55rhnj@kynes>
 <2524316a625d8a51cc6a51fe512e4fef94a036c4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2524316a625d8a51cc6a51fe512e4fef94a036c4.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 08/30, Gix, Brian wrote:
> > I know that last time we've talked about this, the consensus was that the
> > vendor should patch meshd to work on older kernels, so we did exactly
> > that - but maybe having this available in the mainline would be
> > interesting?
> 
> Perhaps something like openssl could be *suggested* in a README as one
> of a few possible work-arounds a vendor could use to run on an older
> kernel, but there is no support for adding an openssl dependancy into
> the BlueZ mainline tip.

Ack.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
