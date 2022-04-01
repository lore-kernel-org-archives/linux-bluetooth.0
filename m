Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450E1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiDARcF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbiDARcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9E1A9488
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 10:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4563B82592
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 17:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E6E0C340EC;
        Fri,  1 Apr 2022 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834212;
        bh=8ExYeFAIpiUlehHEsPjzfGmsJoxl3gqgsbk9Pz9Zz0E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FCaWbxWSVne1L0snwjbFukWUmLxzjqs93GuuJOXKpWdZ0eEcx7OeV48fGsr4AB/Dz
         VAtMryX4/RCSTDW9GkEOx0/IzlfA6dMJUpudadFOOEvMvNhiKFtHJR0lQCdAQcKNcq
         WbonSxleHFAG7SUTmiAyN7J1DEBobvmuvE3iGf0oOMVQP+/vLoBIwIS76UJx4tw4n2
         TwnmJ/QWfcKE7Gdis/DPdE2J/abAwi4+5tNt7Cq3hT9sDIfvOhZ+Ch5Bu1h7GkiHrX
         COSCGIxjLNR9tBcygE1SeCrmgVPWWZSKsrDjxyXhLf5AqyJ3UZydJYSyf8uIRvapzM
         1jo32ewevJ6qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E8B0E6BBCA;
        Fri,  1 Apr 2022 17:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Add Mesh functionality to net/bluetooth
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164883421225.6587.11737123964714497714.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Apr 2022 17:30:12 +0000
References: <20220331180749.456913-1-brian.gix@intel.com>
In-Reply-To: <20220331180749.456913-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 31 Mar 2022 11:07:46 -0700 you wrote:
> Housekeeping and implementation.
> 
> Brian Gix (3):
>   Bluetooth: Keep MGMT pending queue ordered FIFO
>   Bluetooth: Implement support for Mesh
>   Bluetooth: Add experimental wrapper for MGMT based mesh
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: Keep MGMT pending queue ordered FIFO
    https://git.kernel.org/bluetooth/bluetooth-next/c/2598fe7291d8
  - [2/3] Bluetooth: Implement support for Mesh
    (no matching commit)
  - [3/3] Bluetooth: Add experimental wrapper for MGMT based mesh
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


