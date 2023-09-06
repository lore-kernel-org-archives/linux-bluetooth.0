Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D8EE14C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 23:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjIFXua (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjIFXua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 19:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5510F7
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 16:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01397C433CA;
        Wed,  6 Sep 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694044223;
        bh=4CGD0J8ZCJjp4ycWv1+GGjEYIVGFDITT6T/FmqlZCw0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E+08W/QWSCHw52R4tb7uYUOMD+q7B8qOeJvqtk6BZgi3Bz9sUGQXUbhAuhIM6rYLj
         pflPuhZh0Ye/vAzGSNckaG+G1Z9PircCxnbGLqDpLHsH17IWQGMdSCdxfP3o/9kn69
         7NBmP4JqBOsZ7wVIau5vK2+32x7JrIRI+/yFIGrQmVeyM4d2UZ1YX1DwJ7Ltc8TT3r
         Ml4TtJEAznLZasFGFqc9DTCKJsj3rfgOr0OyQPtVZ2keij9/LdIe2QukushXUJg9JN
         6hw1cwI7zD8Bze9HKH9qqEmUaCm3eMN+bzG+/2YvAt1FeTTxx0YxkGnGsZ2g/wVyu7
         pxYB7PYOklmYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC5E5E22B0C;
        Wed,  6 Sep 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] btio: Fix BASE copy from getsockopt()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169404422289.30428.11003136723830603244.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 23:50:22 +0000
References: <20230906114234.10617-1-claudia.rosu@nxp.com>
In-Reply-To: <20230906114234.10617-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Sep 2023 14:42:33 +0300 you wrote:
> Fix copy of BASE from getsockopt() and update base length.
> 
> Claudia Draghicescu (1):
>   btio: Fix BASE copy from getsockopt()
> 
>  btio/btio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] btio: Fix BASE copy from getsockopt()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dc13da09d78b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


