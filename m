Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9218ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJaXKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJaXKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D315710;
        Mon, 31 Oct 2022 16:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F1AEB81AEA;
        Mon, 31 Oct 2022 23:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E865C43470;
        Mon, 31 Oct 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667257816;
        bh=I88aCbyP69hwIDMukb7IOu2lsmzSfOurQ1fV5M9/mR0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SGWCxjkQcyT/jyTkIClGjSt4IElc/dhV8iennjKybrYwBsIL6corg4R+JMaRAsXYo
         DAhGm1KimawyIBx3ZeGKVbuI057nPIbxx416qurdcJNQne9n4bB2higV7Kd1IDKMDX
         YDfBeeILfyWxz6XdxLlchnOoTPPEBiCi0Hr/uL0mjFnUdy63gI0eq+esWD/Ly5X6Yv
         qgIni66tLdXHjEhjPkMmaJgj3sUJhESAotbqGyB+s+YaLiQ1WkC4RDi9wwsB80FRPL
         pVutDr3Tr/mboPDjuUjHJyBL7ymoIGasanK9FTMT2b8ripFvlKNW2wcPVvuXExTg2f
         qFX0tlfBYvfIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11612E5250E;
        Mon, 31 Oct 2022 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v3] Bluetooth: btusb: Add more device IDs for WCN6855
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166725781606.15466.15373655080241803473.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Oct 2022 23:10:16 +0000
References: <OS3P286MB2597E5DC0322DE5839B85D7698359@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB2597E5DC0322DE5839B85D7698359@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Oct 2022 01:22:54 +0800 you wrote:
> Add IDs to usb_device_id table for WCN6855. IDs are extracted from Windows
> driver of Lenovo Thinkpad T14 Gen 2(Driver version 1.0.0.1205 Windows 10)
> 
> Windows driver download address:
> https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/
> thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads
> /driver-list/
> 
> [...]

Here is the summary with links:
  - [RESEND,v3] Bluetooth: btusb: Add more device IDs for WCN6855
    https://git.kernel.org/bluetooth/bluetooth-next/c/81dc22339cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


