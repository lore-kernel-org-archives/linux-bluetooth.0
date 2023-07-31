Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B430BC001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGaRuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGaRu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 13:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F6123
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 10:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AB86126B
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 17:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7862BC433CD;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825824;
        bh=c1V7lO/IowxdKAYeJjOxZ+wTC54kgNefZwTJzq7olr8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A0T+r6cycrV84WyMBqWWdmncuUs6+jzR2poCKD4qIKVJxf4K5CQPrqMBbGLYHUNiM
         9aO1xPH7AUCmQCtJf2Utmpt3k+fa32Xqi1C+4BWhrVIq0sLiJ5Xx1KD6vrbNEz7Zby
         FgOQayEyqX8kCpvPGeNN/FxeldBxkwNS7rxAM73j90D696zIojhEFGaHYWQcoQLO+q
         1ImDBAj8vyKxzutmVi5vXXKWwOqr8ylh9xtfi8F4VlN+Hg5aUmz+94SCayet51a1NM
         0O4f4PVm9TWxPYQ9aeZd09X/uOxqi+vJFImWnaUcHUd2Tnxcr9a48/5lQZW+A+g9Cp
         8MnP2MlQ9qxHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 609BDC691EF;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] main: Fix integer configuration option parse
 failures
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082582439.13999.13820304183162328350.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 17:50:24 +0000
References: <1690795722-29873-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1690795722-29873-1-git-send-email-quic_zijuhu@quicinc.com>
To:     Zijun Hu <quic_zijuhu@quicinc.com>
Cc:     luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Jul 2023 17:28:42 +0800 you wrote:
> parse_config_int() has a obvious logical error, so causes many
> parse failures of integer configuration options, fixed by this
> change.
> ---
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] main: Fix integer configuration option parse failures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=446d8ada5790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


