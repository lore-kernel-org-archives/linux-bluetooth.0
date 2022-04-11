Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B9EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349131AbiDKSWq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349142AbiDKSWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 14:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE41EEC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC5A4612AE
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A82FC385A9;
        Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649701215;
        bh=QUDvxvWo+Ea8FuW/X1EG7QGBhczI3mpLA6AIvtWSRG8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lFXUeLz6ocQuezKWX7McSKJuy07GOR0B001BmZ9J3Ke3Csjsp8JEFO/vhIFcT9Wjy
         bUqkjAh5tKm3rHE/AO2fxtCplw4IDjAyK1lsNOVb876ifP/zd74y6BVH5gSwDBHvee
         UWtTQAotgT1DhbcAGgFylNgks14cjQapDKiDT8YOVTxu3rhvT6SZr5gY5uBOhbafIX
         nMuE2tQhYkmNpKc8JVZ3D5YZEVNEw7yiKb9UeDfmOMsWu5UDAxgiIT7+p3EXlPg8lQ
         JYfPIiDCSiuAo+x/ClnmhC+6XkF/cpUxuIYJQXl0OGkq1JdPaB+0hHekRs0x7H0M3V
         MHRdi7zym7rsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E912E8DBD1;
        Mon, 11 Apr 2022 18:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shell: Fix not being able to auto complete submenus
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164970121518.29224.4941691059877330826.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 18:20:15 +0000
References: <20220407235949.2428708-1-luiz.dentz@gmail.com>
In-Reply-To: <20220407235949.2428708-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Apr 2022 16:59:48 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> submenus should be part of the list of possible auto completes just as
> other commands.
> ---
>  src/shared/shell.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] shell: Fix not being able to auto complete submenus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f547db04fdc6
  - [BlueZ,2/2] shell: Fix not able to auto complete commands with submenu prefix
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=195d9b80e1a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


