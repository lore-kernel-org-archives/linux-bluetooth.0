Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0DC001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjG0Wu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG0Wu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 18:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F801FDD;
        Thu, 27 Jul 2023 15:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E52BF61F79;
        Thu, 27 Jul 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5666BC433C9;
        Thu, 27 Jul 2023 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690498224;
        bh=i5DsTslOD8Clg4eU331uW2tQhTGqkzRkE8EjnUBLwCo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I8ZuIIh5IASgG3ywn1uxy0Wq8Fza6V9uPTWH+ccnsZKdaDtd94SXNBGDehwyCWxx6
         PcbWaC0qmxhs2mselZeL1L2c6Wn20QbBND8noz+frxx7J0CFtMMJ7HKSBUj3U30mA3
         8xUq1bacnWJVXae0nrTGH59UR7pVLf1ueJzk7grUqPYjdQIF9ZgmjJnSuJCLAtdBBs
         kkYdQ3KokOMq1oFDq3QyLTzQJO9uDZfw7SvSwsvtnnMv6Y2C5rWyROeR4+ow5IIUpy
         qRuWTihmWHyALHRThvJgUDjpKVNvuaSwOdP+PrjHXwqcgkTNTOuhm1caYr+QPmLAF4
         FeUB6nK4kWJlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C26AC64459;
        Thu, 27 Jul 2023 22:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Add support for AW693 chipset
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169049822423.13443.14788509499502860271.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 22:50:24 +0000
References: <20230727133317.297014-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230727133317.297014-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jul 2023 19:03:17 +0530 you wrote:
> This adds support for NXP AW693 chipset in btnxpuart driver
> by adding FW name and bootloader signature. Based on the
> loader version bits 7:6 of the bootloader signature, the
> driver can choose between selecting secure and non-secure
> FW files.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Add support for AW693 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd338bea1ff1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


