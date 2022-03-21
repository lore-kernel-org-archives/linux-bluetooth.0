Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C843DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 13:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbiCUNBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347670AbiCUNBg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 09:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A913EFB4;
        Mon, 21 Mar 2022 06:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70136116F;
        Mon, 21 Mar 2022 13:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12B2DC340ED;
        Mon, 21 Mar 2022 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647867610;
        bh=HIBVKRAe8eGail74XQZacg5ce6sZZOwblPluMB3tdrY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZBg5ba8VYve8migAhbbVacSMYcCfiErl+yMqVSR8aLcDawY2I+UkC+zZh7xQl+Lvt
         WBdZsSJ88TQHVJwFwMkFmnWH9vdTOCWblHrGvLYQzC3mvVBOt5dX+pgFiuBS7BLka4
         E38rD0fIkMRnadRbtmVFQucl6P7oZyzy1HEqhwotiCX9GUUrmdfoXbfBSb9Opmq193
         O1AqsAWgO6vmmFF/tnfQ75E9uwOKAuBBGsb/9iBNvlOwX3Q943lbDvp1v6PNz658x8
         qqQ5lJyWnZurn3iZU0oLSAukb3dwSu/tXm2ArgzmcWwVFZ4vCbCi1CQiiKRp+A9V/l
         fDkFKA1kNY5WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB19AE7BB0B;
        Mon, 21 Mar 2022 13:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btbcm: Support per-board firmware variants
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164786760995.8008.1538008387792724276.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 13:00:09 +0000
References: <20220320222749.1502856-1-linus.walleij@linaro.org>
In-Reply-To: <20220320222749.1502856-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, phone-devel@vger.kernel.org,
        markuss.broks@gmail.com, stephan@gerhold.net
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Sun, 20 Mar 2022 23:27:49 +0100 you wrote:
> There are provedly different firmware variants for the different
> phones using some of these chips. These were extracted from a few
> Samsung phones:
> 
> 37446 BCM4334B0.samsung,codina-tmo.hcd
> 37366 BCM4334B0.samsung,golden.hcd
> 37403 BCM4334B0.samsung,kyle.hcd
> 37366 BCM4334B0.samsung,skomer.hcd
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btbcm: Support per-board firmware variants
    https://git.kernel.org/bluetooth/bluetooth-next/c/033465911fe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


