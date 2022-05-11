Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 21:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiEKVUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEKVUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 17:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D661632
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 14:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D4A61B65
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 21:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B94EEC340EE;
        Wed, 11 May 2022 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652304012;
        bh=0RD5/BDWxPNDwx8k3amJR0gICDu3rfG47Oi8pxxQJxk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jOd47t+c26XeuHYZ6vpzaPKkp0GBpjEmH5yac5x5eA4q/QxA7veNn3q+NYH7GyaxE
         cvEKanI2LFNUYLX+h89Yxx6Ogfh9nla16tHud9fsfjMt2Hj+q7T+KQ0878mLC9TcyT
         uXNxzvl20kZVchRmkiN9PBSnWWI8gdTqK8JRSmr9j2TJNuced6/YbhVXRHKDf4ljjv
         H0EzZK9BrwP5o8PTPcndSmYE8aWXeIlGSfIlXEgqWwi8wZV3aUX8Bcx6DM9J9C3sGL
         xIxcNa3RGNxs/5SSPh3ahgqadK8cwhrfHxon1EC4nqSbfVrA+xIIzw41/ZTacPLTcQ
         1I9tvW8nP1ELA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C223F03933;
        Wed, 11 May 2022 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix the creation of hdev->name
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165230401262.9704.4260040171569468709.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 21:20:12 +0000
References: <20220507123248.432213-1-ieitayie@gmail.com>
In-Reply-To: <20220507123248.432213-1-ieitayie@gmail.com>
To:     Itay Iellin <ieitayie@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  7 May 2022 08:32:48 -0400 you wrote:
> Set a size limit of 8 bytes of the written buffer to "hdev->name"
> including the terminating null byte, as the size of "hdev->name" is 8
> bytes. If an id value which is greater than 9999 is allocated,
> then the "snprintf(hdev->name, sizeof(hdev->name), "hci%d", id)"
> function call would lead to a truncation of the id value in decimal
> notation.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix the creation of hdev->name
    https://git.kernel.org/bluetooth/bluetooth-next/c/29aff7408263

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


