Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53945ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiH2UKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiH2UKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86624F22
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB2D1B81202
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7551DC433B5;
        Mon, 29 Aug 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661803815;
        bh=rorNp9sx3ziyxeLHVamOCORb0pp0dMDFvbXdfQdgoYY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gNANOB1mCNNk1SdTubgoo0lbIxALssX1VAZYyRK78nALvZ7zCqZpesWkMEwFYp9cQ
         Q3dJlN9Nj/IsuKNpg96HPzdUX5Yvc2aTQwO30yeOrO6uluGLKjHRiDuBcwAXXDF0Tl
         ibUsP4e7XUG6ObFXRRcd7HhVCac966QuQPyyuWsz5G4OsbbMPheKohrrCd1N8ka4V0
         XWHAW2++iNN8Pn+0wp6/tXqb60CP5p1xCYny2yNsKGxxFWDXcGf0fIdp2kgHbxzRk/
         czgCpYLQ1NWjOD2ua1bkLJcJaLElsnuuD2q+ZfZuB+2qLCj9CF5z6oD/cQZYzXRhjp
         UeRhZu75eGVxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59E5DE924DA;
        Mon, 29 Aug 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/btmgmt: add missing return statement
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166180381536.25653.1874173837275609593.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 20:10:15 +0000
References: <20220825203848.3499-1-ceggers@arri.de>
In-Reply-To: <20220825203848.3499-1-ceggers@arri.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        tedd.an@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Aug 2022 22:38:48 +0200 you wrote:
> Leave function on error instead of printing (possibly) invalid flags.
> 
> Fixes: d70618e49461 ("tools/btmgmt: Add device flags commands")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  tools/btmgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - tools/btmgmt: add missing return statement
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=150bbff449c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


