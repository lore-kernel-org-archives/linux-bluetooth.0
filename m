Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFFC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCGVa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCGVaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 16:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C3A335E
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 13:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A8261579
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0091EC4339B;
        Tue,  7 Mar 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678224620;
        bh=/CBDnnWyhfAZMDfE422siIRIgjBnOaUooWaN483Uttc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GiORcf0ueL40hWkbsOM5yTM5iqAK5TqLW+agS5gF1473p9FcRAw5g4tod2jdMW+3d
         LDm7se6wY6SFqCEq+dIfWyZnkZW3lWDNR6hKmnmBRqvtzTj/yh3gjNj6oH4sZ3WGab
         Ac31wafPzlSpZIb9sf/dsIfEyb+604opCJl7zD7yFog6MaVa6ngmjYMvGu5Y9bG3Ou
         vDH3xXUkFpbMcZhv286P17eXseo2dWX5nE9gAqeCZPuuFDfB74PN/Eb/TaXXoIYPfT
         Ywus6YDJm+ZPilmLJUo0YbgvOvyVflT1FZNmzQhei1u2F5a+xkNib9+V7qO3AFRxn3
         zTfRgq0Bb4nFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2551E61B67;
        Tue,  7 Mar 2023 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167822461985.28216.481970631444868909.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 21:30:19 +0000
References: <20230224175632.461834-1-brian.gix@intel.com>
In-Reply-To: <20230224175632.461834-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Feb 2023 09:56:32 -0800 you wrote:
> The msft_set_filter_enable() command was using the deprecated
> hci_request mechanism rather than hci_sync. This caused the warning error:
> hci0: HCI_REQ-0xfcf0
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
>  net/bluetooth/msft.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)

Here is the summary with links:
  - [v2] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e21956501c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


