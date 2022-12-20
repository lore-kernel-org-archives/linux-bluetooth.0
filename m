Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54136C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 23:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLTXkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiLTXkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 18:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A71FF9C
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 15:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8477B81A7A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 890EDC43392;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671579616;
        bh=HpSxLfCCrLzPdqB/fed+2RHNxB/V/50TsgREOYXcgNU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=doy3gliUFGg/4mSKDoPDnj2/y4U/IJeNSmSS48xvdUM9kDjCpVoRu3nROl6hu5vN+
         wrxk4meQIGQUXzdf+R/JBSMM8XBok5gqH1CKIWx+r2Kxn7n0kpHBwk/bm5ZwSSto+p
         n53hMbGjZYDlugUu5dZn0VmBV4+aMKQY5tTRp6m/nJuDzyepTCxbgYEUDjK/9KCMVD
         U+YbYwWxZ1jLSuIN7mx87C1cXh16J7UE9up+shAKH71EXe/gInV0cp+Qpm9Xa8YNYi
         fWYWOLdxFMjA0Omz0fiWqjIVPJWIUbTcaxOU3R+Ur1AkrDFlMhEFPYgFuSkkStHBbJ
         1vVcYtJvDJO0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70D19C74000;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7] Csip - Client role
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167157961645.23834.1557847362050814425.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Dec 2022 23:40:16 +0000
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
In-Reply-To: <20221122101232.45320-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Nov 2022 15:42:25 +0530 you wrote:
> This version of patch updated with
> 1. Added btmon decoded log in commit message
> 2. Fixed few of scan warnings
> 
> Sathish Narasimman (7):
>   shared/util: Update UUID database for Csip services
>   lib/uuid: Add CSIS UUIDs
>   main.conf: Add CSIP profile configurable options
>   shared/csip: Add initial code for handling CSIP
>   profiles: Add initial code for csip plugin
>   monitor/att: Add decoding support for CSIP
>   tools: Add support to generate RSI using SIRK
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] shared/util: Update UUID database for Csip services
    (no matching commit)
  - [BlueZ,v3,2/7] lib/uuid: Add CSIS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b709058c6008
  - [BlueZ,v3,3/7] main.conf: Add CSIP profile configurable options
    (no matching commit)
  - [BlueZ,v3,4/7] shared/csip: Add initial code for handling CSIP
    (no matching commit)
  - [BlueZ,v3,5/7] profiles: Add initial code for csip plugin
    (no matching commit)
  - [BlueZ,v3,6/7] monitor/att: Add decoding support for CSIP
    (no matching commit)
  - [BlueZ,v3,7/7] tools: Add support to generate RSI using SIRK
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


