Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B94C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 21:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjC0VUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC0VUX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 17:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210D1737
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 14:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72F56131C
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 21:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D4E7C433A0;
        Mon, 27 Mar 2023 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679952018;
        bh=IqnNRsyB20m+4Yt5G1otvie4KdRLm1gAMc72QPkHBs0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I3oT5DxkLMseu1RmgbuLr3d54cIvJk9/TvBOh/pVjXFWSiDPCTFkkIQBSccYoe68J
         ejfQV5ZPl4529ELjU+XbctcMgRT3x0ocuYvcoIvtgENyAXFcm3EnMoUv2rpaOGOQhz
         Ir/t+CQy+xHEs3Rz1FX2pBU50eq1CAkwdyO/e6Z/6I44DsFEnLdodU/rf9xhW0yW19
         Zoo6Bswjp9ciVtnLfvrJ/PHdeR6VahuCKq6DZ9EVmmcg1GWXV0pqTg11tpQds2+vUB
         smLgbN9pgKXS9ViByQ7ZPcEHOudv57Vy93KIsIL4qrPDkQ6At0TiX+wYAcH/X15Vc8
         eSaIvSi+cCNTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 369ECC41612;
        Mon, 27 Mar 2023 21:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] shared/gatt-db: Make gatt_db_attribute_get_value
 public
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167995201821.593.16909761387613996594.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 21:20:18 +0000
References: <20230324233856.3693370-1-luiz.dentz@gmail.com>
In-Reply-To: <20230324233856.3693370-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Mar 2023 16:38:53 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes gatt_db_attribute_get_value public so it can be used by the
> likes of btmon.
> ---
>  src/shared/gatt-db.c | 12 ++++++------
>  src/shared/gatt-db.h |  2 ++
>  2 files changed, 8 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,1/4] shared/gatt-db: Make gatt_db_attribute_get_value public
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7610b9264147
  - [BlueZ,2/4] monitor/att: Print value when printing descriptors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cf7242815668
  - [BlueZ,3/4] monitor/att: Fix not loading gatt_db for devices using RPA
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2719bb5aaf6d
  - [BlueZ,4/4] monitor: Cache IRK being parsed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=011e562a98a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


