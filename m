Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900FAC38142
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBAAKS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 19:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjBAAKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 19:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E67293
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 16:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C42161753
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 00:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89D45C433D2;
        Wed,  1 Feb 2023 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675210216;
        bh=eFiWaJVzEpNrz7z6G8Cz+UXCLmDN7s21qgYd1b2Ez18=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QGo3Pm7/Kr4r/DN8/x3iXCGodVtkqWnyrbqlsZoVtqJ1ScATxtjitkH2F7U6HQjhU
         JTcYIwCZApzi00p2/O9BxZ3FXHqvbKGcwOXbWZbL0kYsqrSbViN8w/ix1Th0N22fyJ
         rWtLzDyk9khpa62TszgOvX8AugOiCl4iuDwO4Lk0rZWsDOzAkVdHvUsZPWapP93+l3
         +weVAZqohp2L4M7OM6GejqIxbbFasbhcjmHc1AnXHjpWty8zxQ87/w7Qb4gJ6ar7G4
         +ldwcHRrQIMMotw59cS2URR4qAo/G5q7x7xFijbI7gAJwUPzXdVXG4N/Ngk/PcPNH8
         f8wfvVyy5DwCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77D04C1614B;
        Wed,  1 Feb 2023 00:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: add CIS feature bits to controller
 information
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167521021648.6611.18110700208022331445.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Feb 2023 00:10:16 +0000
References: <229cb2a6ecc8f182471f87ed527883c1a8353af5.1675103818.git.pav@iki.fi>
In-Reply-To: <229cb2a6ecc8f182471f87ed527883c1a8353af5.1675103818.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jan 2023 20:37:01 +0200 you wrote:
> Userspace needs to know whether the adapter has feature support for
> Connected Isochronous Stream - Central/Peripheral, so it can set up
> LE Audio features accordingly.
> 
> Expose these feature bits as settings in MGMT controller info.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: add CIS feature bits to controller information
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2e9c401579a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


