Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA27DECDFA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 23:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJYXla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiJYXlJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 19:41:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C2E476EC
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 16:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C589B81FB8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E6CC433C1;
        Tue, 25 Oct 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666741216;
        bh=OZ2RrmB7XwF70CeaLqB+MVe204b/JSyZix4Vao6UYns=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ih9+QF6YeYpgwWMDbaIal7kx4ZOOJMgf9Ot9vILAHrin0E6bZvgrYRrf5k8cnQRoZ
         JQYXoerqjfPQwn7zlmnCHm6JNHqW1Z/TblR1JQGQmFQb2L6JL6Um/QTVhevgI0s1UZ
         /ZYqeAfK3ATG7hz9NUJ8frq+jJqFZWSIeXSXLJAsXcZLoVkHY0o8JktfIZjQJHXaP/
         Y4lJRX4udwTLAf4I6oz0Is7+l4qnrJiYSUXap0y4gb1CVBYJG6iqNcdKSn4BOSgKT0
         0i0ltOC8m4il/N2/Vw3h71i2iOIc4zP73SLlqdMtF0BH5h/92xf6uaSm7LVz1aCPb4
         kNUO1anTIzG2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA384E270DD;
        Tue, 25 Oct 2022 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH] doc/ci.config: Add configuration for CI test
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166674121595.11987.9349559934955123700.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 23:40:15 +0000
References: <20221025221645.2344340-1-hj.tedd.an@gmail.com>
In-Reply-To: <20221025221645.2344340-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Oct 2022 15:16:45 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch adds the bluetooth kernel config file used by CI test, which
> enables all bluetooth features.
> ---
>  doc/ci.config | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 doc/ci.config

Here is the summary with links:
  - [BlueZ] doc/ci.config: Add configuration for CI test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f65b4d5fc77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


