Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FEC77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjCaWKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjCaWKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114425279
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A313DB83287
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 22:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB2BC433EF;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680300618;
        bh=G25akUlahBjxXZHNSgnbafkLQZA5UEql73zLYB2d5Ek=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fkMrUwqAmBbs7ayliEIkbfPLQg3sTQgAjXXY3dZmtptZIze9sIZa+tVOxi0J/j7tw
         fjUxClf0cJt8i48smoHnywRF0SlJ/UKkDQUkWi9nYsy5NTXeJD6AFlsoAdgBZOYusP
         /7APfbzFFmVm7CInXuw6C/g5RsdZfYuZwiBlkfScd6mPZu+Pfcb8HVhPQNJXRy1Rbe
         g1VrKjpCSRhGD2sBr6t6GzKLA0NLoPi7uftuV63v5JEdAQ+mSvDIrExOrlettNwx2T
         IpnU7UKohxi6uNXVatMksNNvENRwqsoKADRvjTkWJ27R64WN7zdwEF4hHfbjibc+0x
         lf57RWdJFhNMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 466F0C0C40E;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: SCO: Fix possible circular locking dependency
 on sco_connect_cfm
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168030061828.9780.380338342207470135.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 22:10:18 +0000
References: <20230330220332.1035910-2-luiz.dentz@gmail.com>
In-Reply-To: <20230330220332.1035910-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Mar 2023 15:03:31 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to fix the following trace:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.3.0-rc2-g0b93eeba4454 #4703 Not tainted
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm
    https://git.kernel.org/bluetooth/bluetooth-next/c/53fd49a194f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


