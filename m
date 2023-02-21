Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE41C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Feb 2023 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBUWa1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBUWa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 17:30:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EED5311C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 14:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21B5BB810E7
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5E76C4339B;
        Tue, 21 Feb 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677018618;
        bh=jJtV9PGF0pjiGKs3VWRJ2T6va/UBcFUGPPW5y1YrcU4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tmJCmAgjU4henIiAalXjLOuIwpwRjQrFM6UwovQF0ldR94xThaEbuTXUSDcTMNM7v
         E38kYGJquUYViqfUiRBdg7VFRFAeAHQ+rPr+4CoSnRUbyj8rD3A5//dH8uSCQ0Hkbd
         VODLtsPZ3PZFaeAyZj01ZZPu3iAPSQz763POWdb1GojTsk8A9e7ygtghJfF7+bn10Y
         xPVB133xMF444VK/O10SVcKsskm0GFiOJTv25sycsCATwwjA2wqI642w311p1Qs4FO
         2Ds+XLwjRr5VWEKSwT2i0MFR/8JXdP+HsoKtkhabBfuvNS1FB3hjby8OlRgak3DZpb
         rohNCB83X0zEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD031C43158;
        Tue, 21 Feb 2023 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio/transport: update BAP transport QOS values when
 changed
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167701861870.4644.11941918673872627941.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Feb 2023 22:30:18 +0000
References: <f37329b52b85e536b8db17c0fa5e349578fff286.1676829559.git.pav@iki.fi>
In-Reply-To: <f37329b52b85e536b8db17c0fa5e349578fff286.1676829559.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 19 Feb 2023 18:02:03 +0000 you wrote:
> Currently, BAP transport publishes on DBus QOS values obtained at
> transport creation time. For BAP server the transport creation usually
> occurs before stream QOS is configured, and these values are then all
> zero. bap->sdu is also never set.
> 
> Update transport QOS values in DBus when stream state changes.  Since
> nearly all QOS values are exposed in the transport, use bt_bap_qos to
> store them there for simplicity.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/transport: update BAP transport QOS values when changed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1bfd597fe881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


