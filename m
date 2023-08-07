Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D573EC001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHGXuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92AB3
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B58E462334
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23051C433C8;
        Mon,  7 Aug 2023 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691452223;
        bh=j8j32qL4Gj4OtQl0H7H9ckvJF1oJIVWqEpqA8gdwd+Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Pb7x6lycNEhJRLr9pcgSKROIUlaIoBuaHVcoIw+CB3DKnDTXzvVA9vb4KXrp7Un5i
         hQ6gBHzY6sl5WLTJtTsJS1aTU6MkePeOeZcNzQnazaInsKGC4I+UfW570QQVH3EJT7
         DrCs92S69x66S9kV0x3XZQ2y+ekkxCQwhoI0tM8UaV0G0vylFaUFqVtx2c+PdyIEAr
         2csMF0RcRw5i763mrfpMkl77K98+GpkiFVYLfaALNdLrVUtdspLwajSUqtoj3eFdVb
         wRz1YQAImGh/KGK0CDUnDSv/SAPf0z1tFk/SWxwLzYBVeoaOodzjVUFeC/m355xjOW
         /mWgmQi48ffMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F3A9E270C2;
        Mon,  7 Aug 2023 23:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_event: drop only unbound CIS if Set CIG
 Parameters fails
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169145222305.5057.17030807199575322111.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 23:50:23 +0000
References: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
In-Reply-To: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  5 Aug 2023 19:08:41 +0300 you wrote:
> When user tries to connect a new CIS when its CIG is not configurable,
> that connection shall fail, but pre-existing connections shall not be
> affected.  However, currently hci_cc_le_set_cig_params deletes all CIS
> of the CIG on error so it doesn't work, even though controller shall not
> change CIG/CIS configuration if the command fails.
> 
> Fix by failing on command error only the connections that are not yet
> bound, so that we keep the previous CIS configuration like the
> controller does.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/f5669a036ae6
  - [2/2] Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids
    https://git.kernel.org/bluetooth/bluetooth-next/c/6130cdd83d40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


