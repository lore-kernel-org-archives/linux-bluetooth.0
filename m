Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D51C77B71
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 21:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDNVaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDNVaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787725BA2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 14:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D6E64A7B
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C27C433D2;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681507818;
        bh=/3Yoyx/ibaWJPFH5J31qju/ZQ1ss7ujvidcgJxSMqfw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jhFH2Wdtxx1nk34WL7WFaZ8GcSBPNlJan+kwL4buJENGcP+5GG3Rx9QPvjrOeYFDo
         +A5GvbWUB7z7f1blcZ3cu1jjSy9tG+/BDDdJdTDXZP1oHtCUpatkJ41BzfP+mR/xmg
         W9T14fDlu5WRHFulT0uAXfP5V21sdiiWH3H4+jcbo71nMrhAABd8ySrM9WdUAt12DE
         FpV5HOOL2vIZBOdrGpsLQ2GXXPJMUinjbiFmhy8gYElGP27eJZWIzJP4f7W2krn9Tb
         dqnfJhkg+tRWuapdJNnm7m8aRp6uDdVuQB76vbKvo34PiDgs6yvq76PmHXd/4+gfUu
         +m65Z/mmsZ66w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3683AE21EDE;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v3 1/3] Bluetooth: hci_conn: Add support for linking
 multiple hcon
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150781821.20001.5395447365656696228.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 21:30:18 +0000
References: <20230414202608.1152970-1-luiz.dentz@gmail.com>
In-Reply-To: <20230414202608.1152970-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Apr 2023 13:26:06 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Since it is required for some configurations to have multiple CIS with
> the same peer which is now covered by iso-tester in the following test
> cases:
> 
>     ISO AC 6(i) - Success
>     ISO AC 7(i) - Success
>     ISO AC 8(i) - Success
>     ISO AC 9(i) - Success
>     ISO AC 11(i) - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/3] Bluetooth: hci_conn: Add support for linking multiple hcon
    (no matching commit)
  - [BlueZ,v3,2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/450b35ffd344
  - [BlueZ,v3,3/3] Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e5ad941e0e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


