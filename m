Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89332C77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNVaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNVaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABD5BB8
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 14:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1917664A7C
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60AF6C4339B;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681507818;
        bh=w1bCwHem077sBSGNygws2N49BGNdGSGGBtFYfoezeII=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iOkmDTeoyJk5zX05T728y5O2pCis2f8z5I3XFBkwDnCZp1BmehpImWS5IPyc2ynYj
         IQn3a9RcMrvkK9kEQAEuEWgd17GQS0R5+Jr84X+9FlQyjeYvOoZhmKooBcwo6bp87c
         lIhhFnAT/kJZAP1ExsLYXIbuU2zgOAoe9SSKNKtkUWFwcgESlHpLeeSYPVc9nHZRcI
         q8dHN5tsk3lk2+NsycSpq6xe0j5+4vLFOK7ZtRSvyeWoLa/6O26CXyabshA8ChRAr/
         wNK2okHXlkB9t/NOsjTXH4viF4bGQyDoMC0oz3FUQkqnGwiUZWZGBSa3B6DrT6YjqK
         0nwd0zRaojYIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4036BE52446;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add new quirk for broken set random RPA timeout
 for ATS2851
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150781825.20001.4973139468540739153.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 21:30:18 +0000
References: <20230323134539.3957410-1-raul.cheleguini@gmail.com>
In-Reply-To: <20230323134539.3957410-1-raul.cheleguini@gmail.com>
To:     Raul Cheleguini <raul.cheleguini@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, wzj9912@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Mar 2023 10:45:39 -0300 you wrote:
> The ATS2851 based controller advertises support for command "LE Set Random
> Private Address Timeout" but does not actually implement it, impeding the
> controller initialization.
> 
> Add the quirk HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT to unblock the controller
> initialization.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851
    https://git.kernel.org/bluetooth/bluetooth-next/c/cbddddcbd7d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


