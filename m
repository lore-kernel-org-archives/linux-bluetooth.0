Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732CDC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC1UaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC1UaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 16:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C2DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0625B81E5F
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49810C433EF;
        Tue, 28 Mar 2023 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680035418;
        bh=SRi1FIclEhLgM1CTJYD/AqIHtb0eU0/bn0TxGE0+Yck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EJfXMANcq70e6Iqbr7xn/nz5jfyHzHk6WYLPaPZY6fS+rrjnWFBMvSxrE1jn5Ceyi
         dg0kD96lQFdGypbC5xUjpUQusehepLNaonyF+G8RqebLZOzRZUar44hzB9LMFEiGUx
         fEewIDP6qc8NvgcuNwFs0uHoIBBkumTAWUW8Uxsj2yRhIkVLv7gBnFtiP8x7srm6cW
         hvE3dyXMHXMEMdrnVbisvvlF+z9NusUiHVKnTgN0DrsBBbI3+HbGgh/Ru4an42z8nH
         8KGre2MR7fwCYOvHrau8Wq5gfgRqGQenT6a5IRuTMgxalZuwYBF6o4/g6aZ6SQTs7f
         JjTKc3WCj9BTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C7DFE21EE2;
        Tue, 28 Mar 2023 20:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_conn: Fix not cleaning up on LE
 Connection failure
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168003541817.31334.5504159368010073543.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 20:30:18 +0000
References: <20230327205347.51568-1-luiz.dentz@gmail.com>
In-Reply-To: <20230327205347.51568-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Mar 2023 13:53:46 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_connect_le_scan_cleanup shall always be invoked to cleanup the
> states and re-enable passive scanning if necessary, otherwise it may
> cause the pending action to stay active causing multiple attempts to
> connect.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/501ba6f31a83
  - [v2,2/2] Bluetooth: Fix printing errors if LE Connection times out
    https://git.kernel.org/bluetooth/bluetooth-next/c/2731e038a76d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


