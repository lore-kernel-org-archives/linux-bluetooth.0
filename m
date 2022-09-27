Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCDBC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiI0XAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiI0XAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 19:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A1AD9AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 16:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E1F61BF3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0302C433C1;
        Tue, 27 Sep 2022 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664319619;
        bh=T+3t5wPhdJ5dAsDUrtekBLmCYanYMdKcI0TT1BrjVVQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RoGD9xIre1mpFDdNzg0taV7hY8hR+o+bvBl75eVRxNe/7RF7ZDOPv6rvxYgqdciVo
         Ye/d0juSmZLOn2lumBjNzcX/8v2qJgvJuLwAA+Bpqmp1gRq5xrr9Frs1rv2Dl+o29j
         t3E2IQmPKHaGfpyYOQZa+bG40uBIeGUCGctYaneXDz+tRjLJQgPP9FDhKHGKTzfW2g
         l3btRE1jfqEZ70FZ6IIKBZgZDQUvTudpDjMXXxXdIgbWkSfY/fnPQYjb5MHG7hi7bj
         OVEBBZDC/kZ1aKLoVKOx+pVjdWPA9Q/h23RkfJkGa7Zu+3MXQW03Q/grcxhenBIzP6
         cmNiVW+RnTK4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90754C04E59;
        Tue, 27 Sep 2022 23:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Fix not handling link timeouts propertly
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166431961958.4349.5166821226354951047.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 23:00:19 +0000
References: <20220926225107.3226470-1-luiz.dentz@gmail.com>
In-Reply-To: <20220926225107.3226470-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Sep 2022 15:51:07 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Change that introduced the use of __check_timeout did not account for
> link types properly, it always assumes ACL_LINK is used thus causing
> hdev->acl_last_tx to be used even in case of LE_LINK and then again
> uses ACL_LINK with hci_link_tx_to.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Fix not handling link timeouts propertly
    https://git.kernel.org/bluetooth/bluetooth-next/c/116523c8fac0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


