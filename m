Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B935CC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3DC206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="yS2QpV94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIPJ6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:58:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35858 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfIPJ6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 05:58:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id t3so9521476wmj.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4cSjx5XG6x6AMPYVQpdUv5oPngfbEAO99TqRxKNWknw=;
        b=yS2QpV94dMlDN98C05w6czON2BkTl8qCFg6c+vWS/xpPWNLLOx7Z/vEo/HpSLdj1XM
         fUoha1ur9usQVo8uGs6hklOYlFEvhGoKMaVbDqOB7R0gQ/UEqDDoUOScWt6RbJlt4IJY
         /XwAfaR8P2yMO628VPE0L2TntvWmto5UUE2Su33q6Opi6ze9V8Uf+NDCg/G/cFgtcIg1
         kjbeuwaM00HmoqYUb6AtELBvXpRPU0B/8YY/5W4q0+c1n9WUH3YKxc2O2GffgthLkSrk
         TkRijLbeQoECqhBWONBqe2DPstXLMhweF1dsTGnLPqv/gC9mghEvIqsYknp5RP6o5OcX
         BpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4cSjx5XG6x6AMPYVQpdUv5oPngfbEAO99TqRxKNWknw=;
        b=UTPQhd8i2RdG8E1SMcnOv8aalrWJhgq3ACAywfGZ+CxrvTBU+Jsi+KkbNPC3NXg9cr
         cHNethHaaHAzjXyLMgoyEd+RxAbdrW7sslpF/t0syw+Q6Ar1V4rTQMQ0C7JmooGfrmQH
         At22hqN/G6+OB7g4x2/G5OIdGrNKQDXIya/zsQblHsEFP3IT+QLtfnHxVudBY+xDql43
         L6/4sGY7scilvnavHVRrCu2yNmq2kgwWGCNCh/1MEy4ajt/thf90Jc/SkEqmJf38CCc/
         jeyD1KseXdGs4/M870SFiyb+6E4WogJgB46BXK9XKpx8fWfI1/cmvxeUqjhTySnlEtIV
         9VYw==
X-Gm-Message-State: APjAAAUk8OvVj3L376gpsfFw0Oo6z6woIbH8XDxno2bzK7EA4ThvO/26
        pvmO9cXq4VtnmNORlosE00eIQonvnLo=
X-Google-Smtp-Source: APXvYqzRVnyanlNmmdEH51XL3OzJMY7+sGw3nX1VAR+NL8w+NpIX0TousAqRnfqTR972QOGSviPO0Q==
X-Received: by 2002:a1c:ef14:: with SMTP id n20mr14192477wmh.89.1568627927487;
        Mon, 16 Sep 2019 02:58:47 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u11sm8101956wmd.32.2019.09.16.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 02:58:46 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:58:45 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ 1/1] mesh: Add local/remote bools to DevKey
 transactions
Message-ID: <20190916095845.htvyalekgr4k2ybt@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190915081408.18116-1-brian.gix@intel.com>
 <20190915081408.18116-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190915081408.18116-2-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 09/15, Brian Gix wrote:
> DevKey operations require authorization on the part of the applications
> making the requests. Messages to state changing Servers should use keys
> from the local Key Database to demonstrate authority.

Alright, so if I understand this correctly:

1. If the application would like to change Config Server states on the
   local node, it would need to:
    - call ImportRemoteNode, passing the address of a *local* node and
      the device key obtained from provisioner
    - call DevKeySend to a *local* address, with remote flag set to true
    - receive responses via DevKeyMessageReceived from *local* node,
      with remote flag set to true

   Essentially this means that talking to a local node using device
   security behaves in the same manner as if the node was a remote one.

2. If the application would like to implement an external model that
   uses device security, it would:
    - receive DevKeyMessageReceived calls from remote nodes, with remote
      flag set to false
    - send responses by calling DevKeySend to a *remote* address with
      remote flag set to false

This means that calling DevKeySend to a *local* address with remote flag
false would be forbidden, in order to force the application to use
ImportRemoteNode first?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
