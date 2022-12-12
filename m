Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED16CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 22:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiLLWcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiLLWcR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 17:32:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073B13F5A;
        Mon, 12 Dec 2022 14:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D71361257;
        Mon, 12 Dec 2022 22:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66281C433F1;
        Mon, 12 Dec 2022 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670884336;
        bh=rTHoQ5grv1X7A+1gzOLeUksAc4gGRlSJbhHYSTPrNPQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=not1ghBt5xWFk48Z6f9/e0MTbqcSqE3Vuh3VqP1oSyJQh6glyjDtpbN/eGY009IlJ
         gy4CEIg+qj03b3DAy+Zy6v/cPinbL55uKz/MztQdV3t/plAN/bwJQJ/XfyqVAIo+LA
         zQy0gH/3UWeNXYfDD1FdKMd25ymlUrz+6CCvqjV3+wAYh+tLkr/dIJWQ/qsims3h35
         irhxic+PbtCyKkNR3ausjFBSMuqsSQOKfkaaPxVPV9yKIS62w3brBzAjymodRJi7OM
         Te/DLQLo9tzwKG6XUM7ULpMu1IjQIZfvz38WFY40C43TCIEzv22C1z1hSjFRmRjHYS
         tigVIuPaQZnKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DB05E21EF1;
        Mon, 12 Dec 2022 22:32:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2022-12-02
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167088433631.7987.14240192422383965354.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Dec 2022 22:32:16 +0000
References: <20221202213726.2801581-1-luiz.dentz@gmail.com>
In-Reply-To: <20221202213726.2801581-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Dec 2022 13:37:26 -0800 you wrote:
> The following changes since commit e931a173a685fe213127ae5aa6b7f2196c1d875d:
> 
>   Merge branch 'vmxnet3-fixes' (2022-12-02 10:30:07 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-12-02
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2022-12-02
    https://git.kernel.org/bluetooth/bluetooth-next/c/a789c70c1dfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


