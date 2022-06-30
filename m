Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiF3UkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiF3UkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A402209
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF65B82D01
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 20:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E50DEC341CA;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656621613;
        bh=u28jq5BCveSo0I32G6SxascJIAgLSYQvS7dndjzhwQE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ALCzPT5bhrFWIbDog3ZA3PznBw0QogU1xQG/pL6tUp46K8ZUbT8Z6ia4BatdCGgRl
         iNqN+Z6Gisb/nnvrkqt1xsmAwTvfB8FovnFyIMuvQlyke8s0H+8dT1kOwFpiAPsZH7
         Ju8UHdtqF5S7hO2TLPw6BVIYc4uaNZpIeuD4l1f7jpCVKMi2iLCq0izecjY/6cN8vN
         ezuPBH1uYnqEgUCKwfmWJtN1327OuFKsR0GQIwF0yPiVMETwEvZVcPl3X0PY1pbLfs
         wj71Fks2jsKo4YKHyoC+AARsdYfoNBpJooH5f+wrwobUUpObEitbLesE91EaiM6Jxf
         /3yPSyADJdjzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C733CE49FA0;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avdtp: fix possible minor problems
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165662161380.2141.10688934645144865012.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 20:40:13 +0000
References: <20220629124656.10174-1-lishengyu@uniontech.com>
In-Reply-To: <20220629124656.10174-1-lishengyu@uniontech.com>
To:     lishengyu <lishengyu@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jun 2022 20:46:56 +0800 you wrote:
> It should always be considered that if send_request fails, sep
> should be removed from the list and the requested memory freed;
> ---
>  profiles/audio/avdtp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] avdtp: fix possible minor problems
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44658fccacda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


