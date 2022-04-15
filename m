Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB777C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 00:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiDOANK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Apr 2022 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiDOAMm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Apr 2022 20:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A32275E3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 17:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 115B7B82BE8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 00:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B6FC385A7;
        Fri, 15 Apr 2022 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649981411;
        bh=QnDtRmZBhYIo1asZ8Es5O7uApIslui3Wj5NmYCn6DY8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g2d3r/7kHbeve5sK3NzQJvDMKFzTRdvAvWRZ3aZjAFl3MXmE68y9mMe2IvVlG2No4
         XWiJI04mECWiQruZfCCZR8dfn2B5QIDP877IM9ytyi/XJO0X+nmbBMH02iv67xhujK
         XSS4PLzdhigDfPPvVFqKqYuM/KxqVk8/pN+ldEWewWU6TcH+wuTqo1VPjqm+fQnU9z
         yk/S8Qnftk+4jP7eOw2Eor9w1ecR46SrpD42ZacFhoReRRRm1SXYNexGvgAbnLD60N
         PN8fCwMITcscJH5XfJwF1OcQJdPqtkhVAoz56NTT2FLd1UDq6k7XVnLODpXKZfe7Se
         Mz2xVYj/Hd9XQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92FFCEAC081;
        Fri, 15 Apr 2022 00:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] btdev: Fix not cleanup ssp_status and ssp_auto_complete
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164998141159.26689.17018142389614578549.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Apr 2022 00:10:11 +0000
References: <20220411235804.3776702-1-luiz.dentz@gmail.com>
In-Reply-To: <20220411235804.3776702-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Apr 2022 16:58:02 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not clenup ssp_status and ssp_auto_complete flags on
> auth_complete.
> ---
>  emulator/btdev.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ] btdev: Fix not cleanup ssp_status and ssp_auto_complete
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1967b5311525
  - [BlueZ,2/2] client/player: Add transport menu
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


