Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF8ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 22:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiIAWAz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiIAWAr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 18:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77040BD9
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 15:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1EA61FA2
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 22:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8835CC433D6;
        Thu,  1 Sep 2022 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662069643;
        bh=2sgLHHSSI/LHc7M8YdgzSshBUTTp0x1eNi50soa8zcU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RW7kh7mni7x8L3RNrtdi7Ag0yx58mxb8D4mSZ9BfZrCNi3IXeE/d3NwdKtfwu2lzW
         ATgtYbenbXycryjUfiS745B/dYAHq9+fo2mWdrkGodxKqoMhR8dkmJnCVkuo/7Fifn
         B7G34+nDrzyb7ROHC/mC+gzKKPS/Ky1gtOM+W8v5XUTsE+dmf56c8my7rq+v8B0aVn
         5g/QEiKWwQGdJlVsv+hJCvg8WNX7R6ZVExj/hmrAFWz6oHwsCK41tU+NOYtd5skwbn
         RjBc5QvufODV1KohuhIxX4Sdj8LQxQ6FQrH5VQ1foozijbYpLJ1Ez6TVoI3yJ40U3V
         4GHPP2NtMiViw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F832C4166E;
        Thu,  1 Sep 2022 22:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mgmt-tester: Adds turning on Mesh Experimental
 feature
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166206964325.4836.1100026853020253657.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 22:00:43 +0000
References: <20220901210722.73044-1-brian.gix@intel.com>
In-Reply-To: <20220901210722.73044-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Sep 2022 14:07:22 -0700 you wrote:
> Turns on experimental Mesh feature, and expects it in report when
> querying which experimental features are supported and have been
> enabled.
> ---
>  tools/mgmt-tester.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] mgmt-tester: Adds turning on Mesh Experimental feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c96629bedbae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


