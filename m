Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7479EC875E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 23:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjIGXAk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjIGXAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 19:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2431BD3
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 16:00:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C10C433CA;
        Thu,  7 Sep 2023 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694127635;
        bh=Mt3aKetljQtc+TNcdEfGf8Q5o68o0t1wNqduJinhSwM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZDlak16l7NRWeSg7LdN6LrEMY1Cswqa1avyFF202xXosQAnsL3EDRKNBQ7DJj8HZw
         K/SwTkUNcs0tvy2wkJe23U2eEv5amMlt1QUE1HX8DuqakFTO2lIMEVmZEiVnItJm/+
         o1JPiY7rj3oiqAYXvfMts89+yOe42GYkCraiHM3sqdtHNbgEfl7TN1ktXwH3vP0iKS
         0QCv7p5NF86COui4+6fsKBuqWwxrtJ5fSWKon3DWf4CoAFrsOOfJdsaVunaqGPSHZD
         dXvCv1G4X/PHPbChd9Y/1Ns8HJrDEsJv19ZiQACBOhzpoKhfIjqW7OIez9pHhgjcSS
         A0jXeSvKOyYTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AF0CE22AFD;
        Thu,  7 Sep 2023 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] main.conf: Fix printing errors for valid options
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169412763523.379.8988171638600522218.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Sep 2023 23:00:35 +0000
References: <20230907194134.2242634-1-luiz.dentz@gmail.com>
In-Reply-To: <20230907194134.2242634-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Sep 2023 12:41:33 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following errors:
> 
> Unknown key RefreshDiscovery for group General
> Unknown key Encryption for group CSIS
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] main.conf: Fix printing errors for valid options
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32daf644a497
  - [BlueZ,2/2] main.conf: Fix documention of CSIS.Encrypt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3294c42c9677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


