Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKOTkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiKOTkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 14:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0BFD3E
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 11:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4903B81A1C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62A52C433D7;
        Tue, 15 Nov 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668541216;
        bh=wuuwJupNcYcCtewKsd59dn4NCHN/MkVjSnsCsxZY430=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JNmuUgkHCx8PcoAGz63/nF5DtmOas9Uci02kUkx3z1m0GVBDsnGz98uh9lhD2bwog
         XReSLY1W0J9LWrm64sE+ZfpaZ9R42ghaXKORDuu9vpiHM4A3Crti+4ttuaYB4YXajf
         xYb/0suPaeie8Ol+7siTPAESRkF3GQtYRXpn5CG66Zh73zFion1EyAMOOdjNkCGkrk
         mN5Ke8yzcXtaVAJfYPjurnNGLcYRlZZjVq+uk9w7GzgwpwULLPhdMGBb1neZ21NsFB
         D61cn9MTb3KSE061u5E6+43X0hgrNWRWpC8dq1Z4vj8T9pfi3FTX0wKv3MiWvIIY+U
         lcS5b/ciR734Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47A0DC395F5;
        Tue, 15 Nov 2022 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/6] monitor/att: Fix not dequeing att_read on error
 response
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166854121628.14574.15934497067014079627.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Nov 2022 19:40:16 +0000
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Nov 2022 16:30:33 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If a read/read by type fails it needs to be dequeued otherwise it can
> cause the next operation of the same type to return the wrong request
> and possible decoding as if it was a different attribute type.
> ---
>  monitor/att.c | 109 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 58 insertions(+), 51 deletions(-)

Here is the summary with links:
  - [BlueZ,1/6] monitor/att: Fix not dequeing att_read on error response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b3a8f8fea99b
  - [BlueZ,2/6] shared/util: Add iovec helpers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c2e276d9e7c
  - [BlueZ,3/6] shared/bap: Make use of util_iov helpers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f96bccd80979
  - [BlueZ,4/6] shared/tester: Add tester_io_set_complete_func
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=918c73acb778
  - [BlueZ,5/6] shared/bap: Fix crash when canceling requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7fcd6889fb13
  - [BlueZ,6/6] unit: Introduce test-bap
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ebbfee34517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


