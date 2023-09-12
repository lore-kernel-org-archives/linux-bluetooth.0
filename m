Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D99EEE3F0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjILSud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjILSua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9C18D
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C552C433CA;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544626;
        bh=CR2+aYXmULISGnWHYsM52nE0BYidwoSfFDX5Vm0WTsI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xz0weFzODZqQeCy5oU5hf9TNnL54vqQQhFDcXlrRA8Arj+QOQluwpfQ0hvD7Spiu5
         oJ+wHbi7lDgde+P2+NVhYi9bGTVSTY/Wby2HdlRwLeNycTeA5vxJjY74XbttoHWo9A
         HxU0q7/oDtr3cBdyEs5awdDUe0Fk1y3pyugs98zEFsvXBlquDe6oq6SEj5KUdgCV51
         p072DKg8hKKW87vXRZJYnmQ057PVy4c1MtI9419e55TgdpyaV38x7nAKzziU6qxTOR
         dpdr8z9GrNiSrG03ag/IfwlyrcdOW8JtxA23ooistCPo7Bb/Z86aw7C0Jomzi4y+vL
         9e1R9Ioxwd+pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8360AE49FA7;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/1] bap: Use defer setup when syncing to a BIS
 source
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169454462653.13260.2986968091954754161.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 18:50:26 +0000
References: <20230912065526.1217334-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20230912065526.1217334-1-vlad.pruteanu@nxp.com>
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Sep 2023 09:55:25 +0300 you wrote:
> This commit uses the newly added bt_io_bcast_accept function from
> btio.c to implement the defer setup for the BIS sync process.
> Now, information from the BIG Info advertising report can be
> used when sending the BIG Create Sync command.
> 
> Vlad Pruteanu (1):
>   bap: Use defer setup when syncing to a BIS source
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/1] bap: Use defer setup when syncing to a BIS source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=feadcbbed50d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


