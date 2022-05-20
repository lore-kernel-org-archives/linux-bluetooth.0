Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353545AbiETVAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353540AbiETVAQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 17:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916D199B05
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6438061CB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 21:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8667C34115;
        Fri, 20 May 2022 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653080413;
        bh=89AwmOzLl3xTo3U6f3p3zYumzYFNl/MVXCJurb9Ufyo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pqDRASV5PegEzAjTuHPaQK8rF7PuiaXvjqR9Vc+g297Q1fiye2MVOPK73+5uDpEs/
         qnJ0VYaLM7ESaD7vNMzqM/Ve8Cw5n2wBEH7040U/kLBt2B4EQ56007ZkPWLZ2XLD+d
         oy7FuzPL8UQiryeo+Sk0uFpB2nAcM9gx+H0sq3rFEPF6cayW+ixnonTaRloXwXwA+a
         sAmvDTqFq85r4ea18sBNu5Na97CrvocJTrJWrCtCJ20LjlXhKOVnl3IAbnhLqVnOx/
         aj8LwDScbG8hS34HKcLqvYSeYaqya0Mj5XRJ0o8KEWZP/ie3maRw7u6mI77nDgbs6s
         ZOg86i9P4KLFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7AC7F03937;
        Fri, 20 May 2022 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/7] settings: Add btd_settings_gatt_db_{store,load}
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165308041367.20930.14936567529599341042.git-patchwork-notify@kernel.org>
Date:   Fri, 20 May 2022 21:00:13 +0000
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 May 2022 21:16:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds helper functions to store and load from/to file so they can
> get reused by the likes of gatt-database.c and btmon.
> ---
>  Makefile.am    |   3 +-
>  src/device.c   | 499 ++---------------------------------------------
>  src/settings.c | 510 +++++++++++++++++++++++++++++++++++++++++++++++++
>  src/settings.h |  11 ++
>  4 files changed, 534 insertions(+), 489 deletions(-)
>  create mode 100644 src/settings.c
>  create mode 100644 src/settings.h

Here is the summary with links:
  - [v2,1/7] settings: Add btd_settings_gatt_db_{store,load}
    (no matching commit)
  - [v2,2/7] gatt: Store local GATT database
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f66673878a9f
  - [v2,3/7] monitor: Move print_hex_field to display.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0247ed333ea9
  - [v2,4/7] monitor: Move ATT decoding function into its own file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5efc737f49d4
  - [v2,5/7] monitor: Cache connection information
    (no matching commit)
  - [v2,6/7] monitor/att: Decode attribute type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0bd5350459c3
  - [v2,7/7] monitor/att: Add decoding support for CCC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


