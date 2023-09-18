Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC7CD37B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIRTKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRTKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 15:10:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2910D
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 12:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04931C433CA;
        Mon, 18 Sep 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695064224;
        bh=/AsCLkS1biRUIDEZgkZdIVUsXLy7QoiuHxbJybanig4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pCSxml1p9OioxRmAGipSbTk75JBpwTfz0GwS4MCpLNho313NZJ6wbGLIVGylghC4k
         zY2Ly0At4UVJjTz6Uq8NsYPPyBe2hjwbMux7VC68ik94CgGwTgZKbaxrnFAcM0mON1
         LW8DELtMclRzfLUze25lU54kvzWJYZNkTgxomv47/CLYeqMATKNuGO2vl79mSDbWT0
         TE2E5kRUuO/0MbtjJefOp7SY8SFDSpdaFRmKBdhMKcTAUxifsv2p/MsM4iBv7O2JIb
         svBETquey8Ay4rkB0yVahz8LQl0nyGpX93lBqwtvNDIu1aEVBkGKACksTwzxWFSpJj
         isjqbYc6BB7yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E075CE11F40;
        Mon, 18 Sep 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Fix build warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169506422391.3420.3618121314185203265.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 19:10:23 +0000
References: <20230915234742.3739283-1-luiz.dentz@gmail.com>
In-Reply-To: <20230915234742.3739283-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 Sep 2023 16:47:41 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warnings:
> 
> net/bluetooth/hci_core.c: In function ‘hci_register_dev’:
> net/bluetooth/hci_core.c:2620:54: warning: ‘%d’ directive output may
> be truncated writing between 1 and 10 bytes into a region of size 5
> [-Wformat-truncation=]
>  2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
>       |                                                      ^~
> net/bluetooth/hci_core.c:2620:50: note: directive argument in the range
> [0, 2147483647]
>  2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
>       |                                                  ^~~~~~~
> net/bluetooth/hci_core.c:2620:9: note: ‘snprintf’ output between 5 and
> 14 bytes into a destination of size 8
>  2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_core: Fix build warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e2bdaccb10a
  - [v3,2/2] Bluetooth: hci_codec: Fix leaking content of local_codecs
    https://git.kernel.org/bluetooth/bluetooth-next/c/67e19b75b662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


