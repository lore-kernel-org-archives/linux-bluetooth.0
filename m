Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E91C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 15:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354695AbiCPPl2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348907AbiCPPl1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 11:41:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD274AE15
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0552EB81C17
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAC65C340F0;
        Wed, 16 Mar 2022 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647445210;
        bh=giNVwsZZkAoJvfFKgYXXYGqfH/9jALxusLjdP7i5fOY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tc3GjVj4FxawKgExogY/+8l02v3zA++7T60oKQJqHbKsQuRoQHM3Sm5EbbDr7R31+
         kTurFtvYfYG6rVQoE1Ee4uwOW3rgxFy052m4RThVx/HWaEhGppAE+SXJwefaB6+Yo4
         1VyDcIrxlhhYhNSFfzJ+GpjxgHxGYF1JyHgBrprTjHNJ4XjcvsHG8zzb7o33ADaEvt
         BtTlSw05nspTnmqbnXTifrGXZdJQyD9UEHm6ijZIQsRDadfoHP/0ngMMaE9W5FlxTh
         PzlsZsppqzd+PSMCmNTFO+vGUma+aO1Tp2nf+4F06+gyDRoY/GmVFwT3zedgTdr3i4
         fcrcboesqeVWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFB58E6BBCA;
        Wed, 16 Mar 2022 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: call hci_le_conn_failed with hdev lock in
 hci_le_conn_failed
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164744521071.701.7551558981084729943.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Mar 2022 15:40:10 +0000
References: <20220316153350.10047-1-dossche.niels@gmail.com>
In-Reply-To: <20220316153350.10047-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Wed, 16 Mar 2022 16:33:50 +0100 you wrote:
> hci_le_conn_failed function's documentation says that the caller must
> hold hdev->lock. The only callsite that does not hold that lock is
> hci_le_conn_failed. The other 3 callsites hold the hdev->lock very
> locally. The solution is to hold the lock during the call to
> hci_le_conn_failed.
> 
> Fixes: 3c857757ef6e ("Bluetooth: Add directed advertising support through connect()")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: call hci_le_conn_failed with hdev lock in hci_le_conn_failed
    https://git.kernel.org/bluetooth/bluetooth-next/c/7c686a32a512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


