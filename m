Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11498C001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 20:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGMUKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGMUKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 16:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105AF1720
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 13:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCBE61B5D
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07429C433CA;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279022;
        bh=UMMK3MqMGEcnei/pI+LgVUcWKP7hNJGEf6mAZVt55sw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FA7gAP1HZV61HnaHSqDDd97bBaXKAAWBS92e5xywPziSOlzOE7HBvcSGfupiZlrXR
         4ultiQPct38F63l19e8R0V7Y3H14uuX9q753hz4OZGycpyI8XIPz6H+3pLs5BThtEc
         8Jsj8AhrgQA7vVaQR/lxbL2ahsIc7RKnpH10mmHVfFgNeE1YQW9lXWrwNE7CM3PkbR
         ys/kliUQijC8G9RuhBeLcd7PoeVORrMxMthz1vGz1x1FRbmlHnsUyABLa91tOtIrSO
         TITFh/FnaQGsXqP6WJxlMjJy2+yQ/+AfqTLg1RtMTF7ufejPuSJmbaS8ReBi2y26Zn
         BPZmJx0jrbQdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDB29E4508F;
        Thu, 13 Jul 2023 20:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168927902189.26469.5406966566822603728.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 20:10:21 +0000
References: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
In-Reply-To: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
To:     =?utf-8?q?Tomasz_Mo=C5=84_=3Ctomasz=2Emon=40nordicsemi=2Eno=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org,
        johnbholland@icloud.com, carles.cufi@nordicsemi.no,
        pmenzel@molgen.mpg.de
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Jul 2023 12:25:14 +0200 you wrote:
> Commit c13380a55522 ("Bluetooth: btusb: Do not require hardcoded
> interface numbers") inadvertedly broke bluetooth on Intel Macbook 2014.
> The intention was to keep behavior intact when BTUSB_IFNUM_2 is set and
> otherwise allow any interface numbers. The problem is that the new logic
> condition omits the case where bInterfaceNumber is 0.
> 
> Fix BTUSB_IFNUM_2 handling by allowing both interface number 0 and 2
> when the flag is set.
> 
> [...]

Here is the summary with links:
  - [RFC] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0408f0a1998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


