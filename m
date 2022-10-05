Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJEVAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJEVAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 17:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4080EB9
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 14:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC33B616F4
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F24FC433C1;
        Wed,  5 Oct 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665003616;
        bh=yrXWMLwEy7dgFzxLx1CfybWZCtDvtDY/EXNo+T55ebc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eHa67jvzNv5yE81oRpIqnA49NsQKMOIIfm612AB8p/ibbDIn+Qb4c8r9M5QWYaTuH
         4bWNQPwzol+Ksgia4CwxmlEi9K/EgVNdjNtqS0x7hxW3ARyXrSq/MVFEPsSLgH9RTF
         Xgcg2qru7aFW068717prkOt+o3gIZCHTcTm9q7J5FR5EEm77ow5Jqt2H7lOboDzbMD
         zlvNd+FJ8iSqaCQ596M/O6KhHX0E1gyXLLLXLg9+J637H1Oc15ZR4vWPTDX9q/G99B
         Io99pF16ZV0Tdaiw4G+4zRN/PM0l7c3IFv4tvZ+RVvkABbFPREGjpVpKCJao43++A3
         G6ih/2rm+k5Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17FB6E49FA7;
        Wed,  5 Oct 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166500361608.18591.2059211841297674651.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Oct 2022 21:00:16 +0000
References: <20221005204309.65983-1-inga.stotland@intel.com>
In-Reply-To: <20221005204309.65983-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Wed,  5 Oct 2022 13:43:09 -0700 you wrote:
> This fixes mesh io flow for MESH_IO_TYPE_UNIT_TEST which
> got broken after:
> commit 9966cb8b6999a5f54fc13acbd7e1526512a84342
> ("mesh: Add new kernel MGMT based IO transport")
> ---
>  mesh/main.c    | 8 +++++++-
>  mesh/mesh-io.c | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e71e1103abc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


