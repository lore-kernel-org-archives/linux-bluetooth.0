Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388DC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F42072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ueJrZFQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfLQTLo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:11:44 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40244 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQTLo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 14:11:44 -0500
Received: by mail-lj1-f181.google.com with SMTP id u1so1341502ljk.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 11:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n/Yfu5680e0epSwqFIdNnVVNd9jf0LqCgbB5efu3wK8=;
        b=ueJrZFQieiPTXG3w0sxNsRf8JKOnfKNdgsToI6OESeCYpmi0aKudrSO9Sd6oeJFZHJ
         A6WIfdV2VW85HdDMQ5kjvcvLcywFx//g1H14BWVUjuRaITwsc9SFBFzDKFGYLFzwvwMI
         nQUHdlBvEhdJe7qN6KofOO4n8/lc+3GuAjoNmzQtK9gaVLJi1pwaPJ9E+402oA2WGo1u
         Cd7lT0W42j5qyIauWXpWLx4hDNZKUoQ9YTMFgHiWkLDzFkIvszJBHBJtVWhD3b31+PU7
         mmJ3mPqUFubeKKg5naLpWohyI7d2FxJer0IQDpokXr6s82S/S6z+00Iob4RjgEMP8KoY
         x0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=n/Yfu5680e0epSwqFIdNnVVNd9jf0LqCgbB5efu3wK8=;
        b=jEvCT+UBtlPApfScfl+SqjxlwR4eymjco7EgtORZHeUSl5+HxiMPeyPXyQ3Nb2rEZN
         131GrdTaEByhmGV+LlUH0z/243hsASKYCAmBClFff1cpKOb9EhiqoG0XxAE118zI1AMI
         cptGWbphoYXEyvdgJ75S8uFxeESQZ1VkYCnfo3VPZEq8ifJIexlW9MUF6nJYauhYg/E9
         E0A0+zI43kB4X97Z03a4yqhcV+TsLt6Y0E+XrQBUHXbJ7Mogq8/nxzY5mUJIzFy6dgvk
         qqhbVAM0UpXV0e39K+0hjNdYIJ8HIBXGyn52kpnBuj+MwXMugjGKxKSZWnRp9VF6QTY6
         eWlQ==
X-Gm-Message-State: APjAAAWxxNRpFyklr1Vp4Qzzw5XLP+6DAlpXShlw/oTtyB/yd6fzhh2Y
        K6topBzIrO7Pq7DlGu1FxOaGZQ==
X-Google-Smtp-Source: APXvYqxswdvBO1EdPWf1x3VElwpxCFXU3Aoib2UV4sV/DDsoOXKUVY0vfrKUJzuXMPX4Wv599uF7ag==
X-Received: by 2002:a2e:8119:: with SMTP id d25mr204529ljg.76.1576609900926;
        Tue, 17 Dec 2019 11:11:40 -0800 (PST)
Received: from kynes (apn-46-215-206-57.dynamic.gprs.plus.pl. [46.215.206.57])
        by smtp.gmail.com with ESMTPSA id 30sm16278670ljv.99.2019.12.17.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:11:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 20:11:38 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Message-ID: <20191217191138.ib7socqz4h4i4e5j@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
 <20191217184728.qoapokv7acfyaz33@kynes>
 <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
 <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/17, Gix, Brian wrote:
> I think one piece of functionality that we have *not* yet tested is
> Node Reset.  If a Config Client sends a Node Reset to an "Orphaned
> Node", using that nodes Device Key, the daemon should be cleaning up
> all of it's storage.

I meant 'get rid of it from the application side'. After Create(), noone
else knows how to talk to the newly created config server...

> > I think the Application does need to take responsibility for the
> > token, once it receives it...  If the call (or response) that
> > delivers the token to the App fails, the node should be deleted

Indeed. Would you be willing to accept a patch that changes token
delivery to use JoinComplete call in all cases, and checks that the call
returns successfully?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
