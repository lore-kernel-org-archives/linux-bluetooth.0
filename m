Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC2C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCWUug (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCWUue (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 16:50:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4501271F
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 13:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3793B8224C
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 20:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C10C4339C;
        Thu, 23 Mar 2023 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604619;
        bh=NB4ktg1nSCGTbqKCPepzSVYcTEHDuzCJfIsWM134+4A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lnKMcknhXoAu3OvEVLOmArAn9vIIMRilM9YUxr/1kHLx4piMadbJpDjawA4Kr/t8A
         mcX+9Du/z/PsogghmTvH08OBhZd1DoXEZuIcs2FaAXEdgQH1Y907LAnxmgk8Y2uk8F
         I9FPeC8XdsxH4N38NDVp7Wc5H2z8KJiVrSIpu3+b9pKymJ27haV2rICxqg3KxzwH0V
         s3tUu1TFbQIqBRVcwOVxP9BZmDz7gALfy0pmw/IZbaYslE9jHB8S3ocqD5TOsOZLi6
         UCY18Afu6iYF5rI6QkbXf15AWXWZ2mCu4Ev2wdU891MhFNAvAa/7R1B8FmOjoE16up
         L9zC0cdlTsiOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30251E52505;
        Thu, 23 Mar 2023 20:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] monitor
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167960461919.6047.7144371011985032771.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 20:50:19 +0000
References: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Mar 2023 11:28:56 +0100 you wrote:
> Hello!
> 
> I'm sending some fixes to btmon.
> 
> Best regards.
> 
> Simon Mikuda (2):
>   monitor: Fix crash when there is no write handler
>   monitor: Fix printing Signed Write Command
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] monitor: Fix crash when there is no write handler
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=446e13360dba
  - [BlueZ,2/2] monitor: Fix printing Signed Write Command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=648b4362521b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


