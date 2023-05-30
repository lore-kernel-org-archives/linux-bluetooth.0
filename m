Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E9C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 23:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjE3XUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjE3XUY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 19:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835BE8
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 16:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDFF16347A
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 23:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A34C433D2;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685488821;
        bh=G9U2kr0YcH6PJC3MohSRiNWKIdeHPMY834OFiWa35uE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eh3CIE3fsbCLeg3M/Czn+EHh9z4YxxC9TbFLXc6zAmM25Gf/i9KQCNPoGMtSNWAmh
         6ytDtnbOHvMxDNd0que6nBjllMxrz8zHQWtDKzgyxyIkHrMD7ljhuCBxLFb1Tfy7ch
         kPgBcrYAN1eW3cIHpEpEdi2ofhZvkb32Fwg1/z7ILd5NCHGv1dlazFwojyn8qlb6lc
         Vm2iQo/XTBRTcDyS3vZPwP2mpttSDuHkLW25kUJ2rZwBdiAP4T2qHChh7QPb/02U08
         amarmQplTSOmuEABUFaq1XpG3pvF9b39STaDTtU3cVhD9R3m/GH6VpVyG5VrnSUXwf
         Ql09kfufuBCww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13C9EE21ECC;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] isotest: Add support for creating/synchronizing to
 multiple BISes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168548882107.30926.16332009744574807646.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:20:21 +0000
References: <20230529062734.3685-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230529062734.3685-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 May 2023 09:27:33 +0300 you wrote:
> This adds an additional command line option for the Broadcast exercise,
> so that the user can indicate the number of BISes to create as part of a
> BIG (Broadcast Source), or the number of BISes to synchronize
> to (Broadcast Sink).
> 
> This implementation depends on the kernel support for multiple BISes,
> introduced by the following patch:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] isotest: Add support for creating/synchronizing to multiple BISes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8ff103f99397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


