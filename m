Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 23:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLVXkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 18:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVXkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 18:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8966B6A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 15:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FDC61DC8
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7BABC433F0;
        Thu, 22 Dec 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671752416;
        bh=4+shjo6lFVC5cruU4CMI7Lcbzzi3vmh0/ODMrXkFrhk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EdYnHt704NRjWp211N3z1In2REoyZrkdtMMzwMgdjGqazXgTH9zvAR1DqJgvoZ703
         Vm7IDu7zua3NI8HccRZ+2OxzugM5+1ZbqV9rFP/SggQ3pdkwEfeFD8lNdtd/lQ5N6N
         rJ831UFT6EFrBf76+cxtw/i4/oQ4DtYiX5ycs2WYRtXca6m1LDxNPevMHdIuUWutyd
         h47sHaMqOR3hLXEo4gwsF87qPvhJ0G5VO2TCFaTQy5BWJzRx3P6ftBmBrgcojrcKbz
         /XKQwhGNZfmaC28S2C1r8uSB9UzFvtEjrqhSqjQclQY+yPCq4/Bk4I4gX3pBkDMuOg
         3Bq1aP56GQz3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD686C395EA;
        Thu, 22 Dec 2022 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167175241677.6123.1818448848392983366.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Dec 2022 23:40:16 +0000
References: <20221219234945.3733741-1-luiz.dentz@gmail.com>
In-Reply-To: <20221219234945.3733741-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Dec 2022 15:49:45 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Don't try to use HCI_OP_LE_READ_BUFFER_SIZE_V2 if controller don't
> support ISO channels, but in order to check if ISO channels are
> supported HCI_OP_LE_READ_LOCAL_FEATURES needs to be done earlier so the
> features bits can be checked on hci_le_read_buffer_size_sync.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
    https://git.kernel.org/bluetooth/bluetooth-next/c/711d2d5f3b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


