Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47665C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiESSUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbiESSUN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 14:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B014EBABE
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 11:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C9961A8B
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 18:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D53C34100;
        Thu, 19 May 2022 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652984412;
        bh=nKyfjFyxXnl2SyPy+xerL1IyigF6XpP5GTbMf0/FvBU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fl4dYgPilEStJJUp7Th3cEOEd3urRyHk5W2hKiEkPYebPrTbP38lLkO80dhpNijsK
         3cL2y24glFuXCSUkupKBgnYrN211NXf65XX3lX9yMVJTxaW0sALb9ghJqUn0lAY04Z
         nXzZxM1OwUuEzIF/T0z/P/3fL6cfid1KYxxhpUabbOv1ExlNV45MEBhKC+B121V4gy
         SsysLqNiNGui9QEMnCWKkMbWHf9XysJpW3cEWm1fUyQKjZvHqp/e6TyT+q4W66p1J5
         1hcGA02u4a6ubJPF/RkhYsj0OLIlpC/O2ZgJa8QaoLUhjlAGmJ5lcSYnM3aA6okX3N
         HfB4UXKa6RBLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA374F03939;
        Thu, 19 May 2022 18:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] Bluetooth: eir: Add helpers for managing service data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165298441189.15161.14599873620329136441.git-patchwork-notify@kernel.org>
Date:   Thu, 19 May 2022 18:20:11 +0000
References: <20220506215743.3870212-1-luiz.dentz@gmail.com>
In-Reply-To: <20220506215743.3870212-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri,  6 May 2022 14:57:36 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds helpers for accessing and appending service data (0x16) ad
> type.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/8] Bluetooth: eir: Add helpers for managing service data
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f9ae5b3ae80
  - [v2,2/8] Bluetooth: hci_core: Introduce hci_recv_event_data
    (no matching commit)
  - [v2,3/8] Bluetooth: Add initial implementation of CIS connections
    (no matching commit)
  - [v2,4/8] Bluetooth: Add BTPROTO_ISO socket type
    (no matching commit)
  - [v2,5/8] Bluetooth: Add initial implementation of BIS connections
    (no matching commit)
  - [v2,6/8] Bluetooth: ISO: Add broadcast support
    (no matching commit)
  - [v2,7/8] Bluetooth: btusb: Add support for ISO packets
    (no matching commit)
  - [v2,8/8] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


