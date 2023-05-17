Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B294C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjEQTuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA341BD9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B124646B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04268C4339B;
        Wed, 17 May 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684353023;
        bh=r97bJz9gqDyDGyO4isW7cieZiUXaRK49Z8fDIzCFJO0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AOHOKrwhlKLufAG8mf8MBoDQBR7lq6R7H6fhVueyIykP7/wX7hgo8RnG3wYlXGHRY
         25sjofaUT4yKll2Eoo2TeZCSQsBF61+qOk8o1Iu8nnlJKjltDk9HJLl8tCRKMBGsyF
         wbSiKLanJfMJnEAp6zQ5XH084o1FgtZC499kWLA/kNGI1159/SeMjFR2vKpdeWMw2r
         tINLoS/XEz1k2wCdhCwjgxvoAsi+d1yUyGq9/U6Ju4WvXS3ygssQWVKCxztwWjDbZQ
         hzGoT+HnMVu1k/sZ5vuVDEeVFAedr2BQQ0D+TqNpdCCPVYKELmI2feAWMI2ObVBTN0
         b5X9Mz0Pw+STQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E00BBE54228;
        Wed, 17 May 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/10] profile: Add support for experimental flag
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168435302291.9114.4136193502298705218.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 19:50:22 +0000
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 May 2023 13:59:15 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds experimental field to btd_profile so the plugin can indicate
> drivers that depends on experimental to be enabled.
> ---
>  src/profile.c | 6 ++++++
>  src/profile.h | 5 +++++
>  2 files changed, 11 insertions(+)

Here is the summary with links:
  - [v2,01/10] profile: Add support for experimental flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67c5824fd071
  - [v2,02/10] bap: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da762dfa0255
  - [v2,03/10] bass: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd14ad2e1f50
  - [v2,04/10] csip: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=16da92601f4a
  - [v2,05/10] mcp: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62cbb2a9f57d
  - [v2,06/10] vcp: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2fa20fe9fc4a
  - [v2,07/10] plugin: Treat -ENOTSUP as -ENOSYS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce7cd9fb0611
  - [v2,08/10] adapter: Add support for experimental flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=28917a3c7a4e
  - [v2,09/10] admin: Mark driver as experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=943be6271d77
  - [v2,10/10] main: Rework config option parsing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


