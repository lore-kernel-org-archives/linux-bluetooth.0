Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58419C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351126AbiDTBM7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiDTBM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 21:12:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39518E1A
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 18:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5726BB81CBA
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 01:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE794C385AC;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650417012;
        bh=1Npq9lWsCsbXqrTtphn1ZdNwosJsUNM5qzMgjx9n1sg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OtRsvJfguRmZseKMHTHtA3VOHiZXjQkW+9rPUzbDqP6gmwEQZowDqvmTSUfPPNTRz
         eZgGmu62VmTPJLEsS/1w2vp0oDV8blUaahfvqRU2oJCdsMK0rqKJfV6BcO5ejB8qSf
         09tPyhn4qznziS7Te78DKASWStm20FGTOS9kohYOOIbRgv4ihonfb/ZWYM3VGbwnP9
         D7HOW59WhuYL9czwW68K816wA17KuGTCciPkvIz/iesT6Q3+FlgkIeeA6HDluidaYJ
         NBsDbd4qdlqvveXVVAke6LMQVApqf1NOekuB7soUFDk+WPsKA+p00Xav0cu+HXslmQ
         eIJYEZ8xpZZNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8F52E8DD85;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test: changes for Python3
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165041701188.8238.10125173331499362576.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 01:10:11 +0000
References: <20220419150949.694702-1-diego.rondini@kynetics.com>
In-Reply-To: <20220419150949.694702-1-diego.rondini@kynetics.com>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Apr 2022 17:09:49 +0200 you wrote:
> Remove some leftover usage of Python2 code. In particular replace
> iteritems() with items() to fix the following error:
> 
> 	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'
> ---
>  test/list-devices      | 4 ++--
>  test/map-client        | 2 +-
>  test/monitor-bluetooth | 6 +++---
>  test/test-adapter      | 2 +-
>  test/test-device       | 2 +-
>  test/test-discovery    | 4 ++--
>  test/test-health       | 4 ++--
>  test/test-health-sink  | 4 ++--
>  8 files changed, 14 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [BlueZ] test: changes for Python3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1939bd51e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


