Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC26C0032E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 20:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjJTUu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjJTUu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 16:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90BDBF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 13:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BD22C433C9;
        Fri, 20 Oct 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697835025;
        bh=NJaztkj1X1dzva6vrdoltGnCY7zzPdJ+o0shAhoA2VQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ubK8Lou+nzEBf4r2yWstWAIOADy5tkugysUzmMdR0kcm2tOP3HCBoPJowUyOAMjfv
         uqjZ14/kP9NtQrHuScc9TiEE3/MP/lONAzt1w3TuJ866vq2FIRtkTdibJEgo8SeWug
         /h456TnAIwRphkaN+OLiEQIMKQlUD0/J4Fiwb2h/FQJ7JwXS0096UDD/uLl0i7WjIV
         nPTz6sQp5iGag9PZ6c2jdxk9dGfoCVuGcvObDRXwH+U3wtyxyxExT8Y3Fq2EC8wzcA
         8hFJ4cH8DqnYtssJ+AxEHkV5iCJCCkE8d/2jye6xgAvuJKysFs/YFfv3m+brTjo9t0
         QykFneARhl9QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70E34C691E1;
        Fri, 20 Oct 2023 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] shared/util: Add util_debug_{tlv, bit} helpers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169783502545.21183.11285080609527968095.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Oct 2023 20:50:25 +0000
References: <20231020180834.3010421-1-luiz.dentz@gmail.com>
In-Reply-To: <20231020180834.3010421-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Oct 2023 11:08:31 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds util_debug_tlv and util_debug_bit which can help to print
> debug information in their respective formats.
> ---
>  src/shared/util.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/util.h | 30 ++++++++++++++++
>  2 files changed, 118 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/4] shared/util: Add util_debug_{tlv, bit} helpers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ffc5819ce412
  - [BlueZ,v2,2/4] monitor: Make use of util_debug_tlv to decode TLV entries
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1ec08661422
  - [BlueZ,v2,3/4] shared/bap: Add debug helpers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6d4491649e06
  - [BlueZ,v2,4/4] client: Make use of bap-debug functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a335099bc1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


