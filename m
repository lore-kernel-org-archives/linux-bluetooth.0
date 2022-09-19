Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35066C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISVkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiISVkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 17:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C563FA00
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 14:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFCD6208D
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 21:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72E62C433D7;
        Mon, 19 Sep 2022 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663623615;
        bh=8v/rT5rCSj4gdVSHiF4LaWTcaw+7iIyp5OsVZzA36QA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KZPEkXtq4iXvp4jAehrJz6mKTvO9Sz43KVD0p7ssl09vCEMR8oiLk30eMI7WSlK5V
         O752q54U0DDyvEj5XpiJN5hz+cTDN43ztx+KiOhpdXbp1TwGJiyhvR5kmVceHJWXZ7
         fP8kKVmSipKL6/htfv1muxX6k4nyBnbkT0hiONrhJd/cxaDOHVEvwt0sKDwigm+u/V
         INSSD9GG92daBoHsmsb8TBWAhjORrmQzRoeWZ3zX8pKp5n1kSUV7DzRKdsESdESs3l
         eXtdIgWTb2lL6TP9QFjvn/TnWRyjQ5oCiimruBP4cTtIHNAohVmBQ7RQO+XhqleP/P
         LoYwbfPPqK/Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43D04E52537;
        Mon, 19 Sep 2022 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-client: Make use of
 gatt_db_attribute_get_ccc
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166362361526.14010.918464085094793399.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 21:40:15 +0000
References: <20220916234604.1156551-1-luiz.dentz@gmail.com>
In-Reply-To: <20220916234604.1156551-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Sep 2022 16:46:04 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of gatt_db_attribute_get_ccc to locate a CCC of a given
> attribute.
> ---
>  src/shared/gatt-client.c | 41 ++++++++++------------------------------
>  1 file changed, 10 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/gatt-client: Make use of gatt_db_attribute_get_ccc
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6ac0886f08e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


