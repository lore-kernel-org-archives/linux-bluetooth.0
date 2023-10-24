Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD7C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbjJXSK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjJXSK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 14:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5010D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 11:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC134C433C9;
        Tue, 24 Oct 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698171024;
        bh=t2ps2iXmY8ndXq6MoXhhogAk7NTGIcNwtw9PFxWDIOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kGj09haCw0QCd4qWCrNr5P3cKw/YhkjHnv+qNhiC7RbQlQGe018mB+DU0x8tGVuMk
         417rXL7NhZV/wk00Aw5CQ8xlbnkjmPlLuzvgqcC7e4LbcK/b/OvjiWhpx5EEX7CcEj
         j5rd56Mhh/Af8TdCHpMWOsF6i5GdMf+9RlRxy3wSzfLXmQ6XvTsq8Tm31CvQ4wPLGH
         Qxji5sNDCIASy1zjsgJc9X9bx7+PDMd9yyidV3yq2VFMDH4e9JIUhHVtqFJoZAj0E9
         4tQDbiqN6QtxkhjTLNrs7Hlggtyrm8xsnJ1ZYs0JD5LAM7vd7o4kuLStgo9FKyJtWm
         INC+oNOKuI3lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B62D4C00446;
        Tue, 24 Oct 2023 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix not notifying when connection encryption
 changes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169817102473.23101.4955967355357457403.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 18:10:24 +0000
References: <20231023233839.3700728-1-luiz.dentz@gmail.com>
In-Reply-To: <20231023233839.3700728-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Oct 2023 16:38:39 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some layer such as SMP depend on getting notified about encryption
> changes immediately as they only allow certain PDU to be transmitted
> over an encrypted link which may cause SMP implementation to reject
> valid PDUs received thus causing pairing to fail when it shouldn't.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix not notifying when connection encryption changes
    https://git.kernel.org/bluetooth/bluetooth-next/c/3fa702baa02c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


