Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB6EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGYTu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGYTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2110D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98280618C7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08087C433CA;
        Tue, 25 Jul 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690314622;
        bh=8y5pKGdnjeFCQknWS8WcGUQQwghXdxi12+9aVrNePpg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qfcFdMd1lzZYvzt23bG/ImrzlsfCtAsdPB52o37zTBevNvg/0dSchWDmpqBVZZB2d
         NU8zdxerhNaZ0wTJA/A9+7G8W8lGseu9YqjPTPJmZ/0AVNCKUx3YA437STziopUhjn
         lHvzifS1d3Jt7tqAlVsy01vVwz0RhqzPTLAdm/If5mn8afJb78akEFoew1yB6OTdC7
         bLiuo6ZG1YPRez49tnRtFk28z/OmaCNO21E31CHenOqNH66ARByB0VAcqOsQ0RoGZa
         cqw1/2kvPoEFcS6nOHmyBmTN9MY6lOvySxmL8DXfcgoYF89ActpjRQ+FJDJI2EhrYx
         GbrYaXRQyBpXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFEE9C73FE4;
        Tue, 25 Jul 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/3] Fix the crash observed with VOCS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169031462190.19624.15247252713139938350.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 19:50:21 +0000
References: <20230725134742.51651-1-nitin.jadhav@nxp.com>
In-Reply-To: <20230725134742.51651-1-nitin.jadhav@nxp.com>
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        pav@iki.fi, luiz.dentz@gmail.com, sathish.narasimman@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Jul 2023 16:47:39 +0300 you wrote:
> Hello Maintainers
> 
> This series of patch handles the fix for the crash observed with VOCS when trying to pair with LE Audio TWS earbuds and few other issues.
> 
> A crash was reported for the following patch by Pauli Virtanen <pav@iki.fi>.
> Patch Link: https://patchwork.kernel.org/project/bluetooth/patch/20230612133251.194-4-nitin.jadhav@nxp.com/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/3] shared/vcp: Fix the crash observed with VOCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06ec4f61000a
  - [BlueZ,v4,2/3] shared/vcp: Fix issues of audio location and descriptor
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a0e392b40fa
  - [BlueZ,v4,3/3] shared/vcp: Reserve one more handle in VCS for VOCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d714becb7df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


