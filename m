Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4AC636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBMWUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMWUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB71ADC9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE186131B
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75145C4339B;
        Mon, 13 Feb 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326817;
        bh=31mUBsKEdwcfk/KRhZJX5J5ieN1YgHAwBXUlpet+Sxs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EOep6/zZdHz3+4t4Xx+Y4PS9IQnT/dUEYNIHiS+gRX8dNDNzNpq5+sMjK111o59tK
         JL3Tg2hw15Zkv2Np2+9SxoMbpTW9yCB9abOiVXVmLj4VDqkB4qSvnkFwso7Jl1J2tr
         uMJz0V+ik0xZGmPLb+g3c0+4jBqnIgfEdl8gXyHRvO/EVZtp0YPhhz6t1oKBcNj/Lg
         y+QWU8ECt/V5/6885kjB/bsLln0VIeoIICX+v/RjEerI0BJizrGbCKfd83XYqVd7xH
         PgsBzGRwFZBkMcGCi+wpNRvy/h3rqq+uAJvYWbdRAybDrMIHdjI8llTb8Dk8BqnCps
         uuZJfX+DzyEzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BF9EE68D39;
        Mon, 13 Feb 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/9] doc: remove unimplemented Quality Report from
 MGMT settings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167632681737.28787.7790111416073990674.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 22:20:17 +0000
References: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Feb 2023 10:53:45 +0000 you wrote:
> The Set Quality Report command was removed in
> commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
> but the settings bit was not removed. It's also not implemented on
> kernel side, so remove it now.
> ---
> 
> Notes:
>     v2: split to two commits
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/9] doc: remove unimplemented Quality Report from MGMT settings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e2e3aa73904
  - [BlueZ,v2,2/9] doc: add MGMT setting for CIS features
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97ad0ecbfdd4
  - [BlueZ,v2,3/9] lib: Add defines for MGMT setting bits for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c35d32b19989
  - [BlueZ,v2,4/9] monitor: add MGMT setting bit names for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f2f7a8fe270
  - [BlueZ,v2,5/9] tools/btmgmt: add MGMT setting bit names for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f131929b832
  - [BlueZ,v2,6/9] adapter: add function for checking adapter features, add CIS features
    (no matching commit)
  - [BlueZ,v2,7/9] media: Check adapter CIS support to add BAP in SupportedUUIDs
    (no matching commit)
  - [BlueZ,v2,8/9] shared/bap: support client-only case
    (no matching commit)
  - [BlueZ,v2,9/9] bap: handle adapters that are not CIS Central / Peripheral capable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


