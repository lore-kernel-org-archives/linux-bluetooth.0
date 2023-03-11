Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352DC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCKAla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCKAlD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:41:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00212B964
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7145961D96
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 00:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2240C433A1;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495220;
        bh=YX6MdVPHz4UcFl8y+1vNxd8p5LT4pAtidEQnvEuisog=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qoZGT0SMYa29BcJvQcttnZMD9tud2qXjs52FSi81lTMv09K8pEc7dNaV3ZwHwvXj8
         Mq6e/a1CtxQ4Ex6VGcaH32r8qticLS0KaKYF4X/NfBHhYDDK/KdmQ7lJOTf50xLxFO
         PiyhZunsGmrJeSMLydcyTTsYgD13/QnGhkdERPuDzfbyoNcwZktNMhj56MuusVJwur
         1Qzea/cJPvo7cqvICks8z6aR4szPdtt6sgRMmNz4RSXRo7bH0vSwwWuJW0XH2rUw4X
         VwrM8ol6p6U11vtHswOWeqAETYMtnVVA9TZs5e9HGXepr6HjtykQY+l8DSaPMhRC/B
         HF3FG+4r8mMbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5AB7E270C7;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] device: Fix not always storing device info
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167849522074.21816.14238257789252854283.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:40:20 +0000
References: <20230308005158.2661414-1-luiz.dentz@gmail.com>
In-Reply-To: <20230308005158.2661414-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Mar 2023 16:51:57 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When updating the device address check if the device is marked as
> temporary before attempting to call store_device_info otherwise it will
> have no effect and instead btd_device_set_temporary must be called.
> ---
>  src/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] device: Fix not always storing device info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=581aae6a2722
  - [BlueZ,2/2] gatt: Fix creating duplicated objects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3842320f450e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


