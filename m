Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C4EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFVXAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVXAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 19:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665CC1BE3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 16:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB9D61901
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 23:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 514EDC433C8;
        Thu, 22 Jun 2023 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687474821;
        bh=CVJxGgPARB6tjIkrV8jdy1Fyj/qpjYsWJDIJqiGn8r4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OV8JoQaQZUJEEzWaw7Vccb3TAFsG/wvCeWcgh0bJ+IMzcx6GEZa83hhYs3+Bvxqte
         yWXFhbadfShVddyCgNTOTxCmc+8mSD8KiPdoTStotcBkg67QdhjdQpCMR7Eyi3uSkc
         FmkhYo7f4b7SUdlzG1y28KZrdDQb1rGlPDpxXbZW5yOl2SZvUg60OLoabpE1zOMcS1
         FwVfK/73R3uOyN5Z+9QDl6NQ5JBOL5wQIzgaectdstOCYXum75PisdXnLbl6SAWOH7
         CuVrPMZ0vCpzuZGAlQKQHr5HJ430yDrGTwMdEl5hts+o0Eq/sadoke8jHV7gbfWF1c
         wKQtWRbXVIYEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F5A0C395FF;
        Thu, 22 Jun 2023 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] btdev: Fix LE CIS Established Event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168747482118.12736.13675281947875634146.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 23:00:21 +0000
References: <20230622190843.1242967-1-luiz.dentz@gmail.com>
In-Reply-To: <20230622190843.1242967-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Jun 2023 12:08:43 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> LE CIS Established Event Transport Latency shall follow the formula from
> the spec:
> 
>  BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
>  page 3050:
> 
> [...]

Here is the summary with links:
  - [BlueZ] btdev: Fix LE CIS Established Event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97a07d8485a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


