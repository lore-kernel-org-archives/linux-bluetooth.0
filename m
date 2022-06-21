Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A5C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352969AbiFUTKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbiFUTKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0062A972
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B5061725
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B90F1C341C6;
        Tue, 21 Jun 2022 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655838613;
        bh=W8S7vd4J3mMYW01gFXnXkKsO5qU7ywcvd8mH6ECo4hE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lm4kxxYV9FnAkJ78fDdTsKe9lTznBxar5sWLsFUDckGSVKVVqGMeUVc/AysvbWiX6
         rORVdcLvpNaiCh/BBJxY6ZzfVp9wL3VX1oFR0Ego7CenomkZbGxUNAhwO3+/Bto5Y/
         NwwrBelU0Vag5Ycnz/+wj1IGrNXo3oUB7TQ3mxLu84Aw05C6d/9v8Zm7SMVz7EYNFz
         MgfxLs99YRCk7oMtLbVjsT2Z5Bn5IpzR732qudviKQGPnTG84CJ/h+7dNSt94sxGeg
         zACwB0+q+DsFbunUdTqKPrgTkC+NtvEIWiIGlF5aSDkilYDd+cskoq6zRDGDtbKgDg
         5i73WjcC3lN9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A034E73875;
        Tue, 21 Jun 2022 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH-stable v2] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165583861362.19771.13050352034259001186.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 19:10:13 +0000
References: <20220528003528.571351-1-luiz.dentz@gmail.com>
In-Reply-To: <20220528003528.571351-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 May 2022 17:35:28 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both dev_name and short_name are not guaranteed to be NULL terminated so
> this instead use strnlen and then attempt to determine if the resulting
> string needs to be truncated or not.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216018
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [PATCH-stable,v2] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
    https://git.kernel.org/bluetooth/bluetooth-next/c/c8490f375393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


