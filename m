Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C67C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 18:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbjELSbG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjELSa7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 14:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC733C11
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 11:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1B5657B6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 18:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D2DC433D2;
        Fri, 12 May 2023 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683916220;
        bh=tuAaKFv4b3AiQHtQkg7OYcBgeDJi+FxQA2nlWvmkmP4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=no5FuZkvwbwpmtva3xXulgp2FdIXFWX/e835IYP43u5CgtiNibqk0ie1Cu0jXliGD
         6IMf2kqN/5KNdLW4nbx3sMvJqSpgQ5jYh+v94ncigEdDlrw71xj+AybEk9iDjp2QJ2
         DQdY1Ra4OGLgMuP0rDm1QqOBFbqQmdbQq1/Q8ComZhcKmzchxmjiVYA3itkjzfahaY
         HJpVbOPkrVrh9jCmwmi6sEIGgu/gfaMC8Hgo+JgY99RmMvaychfU4F9G9cWuul+Efe
         2gjJzYOAcDHeUuvcvyT0uTtbydHQKQIF/yWQH5nFzt+SUaA6zs5SOEiZRzgMOqpNAf
         O2xCsPwoyVS1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A7C2E450BB;
        Fri, 12 May 2023 18:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: Update the behavior of --io option
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168391622030.18524.12856135360396725511.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 18:30:20 +0000
References: <20230505193931.106760-1-inga.stotland@gmail.com>
In-Reply-To: <20230505193931.106760-1-inga.stotland@gmail.com>
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Fri,  5 May 2023 12:39:31 -0700 you wrote:
> This aligns the behavior of command line option --io to
> add new "auto" value and modify the behavior of "generic"
> value:
> 
> *auto* - Use first available controller: via MGMT interface
> if kernel supports it, otherwise, via raw HCI socket (i.e.,
> default to *generic*).
> 
> [...]

Here is the summary with links:
  - [BlueZ] mesh: Update the behavior of --io option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93d0d8b2fc69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


