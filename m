Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771BEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 18:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFTSaa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjFTSa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644B1712
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 11:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392F16140F
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86718C433D9;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285824;
        bh=F+HgYsbQIV4xHoSOPoA0oCrvTou7TGHS4kdmjRtNWd0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YFN/0oc9b+fE6nzEIPfXGXZNw6tcKJ/ahVAlULz3vXYrG/cAzDwUD0qo+9DQg3XBA
         r8v8rLbpg9R4EW8aF1Io9uYA/FCupcYixoUS4yOV032PI9ZnHwUPj7lBWtjIP/FxdU
         +afWNCpb6J4gYAXk7YusXrYPinJOatKZm0Vz2P7yccQa52Xk6MCrTtvyllXqePvi0k
         Xu5FgRft5Rd7aWP6/+ACu7FwHlhi0k6fFUVI7kFiMuGiX7f1hexe8nr8A5RrNqafSm
         TPO4R4t0Fsq6/6zlQZsfR0Cb6FRlXtkkuyQ0cbyu+xf736dwJ1h3fT3B/Rd9qCl+DU
         tE3DTboun794g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62FACE2A036;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: ISO: Support multiple BIGs
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168728582440.12887.18062980666581580894.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 18:30:24 +0000
References: <20230619145316.3185-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230619145316.3185-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
        claudia.rosu@nxp.com, andrei.istodorescu@nxp.com,
        vlad.pruteanu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Jun 2023 17:53:15 +0300 you wrote:
> This patch adds support for creating multiple BIGs. According to
> spec, each BIG shall have an unique handle, and each BIG should
> be associated with a different advertising handle. Otherwise,
> the LE Create BIG command will fail, with error code
> Command Disallowed (for reusing a BIG handle), or
> Unknown Advertising Identifier (for reusing an advertising
> handle).
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: ISO: Support multiple BIGs
    https://git.kernel.org/bluetooth/bluetooth-next/c/cd3e1f298102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


