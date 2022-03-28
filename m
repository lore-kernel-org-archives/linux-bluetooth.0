Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 18:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiC1SB4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiC1SBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 14:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70540A30
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C3661180
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 18:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 537F3C340F3;
        Mon, 28 Mar 2022 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648490411;
        bh=WdRAIqooItxYOmBSjxJcVMZAXtyZzmqeviel8d0aIHQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rYIZNFnRONJ17rULRIub9Bd1ioXpYzuXXEzkhkHKnvoci1+gfLJQ/v83D/32Q1358
         f8OejPqTIFeU+RUmnf/WF4COW6c0N2ROaw1ZNFV1oG3oo/3/3NHSUVyHqW/sNKEOKQ
         2VPXHb4REzKC8bNjf+hXNSa6T3ZNcfrMdxWWJGuKb1uUZRMsXtoc8Uc/0Lj4rFeqn4
         SADNUJcxvXOCt96SAQONqfDlWVMeaVjLSyuP3mNeaK8LpqD4ayD3llIwZIL59ud+03
         SNejIjozYxPyfIgfrLp8MdKXgPgux6i/a4vM0SljNNq7mcVGdOe4oTpu3vxSR04iqm
         as3titK/HEwLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31278E7BB0B;
        Mon, 28 Mar 2022 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] adapter: Fix adding SDP records when operating on
 LE only mode
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164849041119.15036.9636485473839872004.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Mar 2022 18:00:11 +0000
References: <20220324213658.59479-1-luiz.dentz@gmail.com>
In-Reply-To: <20220324213658.59479-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Mar 2022 14:36:57 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If mode is set to BT_MODE_LE SDP protocol won't be operational so it is
> useless to attempt to add records.
> ---
>  src/adapter.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] adapter: Fix adding SDP records when operating on LE only mode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4fefa24097e4
  - [BlueZ,2/2] a2dp: Don't initialize a2dp_sep->destroy until properly registered
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=18fc3abad28c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


