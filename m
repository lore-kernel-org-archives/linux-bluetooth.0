Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A35C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbiFNUwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358461AbiFNUvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE550E1B
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC4F61640
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CB9C341C0;
        Tue, 14 Jun 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655239815;
        bh=VyIeNTDVTjji9dDUWrj6TRM8ui+ayqTBr4VfvaJxJms=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C4t1ScCks0mh4z7o/mVGsqWeyz9m1Uev+El5vGquGgPLJSWSg5vMi7KWWMlXRoYyF
         mTKFcque/YUlkc71+7q7onp7sHnA3rCcFvmpnZ/8Cam125IzzHY/i1mXgEgud0zqOv
         Qo3/2nHOnMdOZimzeGdpPTozCPw9+uPzgZb1z+SOS9AbENkqDO7ar7eapXXOwItSQe
         UngEHcAAnzQSbwM+3bsfWQ2yPSuDOuEcuhaInstW3FFoqM+3ovUlNiBdRJhzirqYUO
         KTE24PqzA8mEOyYkTKxeuYuAS8zwNJg46pQpu342rw5tLJYFmsQJCDx03o1cozzcKQ
         w6lzij5NCpF+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A862E73856;
        Tue, 14 Jun 2022 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor/att: Fix decoding for notifications
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165523981556.27818.11315930327161607102.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 20:50:15 +0000
References: <20220613233419.177421-2-luiz.dentz@gmail.com>
In-Reply-To: <20220613233419.177421-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jun 2022 16:34:19 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  monitor/att.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] monitor/att: Fix decoding for notifications
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ef14e6eaa7e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


