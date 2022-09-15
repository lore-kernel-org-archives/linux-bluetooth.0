Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B4C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 21:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIOVUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 17:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIOVUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 17:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42031EF3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 14:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68086B8226A
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 21:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20C3FC433D6;
        Thu, 15 Sep 2022 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663276815;
        bh=/1DXK3ufwDlWCPCHh12EjaFNovpwWAEDY9uQ5h/IodA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a67D9MBnRqBmro0xTFT/aNgSIR2vcJ/EvyiNCZXVmHibh++O3o1s1HAXI3XxqVI8Y
         J4mqaRtq15XLKaxla9iY6dLWZiVAUPOMQjsFWhABLGtcmoemMDCC3HsIQK1iic/Cxc
         SZBwJpXmaTj4D0Fi9YKXbdaQtUtQUTbVes7B2EQ4AAyvPiYfs3r3eerqAcQ55R/hAA
         UXImxsIoYVAdpKcNS7i9qCkS7k/9u76yltHt+HQTxOKxtVUwRSt02Kyyrp0YioSvcJ
         Yirdd9rZcR8CKeCbHvUl5LTYgsLiezMEL0hSHDMYFSZBs/qF5Xg3QzXDZBcZUB6AtM
         +mWKlvQS7ys4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03D6DC73FEB;
        Thu, 15 Sep 2022 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] lib/uuid: Add VCS UUIDs
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166327681501.24209.16329562314897625508.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Sep 2022 21:20:15 +0000
References: <20220915095412.462210-1-sathish.narasimman@intel.com>
In-Reply-To: <20220915095412.462210-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Sep 2022 15:24:09 +0530 you wrote:
> This adds Volume Control Service UUIDs which will be used by
> Volume Control Profile.
> ---
>  lib/uuid.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/4] lib/uuid: Add VCS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af1bfbb470c0
  - [BlueZ,v2,2/4] shared/vcp: Add initial code for handling VCP
    (no matching commit)
  - [BlueZ,v2,3/4] profiles: Add initial code for vcp plugin
    (no matching commit)
  - [BlueZ,v2,4/4] monitor/att: Add decoding support for Volume Control Serice
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


