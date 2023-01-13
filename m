Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C683C6379F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 23:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAMXA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjAMXAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 18:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC97EC9C
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 15:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81D03B82271
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED812C433EF;
        Fri, 13 Jan 2023 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673650818;
        bh=KYOdZXFj166WtImSAJ/jkSXhmWf1qj+EM6a1kLVFemQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SnILdAelFrz8RMQSh0qSc9/qgmpbkNeKZufR31B0wP2zl9xDmzwtxPls8UExSf6nd
         DWUhzBZr4rzeyh67sFbNudzOWdVhuekW+6WjU8Iqz+ncIFJlFWkvk/RekH0VygRWnD
         /7cpJ73kVsc8CsWBX/amTAIGKpdzHYFcb/gfGZgCgZzpsyWl4aZdDMChMwor0Ayc/6
         IKafDwQldhLLBOT91AMAnD7qH6AjM0I/kohSDFGPK7zqP4Ri9YI08ufEBYeT7emAb1
         wvytcH6IK8mfPkLIkVc6Owt4bjuQpKKdHHm1KFLBMvQ3jRSPzwcOMMD2v3gNPooXO+
         X1o00N5t9HPLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3B48E21EE0;
        Fri, 13 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] shared/bap: Fixing Company ID,
 Vendor ID and Metadata handling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167365081786.3016.15296410621836946683.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 23:00:17 +0000
References: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, mabhay125@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Jan 2023 10:36:05 +0530 you wrote:
> This fixes Company ID, Vendor Codec ID and metadata storing
> PAC record.
> ---
>  src/shared/bap.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v3] shared/bap: Fixing Company ID, Vendor ID and Metadata handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fd893fdd814e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


