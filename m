Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694CC7EE2A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Jun 2023 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjFETkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjFETkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Jun 2023 15:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99CF2;
        Mon,  5 Jun 2023 12:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B712629D4;
        Mon,  5 Jun 2023 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8734C4339E;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685994021;
        bh=bU+IT8BCly5Fc/qZSAc8bqubJxJEIBW8A50BpW7DNw8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MgBOgzagW5VFRZISYs1byVQz1+5y1GRY2nO3kmF3TAthDgMKFs4/rOXAHspMOKmqR
         1D/uDjIqsu9mhc8WY1guTY6YIiduEKZESxYRwoKvpGJxxLUKNpU/k9BguZcZYCPeS8
         KfKC01smzrUEUIB8HPefp2yF+SnQEWZTJROD18TKlMsEBbxWxe8TWZemC+M7nLT3bM
         OXJGJZ2WMp6R2G4mNZEO8dXFG+7dZhOJIsko5cpS+yWrN6KuY9SYbLXSO6ZvsCs9Kg
         FF+gRDo8IZq20mA1VY0MlBqlZKpf8V7/a3cBXDdE0GWmaAfyeyWCv6gUlyfCO5kOQc
         CBV9+VJW2n5mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99152E4F0A6;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Add missing checks for invalid DCID
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168599402161.27522.9116993393266784955.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 19:40:21 +0000
References: <20230603122808.1633403-1-iam@sung-woo.kim>
In-Reply-To: <20230603122808.1633403-1-iam@sung-woo.kim>
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     daveti@purdue.edu, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  3 Jun 2023 08:28:09 -0400 you wrote:
> When receiving a connect response we should make sure that the DCID is
> within the valid range and that we don't already have another channel
> allocated for the same DCID.
> Missing checks may violate the specification (BLUETOOTH CORE SPECIFICATION
> Version 5.4 | Vol 3, Part A, Page 1046).
> 
> Fixes: 40624183c202 ("L2CAP: Add missing checks for invalid LE DCID")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Add missing checks for invalid DCID
    https://git.kernel.org/bluetooth/bluetooth-next/c/f9367ce74db3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


