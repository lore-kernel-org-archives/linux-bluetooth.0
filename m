Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18BCE79A8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjISTUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjISTUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 15:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AC110
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FF8BC433CD;
        Tue, 19 Sep 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695151225;
        bh=1oLz7k8pTZrAbRV6JNViMXXiO64//omQe8hCyOTca7A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tV15wHjXNIpizVjfyw//S4zSJPw+5QEDO86VWtxNg/xrPFrvZY8m2FDZU/I0P9bS1
         CvlAjhPycWJmqTpJ6hbXFoZUA0G/AWmGV0F9z/Sip4+V2DACn0+gTkMchfUq6x9Wju
         T1IsBfU00ej2U8GXSOTPUemqiM2w8QpgRY/zy2A7BdMrqBerXIwipheGdlG438deDS
         0sDevrnId37OKvXJsIdqbKri3QEUVaZ32E9MtxNRi3gFzZqo/6ghScxta8NZybl6s3
         Bt87kppIcIu63xdDqSuY+tdWITeDlX9aH6tzbY1iQsnO1W2u9XyfXfSkz7kW7iAS8U
         dNcWG2j18xfxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65284E11F41;
        Tue, 19 Sep 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] emulator: Skip new line when using util_debug
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169515122541.29274.14107504131963002768.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Sep 2023 19:20:25 +0000
References: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Sep 2023 18:27:44 +0200 you wrote:
> The debug callback vhci_debug() already prints new line after each debug
> string. Explicit new line in the util_debug call causes double new line
> in the output.
> ---
>  emulator/btdev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] emulator: Skip new line when using util_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb9eaf01d161
  - [BlueZ,2/2] hciemu: Call btdev_receive_h4 unconditionally
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7f788a2c5162

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


