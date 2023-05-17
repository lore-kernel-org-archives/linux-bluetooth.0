Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58BBC7EE22
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQTu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29165525E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA71264ADA
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E79C4339E;
        Wed, 17 May 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684353023;
        bh=BLIMzDWfqNFrp/VCcxEYKWipgQ13je0htbpfHT74yLQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GFdDI9Vs6tjFvThAWfddxG/lt9J2yAy3ruqh2p1I/ahHP68XbTuH5pHC4ePTXm8SP
         OH3b1BgMy9eKizXnWJ/OzQBjRxfiw+Y9gEiD7nAFzCLhuaxOXLU1aBFYJpoLucyiqG
         gYAXNCCTmb/RAXP9sz8kW9vqGbcSzdKOSCoLsBPJrNa9gnCBKDb8gS57md0j7OacgN
         g2EHIz9n9dxF4+1HW9RXq+uC33klH/G70r2JMTWmQhSvO7oascpwrjbAX+x6c2lNlg
         xxTzn7MgN9K3OcAycaQqDnEb3ZL5jww59Owam6Bc6ZG6tHR7lJrhyYU7Wgg6bBwSMP
         57ESSbpbMFN/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB25FE5421C;
        Wed, 17 May 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] test-runner: revert udevd and audio support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168435302295.9114.3945510474101072187.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 19:50:22 +0000
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
In-Reply-To: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 13 May 2023 16:08:36 +0000 you wrote:
> Tests running inside the VM don't need access to sound cards running on
> the host.
> 
> This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
> This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
> ---
>  tools/test-runner.c | 108 ++------------------------------------------
>  1 file changed, 3 insertions(+), 105 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/2] test-runner: revert udevd and audio support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0a10f8c9d78
  - [BlueZ,v3,2/2] tools/test-runner: add option to start Pipewire inside the VM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86b8d4192dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


