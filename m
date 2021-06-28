Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9DC11F64
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 23:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C65761D01
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbhF1XMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 19:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236590AbhF1XMi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 19:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 03C6461D02;
        Mon, 28 Jun 2021 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624921812;
        bh=gkW62qCHQgIrYJEFmkJeNhWFZWK+2asrsyXPVnIk7aQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dzyVrNE0sN5g0flCly5RmIsYeodpWZ0Wp8YyNzwwX7969+9IW3I/oC01p1FfYhQH3
         AyVgGNhLWCqYVmsFq5KfHvxTMBDNwgd2wZMgZc9RKtJaVX54Dwj853piSMR7rt+A78
         3117uVuo3VdZbN/QgRxfTtiICcYZfnTy2lYRRei+GloUdzH69VlI1DvlvSnn88Sdts
         vHGN/4HRRBvqYSDwwl/j5tsMDDiUezdit4u3DGvKsxvXdEYHgDxo8JpylIvUk6MUxH
         f04Y15FQ72P6w8CLqgvOaCZCh0RPCp7CeEMxOxbo//tKcLJGnpcaMkZlavU9GRi4Qp
         E7LO8CFEqN62g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2021-06-28
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162492181194.29625.18150550264106951771.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Jun 2021 23:10:11 +0000
References: <20210628171552.313547-1-luiz.dentz@gmail.com>
In-Reply-To: <20210628171552.313547-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (refs/heads/master):

On Mon, 28 Jun 2021 10:15:52 -0700 you wrote:
> The following changes since commit ff8744b5eb116fdf9b80a6ff774393afac7325bd:
> 
>   Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2021-06-25 11:59:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2021-06-28
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2021-06-28
    https://git.kernel.org/netdev/net-next/c/f0305e732a1a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


