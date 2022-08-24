Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42065C48BE4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Aug 2022 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiHXVkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiHXVkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Aug 2022 17:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9D25EA6
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 14:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7026BB8238B
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05E9BC433B5;
        Wed, 24 Aug 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661377216;
        bh=DChq7P+/YgpWgtTae9mjj6FQt2qxPKBiNdPgNsIlaBI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ARo0EBzN2rIRheV3dSH2zYOQua2OIWVUhM10kYKmtTjLtJitOrErnORMmX3ZPT1xI
         xNR9K8KLliyhdkXcN5BvnmRmHWu1CPMF+F+QCLEvFLmiZjViXLnv/eDjj1Ge3VSmI3
         343h5sGvsOv2EMTUna8FIGa03ZbaG4gmmmkjmNlOBVkGYI7sRUJJJS+IeOp8UnAJzH
         xngNE52edXEkwGnDyIOHkD0QFTArwkUO49QfEM3lR6ia7ZkwCSTzwbDuxZpk/6/rkk
         aoKR7bvHzZ4/K9GbBVKFp5FAKavhG93emr0X79ecP4H/i0NE924MqxNa1js4LLYV7d
         B+QN2BZDIcMBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3FC2E2A03D;
        Wed, 24 Aug 2022 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] zsh: drop no more arguments message
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166137721593.21154.824077337582833353.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 21:40:15 +0000
References: <20220822231909.45606-1-ronan@rjp.ie>
In-Reply-To: <20220822231909.45606-1-ronan@rjp.ie>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Aug 2022 16:19:10 -0700 you wrote:
> This usage of the _message as a completion function is invalid, and
> will result in an error if invoked by _arguments when the user has a
> format style set for completion messages.
> 
> We can just drop this message, since it is not necessary.
> 
> Before:
>   $ zstyle ':completion:*:messages' format '%d'
>   $ bluetoothctl connect <TAB>
>   _message:zformat:42: invalid argument: -J
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] zsh: drop no more arguments message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c2f0c037e92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


