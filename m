Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C48C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 13:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354026AbiDONdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353987AbiDONdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 09:33:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969B66F92;
        Fri, 15 Apr 2022 06:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F055B82E4B;
        Fri, 15 Apr 2022 13:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B90EEC385A7;
        Fri, 15 Apr 2022 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650029475;
        bh=/ZCtmMVszBUufoJu4C6UHm7Mhkfsxw/fiIHMP8dVi/E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o4Y1yohBZSejrlEYmC5fyZ8CX6HrtD7mqZgGIBMd2G49stDJXVuJgtPqzlYQy03CH
         9Qya6Cbi/plUbGnPdDzVJe22zkoTcJb8SDwg9BfwO4dENfMrjALwS67L83ZsObLnk4
         m/NrLo5x3QR6KBB/8Qak+o/a2xzWukR0he0mn9mfv0eTnL940yhSQExBPpHwqVc6sa
         MwkrfjMqQmMIDeaeNkEFI+LTphjlnKTHxCrkVZq8jZWsTddSEU7Eo4JYnGvSFqENe9
         qPqjTvrcJEGcGfhA6KXrtb5BHYcYvq8zfu4rJeBBE4jdU8Ml6lpwh786V3PjBaLXoz
         HHCCQRIAI1dAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C27EE6D402;
        Fri, 15 Apr 2022 13:31:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Use del_timer_sync() before freeing
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165002947563.30414.10092759086081874697.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Apr 2022 13:31:15 +0000
References: <20220405100200.64f56e50@gandalf.local.home>
In-Reply-To: <20220405100200.64f56e50@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ytkim@qca.qualcomm.com, tglx@linutronix.de, eric.dumazet@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Tue, 5 Apr 2022 10:02:00 -0400 you wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> While looking at a crash report on a timer list being corrupted, which
> usually happens when a timer is freed while still active. This is
> commonly triggered by code calling del_timer() instead of
> del_timer_sync() just before freeing.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_qca: Use del_timer_sync() before freeing
    https://git.kernel.org/bluetooth/bluetooth-next/c/373ae6de4361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


