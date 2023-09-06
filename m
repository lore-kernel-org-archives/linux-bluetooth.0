Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006BEE14D3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbjIFUa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbjIFUa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 16:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E699F19BA
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 13:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C425C433C9;
        Wed,  6 Sep 2023 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694032223;
        bh=lXBKinSKQ8iSqaPATXja7X1OstSq5B+8oKEl65IUMnY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vPaXhUJAq9wlN+hIQzGfoNEz7Khri4PTMDsR3E7Gubdn6sH/BeGx+amL8MKgtsw2a
         a8ZebH/bwRNvh7+LXG8kcFBBXBRNsqg/rgagYWGffNdmoV+IFyI3VtTxtN8vnNB2HW
         ab5XjPPQkGtJSp9IeQa0MDJPjlhmSpPL5QT6okxfMT/m5mfWGXffte2/xLubprHNG9
         UmvwmJWBeqBkX8P40/mfBgdo2lTlq7rgchXmEYUyNulrolu6yF71PdnDTCUMqq1zep
         BSIp5Npv99yPgrU9bvZdaVR7r7uAZeAvwMYCwmNWYa/3Fm/LcD+O+gWwR0167LWOYg
         lYlFy85FXo6wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7480FC04D3F;
        Wed,  6 Sep 2023 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: ISO: Fix BIS cleanup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169403222347.1730.11916599685504517820.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 20:30:23 +0000
References: <20230906135954.9165-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230906135954.9165-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Sep 2023 16:59:53 +0300 you wrote:
> This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
> no HCI disconnect command should be issued. A master BIS should only be
> terminated by disabling periodic and extended advertising, and terminating
> the BIG.
> 
> In case of a Broadcast Receiver, all BIS and PA sync connections can be
> cleaned up by calling hci_conn_failed, since it contains all function
> calls that are necessary for successful cleanup.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: ISO: Fix BIS cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/84aeff2468e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


