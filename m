Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C96C761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjCaWKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjCaWKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1785279
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1874662C58
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 22:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A6BEC4339B;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680300618;
        bh=AXUf/AU/uaRcFfSXoUMLK3b/n6wggqxeoltFou7MKZo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c6n4ikETjfb30IMxJLf5mcp0GwVx6k/qCyI/m3UwNiRrYNQ+XqofU1KCDyjw7HE1l
         ON3Qzwy/nck5XX6CuPCHNNK7Oma7g0LWhi31jCnuzLj5xPIs2hut2ywbCyncmB8CUd
         E7az2IRgV8PLXfnn9vNDuWpzlsh2j6HMIhCKBHGPRCrPQny5wBgCmyFjOKhmbRM3C/
         w0EQliYA0Opx1UOQfiHCqBVqNV9Ra76wt1CD+m6AU/pJwXTg5+Xzi+sB6bjAvkx54H
         /+m11Bu3PCCP4Pg9wWvLFnBMMJdN1H3woLU9c1MeFaAqFwlmoasla8vxPMVfWSUmE5
         GRTgh4jwGeloQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5583CC73FE0;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix double free in hci_conn_cleanup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168030061834.9780.9050240838734516286.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 22:10:18 +0000
References: <20230330220332.1035910-1-luiz.dentz@gmail.com>
In-Reply-To: <20230330220332.1035910-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Mar 2023 15:03:30 -0700 you wrote:
> From: ZhengHan Wang <wzhmmmmm@gmail.com>
> 
> syzbot reports a slab use-after-free in hci_conn_hash_flush [1].
> After releasing an object using hci_conn_del_sysfs in the
> hci_conn_cleanup function, releasing the same object again
> using the hci_dev_put and hci_conn_put functions causes a double free.
> Here's a simplified flow:
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix double free in hci_conn_cleanup
    (no matching commit)
  - [2/2] Bluetooth: SCO: Fix possible circular locking dependency sco_sock_getsockopt
    https://git.kernel.org/bluetooth/bluetooth-next/c/c545d02663ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


