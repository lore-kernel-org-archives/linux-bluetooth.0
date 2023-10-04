Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7CAE7C4F7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjJDTub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJDTua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 15:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDCA6
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 12:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9DCC433C9;
        Wed,  4 Oct 2023 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696449025;
        bh=1OZEZNMK3yltLKmS00qaVG9ocWhJQ5CmSZV8q8VE+bs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t3Aa8PcXm9OFbWhnJunqGim+KhB9MYQGGIdl6b0CisEB/x9miVNtFe6xJsXEsComy
         2dmuKzgv9u+pKINjhGMkar/GWoU0+SUlZAbEXDbWa3ybSwoFoSNgXmW25J80Y7G3l3
         66R0+nbs9K0RC1oLKnGQVsajy3ch5GQdoifuuOMxPW/5xZIbaXvTdK2iWjYnuiMwbY
         v5E+3JSYQG1LLq6c9BLAhMJNZKHAotPNMjqh1+O9Cgm/+NYTpKqKp73hLWe6ZbKEQE
         7XogjwDN3cNXHRIO7Hlxlb8a5RuRQKLG9T60BmtnXy91TdXLsWX1luR58afeI9/RZk
         WRFEMUz5NzH0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30069C395EC;
        Wed,  4 Oct 2023 19:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] adapter: Add Version and Manufacturer props to
 org.bluez.Adapter1.
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169644902518.20785.1649061266730597308.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 19:50:25 +0000
References: <20230929130742.146571-1-vibhavp@gmail.com>
In-Reply-To: <20230929130742.146571-1-vibhavp@gmail.com>
To:     Vibhav Pant <vibhavp@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 Sep 2023 18:37:24 +0530 you wrote:
> From: Vibhav Pant <vibhavp@gmail.com>
> 
> This allows DBus clients to find an adapter's version and
> manufacturer company code without querying the management API.
> ---
>  src/adapter.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2677c0153fd
  - [BlueZ,v2,2/2] adapter-api: Add docs for properties Manufacturer and Version.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6393012d4680

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


