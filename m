Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D71E92FC0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJEVAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjJEVA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEC95
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1395BC433CB;
        Thu,  5 Oct 2023 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539628;
        bh=r+hoYA0Ghf7jPovthBLF/x/QCKvqa1Kj9Wixa6TygyI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H2G4B25BSlGiC7EMFdAOmONAPJKQgR8Z3fm+9BvZ85ZESamvsK2J/3g6wtBe1WB4X
         HduiU1ML2nut51Zx+2c1I4CUePoa2FTqgxpGLbWGiUb8BTy9I89oMnt+EXPIDLmdQu
         JhUtifv9dAIQwBWlsACYREJsftcI3o5fq7Xwt6Xuc8yL2hd0mijH122OGhQ6Ui4J42
         qld/zRFkcWQmYIPZ/7yIt81HoL+WzDqU0mdB+zi6xuzwhwoH/O1Ufphjpox4v3daiQ
         SaiVOdXJNhJ/dulmTuGjUevEh2oPClTtUJdzLKiVvBvFKPBDxWGXXsEzjGqW3T0BJH
         0glJYd6wjz8hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0484E11F51;
        Thu,  5 Oct 2023 21:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] battery: mark all battery DBus APIs
 non-experimental
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169653962798.16076.4314419735819907678.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 21:00:27 +0000
References: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
In-Reply-To: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Oct 2023 19:57:32 +0300 you wrote:
> Remove experimental marker from BatteryProvider1 and Battery1.Source.
> 
> It's common that headsets send battery information via HFP, and often
> this is also the only way to get it. Pipewire/pulseaudio manage HFP,
> parse the battery commands, and use the BatteryProvider API if present
> to forward it. No problems with the API appeared here, and it's been
> experimental for a few years, so it's useful to enable it by default
> now.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] battery: mark all battery DBus APIs non-experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=495a582675cf
  - [BlueZ,2/2] doc: mark battery APIs non-experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=85460c32d133

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


