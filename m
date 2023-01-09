Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C148C54EBE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Jan 2023 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjAIXkb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjAIXkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Jan 2023 18:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F74FDD
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 15:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5FC6148C
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E9D2C433F0;
        Mon,  9 Jan 2023 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673307616;
        bh=z7BZ3XZdONNHPMEtDBEEOXisJDfe+4V3hPKwypELc+w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y8WoagtK99OFK4+PASeHsgHx6fj+C/1nETEbb6GTTtijb1rPikyT2cjK4GTPEeJ2J
         TsCb60/j6asjXFcibuDGiqhmEH/eaEaIe9z4KAKtbomSMRKqtMx/IfC80x+4NxfdXb
         ArKPIT2SuTcSqG/1EKMoItSBqfYuTI3eNpm/8F2LsW+CGTbbMNCMkryMbsHy+QUPgb
         qjnMAlbMODIRzRlqPu9Ur9fOKhYgRDf4Wg3AsZYg0mROJ6yrSVy5NCdQlpeeeyPssm
         ZGfNd7opxeF8p95kgPKGZVeTqYyt0u3Nz5+3dgrg2hhh3xifPt7ZwYA9XqrKDi1Nyk
         76yPywkuJycSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75254E21EE6;
        Mon,  9 Jan 2023 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: fix memory leak in
 hci_update_adv_data()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167330761647.32176.3234485994949407027.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Jan 2023 23:40:16 +0000
References: <20230109212237.3209300-1-luiz.dentz@gmail.com>
In-Reply-To: <20230109212237.3209300-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Jan 2023 13:22:37 -0800 you wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> When hci_cmd_sync_queue() failed in hci_update_adv_data(), inst_ptr is
> not freed, which will cause memory leak, convert to use ERR_PTR/PTR_ERR
> to pass the instance to callback so no memory needs to be allocated.
> 
> Fixes: 651cd3d65b0f ("Bluetooth: convert hci_update_adv_data to hci_sync")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8b5fd71713b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


