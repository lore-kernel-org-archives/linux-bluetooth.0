Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC59C6379F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBNUkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNUkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 15:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01128A47
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 12:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99DB4B81F19
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 20:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EB0C433A0;
        Tue, 14 Feb 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676407217;
        bh=+r7FyiwHEOIrKKbBUo2GYMaCNWxf9mhgmL1UZ4q9wMU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ni7WHIITS/LOZ08gA30vhVU7qtvWTRDHvTbEgqYI81Q6Vp4zOxSK4qf7JRmtXGV7c
         b61vQ/VTfP+NAr0lSrZw13tih0SdlOKTla8qAZRJj/OGPDaLcJ97u+576V4jjM8P43
         9CYV+Q4VL0bYsjFuDghcjHXYjXXmc3HZIylfFq8oqONsi6gTk13kNgXe+7N0H0/pqQ
         REaDcrGNmjHMBXa7dFgNsdYudXdPnKtEb8Wu21wUomxYKNq31te1W6bjLj9+48/UZ7
         SxG/aQbt9QGL/bdXwnVLgN+J7Og3THSyb3UZpyykqNyvqyMj5aOrlT/FBD8J9inrJN
         DE0DUuc+ME5lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45417E68D39;
        Tue, 14 Feb 2023 20:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mgmt: Use BIT macro when defining bitfields
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167640721728.14815.3552756946607023637.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 20:40:17 +0000
References: <20230214021606.647442-1-luiz.dentz@gmail.com>
In-Reply-To: <20230214021606.647442-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Feb 2023 18:16:06 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of BIT macro when defining bitfields which makes it
> clearer what bit it is toggling.
> ---
>  lib/mgmt.h | 117 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 61 insertions(+), 56 deletions(-)

Here is the summary with links:
  - [BlueZ] mgmt: Use BIT macro when defining bitfields
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d63ee2a58c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


