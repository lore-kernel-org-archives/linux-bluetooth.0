Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B0C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 05:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCPFkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 01:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4455A1B1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 22:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5FD61F24
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 05:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AAC4C433EF;
        Thu, 16 Mar 2023 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678945218;
        bh=3iaULba7j1eaUamCtz5rnGf6PwbjSXGFksUqJhF2gQM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L3+4aC7zSB2Wj9GZRP4QIC0KSyHf/dhIQyfPlAroZLKOI20n9qBL/1qMDkv5dK2Ur
         spxScXzQQMKanFDsIvjVT+Za4ujFZUwfeGNL1hzHj9aEqDWmobixENk7oT2ITAhvO4
         xcjLmZ25peyzhMx+zooAXaeS6BFsmDu+wP0J1KRHe7TFDU+NY6YbzFHSijAIdrt3bg
         SS+fOhTeRN5N8DqcaT4nQsNz0dSu5k3ivr3C2QCRrUR9bViKSkn4mPLGIGW9dN2NHs
         XuaRHhvmRvpK8sJAchzZSFV7OJATLCaF5DJP0JIfbM2kZFLl74i4ECjfdkJt8+zzvi
         6Z9DQS4swKvWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEC7CE66CBF;
        Thu, 16 Mar 2023 05:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] mesh: Filter originated Provisioning Data
 packets
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167894521790.26854.12733815964151398643.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Mar 2023 05:40:17 +0000
References: <20230316011627.27322-1-brian.gix@gmail.com>
In-Reply-To: <20230316011627.27322-1-brian.gix@gmail.com>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Wed, 15 Mar 2023 18:16:25 -0700 you wrote:
> The mesh daemon can process incoming mesh packets on more than one
> controller, but if a Provisioning data packet that originated from the
> local daemon is received by a different controller, it must be filtered
> and disregarded, or it will break the provisioning protocol.
> ---
>  mesh/mesh-io-mgmt.c | 58 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/3] mesh: Filter originated Provisioning Data packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a5998b588c86
  - [BlueZ,v2,2/3] mesh: Make MGMT mesh-io less noisy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1f7aed635f3
  - [BlueZ,v2,3/3] mesh: Don't send Prov Failed on non-existant links
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=806230e4fda7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


