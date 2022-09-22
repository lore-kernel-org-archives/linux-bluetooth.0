Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DEC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIVVUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiIVVUU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10886857E6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD8B619A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 21:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02ACBC433D7;
        Thu, 22 Sep 2022 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663881616;
        bh=Xrleq01zQ/lJQL2zbaJRQUNDvG8q3JHtsxW76YzfNAI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vO/TfLqU07LtnrDPyQISzo6vb5ZWA8mLm1OJvu+Ysfxdd+pd6JbwoeEe0uQUFUl8z
         g1lZpaAhUlyypPKEI477Rdc7+ob+O+X5z5wc4gSueoU+biESUIdOg6vyWBu0BFQZKh
         w8PRFEVbfQ3zEtyHSf0esdovwjxHgbwjnLk9nVaeDZ6QAzsBhzBECoULbCb1VNwvvD
         wfbpB2UiYjKb5LxiEmRbbS/7jVyqOf8zBDEnQCBITT70l0mxyUum+jNvyi2Z3/1iF8
         r4AO3p1nVPZbNJ5UBuVsGLanvGBL17YaGcgiNohC6g1Vnop853WYJnyFHY8M+Esqwq
         kNkEpIHEB5/Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC5A3E4D03E;
        Thu, 22 Sep 2022 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Mesh demon switched to using kernel Mesh MGMT
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166388161589.29143.11388511112936355434.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 21:20:15 +0000
References: <20220922203852.494315-1-brian.gix@intel.com>
In-Reply-To: <20220922203852.494315-1-brian.gix@intel.com>
To:     Gix@ci.codeaurora.org, Brian <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        inga.stotland@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Thu, 22 Sep 2022 13:38:48 -0700 you wrote:
> This patchset enables the mesh daemon (bluetooth-meshd) to use the new
> MGMT mesh opcodes and events to send and receive Mesh packets. By
> default, the daemon attempts to enable the experimental mesh
> functionality, and query the kernel for active mesh support before then
> enumerating the available controllers and selecting ojne that works.
> 
> If no kernel support is found, it will continue to use a raw HCI socket
> for mesh support.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] mgmt: Add support for Mesh in the kernel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0454e2d09570
  - [BlueZ,2/4] lib: Add defines of new MGMT opcodes and events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=721d5a8ae86d
  - [BlueZ,3/4] mesh: Improve PB-ADV timing for reliability
    (no matching commit)
  - [BlueZ,4/4] mesh: Add new kernel MGMT based IO transport
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


