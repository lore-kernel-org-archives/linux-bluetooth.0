Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61094C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 18:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiDKSWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbiDKSWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 14:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195112AF3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E30A6612AF
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD44C385AA;
        Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649701215;
        bh=8lbyd6/UFkR0XHp8qxja+Jx7TTDowqn/1UQQke2noAs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bzscld73UE/RhEc01+3ifvzFgOogPGz5h+sTzonvvlsUKhOL5NQwsxypepyYtqBAf
         Q8eUDBLoCD6Tvd24+otYGrXZ0w/PkXqpSvZcQmZFLufOXbEp7D6jR7jPZdPU3o0dm0
         fJLCFc8xOzvnI9VsaMyK9BPddARdzOXcbCZth5XdxgCxqi4ieHJtBE1V5EYiYWLkfq
         ecMEzD3P76Uh2zrpsBCy572UTI8SIi1ukb0HEPeuonKCYjWfKItdL8LagKT/VB6lXJ
         W4I6E7FS0opGj802vmb5FNPe2R/ZauectnaiaugH6PQcLn7r6vmmXgmkw5K/MkrSoE
         rGiwV/GliyvFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3635CE73CC8;
        Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] adapter: Fix check of DISCOVERABLE setting
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164970121521.29224.5669966726836685486.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 18:20:15 +0000
References: <20220409100130.9743-1-jakob@hilmer.dk>
In-Reply-To: <20220409100130.9743-1-jakob@hilmer.dk>
To:     Jakob Hilmer <jakob@hilmer.dk>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  9 Apr 2022 12:01:29 +0200 you wrote:
> While debugging problems with BT discoverable with an older version
> of BlueZ. I stumbled upon this error - Two places the flag of
> `current_settings` is checked against MGMT_OP_SET_DISCOVERABLE
> instead of MGMT_SETTING_DISCOVERABLE.
> 
> Jakob hilmer (1):
>   adapter: Fix check of DISCOVERABLE setting
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] adapter: Fix check of DISCOVERABLE setting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7903bbe1005b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


