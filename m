Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D55C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353743AbiDZSXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbiDZSXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 14:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D49627C;
        Tue, 26 Apr 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F907B821FD;
        Tue, 26 Apr 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D20C385AA;
        Tue, 26 Apr 2022 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650997212;
        bh=IChXkZaJvZkNcfmr+3DC8BXoJsGWNChHpzqf694eNpI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nxyY8gH7KtrErcm+JZ147vq0vNiDVKN8B8r7PPix9wXJGvaDkG7bmCC9ce3dS4wJ6
         7lFcDJNl5GFzEnoKnhB1ZHQsajw4NWoAhU6J0Rcpk8YbgCWQ64n6j7Iw7d7RpB7/Kn
         wp4Bck1kOLu0c1IcLVE0mwn92TymSvW11KluA7nJqLriBd08JR4KctUwKAbNp9Sfnq
         AnEXY6m5wmMVxoTYR+zMhHOF21S1Zpq1ZFMq5e+mcJL2lwW00edgCEc8UE6v0JXbzK
         n9GFG48N8nmrs+eFXW/wPmXrQnoWfz1sVrnc5Dx7Ay3PHlxXnBbPpsxdaPQFHqO611
         kvU5tTmzBN/dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7108F0383D;
        Tue, 26 Apr 2022 18:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: core: Fix missing power_on work cancel on HCI
 close
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165099721194.28515.11075486461525033162.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Apr 2022 18:20:11 +0000
References: <20220426081823.21557-1-vasyl.vavrychuk@opensynergy.com>
In-Reply-To: <20220426081823.21557-1-vasyl.vavrychuk@opensynergy.com>
To:     Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Tue, 26 Apr 2022 11:18:23 +0300 you wrote:
> Move power_on work cancel to hci_dev_close_sync to ensure that power_on
> work is canceled after HCI interface down, power off, rfkill, etc.
> 
> For example, if
> 
>     hciconfig hci0 down
> 
> [...]

Here is the summary with links:
  - Bluetooth: core: Fix missing power_on work cancel on HCI close
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d866d8ec36f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


