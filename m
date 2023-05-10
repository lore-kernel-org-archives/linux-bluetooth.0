Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF7C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEJUAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJUAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 16:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11E359F
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F3A637E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 20:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E685AC4339B;
        Wed, 10 May 2023 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683748821;
        bh=82JkD7IOio03WQbw2hxe2gK/RlNMBFCnKU1K8zNbbqM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=THgd41I9O6fY6gftYbXMNcVPd4s+iuXAEse8Tp7KZ1gMYxXTNwTOecqj6C/cMqQ1i
         XZ44Od+yPCMf0B4C95cNXikd8O1o3IcOG6bDGS59uc8dzXKhvR4UQE3bJ/9MjuutOH
         IEdSoHWvWkU0u9iBqcVjYa4LRTW8vH7TxTpU6YEdeJ3Lak9+YpwTBOmcAqS0KSaGub
         gvsqsoDn2v7PtGXC+n1u+6dhRjplPqdwnAIrSkZi91UnvRMrE+o+c/gXT3OvGPa8sG
         ZdpRFlytk1SO87tODYQG1hOW0v7rEIe65BIyI4CN1HTm0ztTCQ04woGGdLhuonF/Vf
         mtrKZZXMxMecw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1560E26D2A;
        Wed, 10 May 2023 20:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] monitor/intel: Fix not skipping unknown TLV types
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168374882178.21592.1913434271130730160.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 20:00:21 +0000
References: <20230509235507.3424068-1-luiz.dentz@gmail.com>
In-Reply-To: <20230509235507.3424068-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 May 2023 16:55:06 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The code was stopping at first time it detected an unknown TLV type when
> it could continue:
> 
> > HCI Event: Vendor (0xff) plen 82
>         Vendor Prefix (0x8780)
>       Intel Extended Telemetry (0x03)
>         Extended event type (0x01): Audio Link Quality Report Type (0x05)
>         Unknown extended subevent 0x81
>         01 01 05 81 04 88 13 00 00 82 10 6a e6 6c 00 00  ...........j.l..
>         00 00 00 4b 45 53 00 00 00 00 00 83 04 00 00 00  ...KES..........
>         00 84 04 01 03 07 19 85 04 3f 08 00 00 86 08 00  .........?......
>         00 00 00 00 00 00 00 87 04 00 00 00 00 88 04 00  ................
>         00 00 00 89 04 00 00 00 00 8a 04 b9 49 0c 00     ............I..
> 
> [...]

Here is the summary with links:
  - [v2,1/2] monitor/intel: Fix not skipping unknown TLV types
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89f8d6bae18f
  - [v2,2/2] monitor/intel: Skip packet/error counters if 0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c452c2ec173

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


