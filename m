Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF9E94139
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjJGBA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGBA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34FB6
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5EA3C433C9;
        Sat,  7 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696640423;
        bh=q/zJeRnFfpBRFF7QvPhX2DXjRWA58bqO0uAWOBUpxIk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g7AuwRyw39YEZwltFROz9DF4czKla7XQHjSX9+nh2CyKmrfOdVF2F2If+ICeG7G7A
         XC0vp67A9re8LJ7zfjVOmuBPfwSyeTrHKH+o3lto44ou3YT4erFtG7mfgBZqURtw7Z
         ozUtAVl5UQBMTuHuQGIN6Ukor+hdimlMHG9d97DJGGX1EAAqDYuswFDnFy1YsVVwuE
         Vbg4Prfcfc1Oz3cMkxXhmF8HwXO/OGTL9mz7TPenwpmNuptID3A5r7N3Xdi9ZRpKqb
         qIoTqTFh7tgBUGjVmMM85mqy0wPVe70UU7E7aIGN/ANGgYzdjJyAGi6I+vdQOluMyH
         y0RtlCf3lKZ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE6CC595CB;
        Sat,  7 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_event: Fix using memcmp when comparing
 keys
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169664042376.23949.5642884188872485507.git-patchwork-notify@kernel.org>
Date:   Sat, 07 Oct 2023 01:00:23 +0000
References: <20231005212322.3886919-1-luiz.dentz@gmail.com>
In-Reply-To: <20231005212322.3886919-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Oct 2023 14:23:21 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> memcmp is not consider safe to use with cryptographic secrets:
> 
>  'Do  not  use memcmp() to compare security critical data, such as
>  cryptographic secrets, because the required CPU time depends on the
>  number of equal bytes.'
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_event: Fix using memcmp when comparing keys
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ce9e7726323
  - [2/2] Bluetooth: hci_event: Fix coding style
    https://git.kernel.org/bluetooth/bluetooth-next/c/f1b0dea09e3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


