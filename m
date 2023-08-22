Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB43EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 19:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHVTUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHVTUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85100E59
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 12:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD3B65DB1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A229C433C7;
        Tue, 22 Aug 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692732024;
        bh=oGgeRiqDCi3bKy8XKy+K4oNek9tprqwztNNF9QQb6Rw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S1QOupFf50LVu/jjyITHXroSu+k+IaZQbKqGXNfv9eiqhQk7hS1TBAlktClckb+WC
         B2WSvbUFFKq95NKwGV3XcGZjj0xT2k7YxVqRuuYDYnYiOb4gbJ7BfBstPzSlNmT2UF
         lREUkaWrGZutNFE/EcaA8uURTfi4OwzYMuxNG8qKmepZCVGkpx7x+o2gHmtKg6RF9x
         m0LqCsSZEEooA2sIxf3xt9sM6WnOcrANkzIu6Jv2C0kDKM33CFkMGjawih53ReyL+v
         nFszbkbAEamlbKHZc5tiICbnZfPo3HIPMPnlVSiKPV9UZwpZxcSuRzTh8tFkL5AWbY
         7i/iC7mXSSrVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54A24E21ECD;
        Tue, 22 Aug 2023 19:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: Send new command for PPAG
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169273202434.24226.10967715563157372357.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Aug 2023 19:20:24 +0000
References: <20230817114249.75827-1-lokendra.singh@intel.com>
In-Reply-To: <20230817114249.75827-1-lokendra.singh@intel.com>
To:     Lokendra Singh <lokendra.singh@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, luiz.von.dentz@intel.com,
        tedd.an@intel.com, kiran.k@intel.com, seema.sreemantha@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Aug 2023 17:12:50 +0530 you wrote:
> Added support for the new command opcode FE0B
> (HCI Intel PPAG Enable).
> 
> btmon log:
> < HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
>         Enable: 0x00000002
> > HCI Event: Command Complete (0x0e) plen 4
>       Intel PPAG Enable (0x3f|0x020b) ncmd 1
>         Status: Success (0x00)
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: Send new command for PPAG
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0c33fb2c3b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


