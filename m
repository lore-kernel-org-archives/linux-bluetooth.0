Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2305C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAMXA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAMXAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 18:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370687F9E4
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 15:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92E52B82273
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09F06C433F0;
        Fri, 13 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673650818;
        bh=nIdnpw3CTcMRX2Pml1FI+KJ7nXGiUXoCO9DP3eiJzY8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=opBSHIJWwaxWmfLU3HBNwEHv2E1sFobdgtwgM2h98/MluBY8LDpwHwprz38pagzBP
         r6Cjg1y5OCLxqeNNA6RBGpJClVq9lArpMxleKMoxI9vTj+CvXtRFALhGp0Qh1Z5tsW
         jvCQGzMjkEZTRsPJkvgsdV21HfCqcoOfSziUCKm2OxNLmvsTTCHR5hVjE72afe5W43
         lAIeViZbqD+pCWEHbzZflp08PVvSbiIQebwpTaaWUxkSH+sYaD8NLAXv5KkHmVa4TA
         q9s0S2uz3BB+1Fh/HbW1vyAovKFLuPtVTdidxqGMG2bl1olULzKE4JelitCdsKS/Es
         KNjsKA41dWcgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9CCBC395C7;
        Fri, 13 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Fix scan-build warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167365081788.3016.12507705711206789012.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 23:00:17 +0000
References: <20230113211638.303409-1-luiz.dentz@gmail.com>
In-Reply-To: <20230113211638.303409-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Jan 2023 13:16:38 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning:
> 
> src/shared/bap.c:2268:26: warning: Access to field 'iov_len' results in
> a dereference of a null pointer (loaded from variable 'cont')
>         return iov_append(data, cont->iov_len, cont->iov_base);
> 	                                ^~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: Fix scan-build warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f8b3544b95e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


