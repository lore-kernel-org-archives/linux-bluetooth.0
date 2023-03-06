Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5399C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 23:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCFXkl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 18:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCFXkc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 18:40:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F155A6E6
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 15:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D72B80E98
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C738C433D2;
        Mon,  6 Mar 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678146018;
        bh=jguVEPQqnzHG/eUYo8SPZOlMcC3gZzooAq+VbTESLtg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=abvVrSq8xaFbNaXgbMsBhrNUIEE6llLdHyPB5vmdKxZvY8O7osLIN4ySnMEaL05Ow
         j6uXM7RLc4jJrf+trMlnry8cQkKTyuSVxODSC1R4dAmtn6/OIH8W9HSUvSiPAs0YOa
         Pp/uCgVs9Rr9+T4yaHOOY7xjoOEpVTTIHvFf/tIaRU402HESZISKe97cG2S4BDMWh2
         E/CmxN5cK/Z+ih2dURPxX3ToyRtPvSDpVrZASQ6fjLuK/fkfLYclqMn+CYG3Jpdz2H
         voHFjFFo06oU5IAsByrI7oPV4vxAMFrV5ACUAXX6Nuk/PvHrodXwi9k1ONM9jnlu+U
         BVi/UcqSbhnOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE909E4FC50;
        Mon,  6 Mar 2023 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Make use of
 bt_gatt_client_idle_register
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167814601797.9993.15190477383673207064.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Mar 2023 23:40:17 +0000
References: <20230302205758.1252736-1-luiz.dentz@gmail.com>
In-Reply-To: <20230302205758.1252736-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Mar 2023 12:57:57 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This uses bt_gatt_client_idle_register to track when instance is ready
> instead of using a dedicated queue to track requests.
> 
> Fixes: https://github.com/bluez/bluez/issues/485
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/bap: Make use of bt_gatt_client_idle_register
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07bd8e3a720a
  - [BlueZ,2/2] bap: Fix crash on unexpected disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=57f15616abde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


