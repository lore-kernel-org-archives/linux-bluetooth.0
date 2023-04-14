Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643FC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDNUKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNUKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E465B7;
        Fri, 14 Apr 2023 13:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3DF649F5;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3EBC4339E;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681503020;
        bh=VYAuLSJnEMAkX+vDzpaAVQk7hpPnKCfWHvAaAjXfvdg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gsKAMDFBUJWNqWSHN5AFNoRRNNjxJJjA1twtXZRN1g5o6D4g0KSxeQlWlqREaZs9R
         QwqR3/X7Qtuj2GE3OKnFVyrFwKAP558IR4NZ5ZRy9ILqYwsINt0HqX26X30OWTOO+W
         xGaBDqEqUvLesTgMCJpuNLoWVm/oKBJ1jg4WaVq2GgUD5fFE5AO4SgFUqMNLvcpKs7
         TW6fLlardwox4xwOzefLmLf9tY4NGCuqkyrhSwWNQLZBi64Ls8c0hiE5smF6fr5F41
         tUxvyZrwcB6c9RGOXazPqlzPnI09LtNbsftLKaVZSAuqxt56Fk8qNktuU3zJZSlpBS
         suxhv/VClWftw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21BA9E4D003;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: vhci: Fix info leak in force_devcd_write()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150302013.15322.10506281113817205664.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 20:10:20 +0000
References: <634ab328-3ef2-43b7-8f81-8a48c7661427@kili.mountain>
In-Reply-To: <634ab328-3ef2-43b7-8f81-8a48c7661427@kili.mountain>
To:     Dan Carpenter <error27@gmail.com>
Cc:     mmandlik@google.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 6 Apr 2023 11:55:17 +0300 you wrote:
> There are a number of bugs here:
> 
> 1) If "count" is less than sizeof(dump_data.data) then it copies
>    uninitialized data.
> 2) If simple_write_to_buffer() returns -EFAULT then we run into a
>    problem "ret < count" comparison.  "count" is an unsigned long so the
>    comparison is type promoted to unsigned long and the negative returns
>    become high positive values.  That also results in copying
>    uninitialized data.
> 3) If "*ppos" is non-zero then the first part of the dump_data
>    buffer is uninitialized.  Using copy_from_user() instead of
>    simple_write_to_buffer() is more appropriate here.
> 
> [...]

Here is the summary with links:
  - Bluetooth: vhci: Fix info leak in force_devcd_write()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b1900708232

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


