Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A69E776C5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJBVu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 17:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjJBVu2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 17:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4DAB
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 14:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6206EC433CA;
        Mon,  2 Oct 2023 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696283425;
        bh=6ObeA4N5Vob6v2kZamR6nWdWpYFrlsqC7KAt01p4FOQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TkhydRG0p0NyvKG9SkKZ6WiZvLvGSDDo4VGdWF72bhjyneh5mIt9PuBaSqjGd6dsf
         8evLzbG1AkYhputIA5BSwbuGg6oRcJYVbzrzTrGIvooe6mZoi8iSQ6+vVGoVRiOHLr
         e1taA3iPWFEjGnRlRdonlFo4qgYCY/9dzQNsF1hZKFnittbCuwejQsXFH2m3b1EtdB
         MTcJwIOyhfoAZ9RcsZvt0DjvR7QNaOebGWxn69aUUjzh0dtfJHJmoyWSE5AMf+8sho
         phNrNijF1oOnE1Q+kSOqKbZBVBzbrZiFfUsH6EppRBZ+EkxOoljU5ghBBnCW7FZiPg
         K2jVoMHiq7iTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47A12C395C5;
        Mon,  2 Oct 2023 21:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Update transport acquire/release flow BAP bcast source
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169628342528.15136.7449845315766019012.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 21:50:25 +0000
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Oct 2023 18:33:49 +0300 you wrote:
> From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
> 
> Update transport acquire/release flow for BAP broadcast source to
> fix failure on transport release, and second acquire
> 
> Silviu Florian Barbulescu (3):
>   shared/bap:Update stream enable/disable flow bcast source
>   transport: Update transport release flow for broadcast source
>   bap:Update transport acquire/release flow for bcast source
> 
> [...]

Here is the summary with links:
  - [v2,1/3] shared/bap:Update stream enable/disable flow bcast src
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a79ff88fd95
  - [v2,2/3] transport: Update transport release flow for bcast src
    (no matching commit)
  - [v2,3/3] bap:Update transport acquire/release flow for bcast src
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


