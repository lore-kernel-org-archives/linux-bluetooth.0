Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E2EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 20:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGTUkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTUkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 16:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50712F
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 13:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFCC61C36
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8E5EC433C8;
        Thu, 20 Jul 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689885621;
        bh=AXY/KOvo7u/NrHc9ZIkt/XERJmJsoNqMmrgg5GOnPTk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jiwqb2I+WL/Hj1bwPtYxJhNRuLpN3U1lOMMTPdWepWffhXAfveyUskskFV98ntukB
         2QZy1c20gjD4exU/UUa53Yg589hNSFZurxiXsJTcYGbF5b7T9FRftvV1X5tQ3MFS03
         L/EaOrepcEgbKWK/Xy7PG7X8CJ/+rDCypZOZSKIPmbd9Nsoy5rrXZeh0KyFEaDUhxb
         PBla8+9RJM173P8ouEiBGTyFo7HI7SYxRRjD5LcEAKKXc/y7DiPSA/npLrzs9eIcA9
         zgH1csCBLiOP3cUx63b+2QIXieWhsu8WZRa0p+TkxPc0wuvoxuPSUZ/6R36afc/QEw
         mlAIsgqg5RaZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97F19C595C4;
        Thu, 20 Jul 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v5 1/3] btmgmt: Add man page
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168988562161.5880.9801368453450487903.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 20:40:21 +0000
References: <20230720190228.446570-1-luiz.dentz@gmail.com>
In-Reply-To: <20230720190228.446570-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Jul 2023 12:02:26 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btmgmt.rst which is then converted to btmgmt.1 using rst2man.
> ---
>  Makefile.tools   |  5 +--
>  tools/btmgmt.rst | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 2 deletions(-)
>  create mode 100644 tools/btmgmt.rst

Here is the summary with links:
  - [BlueZ,v5,1/3] btmgmt: Add man page
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9ccebfa7f91c
  - [BlueZ,v5,2/3] client: Add bluetoothctl-mgmt.1 man page
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0bfd7628025
  - [BlueZ,v5,3/3] client: Add bluetoothctl-monitor.1 man page
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=82d3d803d4c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


