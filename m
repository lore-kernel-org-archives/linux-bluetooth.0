Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJDXkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJDXkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 19:40:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAF1D676;
        Tue,  4 Oct 2022 16:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D8DFCE1119;
        Tue,  4 Oct 2022 23:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0122BC433D6;
        Tue,  4 Oct 2022 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664926815;
        bh=qYshTl+pBcyzQ2bSYCdG81rJrDziSldW1bPras2wmZw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dl5lnTIXJoUi7lNxwCLrR2iHOVfadGcE9H+AknXRmYKybpwLY9rAR2uyvOg+6oZTH
         9EYlw8xtzvrbIEDkrb3+ttXCq+OwfGpXiOkvE3SBgFFSEB9ipOg0VRBL509zKhgAhP
         vIFP9AtndIjnZ/OSrB9QZleJO4yXzp2vmqgBarSo6Dm4ypPPJPYcd40J6Lp7fg7Xd4
         0F5PekL8r2NjbTLUxYMp1Z88gODW1xbXfgtfU/0KniKzecjTG5gjEDEO7lenywUMSC
         YZr9LmgkjqftTkxgUEYkRGEDDyXj5yr2w0buJd2ujuzgqzgb+HQQPIleeZP6bN3nRB
         U3AtsZuUoNc9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8936E49F63;
        Tue,  4 Oct 2022 23:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix use-after-free caused by
 l2cap_reassemble_sdu
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166492681488.12972.13888396104463386099.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Oct 2022 23:40:14 +0000
References: <20221004212718.504094-1-maxtram95@gmail.com>
In-Reply-To: <20221004212718.504094-1-maxtram95@gmail.com>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        mathew.j.martineau@linux.intel.com,
        gustavo.padovan@collabora.co.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Oct 2022 00:27:18 +0300 you wrote:
> Fix the race condition between the following two flows that run in
> parallel:
> 
> 1. l2cap_reassemble_sdu -> chan->ops->recv (l2cap_sock_recv_cb) ->
>    __sock_queue_rcv_skb.
> 
> 2. bt_sock_recvmsg -> skb_recv_datagram, skb_free_datagram.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
    https://git.kernel.org/bluetooth/bluetooth-next/c/89f9f3cb86b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


