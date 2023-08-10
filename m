Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF29DC001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjHJAK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJAKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 20:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5264E5F
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 17:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C0963F6E
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7E33C433C9;
        Thu, 10 Aug 2023 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691626223;
        bh=YHW6YyTkZXdP3QsLVd+chOkfrGbCrRwx/P3f332qawo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Mnr9BhAozj0rQjoPgu+YBliGePno9CNbPeQq7SQl16yNNhh558d/9S3su3tlMFQzm
         887lBLMrL4XQNcEcRpdHLuXqUqg5uKiCzuwN1wgJNl5XQ/4TP+Jp3Ne9DK35TzezLj
         U3NPnAsTIWkhQNAZGV1kvLfYwalJ9HsYABUYsm7FPlzg9/3t6xThbNazr1HfcCvaLf
         axQsO9fjA+0eYjibPb6jxbs9rK+vVHHgo5iwOVYJE9Q3VdJOsqGqZFu987x4sCExFo
         lilbGc85MNRyVp0QYI3ccg7MPqSAxStW9IqtBBCJWp1BpCdSrDk4bUNg6Kbd9BuBtE
         RWdHlJi5FQzBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9034E33090;
        Thu, 10 Aug 2023 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix not probing drivers at startup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169162622375.3909.7897508359769913686.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 00:10:23 +0000
References: <20230809194620.1595792-1-luiz.dentz@gmail.com>
In-Reply-To: <20230809194620.1595792-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Aug 2023 12:46:20 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Patch 67a26abe53bf ("profile: Add probe_on_discover flag") introduced a
> regression which prevents drivers to be properly loaded at startup since
> at that point they are not connected when code shall testing if
> the devide is temporary instead.
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix not probing drivers at startup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac04e5f38225

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


