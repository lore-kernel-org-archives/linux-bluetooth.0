Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15AC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 20:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCQUbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQUbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 16:31:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCEA55B2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07191B826C2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 20:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB779C433EF;
        Fri, 17 Mar 2023 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679085018;
        bh=GGB26Ygz6rGVk5DLSCT7RyVDeH23sHB1eUJFH1wWLww=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o02efoa2IJEwEc9Y2WJbpKkKHuzYxYlloZnOaKemHzyRoEY5IyNZ52M+aOSNX7AuI
         3m0VEM540noHlejVKM9kccocbPdJPxj8QUUGwhxNYx4P2YH7KF7CVEAQTdTXWdzD/+
         tuDcGAZNLD6D86B4LmsXP6OFufOnk59EYnZl60Onjv/C+aQbJsC8v4c+Wq33JX99y2
         0+GTjl1z9YXWV8VDLz8i7vGCkAix0qCq8EkTnigdTWaiRjfRRc0ANeLfNSU12SUVR3
         Xo5RJ9VAnlIxM4Z5bitWrTMWo9UIxTMlyK/D2+n705F7boUWygj/xKk3RohllvdBv1
         jRuaWvkMtZF0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91CB3E21EE6;
        Fri, 17 Mar 2023 20:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] tools/mesh-cfgclient: Prevent storing duplicate
 models
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167908501859.28511.1166223350843990916.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 20:30:18 +0000
References: <20230316213312.159370-1-inga.stotland@gmail.com>
In-Reply-To: <20230316213312.159370-1-inga.stotland@gmail.com>
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com,
        brian.gix@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Thu, 16 Mar 2023 14:33:11 -0700 you wrote:
> This fixes the situation when subsequent requests to get a node
> composition result in appending element's model list with duplicate models.
> This adds a check for a presence of a model on an element when attempting
> to add a new model ID to a model list on this element.
> ---
>  tools/mesh/mesh-db.c | 17 ++++++++++++-----
>  tools/mesh/remote.c  |  9 +++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] tools/mesh-cfgclient: Prevent storing duplicate models
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc961998a842
  - [BlueZ,v2,2/2] tools/mesh-cfgclient: Auto request own composition data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=551a0c80ab33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


