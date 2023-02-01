Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8DC636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 01:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBABKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 20:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBABKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 20:10:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BA254239
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 17:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8001B81FDB
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 01:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7253EC433EF;
        Wed,  1 Feb 2023 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675213817;
        bh=h4FnAriTeFeshCr2iPlT/uKwlyR5N8sxgsmICoEjynk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uhANKCdP5tGb4w5PjBQSWn//lmRBYNdNlXsUW8Qp5ijtPY2CAvQeBBigK9Pa3/1Tv
         PQ/MUeghmvEnQ33NWbm0bzHj8Jf63kCdFG3YBpwiTjja9Z7/nHvs5M7vRFeg6GpusZ
         d4VQhYuoKHSbFfvu8rxR5fZw7UNLynXpMdnosE2/wYoWXvYRE+f8q/4Tyg7ydLdD3r
         8SCUiB01xAHc8IlBztlrciC1Xenfw4sJLHq2p7J8tsX+rpPZoZ/2HBa8kC10ASU4ym
         o2WlEKORMxzY6BAblTJOquif78ay91zKTPB1xOeAVmwabtcQ7I7g2MhjXj3rt1bBn1
         hXw1BUUlUit8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 567B3E4D00A;
        Wed,  1 Feb 2023 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] profiles: Add Support for Metadata, CID and VID
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167521381735.32644.5977585726413771767.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Feb 2023 01:10:17 +0000
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Jan 2023 15:56:45 -0800 you wrote:
> From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
> 
> This adds support for Metadata, Company ID and Vendor Codec ID
> ---
>  profiles/audio/bap.c       |   7 ++-
>  profiles/audio/media.c     | 106 +++++++++++++++++++++++++++++++++----
>  profiles/audio/transport.c |   4 +-
>  3 files changed, 105 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] profiles: Add Support for Metadata, CID and VID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17bcd2a37629
  - [BlueZ,2/5] client/player: Add support for Company ID, Vendor ID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=33d99e12c37f
  - [BlueZ,3/5] shared/util: Check arguments on util_memcpy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be5c49385e4d
  - [BlueZ,4/5] media-api: Make Vendor a uint32_t
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d611a40ffc7b
  - [BlueZ,5/5] media: Rework support of Vendor to use uint32_t as type
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


