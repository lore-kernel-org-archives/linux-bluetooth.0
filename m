Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B9C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiFBTKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiFBTKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 15:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40931C77
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D447E61764
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 19:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C87CC3411C;
        Thu,  2 Jun 2022 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654197013;
        bh=xnf1NQwU12L1cAlMRIrIMFeFPCdudLVuSn1U/eqjX48=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kOkwpP/eBbYs8ei6cSXFWPGl4eMLlsSAa7d7B92Ii+L2f9H3WoJlpgz9IJ18ENs4F
         wqRa33LC6K8KRoRo2gWSKdIrXTr91pabv787Xsf6HOxUOyMGxE+iNfgG6dTJihmUbt
         pCO+8IypWujrgmJsz+D701iaL0WnCSp3CWvdORNPB4XIdqCyAaNLloQssZmAx8RXbZ
         WpdcDCz24Du7L3myhaX630wfW3x9npiUVY/3qwXyveFtsaUwvcmNgFI8seY/BLx+Wz
         MlVjjV/Yn2iHsrpn4FosEV95PCz+YRM3nNNUYfeZBqRor6dVha63PcxITZfE25jsim
         MBswtIKdBEThw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20599F03945;
        Thu,  2 Jun 2022 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test-runner: Fix not waiting for system_bus_socket
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165419701312.15914.5777258811171838587.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 19:10:13 +0000
References: <20220601211230.1355268-1-luiz.dentz@gmail.com>
In-Reply-To: <20220601211230.1355268-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Jun 2022 14:12:30 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes test-runner wait for system_bus_socket to be available before
> continuing otherwise the likes of bluetoothd would likely fail to start.
> ---
>  tools/test-runner.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] test-runner: Fix not waiting for system_bus_socket
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7bcd32e67e93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


