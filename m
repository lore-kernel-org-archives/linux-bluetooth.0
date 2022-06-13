Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 19:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiFMTmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbiFMTlq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 15:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879B5F79
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 11:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADC88B81243
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DFB1C385A2;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655143815;
        bh=WpfBoAbhsJsKwI7KdNe3hUkCEjiY4YgfMDlqu5rCVII=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kPHLbLhZTsZnXZyQWj9pjPW0REBTM0+ZyfkCJ5lf2MwiPMcZL0FyNrfuEPmE7KZm7
         OjV13E2MRAhzhG4Kwbh4TVJkWRdHcq5cWrIl7imDBfCBzZpPqXjydN5zzFuGCjrMGi
         erLhwcgrJJ90K5mjL/CvMtVi/8x15MsdtxVNlxVkDod+0QRTSYBBBYKyAZmaSeAQOA
         +bJi/L+Yd3iMuKRbazu9M3jcv7w/FRMa2pLK1Eog3LjFitsjAv5e4EY9V5tMs9iD5N
         lMO3EomBp1fMwIO8BlAJulfi16Ue4hv7U3/YZaUaRHebjDy2038x2dwzZaOoB872J6
         aZ35ElDcBGASw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 417E8FD99FB;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/4] test-runner: Add support for audio daemons
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165514381526.24573.5473028476599464353.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Jun 2022 18:10:15 +0000
References: <20220610163820.79105-1-frederic.danis@collabora.com>
In-Reply-To: <20220610163820.79105-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jun 2022 18:38:16 +0200 you wrote:
> Those patches add DBus session and an audio card so it should be possible
> to start an audio daemon like PipeWire in the VM.
> 
> Frédéric Danis (4):
>   test-runner: Add DBus session support
>   doc/test-runner: Add audio config options
>   test-runner: Add audio card support
>   test-runner: Add udevd and trigger events
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] test-runner: Add DBus session support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7e2f05e029b
  - [BlueZ,v3,2/4] doc/test-runner: Add audio config options
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=096599c1ae85
  - [BlueZ,v3,3/4] test-runner: Add audio card support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e20e7e0b05c7
  - [BlueZ,v3,4/4] test-runner: Add udevd and trigger events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=91a48af52efb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


