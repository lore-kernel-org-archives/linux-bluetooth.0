Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJFVAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJFVAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 17:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF369DF96
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 14:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB616B82191
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D3F3C4347C;
        Thu,  6 Oct 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665090017;
        bh=xUvXEpBsGA7u+IgRkxWUwFVYf/5iRl+5/XKIZRUGyxM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M3rd7iJdpc/3c2liQb8DUWPU1wrzUhR6tfaHxGxr925JRWOg0pY/JRO4XqMeZS8U2
         sqKSd9a+ej7zGDmGTOGf1gQzOw9DGu8g9RK04r+VDjcbUFMtufBvWdCzQZVmLjy/aa
         kzW/RZZ7WFVFl818osk0w2MmH6iYWRuGJP5KJd1vOrbC5YGXzs9AFsJs7l1TlTlNdK
         e6NMx5YRbutNQeicbFrnJgudDSUFCgUWdQsGt5ll3UL3e9IUg3nSfzlV9qhYLtyjrp
         n4MKfoXAiVU/BTO8Lmp0B41X4eKO8ZDOGdLopW3s6W8etMyPv3C4mAA0bH92YGNLGX
         rVGs2KI4DO3/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A907E2A05F;
        Thu,  6 Oct 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] Mesh: Fixes for PTS issues
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166509001730.28080.8515403605941820291.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 21:00:17 +0000
References: <20221006145927.32731-1-isak.westin@loytec.com>
In-Reply-To: <20221006145927.32731-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Thu,  6 Oct 2022 16:59:21 +0200 you wrote:
> Hi,
> 
> Here is the last patch set with fixes for issues found during PTS
> testing. This covers following tests:
>  - MESH/NODE/PROV/*
>  - MESH/NODE/TNPT/*
>  - MESH/NODE/RLY/*
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] mesh: Update Key Refresh flag after provision
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95bf980b015e
  - [BlueZ,2/6] mesh: provisionee: Handle unknown PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1f1a49aeb15
  - [BlueZ,3/6] mesh: provisionee: Handle failed provisioning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=77da94eb7a8c
  - [BlueZ,4/6] mesh: provisionee: Check prov start parameters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=838ddc931263
  - [BlueZ,5/6] mesh: Keep canceled SAR data for at least 10 sec
    (no matching commit)
  - [BlueZ,6/6] mesh: Fix msg cache ring buffer
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


