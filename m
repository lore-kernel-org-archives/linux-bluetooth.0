Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24F7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJGTk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJGTkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 15:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25284BC62F
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 12:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00BDB61DD0
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 19:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C6C3C433D7;
        Fri,  7 Oct 2022 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665171615;
        bh=vT3vqAnmVCmDJ4eT0whsad1jf8cEAnWsjM2dj5fy4Uw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Uu8e85ZrvBHJK+yUnNjFSnzmHpIhMeg0DuKbf304hg1mbp4UM6znUOorQ260IOFcf
         E2VEgoprOasrkAZYp5uYvadjHSwqSmCcBehJU8nBkbVf/eWMzBTpvnBEDIKjTAWndm
         /3EGuaWafVrucwNJKvGMSmSZMS8ASWcVPcgNOW+VMJe/g9SoV5iXhPtV+BIwUahzT6
         +KJHHv7ODSr2h5vyB0WSEIRQ6DCrpfoc5VMj560Qlo9ch6yZNLeJBXYCMD4frDcDyt
         ZadDjt/iTY3cUUTVXJkqqV5IEXrRzPK3L/5NSH3Cm4fDPrc4JQF+8rSBVTmfEAuLnA
         eePpNgN4gQgEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42605E2A05C;
        Fri,  7 Oct 2022 19:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] btusb: Avoid reset of ISOC endpoint alt settings to zero
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166517161526.22886.9789637113576630246.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Oct 2022 19:40:15 +0000
References: <20221003064836.11414-1-kiran.k@intel.com>
In-Reply-To: <20221003064836.11414-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Oct 2022 12:18:36 +0530 you wrote:
> From: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> 
> In case of suspend/resume and HCI_RESET (BT On and Off),
> ISOC endpoint set to alt setting 0 when no SCO connection exists.
> This patch shall avoid resetting of ISOC endpoint to alt setting to 0.
> 
> Signed-off-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] btusb: Avoid reset of ISOC endpoint alt settings to zero
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed9fc1335a21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


