Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B086C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCUQAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCUQAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 12:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563A7EF2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 09:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC3461D04
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 16:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16394C4339E;
        Tue, 21 Mar 2023 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679414418;
        bh=BC1tYTV7iPBB0uo9ja/OSf8plyJ2juXHQT3835M0LV8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KI8IhNDfKCiPcMJGOmUnDe9B/cB9t86M/a/KiIndnsDyhZ+qtyIYdhxhutCD3ii/c
         YGOXHaImNQRUTug8Hbd1R6DQqJR+ufycGYZyToPz/ekri5903EBtCMez+t+cufOxhN
         hlqJMcZ5koSw2xRV3Ve1tiRzgsxOtPhaAphqlFoNR1AITgMUqexyVIdn9sTITbHw7C
         DQB0iZMCFcZktyMRI+zvf1gJk+wasgjRs9FWp8MwShY4EAswYd9EJueYxRAMMYGLQF
         I4fIK/o5uzScREk+xvgl13q4oAg/oCFeSgy7qQ44zMTZCrRbjbC1PuppKPmhKkeguL
         HZD2zzfBTvqvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0EC8E52513;
        Tue, 21 Mar 2023 16:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obexd: reject to accept file when replying reject
 message
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167941441798.2626.12511426282910293459.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:00:17 +0000
References: <20230315100435.5424-1-aarongt.shen@gmail.com>
In-Reply-To: <20230315100435.5424-1-aarongt.shen@gmail.com>
To:     Aaron_shen <aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Mar 2023 18:04:35 +0800 you wrote:
> It will accept file when obex agent replied any message
> event though the message is org.bluez.obex.Error.Rejected.
> The patch helps to reject a Bluetooth object push request if
> user replied "org.bluez.obex.Error.Rejected" message according
> to the doc/obex-agent-api.txt.
> ---
>  obexd/src/manager.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] obexd: reject to accept file when replying reject message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=338ba4352b6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


