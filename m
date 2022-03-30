Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiC3UCA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiC3UB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 16:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045A31DD9
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7A9C61530
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 20:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13BC4C340F0;
        Wed, 30 Mar 2022 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648670411;
        bh=XHBy/qh9DD1cHirl7vbpVYRamH8EoO2A4HBHMvqwMYI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ojTXY/GokZQYypcn2ts9CCgJpEqyzswaN612fDvzFrImPUFlbHYpgRWDdYll9x+j3
         hLDUG2b2wL4R85GGcuQEma3ymrPz/E5WRXYUG5eDQIbZIC8wcvRgXUyM4YMfnhkDNk
         eEbkd0keAA0L92ufn4EJmsWEyVOZuQiMKF2EJLRHH+7xgrfvoaSsh2pKe/8bVJtaEA
         0AotMY9LFIYoqr4YoibJK0/+D16pYSQsJjQH5da29iv1Pur2citHxWXiJq9QE0Ae7k
         Gae4lhedKGP88ZLzYiY9bz4Yy22pq9chlbHVBuWKO11gHL18HJs3gMsfs1Fxu2za/u
         Dxpn8NkPpeERw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA336E6BBCA;
        Wed, 30 Mar 2022 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shell: Make bt_shell_add_submenu set main menu if
 none has been set
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164867041095.27763.8382818293639657358.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Mar 2022 20:00:10 +0000
References: <20220328212518.1890451-1-luiz.dentz@gmail.com>
In-Reply-To: <20220328212518.1890451-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Mar 2022 14:25:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If not main menu has been set when calling bt_shell_add_submenu then
> turns it on it main menu.
> ---
>  src/shared/shell.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] shell: Make bt_shell_add_submenu set main menu if none has been set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0cc480a546e9
  - [BlueZ,2/2] client: Add support for player submenu
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


