Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D980C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiHEXUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiHEXUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188CE3A
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D585F61378
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 23:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 379F8C433B5;
        Fri,  5 Aug 2022 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659741613;
        bh=LyRrp6G10HKo58WrtjgFvKssxtZyBOgvNhkBbyHB+cE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LYQIyALUNgfxn57STnZOE3KySA37ATzwt+ssmGm68j14qYyQXIjioUkffjuQsVxSx
         wPVKVLhEqNKaq4c7j/PYfeSrb/RZn0HVEDlICD309OBtEr6IWJ1tn6NoUK13dMpUPA
         Y0WGvn9ciC3EQilD5C0/37NQkyQfTZ0tRCs+9CQQSr4tZOejUEJ2cbFNPR3n8EDDYe
         zBiNJZxUpseYEXAJG+TTjBbnoa3oFKr1z0jxpEVXG9enXXa7tlvnf8SNEW9zBRTdfU
         UmZrQhMVtkUzfwzQbhEeOtBdOCXEp0NHEh07YoxqCCHWKzzaBWop9BumiUjy1tVTTX
         g+zuLUKLDn+2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DC22C43142;
        Fri,  5 Aug 2022 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Fix not using the correct QoS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165974161311.5986.16553764464556071427.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 23:20:13 +0000
References: <20220805215601.3958596-1-luiz.dentz@gmail.com>
In-Reply-To: <20220805215601.3958596-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Aug 2022 14:56:01 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes using wrong QoS settings when attempting to send frames while
> acting as peripheral since the QoS settings in use are stored in
> hconn->iso_qos not in sk->qos, this is actually properly handled on
> getsockopt(BT_ISO_QOS) but not on iso_send_frame.
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Fix not using the correct QoS
    https://git.kernel.org/bluetooth/bluetooth-next/c/aac59090a068

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


