Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4AAC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 22:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiIUWKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUWKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 18:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF34A025E
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 15:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6261DB81D8E
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B9F7C433C1;
        Wed, 21 Sep 2022 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663798215;
        bh=O2uC2i9D50twP6JDe1uAD7BZP0hqnbB0LVhBKL2w4Vs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CaLhOiOUaHOWBoV/9sd1T1NBmSwowoYzbowm7VE/08OBx5soRGmvkC4GVlgeiy3RB
         l7QCJVhbhMuYUems6rp6yx7+b+6zD3Vq9Hj9CtkNoHSnlNmxG10n3iXw9PcJpcvkEF
         5/y6CGlwrJvuQooPGV5pUtezLMxHconOfb665OjtSUscn//Dkcj0RqAA/K26YEVjT7
         DP8lrv1E++oAqLivCklEItMP2guA3/BxgvhlmH0q9st/RKlLVpe2o5OnnygNb0ndmy
         CDGpWVBtGwcbG6DTf12cNfSgG3hVrYX5Ej+JUYUXRQIzxUlX4+8Kldson2CYoBmVR1
         Au7yToVM6MVtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06F19E4D03C;
        Wed, 21 Sep 2022 22:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add
 multiple times
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166379821502.30168.7541949317422281734.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 22:10:15 +0000
References: <20220919175700.1649726-1-luiz.dentz@gmail.com>
In-Reply-To: <20220919175700.1649726-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Sep 2022 10:56:59 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> device_add shall not be called multiple times as stated in its
> documentation:
> 
>  'Do not call this routine or device_register() more than once for
>  any device structure'
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
    https://git.kernel.org/bluetooth/bluetooth-next/c/448a496f7606
  - [2/2] Bluetooth: hci_debugfs: Fix not checking conn->debugfs
    https://git.kernel.org/bluetooth/bluetooth-next/c/7096daba731e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


