Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82515C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiDSADA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiDSAC4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4C4E0AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2995CE126F
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B35BC385A8;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326412;
        bh=9XeImoCq0Gf+ScolKuTu/Tz7aKA/wZabQZ0fz3YdEmk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nf0Tk7A9XJtOP0Gj7ZqI9SW4tHO84Y5U2O4eN4VFi0U/Je3JYYonuTb+eeU14ENQI
         c6toLujqJI6BF/pEGL291OPDQpPxD5sf8NjMxYt07cR16TtLkOyVXkkEk0VUKoi+R6
         /6RoBLwngJAZIjjIFF/8pWX5TFVTasrZO70kou47uuL5iG687xt2BFPwpRD4ZwYl92
         x6MvD8wNcyRgm5GNCqX1ihVEk+7kiI2NsSyJohSt6xp5Mp7WiTvXm1aK7QBmx3+R4r
         lLPUrU6WoYqGLbTzKaWedSpq55PIKr2LMTB0V09XyiJcZ7u3IuVgpvRcEeprjnN0tT
         LrsUq7S01aDig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D8DBF0383D;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 BlueZ 1/3] storage: Add support for STATE_DIRECTORY
 environment variable
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165032641205.24068.15560750776902412548.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 00:00:12 +0000
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
In-Reply-To: <20220415223049.1155838-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 Apr 2022 15:30:47 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When running as a systemd service the STATE_DIRECTORY environment
> variable maybe set:
> 
> https://www.freedesktop.org/software/systemd/man/systemd.exec.html
> 
> [...]

Here is the summary with links:
  - [v2,BlueZ,1/3] storage: Add support for STATE_DIRECTORY environment variable
    (no matching commit)
  - [v2,BlueZ,2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
    (no matching commit)
  - [v2,BlueZ,3/3] build: Make use of StateDirectory and ConfigurationDirectory
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0905a06410d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


