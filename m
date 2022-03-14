Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD93C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbiCNPbX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiCNPbX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65C1AF19
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 08:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FCA61243
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59295C340EC;
        Mon, 14 Mar 2022 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647271810;
        bh=Y4M/wjx6qhvgG+4LqxzOFmAjUQ8KSsGP40KibZp7W4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LOZ8Zz7i1Tw+wUrU3T90Zn3x0QUeNS0J89OH3/OqhA4j3fdZutubodbbJ18Gk56BV
         iBfLYvlsuigzudaX40/cOabqw5xzzYzLeJGZy3ZbGUStxnPXrpkiYCqI1Og9djoQSe
         qcoNzNGCBwBVqsEvB+RUn0yM31FZYac15mjXpSOHWtKNY2l+gP3tzAr7wegSY8706T
         R4EQ4MkewUDVU9P3zZP3fuh6QLdXEWPpHl81rz3LxvOya81G0o9CkEFCio4oau3Ys6
         DorYBivm41jMwWgtlyKevOd7sykduZhNNVpZqLbPHrpC2DZizoeY695BO/G4D6Xz3J
         Ur5BZEz3+wViA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38E17E6D3DE;
        Mon, 14 Mar 2022 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix use after free in hci_send_acl
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164727181022.21893.9899108200506354783.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Mar 2022 15:30:10 +0000
References: <20220311211933.3285806-1-luiz.dentz@gmail.com>
In-Reply-To: <20220311211933.3285806-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri, 11 Mar 2022 13:19:33 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace caused by receiving
> HCI_EV_DISCONN_PHY_LINK_COMPLETE which does call hci_conn_del without
> first checking if conn->type is in fact AMP_LINK and in case it is
> do properly cleanup upper layers with hci_disconn_cfm:
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix use after free in hci_send_acl
    https://git.kernel.org/bluetooth/bluetooth-next/c/db0309dd3768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


