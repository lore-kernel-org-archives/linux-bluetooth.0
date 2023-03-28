Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E79C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjC1VAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC1VAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 17:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B4C1FEC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 14:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB736195F
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 21:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3264C4339B;
        Tue, 28 Mar 2023 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680037218;
        bh=5OZPw+2Be0sQECttvAYPzLu/d1pCX7Fu6h71/Fg3zCk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZcQ2H9aYH71SQOPo70ZuM0/dguQpE1LK4wmglRSg0wey2XKkREE7HWXRHXE6a9cuz
         mQApPWiLiKwIKZ7THUWV0fuyTFl4eMxzY+IElllUYIWWqnQ4MFO7RyZtA0U0JrzM2p
         BH2jJVvjpH5+Jw5gHg1DNTeWzlhi5CJQE/E3dA9ZNTE9Ujq65wcTYAp6z+JyriMJjW
         rqjdu55tWWdLMJz28sbZnedziJA9P2QwopT/dfirGTczs2UZ1j+L6JjdvN30A5w9z2
         OypZ4Uk8qf/OG8k8800vBvEebtHa/zePlhEXxMhNAZLUfTNbNIA0jqqshjcCmdlJK0
         AZpRDgzw3Ec/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFFEEE21EE2;
        Tue, 28 Mar 2023 21:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: Two additional devices
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168003721878.12776.16538744663777219563.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 21:00:18 +0000
References: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20230323005203.19749-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Mar 2023 19:52:01 -0500 you wrote:
> Two additional Bluetiith parts attached to Realtek RTW8852BE devices
> have been reported.
> 
> Larry Finger (2):
>   bluetooth: Add device 0bda:887b to device tables
>   bluetooth: Add device 13d3:3571 to device tables
> 
> [...]

Here is the summary with links:
  - [1/2] bluetooth: Add device 0bda:887b to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/8052aa4f4e7c
  - [2/2] bluetooth: Add device 13d3:3571 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb3248d369af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


