Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DAC77B62
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC3SKb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjC3SK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1FEEB6F
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8D84B829AA
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 18:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CEC9C433A0;
        Thu, 30 Mar 2023 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680199825;
        bh=4iLHeM3M3bJhviMmdj+qRQh9DHaY/OnXZ9Z49uyWjEQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t20GnqZDShvf8PxCPJrmv8k3i5oA5wm6oApeiw1+9/8sdGUJ6WDjhRdfofdtpbnfH
         JxZRkMIpUpQ507HLoPvaHuSqXQWvzgsoOnFnqs5IirzoCd5os4dJN10YpcEFy+8XBb
         l0j3s5TlEgBuIQtibYidr+n7VpRiwIHaSU+chHMTP1NQa+jw3z6JgqtOfVtvSQzRjI
         mY+mQf67ub5CVTVJc56X1uGIXo2YQi+UEyu6vx92cM5n/5Waj/juBTBg8hslkpaPSS
         P3Ig3D38/Iso4U/EbgM3Udo41yWY0CWUTkAG2MbbTPfadQf7ZKZ4xJW/JHc70bZG2d
         hQFRoyg0GyB1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32B26E2A03D;
        Thu, 30 Mar 2023 18:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v5 1/2] vhci: Add support to trigger devcoredump and
 read the dump file
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168019982520.20045.11650139439500360979.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 18:10:25 +0000
References: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
In-Reply-To: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Mar 2023 23:08:02 -0700 you wrote:
> Add vhci support to trigger the hci devcoredump by writing to
> force_devcoredump debugfs entry and read the generated devcoredump
> file.
> 
> ---
> 
> Changes in v5:
> - Refactor vhci_read_devcd()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/2] vhci: Add support to trigger devcoredump and read the dump file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8bd2f2961774
  - [BlueZ,v5,2/2] mgmt-tester: Add devcoredump tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


