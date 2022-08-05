Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0354C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiHEXAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiHEXAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE92FE
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05D661068
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25486C433C1;
        Fri,  5 Aug 2022 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659740414;
        bh=qvY39bXQ1LunewcTHZAVIOOV+RMh+aLmaIRj/K8gTCw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ccwGncqSrUDYwmCbqQxnA3xrkRFqdyN5wjhInJJIGVW/NDRamk6yZUJSK8u9Ae/t1
         IM7VUpl3WiJe5/mvLOED+r+KwsjZZNUY20wXLbmg1pVqW2561166tQiGEEhfcWdgMa
         x7iAQ6sKIALmvh0MFyYWi/wXhPsZvzOYF+kSIjg5h+T7F4jb2fCj3imeLg648avidh
         wfcdqMDVbaFNU6GEUBfBCWeFbG9L286SPKTrQRXNh/FsEHjdVw89PY6N6MeyDD8rgj
         fJ6V7VK8YRCf1NHeuRXOXpo6LOOK03yGuzBkgEiMiVN7Z/9Kxzyhe5USh1OO6I/nnL
         tMGBDef+/lt7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5CBC43140;
        Fri,  5 Aug 2022 23:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/tester: Add tester_setup_io
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165974041404.27436.7314183844985610360.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 23:00:14 +0000
References: <20220805201034.3838529-1-luiz.dentz@gmail.com>
In-Reply-To: <20220805201034.3838529-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Aug 2022 13:10:33 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds tester_setup_io which can be used to add a PDU list in the
> form of iovec.
> ---
>  src/shared/tester.c | 155 ++++++++++++++++++++++++++++++++++++++++++--
>  src/shared/tester.h |  12 ++++
>  2 files changed, 163 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] shared/tester: Add tester_setup_io
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2dfe29197435
  - [BlueZ,2/2] test-tester: This add tests for tester
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f07b88abfb89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


