Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDEBC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCGVaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCGVaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 16:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C3A3359
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 13:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F086154D
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E542AC433D2;
        Tue,  7 Mar 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678224619;
        bh=bxnLK8Qfig8+rVxBew05pYiR/NghMk1PM7E1bvz4A0k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gwdXivO7HAOK0NIddsDH8+fgx6rUvBN9r3aAwtt+dGCPpcBHlO+IFG8RgPEYbTmnN
         p8W343TNy9ml6pLtHcnZMkSgGxTxshzXr9dRYujtokd71fnuTTl+FdNBjlfs58j5tS
         XotD2oRlvkYFYiJgiJ4rz1jVn3Byu3PjXEyTvIxRkcw1m2RAYEGVZCjZ0OyLo/pawZ
         dSDIxnmIeQMFzdIp6s5CzT32ToVMT9GUHDToryMRc/9tJBaUgin13iHfz2Maawatl9
         jXcEHfrVb54h4Md+LpyvZp1TiYYYMWtOxzoJpDhNvc5wjMNr5gW6fP4S8//5hNKpFK
         LQTJlkjMK8Phg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C74E5E61B62;
        Tue,  7 Mar 2023 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Remove "Power-on" check from Mesh feature
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167822461980.28216.14243547193068749513.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 21:30:19 +0000
References: <20230306223221.536377-1-brian.gix@gmail.com>
In-Reply-To: <20230306223221.536377-1-brian.gix@gmail.com>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Mar 2023 14:32:21 -0800 you wrote:
> The Bluetooth mesh experimental feature enable was requiring the
> controller to be powered off in order for the Enable to work. Mesh is
> supposed to be enablable regardless of the controller state, and created
> an unintended requirement that the mesh daemon be started before the
> classic bluetoothd daemon.
> 
> Fixes: Unintended Bluetooth startup order dependancy
> Signed-off-by: Brian Gix <brian.gix@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Remove "Power-on" check from Mesh feature
    https://git.kernel.org/bluetooth/bluetooth-next/c/eaa2b72585a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


