Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA185CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 20:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjJRUU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRUU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 16:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159FA4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 13:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C60EDC433C7;
        Wed, 18 Oct 2023 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697660424;
        bh=S+f5+k1m/2GF+xlXJETEKOUWWZB29CR40l2WFQXhWfM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J3bvG5J8jFsbKhnsN4W2PkO1k/vB6W7b5nSSwiu9kgvVMQQFo8E6iRZGHZm7ixLMm
         JkATQl5CWEpeLs4s+KFbAU1fzYlWJjn2WSq9LZHRujg5PkqzFi8qwiYMWJ9APERJl8
         oMusvmqijYtRxGnO1ePt5lpuWtcF8ekUxd2f6auSHqzjE7yEuIeqpuD+d8B6er7ruj
         Nd/2hrF918aBVE7Dej24QzhkdeBmBBuAz+WEo46ifyhyXITlRQKhP7R5kif5LtzB6A
         i+jxJXucisgkvXTQ1vf3w1Dtnry5yTabNyE9WSC95eYWWvKDT4KGK6bZ1WvlAXNEAV
         PGhwWL3ubtK9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB02CC0C40E;
        Wed, 18 Oct 2023 20:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Fix double free in hci_conn_cleanup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169766042469.15093.3661599714802622325.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 20:20:24 +0000
References: <20231018103248.294565-1-hadess@hadess.net>
In-Reply-To: <20231018103248.294565-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org, wzhmmmmm@gmail.com,
        luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Oct 2023 12:30:55 +0200 you wrote:
> From: ZhengHan Wang <wzhmmmmm@gmail.com>
> 
> syzbot reports a slab use-after-free in hci_conn_hash_flush [1].
> After releasing an object using hci_conn_del_sysfs in the
> hci_conn_cleanup function, releasing the same object again
> using the hci_dev_put and hci_conn_put functions causes a double free.
> Here's a simplified flow:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Fix double free in hci_conn_cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/4706a126c330

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


