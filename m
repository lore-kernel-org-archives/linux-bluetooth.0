Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3552BC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F3A214AF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="GfjgdcZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfIPLIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:08:43 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38031 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfIPLIn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 07:08:43 -0400
Received: by mail-wr1-f54.google.com with SMTP id l11so38362942wrx.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gPL7LiuOjEExSlU8WxEfL+s/iuBK0S+TbS2/pWpVnFg=;
        b=GfjgdcZg2cmeG4aNv6M2e9Hwi/oImojVbzmZNjDhi3Z/W/fUPW+zDRYnCeR0NrmwW7
         yYGzOjtibtzQORpMqZ8gT0neA3TLAzH7dJP95jZ6unENpvxN33CjxpRRcUntV6E/samt
         NngEZ6jqvS71dkHP7ewKsUfM95jcQmVSEFEpcNH2oPUC68IJvjlq0LbP8haijnBRv8nq
         rCAYcjmjYdQ6Zp/LRy/jBQFjLNzi88z1TokNSEJOCpR3owHkrJQ/kWFYdQU0L9XAE+zA
         3JGSa2Bf/iLGFe3bAx2TtK7Jq0OQv6dTGzbY0MwIqB6xNpDt3MHAnk21Rzm8QFXZyOea
         RHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gPL7LiuOjEExSlU8WxEfL+s/iuBK0S+TbS2/pWpVnFg=;
        b=awyKRevieQuUeQENmE9KNGLoCeO/k0LxEc93rpCpeH1o/tONUz8EFtV4HrV1HDHro2
         GD2n4L4HYGO5YihdDhXcJUSO6WFft9CzaXcezWyIU5nGK9gOR3brLBufsLKyw9dtS/IW
         fMSucXMe8WWLnxYbSfyIkDfXQs85gSCVCLKc2XEgMHwb8yNT04vjlR8NM8+BEfk7RzFl
         DAf2usCDxt9s3SsWrbMM3dIU12eYLyQYzCCze8RqaM4dnKl3nDNTw/vkkL5LAAwGzOy6
         sDj5tMX25zN3D1M/qkmwB+NrT5HrvY5jzuzxTh+h5vt21DKWo8q4iUno9YLmlVETGgoc
         rWcQ==
X-Gm-Message-State: APjAAAXUgoRRz0tzSnMHjelbSz/DdoKThTYS4m1X0ggaKuM4YBcYHKuY
        0oxh0MV75lIFhWK47mHnU8WT+RHYWn4=
X-Google-Smtp-Source: APXvYqwMyrZg98+O/FLyTpcAs5eybM322JAkXLdU0qjk3551skDwHB9gr4/Rm9CLl+PO81jtI0/U+w==
X-Received: by 2002:adf:e9ce:: with SMTP id l14mr25653079wrn.264.1568632121187;
        Mon, 16 Sep 2019 04:08:41 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b22sm6386486wmj.36.2019.09.16.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:08:40 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:08:39 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Add local/remote bools to DevKey
 transactions
Message-ID: <20190916110839.jscnzmdnnrbefmqm@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190915081408.18116-1-brian.gix@intel.com>
 <20190915081408.18116-2-brian.gix@intel.com>
 <20190916095845.htvyalekgr4k2ybt@mlowasrzechonek2133>
 <8DD9DDA0-1081-479F-B215-2E815B1A8F27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8DD9DDA0-1081-479F-B215-2E815B1A8F27@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 09/16, Gix, Brian wrote:
> > 1. If the application would like to change Config Server states on the
> >   local node, it would need to:
> >    - call ImportRemoteNode, passing the address of a *local* node and
> >      the device key obtained from provisioner
> >    - call DevKeySend to a *local* address, with remote flag set to true
> >    - receive responses via DevKeyMessageReceived from *local* node,
> >      with remote flag set to true
> > 
> >   Essentially this means that talking to a local node using device
> >   security behaves in the same manner as if the node was a remote one.
> > 
> > 2. If the application would like to implement an external model that
> >   uses device security, it would:
> >    - receive DevKeyMessageReceived calls from remote nodes, with remote
> >      flag set to false
> >    - send responses by calling DevKeySend to a *remote* address with
> >      remote flag set to false
> > 
> > This means that calling DevKeySend to a *local* address with remote flag
> > false would be forbidden, in order to force the application to use
> > ImportRemoteNode first?
> 
> I think that is all basically correct. I switched the Boolean
> bit-sense  such that the boolean parameter is “remote” on the send and
> “local” on the receive.
> 
> And most importantly, your last point is an emphatic yes....    you
> will need to import your own device key to the key ring if you want to
> talk to your own builtin servers.  The one exception will be nodes
> that have called “Create()” which are generating brand new mesh
> networks with themselves as unicast 0001.

Ok, sounds good!

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
