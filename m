Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGPK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJGPKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 11:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905C62A85
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD016B82390
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 15:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 746AEC43142;
        Fri,  7 Oct 2022 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665155415;
        bh=QdQI01W3OqOsin2O2A2BUUm1NvOrhBroBVJ8BWt5huo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fu41G+VXZU8icFdIkCi8qbALTKu+W1KwwlTsYqCvIsVj4fJKUUg/FInOJhuMR968E
         I9cmixpG1UAGeA+SAU2ZLs0JzbF9egelwZ+JIfKXy4aJzgLjh3zmJYC1lxtQQAyh0m
         ER+p/E2+v5P4BtqUZarPC1yGraQLcLk7+ApVl3kAG0u2tGXr0bkBcsSp1i0irtR5CE
         T16dZUbMvYzgezvgJU9zdX5PTeEbmxVrsJXFM/WzuEOQC4uarEtMJRS+gI0VZ6yAz8
         uOBC7qRIt5lTvb6LNbkKYEKQsfMAKGa4fbl3DeU2fayA1I6q14kYuPundGW/6cwp7H
         IKqJAWd/BOSrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58DA0E43EFE;
        Fri,  7 Oct 2022 15:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] Mesh: Fixes for PTS issues
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166515541536.23839.11183936309410126652.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Oct 2022 15:10:15 +0000
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
    (no matching commit)
  - [BlueZ,2/6] mesh: provisionee: Handle unknown PDUs
    (no matching commit)
  - [BlueZ,3/6] mesh: provisionee: Handle failed provisioning
    (no matching commit)
  - [BlueZ,4/6] mesh: provisionee: Check prov start parameters
    (no matching commit)
  - [BlueZ,5/6] mesh: Keep canceled SAR data for at least 10 sec
    (no matching commit)
  - [BlueZ,6/6] mesh: Fix msg cache ring buffer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dabf32b313c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


