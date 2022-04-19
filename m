Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D86C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiDSAC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiDSAC4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B99E00E
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74441B81128
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E47C385AD;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326412;
        bh=0njdH49nNa+Ip5TXEvLCIaEReHnPaiClhqYFUS2/2lk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OTzI+1jDWTWwSFS0/9hopdDgv/DUoHD3lsQHlAltsjG1A/ysXGUrs46L7C6Y2KLSo
         h+q7w+jKz9bRs6lmpp2bSMJUdCzw2TOQnw0CgkgWiCK7N13FOyzfbJ9FeCUySgW0XM
         ff8m5BZQgtA2Ffrg1YdyQjarvsOBzSgOZlC+8OXCSsBVv/ILWIy10sEgm5i8hkkOn2
         jmkj+N1UdbM7/bFZMe3HYBkr2WrDuhP/NTlZK8yqZQ5MczXAi+xxbPKc5fI4DYBli8
         fDZjB/XibgVzA7bRMDKj4On/7sxI1AuI227D0mIQJsrP+AM3JBNEBE1ltf71xOSz2V
         QLtU/wiODsikA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17ED1E8DBD4;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] policy: Change AutoEnable default to true
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165032641209.24068.14336442227572728184.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 00:00:12 +0000
References: <20220413222425.187199-1-luiz.dentz@gmail.com>
In-Reply-To: <20220413222425.187199-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Apr 2022 15:24:25 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This changes the default of AutoEnable to true so controllers are power
> up by default.
> 
> Fixes: https://github.com/bluez/bluez/issues/328
> 
> [...]

Here is the summary with links:
  - [BlueZ] policy: Change AutoEnable default to true
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=180cf09933b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


