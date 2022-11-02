Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC41C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 16:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKBQja (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiKBQiy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 12:38:54 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3C1C425
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 09:33:36 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13ae8117023so20871360fac.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Nov 2022 09:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIJ9YfDZoexQP0+oYMCU+CJvJ6/e2TbbtINXcDEy98s=;
        b=xrE8AVkmQ31MOgOQvTifMevbH3nPicbcJPnz9gABpsnl+sNv75zLRyrg+EP7TKSqeu
         Q6Aw50Ur5dErzK9DWvBhhIrei09GODGCTmpZMZ4Ua6sto9WFUWvwzbViaD7ha8NFGAQN
         2zxLPYMOb6epjNDW/3N+ZXzoAfT9gaEUA3bQDhRLDbAMpOyYQ3xhiYF8zZVJW/sqbq+9
         xK4fktF+Hx5joLowkAUz/m+7OkvqIfu0qGfj73FlcBUR1DdYFFZsgAyao87X4QffQeYe
         pmBE1RoE/lbi6GeVnLibrgRyNHX67tYAZ9hzuIPbBkDJpbdHUKUCRwsjcmM+JS5QxynV
         KnaA==
X-Gm-Message-State: ACrzQf3CI3ncs7f6HUVw1HG8sYLUmaDRPbWowGbo/kxMYcqtE70rsypd
        cpjtRdcYu6vr+qDvcjaaSw==
X-Google-Smtp-Source: AMsMyM7cBwnhSuweP9eO41SiFqsM+Z9QV91xuOG+tHBTknF5/R+dPI4ILjWidZqnHfRtaa2bb11gEg==
X-Received: by 2002:a05:6870:3924:b0:13b:747c:9311 with SMTP id b36-20020a056870392400b0013b747c9311mr25375696oap.151.1667406805793;
        Wed, 02 Nov 2022 09:33:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bo35-20020a05680822a300b0034fd36e95bfsm4643634oib.31.2022.11.02.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:33:25 -0700 (PDT)
Received: (nullmailer pid 4008127 invoked by uid 1000);
        Wed, 02 Nov 2022 16:33:27 -0000
Date:   Wed, 2 Nov 2022 11:33:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT
 binding
Message-ID: <20221102163327.GA4006397-robh@kernel.org>
References: <20221031204804.195267-1-marex@denx.de>
 <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
 <a7485b76-b4aa-a6d6-b509-c6f370380926@denx.de>
 <CABBYNZLpaT7FCwXrGq8RU4owP74VA7Eo99jceFzVsqqVnYFaHw@mail.gmail.com>
 <52c65cd1-9631-50a7-aded-7e4a877bbad9@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c65cd1-9631-50a7-aded-7e4a877bbad9@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 01, 2022 at 11:52:23PM +0100, Marek Vasut wrote:
> On 11/1/22 23:44, Luiz Augusto von Dentz wrote:
> > Hi Marek,
> 
> Hi,
> 
> > On Tue, Nov 1, 2022 at 3:38 PM Marek Vasut <marex@denx.de> wrote:
> > > 
> > > On 10/31/22 23:07, bluez.test.bot@gmail.com wrote:
> > > > This is automated email and please do not reply to this email!
> > > > 
> > > > Dear submitter,
> > > > 
> > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690631
> > > > 
> > > > ---Test result---
> > > > 
> > > > Test Summary:
> > > > CheckPatch                    PASS      2.99 seconds
> > > > GitLint                       PASS      1.48 seconds
> > > > SubjectPrefix                 FAIL      0.58 seconds
> > > 
> > > Should the DT bindings really have Bluetooth: prefix/tag too ?
> > > git log on prior art indicates they shouldn't .
> > 
> > If it is meant for bluetooth-next then yes it shall contain it since
> > the CI does attempt to check its presence, in the other hand we could
> > perhaps use the prefix [bluetooth] to avoid having the CI run on
> > patches that are not meant for bluetooth-next but I don't think other
> > subsystem do require this so it sort of hard to enforce proper
> > prefixing.
> 
> Linux Documentation/devicetree/bindings seems to start with dt-bindings:
> prefix always, so maybe we should keep it that way ?

Yes.
