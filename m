Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AC5EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHUWap (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHUWap (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 18:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98702DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 15:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE630648E5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 22:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5194EC433CD;
        Mon, 21 Aug 2023 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692657032;
        bh=X94Kb2z5IG0Icp/pR6QACqPBHHBD/YJSKCekcjQXyMw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jbeNqy3L/6nxVkVzA6w5W349EMX+4LhFfvR6a7y0kPF6N7N6NqPRitJ3S721cg9Er
         nN8Pzm9bXVGZjnncwtNv6BPeGMAvb8RV/d0hcrWtbArdRCwlNX0gM8sigXaXVTBCHb
         n+VMYpGDED5FhSR41fJTwA7BrRA3/4dO/0MJpI1cfT/esm+itU1e0vxtCnxt9iBuVM
         SKcxCjU2gtarFqxLDathsbQCBYTA5szOdOk9m/0GZTVbwhNs/wmjcVNNEDCqKhhEMz
         d86+6dpMTNdW1xXtSlpkVPuZLAsxXatwoiwfuQ7bsmASf4llzIt9soTZwwndGC7Hrs
         cIDJ8fPZW7FgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37B26C3274B;
        Mon, 21 Aug 2023 22:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] monitor/intel: Add decoding of PPAG Enable command
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169265703222.7836.5665665418365368088.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 22:30:32 +0000
References: <20230818044542.532700-1-lokendra.singh@intel.com>
In-Reply-To: <20230818044542.532700-1-lokendra.singh@intel.com>
To:     Lokendra Singh <lokendra.singh@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, luiz.von.dentz@intel.com,
        tedd.an@intel.com, kiran.k@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Aug 2023 10:15:43 +0530 you wrote:
> Add decoding support for Intel PPAG Enable
> command.
> 
> btmon log:
> < HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
>         Enable: 0x00000002 (China)
> > HCI Event: Command Complete (0x0e) plen 4
>       Intel PPAG Enable (0x3f|0x020b) ncmd 1
>         Status: Success (0x00)
> 
> [...]

Here is the summary with links:
  - [v2] monitor/intel: Add decoding of PPAG Enable command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c01cf4552c12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


