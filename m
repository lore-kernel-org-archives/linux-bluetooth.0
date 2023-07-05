Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB3EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjGESAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjGESA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D651985
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49EF616BA
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F54AC433CD;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688580025;
        bh=FEtwvq+psI1D/51MOP16qxgVkyT9uxJ5XlLshbNxers=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XVgGQK49qCA0vP8Hgsa2Iy+vBH2EMrHSsfQRU9PRKEZrTad/jOJFrmBUp6Mht3nEw
         HmzP7zauYAXlU4gLlh+qZvomS5zzQKltE3WLgq3oCSwc/sbI5CdLRjI6BEWGBJZpBs
         frIdk+R/eStu3Yf6aVsqCFX1FAb5ds/7LBr5Zg4jwgqtuvcaA4HZ03nxmBQ8g8Dwp4
         HlU7wNA5aU05gw6+zjKHlVCJnpbauqgU5YQwVtWGkvVDGZocvdMfEsfX/7ohdwZLqw
         M1dQvMBjqLhoYCgn3cWbnZ+R90G4IA64CdKOat/Q1KlyzZBMdrms6Flbu4xiiRChSk
         26ORJGG5Fx7BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19A85C691F0;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] plugins/admin: Fix heap-use-after-free when using 2
 controllers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168858002509.7518.8262245592658032637.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:00:25 +0000
References: <20230704055643.296260-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20230704055643.296260-1-vlad.pruteanu@nxp.com>
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Jul 2023 08:56:42 +0300 you wrote:
> This commit fixes the heap-use-after-free error when connecting 2
> controllers. When a controller is connected
> admin_policy_adapter_probe is called. If policy_data was already
> allocated it gets freed, if not, it only gets allocated. Eventually
> add_interface is called. Here policy_data is put in the "data" variable
> (specific for each controller) and the process_changes task is called
> with idle priority. This function ultimately accesses policy_data from
> the "data" variable.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] plugins/admin: Fix heap-use-after-free when using 2 controllers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b74146068892

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


