Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E7C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiG2AKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG2AKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E88DEB0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5E661D0B
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0EA5C4347C;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659053414;
        bh=VvMyffPD3Wk5WYD9sohZCxnEoge+plne1gJERpe7fuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hYKQozeC/X24IY8dZH48uEqXi5nG8xXzQQSiGQR1OE/C8e/gLj/VrCX8QaG1Vy8G4
         V0GqLHButaLMqE1kVUPyAMoPTR7Q+ApbuHnfMiYoPMfLAZQ0Egs6tqQHKMwPxzfTZi
         Xp859VBsAWJLxL4hcU7gTRaDF67h9RSeG/nbY1qSn46YRe4EggVzKnwC8qm2/+dus8
         QCo5vfZHTeYxScqX5sUJSWNTEFwUIppzm38EkbQIpiVc3kXQjCvQcDbOEYx+yutXbT
         7HHZ8hKbEXjqryzXE4WYL2lIhsS5USq7RfM+b4DHFLvuwc3wCn1S0zoykpp8XaoGsJ
         Qu+i6DM8+ixeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8194C43143;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix null pointer deref on unexpected status event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165905341474.26440.12900245976401138748.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 00:10:14 +0000
References: <20220722115307.243056-1-soenke.huster@eknoes.de>
In-Reply-To: <20220722115307.243056-1-soenke.huster@eknoes.de>
To:     Soenke Huster <soenke.huster@eknoes.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 Jul 2022 13:53:07 +0200 you wrote:
> __hci_cmd_sync returns NULL if the controller responds with a status
> event. This is unexpected for the commands sent here, but on
> occurrence leads to null pointer dereferences and thus must be
> handled.
> 
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix null pointer deref on unexpected status event
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa7c99c75eea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


