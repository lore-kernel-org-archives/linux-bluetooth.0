Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0376141F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 15:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhEGPbg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 11:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233625AbhEGPbg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 11:31:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 639F6613F0;
        Fri,  7 May 2021 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401435;
        bh=GAr1KH9Y7/MpM8hHmDSAod/Z5TUK0Ud72T77n7e9CZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvWq41CgSPALqsyCZFHGIGyhcZi546wgk+0iwMTcIvUcggZXGKD8OrmIJ3PAjuNep
         yQuCsTgHm/RixsnYAKvw/7/LgHYU3FO+QGMyrdD7ND0IWRIlX12PFHPLCiA6oMOBiG
         SavuCZ8T0aXq3z3mpjHME1RznXffIYbAhpSLsy4ohMMCLB8ZevkEWGQVpXSRK36yvJ
         suVzryCHDkufLiv8vOidgjq3GX/3vaT26iRtulGFWEgYfdHopaQLS/Dkx0G/1/5rYi
         mmKqnS8BLoP1bKT5XqPHnPbfY4ey9Y0neSrjl5Dij+U8On4zM8OShzfBoI+5RlM4DK
         QNevWwx59zoCw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lf2RA-0006Tk-Kq; Fri, 07 May 2021 17:30:45 +0200
Date:   Fri, 7 May 2021 17:30:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix potential gfp
Message-ID: <YJVdJEMKz6YcnwOW@hovoldconsulting.com>
References: <20210501150445.4055-1-paskripkin@gmail.com>
 <9A08CBDA-3501-48F6-9F7A-60958C5CF888@holtmann.org>
 <YJU8iP+O9aSYwYp/@hovoldconsulting.com>
 <CDE30B55-E91B-4513-80E4-2198F8A32217@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDE30B55-E91B-4513-80E4-2198F8A32217@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 07, 2021 at 05:20:11PM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >>> In qca_power_shutdown() qcadev local variable is
> >>> initialized by hu->serdev.dev private data, but
> >>> hu->serdev can be NULL and there is a check for it.
> >>> 
> >>> Since, qcadev is not used before
> >>> 
> >>> 	if (!hu->serdev)
> >>> 		return;
> >>> 
> >>> we can move its initialization after this "if" to
> >>> prevent gfp.
> >>> 
> >>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> >>> ---
> >>> drivers/bluetooth/hci_qca.c | 4 ++--
> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> patch has been applied to bluetooth-next tree.
> > 
> > Why did you pick the v1 when it is clear from thread that a v2 has been
> > posted?
> 
> because I only saw that email after I applied the patch and the v2 is
> nowhere in sight as it seems. If it shows up, I replace this one then.

Here it is

	https://lore.kernel.org/lkml/20210503100605.5223-1-paskripkin@gmail.com/

Johan
