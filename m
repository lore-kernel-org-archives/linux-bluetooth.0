Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC1C19F29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiHDAKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiHDAKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3557388B
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF0261713
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A8A1C433D7;
        Thu,  4 Aug 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659571814;
        bh=EkJOfji2JcLbhM1mRmUsI6qfzBabaGtUqglZ1qQYKlI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lj8fk96S93UPZMi6XgZsipeajEDKuquBdB5HDzHsLfbSCqLOvOSpTHTZD3vpG8ltI
         LHKMsK6NTHFOtAsK3nE+8zCIm9VsQ2/1gUt1ub0dPaWwG/l/qZGPmtStvwJiFyX4z4
         mG3mi/yquSf8dXA/BKLqPPCGLeWNPNPAg0yWRJIzPoLWgIJdE8D4zx7HEj+U/6ExDY
         Enzz+WFTf80No6C5nfsj+hhSUOGCjsiMAwTnl2mmCvkefMSkonQBIEOCh/NpApxXpM
         97ZIJ3Xh3qjG6airWZMaUBvREhXCFtjVDI5bZeW2z0mU8rLKetuOjjRrmNPPrrXghW
         JlH0h0c85l/MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CBD9C43142;
        Thu,  4 Aug 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Fix iso_sock_getsockopt for BT_DEFER_SETUP
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165957181450.32352.17724736705963571844.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 00:10:14 +0000
References: <20220803172006.2951684-1-luiz.dentz@gmail.com>
In-Reply-To: <20220803172006.2951684-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Aug 2022 10:20:06 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_DEFER_SETUP shall be considered valid for all states except for
> BT_CONNECTED as it is also used when initiated a connection rather then
> only for BT_BOUND and BT_LISTEN.
> 
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Fix iso_sock_getsockopt for BT_DEFER_SETUP
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a3fd9bb4fac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


