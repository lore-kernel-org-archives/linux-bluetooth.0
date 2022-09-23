Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B23C04A95
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIWUuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiIWUuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 16:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3EB6D14
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 13:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DFB1B83A9F
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 20:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CC77C433C1;
        Fri, 23 Sep 2022 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663966219;
        bh=GgCdybkCv3FkChk8TX0YtCMDin+nIGtHWKnM4vmp4xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bTrqyjX+hXNJ5NDH4Zdci0zizgjsTQAnt7xq2UJYx3YVOXzNbgN5Htcr8dSgeDMpS
         axRQOYUK8oLqKaXLZwItAQg7e8uTfspQjRO0uowwN7QjH9oCZptTb41oTJkYS17A42
         GDuT0eOWGZnM68YTzNAeCQMXAf1pbthLAM/dfKOjTccxJ29DC7u9qHjar9B8vdDPuq
         rWwl+xgBW/vcjDLAjisqcraIq8VABK+Sdbrxo4A3Eh6PFwbWW/bCNHOCLUxsdp8qu+
         SzJiv/+m15egb3SkjnWJe3tsGAukU8B+cEmDUjM+tYPH/rfo24sZr0im/TkX/ricoo
         ZPKofriPH3W6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2F10C070C8;
        Fri, 23 Sep 2022 20:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 4/9] advertising: parse_min_interval: reset min_interval
 if iter is NULL
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166396621892.24262.10548710352015737373.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Sep 2022 20:50:18 +0000
References: <20220923102600.10455-1-ceggers@arri.de>
In-Reply-To: <20220923102600.10455-1-ceggers@arri.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Sep 2022 12:26:00 +0200 you wrote:
> Set property to its default value (as done in all other methods listed
> in parsers[]).
> ---
>  src/advertising.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abfb3a807c39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


