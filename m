Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C2E92FC1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjJEVAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjJEVA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D093
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07250C433C9;
        Thu,  5 Oct 2023 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539628;
        bh=wz9Kr5e8k1upUaDu3XCbM8DC57FQu4B1h9oyHZ12078=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FF/d9EmItf/netkz4hpCAHjey17BzV/cwHa8UGuU469aXPGO6doYoNDPKX4SoRsEp
         OvWW2KMUS8bmyJIU1rkNS6rDPXtJaD2AqC2dQ8sCPcq2xkg4zQdJ0H6APYk7bRMLCZ
         7qgeSaHHkQolWOxE3j3IBjD9sTWUs8atqN5CjUd3mNgISoZ1Go5bO/GRYnFXtCoyqh
         G3RCoTcAejB8D50PkLyva7xJ5iGjlyYg3kXLRUVP2FjE/h/uKSelRcZMuanoiSIEnH
         5E2UATx+7PseYDAWMHunX26068kqaD/UmBBbgcg2MqI1IcA1hIPtb4J3QUv/F+x5ih
         tSkyBWWxtXzTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6F6BE632D2;
        Thu,  5 Oct 2023 21:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Add BASS unit tests for the SPE suite
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169653962794.16076.15815669092415625967.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 21:00:27 +0000
References: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Oct 2023 18:31:46 +0300 you wrote:
> This patch series adds BASS unit tests for the Service Procedures Error
> Handling suite.
> 
> Some unit tests require the BASS Server to synchronize to a broadcast
> source, as instructed by a BASS Client. For this, a testing framework
> was added similar to the one used by iso-tester, to emulate hardware.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] btio: Bind listener to bcaster addr based on dst opt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=769268f4b1f4
  - [BlueZ,2/4] hciemu: Add support for setting emulator bdaddr
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b94e33f90aa0
  - [BlueZ,3/4] shared/bass: Add miscellaneous fixes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a56bc5ec376a
  - [BlueZ,4/4] test-bass: Add unit tests for the SPE suite
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


