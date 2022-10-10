Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJJVBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJJVAx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 17:00:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0240009
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 14:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6447B810DF
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F195C433B5;
        Mon, 10 Oct 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435617;
        bh=cMfrsdFSB9fjR4lIzON8HaJSI6xIescOn6Tr/dA2aK0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F3rntuOfxBMPuZrpjPK4IDycqpg8Ip02Jv8AvFXuAvsWzcbwss/FZ4Dlhv4rXRax1
         SC+Rzfb0vDitAdic3/S6LDknZb0WzM8FhjFqMkZXLMHVvFfjbGz7vtugGx1q6//8BH
         wct/TBvs2w/b0qXh3GGIYsOenXhdb4N3RNb2WTlQAz/BFt8rJBvQ2XbGxhe91HOWJw
         Infz2IR7KpfrSgmAFD77nu+KU5wOKAVAzWtV5cKncH8myOcmdpPnVA8atxH7kU+3RS
         qi1J6Stavx/MWdFAIqZgtBmdW6RYvuPpn+fUUrYrKltFb51csxX2exVrq7oa3g6CEQ
         m4WabeZsreg+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D560E4D00E;
        Mon, 10 Oct 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] vhci: Add function to interact with
 force_static_address
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166543561744.14234.11311670254400177639.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Oct 2022 21:00:17 +0000
References: <20221007225527.1838767-1-luiz.dentz@gmail.com>
In-Reply-To: <20221007225527.1838767-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Oct 2022 15:55:27 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds functions that can be used to set debugfs
> force_static_address.
> ---
>  emulator/vhci.c | 10 ++++++++++
>  emulator/vhci.h |  1 +
>  2 files changed, 11 insertions(+)

Here is the summary with links:
  - [BlueZ] vhci: Add function to interact with force_static_address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2bf15137410

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


