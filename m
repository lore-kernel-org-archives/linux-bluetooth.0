Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiDSADB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiDSAC4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F24E09A
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ECBEB81135
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40E9DC385AE;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326412;
        bh=734g4I4K1Lrrcr/smuZCTuYTdzsORaRuHef8Az4rtWg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X0N25GerDLc/AMVHDYjVz8pcxkXrQwbO+7wQtDFp0kOXX4ouXBkeBLYJvER9uX4Z8
         64uQYqIWwBK2EoKpia9ClOC8ZVLuu/zsKaIYk0HxAMuR8xabtgqm+CkpM4xufkAYD9
         CFroefbB2tEn2Y0t72tl7HSzTG+1uAknF9eRbQmCqxc2eaitZO2wgR1Dhyh3rWS9Ko
         M0QjVjKQRwmJ1Jq+shFViG8hI/ibOHYj4oPpR+mAetrUFAo3YzY/IAad51AIKPZdf2
         Wo3c2JyWqRKsmz3d6ZdoeHcG8qewJbnTVdIS1+iUW0h41dNG1Fe5XskTR9mriL04pz
         nk249JXPKBfIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21975F03848;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 BlueZ 1/2] client/player: Add endpoint menu
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165032641213.24068.6111682855390773008.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 00:00:12 +0000
References: <20220413211630.171843-1-luiz.dentz@gmail.com>
In-Reply-To: <20220413211630.171843-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Apr 2022 14:16:29 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds endpoint menu:
> 
> [bluetooth]# menu endpoint
> Menu endpoint:
> Available commands:
> 
> [...]

Here is the summary with links:
  - [v2,BlueZ,1/2] client/player: Add endpoint menu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46f171a86c17
  - [v2,BlueZ,2/2] client/player: Add transport menu
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


