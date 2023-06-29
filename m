Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A840EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjF2SnX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2SnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCED2D55
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 11:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64287615F2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 18:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD0CC433C9;
        Thu, 29 Jun 2023 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064199;
        bh=JB3yOko/3MZ4NfcJ02y4I5HJqG6ralFIy2cH6mm4B58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hUbaOnhj+FLOhftYP5ssuSKS8yVeU8e7MzEtJciAIkpr4y6XDKdwjmtUSSIwRsXwj
         iTgyx+hq2WWfuXazpap7YW6qBVjjmB8TkPSR7YXYBseazvx1kq7+I3qpQT04o9QWQL
         Z1G613NyD0c4gHxyk+/DaGw0DWO9znNCVWxupFgNgP+YCRk/9+fWE+Lbq9BPGs8+LO
         gs8mP2e4LyygsBlxsyotQOv6Mhfa+2DL96CdqgiSFSAxg+XM746xR2k97iREW+5x+G
         Ah6qUUyQHUEpWryxB8ujSbv81Og7WAC53zq4icazJjtdbXlSQPgNvdMLO6gwayia8b
         wh85+DCBj0aQw==
Date:   Thu, 29 Jun 2023 11:43:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-06-27
Message-ID: <20230629114318.61b46f61@kernel.org>
In-Reply-To: <CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com>
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
        <20230628193854.6fabbf6d@kernel.org>
        <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
        <20230629082241.56eefe0b@kernel.org>
        <20230629105941.1f7fed9c@kernel.org>
        <CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 29 Jun 2023 11:34:34 -0700 Luiz Augusto von Dentz wrote:
> > > Nothing to add to that list?
> > > Let me see if I can cherry-pick them cleanly.  
> >
> > I pushed these to net now, hopefully I didn't mess it up :)  
> 
> Great, thanks. I guess I will change the frequency we do pull request
> to net-next going forward, perhaps something doing it
> bi-weekly/monthly would be better to avoid risking missing the merge
> window if that happens to conflict with some event, etc.

Maybe every 3 weeks would be optimal? Basically the week after -rc3,
the week after -rc6 and then a small catch up right before the merge
window if needed? Obviously easier said than done as life tends to 
not align with fixed schedules..
