Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90DECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHaXKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHaXKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329B52E79
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC9A61C83
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A551C43140;
        Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987417;
        bh=ZIfAiEGBjUh0Mg7+DTfXZYi1vTr4bu5+inKuFgjOZMc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R8qqEfh6Y5v3m2JSJ0l5xwObmdHUOXmnwlXN9HeZI+7bxDeHR0kUW8mRpSzUgrM20
         romQSlsHS0k7X483oLBUWkZbHEoaA7U5MiwtG7DLSWLUBaiEEley6iYlpmXxFjNSGa
         FT5rSLyznnbMb4gl38KJUxaoh9NeQ+XACi1EZgBz/P/WwKNdqq/GBC2jtFiofX7tbQ
         pWZfJJcjAFVu2eVCWYs33AqsKdFAbO7oWPQp6bACnARuXFXj5jJ992MZsQrc3vNCDo
         ht5aCix6kmdDl4tkwbgU5YBK/BDo60YxNU4AjXKZPu0Ag34pm0bvVUg3mL5XR1UPDX
         RfqejxYK3sU9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1840FE924DA;
        Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] client/player: Fix checkpatch warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198741709.19908.7092975051006223635.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:10:17 +0000
References: <20220830214215.1137276-1-luiz.dentz@gmail.com>
In-Reply-To: <20220830214215.1137276-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Aug 2022 14:42:14 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following checkpatch warning:
> 
> WARNING:LINE_SPACING: Missing a blank line after declarations
> 216: FILE: client/player.c:625:
> +               GDBusProxy *proxy = l->data;
> +               print_player(proxy, NULL);
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] client/player: Fix checkpatch warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d8febc76a43f
  - [BlueZ,2/2] shared/shell: Fix scan-build error
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


