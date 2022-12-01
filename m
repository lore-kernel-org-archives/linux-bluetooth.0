Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4DC4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 20:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiLAUAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiLAUAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 15:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02E22BCD
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA6A62103
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36F4CC433D6;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669924818;
        bh=BjPOW+TvjNtFFOLlPY2xbxugzxrJmwH0XriDe9wsv/A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vDXhWCMmHwOyARnSa+K4dwuYwow65faGIdQQs5ci3tYpBR4pk5HwS5qDcsT7Eg2G4
         BVcUZuZYUF0QycSS3TwjBR+7Z2YdCPBS1cKHgWh2XzzQCSKhTjNqfl9MlFi0UPOdTd
         ODS7Lw2LqBIjg8qhUxWfLF+48df94b2Zqf30or3WERcGP3LUy8sKpy8LeX2wu4fwjw
         xbUgsjc6dAaCZ58qCpPT78cGUSOgD5D7+jiywZNnJu6+XWDhzlJFNh4k2c4lGzCjLq
         RC+Q9K4u9/z3z/ViZPquTTUbn2od2yXtNs3rKVeUI2D7efIT/DgdWSyqs2/aI4snKn
         g3pRQlZMHLMCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ACE6E5253D;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: Remove codec id field in vendor codec
 definition
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166992481810.20187.17437316153305595880.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Dec 2022 20:00:18 +0000
References: <20221122090257.26564-1-kiran.k@intel.com>
In-Reply-To: <20221122090257.26564-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Nov 2022 14:32:56 +0530 you wrote:
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
> 
> As per the specfication vendor codec id is defined.
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2127
> 
> Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: Remove codec id field in vendor codec definition
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0d0a36e32ab
  - [v3,2/2] Bluetooth: Fix support for Read Local Supported Codecs V2
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb77b0482a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


