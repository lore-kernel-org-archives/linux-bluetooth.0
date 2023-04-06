Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3733C76196
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjDFVA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbjDFVAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C6D7D8C
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6127D64CAC
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0122C433A0;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=io+nVyeWT/8HbQTgKHKUz2d+yeMaEfJjQPiJmcTTvyQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AJZziZQ37y5WhKcK8Iwq3M3W4QGHUx7Hjji1VC54RnFMqcqXhhXa/ZIrMiHOOdJTs
         0Lpg/UzhHFmSBS4f9CWQf+Jt6FvC3adNnRb+dKjs5TvSKVBVQNwxz45FTC6YOgqOhX
         UbgkQAKES6OU3KzH6kqG3v83fD9EIHqBLO2loa1Zc1bgmKJkoQhmJCl8KnGQPavm2W
         zFJBghsXjqdQ1h9QIAP961EqJAPlASZ0rbwgz3WAHobvjlpvWzSYXf/3Z7yYdmkPJV
         kLP0tJDyOJqike1HfeeTd5s8IDm70GLAMWSblqWe6BxNbxcNI+I0r4rfhIEC3mFIfJ
         VK4wrF1OQ9o+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A251EE4F157;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_conn: Fix possible UAF
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482065.2619.2057175131685792389.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230403224412.2021594-1-luiz.dentz@gmail.com>
In-Reply-To: <20230403224412.2021594-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 15:44:12 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in hci_conn_del+0xba/0x3a0
> Write of size 8 at addr ffff88800208e9c8 by task iso-tester/31
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_conn: Fix possible UAF
    https://git.kernel.org/bluetooth/bluetooth-next/c/14a833f37a74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


