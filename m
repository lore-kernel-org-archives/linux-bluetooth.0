Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E3C04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 13:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiI1NuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiI1NuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 09:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A23204E
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 06:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73E9AB820D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C98C433D6;
        Wed, 28 Sep 2022 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664373015;
        bh=Kry0yrJyPYTS8EeSxna7eujlQMtmlORtxR4QFXt1PHg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iQj560Qm90GK9P3mTlTbqC/j90oE45j/KvP44HFABCVdoRoPDQcXodM9wldgm4M7W
         HLV3TmdQfwMoCDcv3utL7FQkTxPdKFgUrCFjyDMYBXYENhRHlQ4PPjQeQTopZM5A8s
         VbUiXlWXBaH4W0paR9/gwODLMYqh76+byMSg9Fd47QUnivrZF+rzXmRgFaQUsB+NAb
         QNF8jxbrrpmDPBMAYL8/dm6c+2pjL3xT7pm/3hYfq8bGPHaYghCgvGuYTFZZB0165w
         bX5XtLQ1vtYnXnbmfmqWHS7SXd5b4/PiKObYwTRuxP8u0Na5PlJVlSFCa5u5Vsi9KG
         Dh/aIIfBydMag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 051A7E21EC6;
        Wed, 28 Sep 2022 13:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166437301501.12437.14525618290524762203.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Sep 2022 13:50:15 +0000
References: <20220927225514.278400-1-brian.gix@intel.com>
In-Reply-To: <20220927225514.278400-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com,
        tedd.an@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Tue, 27 Sep 2022 15:55:14 -0700 you wrote:
> Tester was failing by not clearing the HCI queue of expected events
> ---
>  tools/mesh-tester.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Here is the summary with links:
  - [BlueZ] tools: Fix mesh-tester to expect end of ADV
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3b47cf5db9a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


