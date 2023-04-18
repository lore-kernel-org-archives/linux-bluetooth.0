Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEABDC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 20:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDRUBU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDRUBQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 16:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC9B762
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 13:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A3C7638A3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 20:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAF0C4339C;
        Tue, 18 Apr 2023 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681848071;
        bh=O+Rn60PqnlMi7dHxyTt7C7SYHQYoK0QqOoDYBv1BuzY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CYKo1mFRUr9HndAlnJaToXzsAnV0k1mMVsOkFTHuzKoobVyB1oI+9MlevLigOm0LB
         OSfAFHmNHfZ2pNld1TYg1AAi3awRMoIwa6a7c/sgwx/c4JZLU+bqRoV0ZMlL70/Qqo
         Db3D5SMuYZn7XG92CYMlapHaXk3zTRmY+JajV26Xu08qTLVvMFxc4nCypNaqQEUyQA
         POtl0x6oKmokSEO/loTlQR4KWZ8QCXhYllGM+cdij+EmMA+9YK+/VuP3aUcdhlvq69
         NU0wJmXXfAcqmsiccadEbnGCMTXGb5200SwUxfgfSE0f4IFuuzZLa4nQjIjmgTD+nm
         Jp7dAH6jAKNKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56DE7E4D013;
        Tue, 18 Apr 2023 20:01:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix sparse warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168184807135.10886.14421946935057816182.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Apr 2023 20:01:11 +0000
References: <20230418000704.1937843-1-luiz.dentz@gmail.com>
In-Reply-To: <20230418000704.1937843-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Apr 2023 17:07:04 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following sparse warnings:
> 
>    drivers/bluetooth/btnxpuart.c:681:23: sparse: sparse:
>    restricted __le16 degrades to integer
>    drivers/bluetooth/btnxpuart.c:690:82: sparse:
>    sparse: incorrect type in argument 2 (different base types)
>    @@     expected unsigned short [usertype] req_len
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:690:82: sparse:
>    expected unsigned short [usertype] req_len
>    drivers/bluetooth/btnxpuart.c:690:82: sparse:
>    got restricted __le16 [usertype] len
>    drivers/bluetooth/btnxpuart.c:694:84: sparse:
>    sparse: incorrect type in argument 2 (different base types)
>    @@     expected unsigned short [usertype] req_len
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:694:84: sparse:
>    expected unsigned short [usertype] req_len
>    drivers/bluetooth/btnxpuart.c:694:84: sparse:
>    got restricted __le16 [usertype] len
>    drivers/bluetooth/btnxpuart.c:708:23: sparse:
>    sparse: incorrect type in assignment (different base types)
>    @@     expected unsigned int [usertype] requested_len
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:708:23: sparse:
>    expected unsigned int [usertype] requested_len
>    drivers/bluetooth/btnxpuart.c:708:23: sparse:
>    got restricted __le16 [usertype] len
>    drivers/bluetooth/btnxpuart.c:787:78: sparse:
>    sparse: incorrect type in argument 2 (different base types)
>    @@     expected unsigned short [usertype] chipid
>    @@     got restricted __le16 [usertype] chip_id @@
>    drivers/bluetooth/btnxpuart.c:787:78: sparse:
>    expected unsigned short [usertype] chipid
>    drivers/bluetooth/btnxpuart.c:787:78: sparse:
>    got restricted __le16 [usertype] chip_id
>    drivers/bluetooth/btnxpuart.c:810:74: sparse:
>    sparse: incorrect type in argument 2 (different base types)
>    @@     expected unsigned short [usertype] req_len
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:810:74: sparse:
>    expected unsigned short [usertype] req_len
>    drivers/bluetooth/btnxpuart.c:810:74: sparse:
>    got restricted __le16 [usertype] len
>    drivers/bluetooth/btnxpuart.c:815:76: sparse:
>    sparse: incorrect type in argument 2 (different base types)
>    @@     expected unsigned short [usertype] req_len
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:815:76: sparse:
>    expected unsigned short [usertype] req_len
>    drivers/bluetooth/btnxpuart.c:815:76: sparse:
>    got restricted __le16 [usertype] len
>    drivers/bluetooth/btnxpuart.c:834:16: sparse:
>    sparse: restricted __le32 degrades to integer
>    drivers/bluetooth/btnxpuart.c:843:55: sparse:
>    sparse: restricted __le32 degrades to integer
>    drivers/bluetooth/btnxpuart.c:844:36: sparse:
>    sparse: incorrect type in argument 3 (different base types)
>    @@     expected unsigned long [usertype]
>    @@     got restricted __le16 [usertype] len @@
>    drivers/bluetooth/btnxpuart.c:844:36: sparse:
>    expected unsigned long [usertype]
>    drivers/bluetooth/btnxpuart.c:844:36: sparse:
>    got restricted __le16 [usertype] len
> 
> [...]

Here is the summary with links:
  - Bluetooth: btnxpuart: Fix sparse warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/183d1a0466eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


