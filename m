Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C223EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 19:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjF2T1M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjF2T0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 15:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF43AB3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 12:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B9761616
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9FBAC433C9;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688066683;
        bh=2oJvohimrtBxgh46YXcxeBnk00MReuYlG5DqyWPcT88=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jcr6GOznFFfsKUkVxXf53xF0ecsEwG/8Ryy/WaOf+L8qfTeiMNYxp2n9ElAFF7xFM
         zxEzpyDFZkfZB8WczcgyEHwUkQV6foZ6GKM8qdVXs4iCyNnGb7EAmnJVxdsJHmefhP
         1ZqgSNJGxCwCbTh02Eukxs78cP4/aqUNbPfQgwTo1qpolpVpAnXbjZfIzjlOa5JA9/
         PUSGh4lKWYt7pBz9AI9fYQyjrVJaXCijhQXz1DsHXYorjXLDw5tbk/9xfo0ff8Pe7u
         mSzPrTyLfyIw6+U26Nw1QBtxrGsiap8mcZb/Ow4LcBzKEw654gOFD+X1EPyvfsoF49
         JFE+FZcFBmsJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 971BDC64458;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] Bluetooth: hci_sync: Enable events for BIS capable
 device
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168806668360.29593.8609924413523480751.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 19:24:43 +0000
References: <20230629134518.5574-1-claudia.rosu@nxp.com>
In-Reply-To: <20230629134518.5574-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jun 2023 16:45:17 +0300 you wrote:
> In the case of a Synchronized Receiver capable device, enable at start-up the
> events for PA reports, PA Sync Established and Big Info Adv reports.
> 
> Claudia Draghicescu (1):
>   Bluetooth: hci_sync: Enable events for BIS capable devices
> 
>  net/bluetooth/hci_sync.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> [...]

Here is the summary with links:
  - [v3,1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/e006be3454c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


