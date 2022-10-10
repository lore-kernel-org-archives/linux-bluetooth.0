Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362CBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJJUAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJUAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 16:00:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5EDEC5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 13:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1202CE1270
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0040CC433C1;
        Mon, 10 Oct 2022 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432016;
        bh=INpiWraOAqykh5Ej8xL4Hl6ufSkzG2A2Vzy7P1dwCHU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ha3umtLLh/kvDf55iV7jLzkEicduwDWpzVLX+G2CjIMm+Hqp5KIBOlhA6qPDGhUvm
         L1PaJvbl7y37umWtsUfQxVFFySrfOKCyi8ZNw7KQQ90nXHFW+6QAnuI5JAt9omFy2p
         L079gsjzOKGRYm5E0ITt8iHi6iYOlgXKuWKVjvPwAc2Z+c/ORFOq3ZN+TYW3EEdy/9
         yUt+rE5gwuJAGbwtMpz0kfJPnSpzh5GWJ6MIfsJNU20k9pdTZKar9PVnSj/LhH0xJ8
         MAl7Jb4Awp7JIDP4EGSxWmRZUW1HjKbv8o3ZizSMn76Lv+VVswm2IRp1jvsbQprz2h
         5zu2MASYhehYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D850AE2A05F;
        Mon, 10 Oct 2022 20:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] Bug Fix for Memory overwrite
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166543201588.2402.16046609638289256632.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Oct 2022 20:00:15 +0000
References: <20221007174516.22335-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221007174516.22335-1-abhay.maheshbhai.maheta@intel.com>
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Oct 2022 23:15:15 +0530 you wrote:
> Fix to avoid memory overwrite during ASE stream enable operation.
> 
> Abhay Maheta (1):
>   shared/bap: Fixing memory overwrite during ASE Enable Operation
> 
>  src/shared/bap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3da439ae3c76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


