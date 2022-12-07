Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA4C4708D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLGXuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Dec 2022 18:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B15E3F9
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 15:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF11DB81CEC
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B5E8C433B5;
        Wed,  7 Dec 2022 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670457016;
        bh=YG5xgzzwnSLowRMSeVdd+z0UCLrBZGxNGQJXjC/rq7s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BjPWwSt/IxG2VjmKv2MOKKTaM56+7s6jhkvo62qRIMN1yjYi74X22w6k5bFMpbb1B
         HCcmjBRFAenZ4UlRMX8PNqM3TF8IeieWSXWMBrzN1zXPJYVjSoundBUErD0it4j3sl
         uzuTGlM22fUUo7FmNNKCFsdQ8VsrsCkPYISKrd83Sl6d/uetX18Lrh3giMiFm97eSU
         +rYLZBy7JKcwEV5GJo+xUYtM9WrQGmQmnSQi0RSA2e+tiU5bL8GGPaFJRzuAL+I0Ct
         R38ciaKNgQN+V/lDO+qVFAeF906ZQ6dltzAnp1Xl9ROuvZKW9/CtAxfNqX9NAjNmTO
         taBevH0c4XnBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7361DE270CF;
        Wed,  7 Dec 2022 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client: Allow gatt.select-attribute to work with local
 attributes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167045701647.16225.2430697774675493430.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 23:50:16 +0000
References: <20221205222617.3580784-1-luiz.dentz@gmail.com>
In-Reply-To: <20221205222617.3580784-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Dec 2022 14:26:17 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This allows gatt.select-attribute local to select from the registered
> attributes:
> 
> [bluetooth]# gatt.select-attribute local /org/bluez/app/service0/chrc0
> [/org/bluez/app/service0/chrc0]# gatt.write 0x01
> [CHG] Attribute /org/bluez/app/service0/chrc0 (%UUID) written
> [/org/bluez/app/service0/chrc0]# gatt.read
> 01                                               .
> [/org/bluez/app/service0/chrc0]# gatt.select-attribute local
>  /org/bluez/app/service0/chrc1
> [/org/bluez/app/service0/chrc1]# gatt.write 0x01
> [CHG] Attribute /org/bluez/app/service0/chrc1 (%UUID) written
> [/org/bluez/app/service0/chrc1]# gatt.read
> 01                                               .
> [/org/bluez/app/service0/chrc1]#
> 
> [...]

Here is the summary with links:
  - [BlueZ] client: Allow gatt.select-attribute to work with local attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a550d43b84e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


