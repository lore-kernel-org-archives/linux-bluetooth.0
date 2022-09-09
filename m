Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBFC6FA89
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIITax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIITa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 15:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972897D54
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 12:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88A09B82628
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18054C433B5;
        Fri,  9 Sep 2022 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662751817;
        bh=9KDyNC9V+LMv8gvgXu+UituuP7vFH22OiGpaWzFSPkE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mIOS03KyvuZW9t395Lzuw6n/Wrt8hH9vkR00P7oYBAtGOsi4eCau3aamcLM1gNbRW
         rgbUbHm0bM3eWQybnLnRp1Q/ayrCD/mEJ3TzrKLkwiLi7UyHWAQ95CsoRoiF19JNgf
         Rs3bgkl4WsMMZbJ69NKo+x8e+4kCjxUuzn6ysicRqgMhNrn84b2CLIdU7k/R06lbxI
         wE3TonbTYy0TbUpBZgASKx+ETcZci6V41BqR7PQ4kQosS/3xsVBe7TywCNPNqU1kq6
         WjxoKgOBHlqjWAHTScnuOoQ2Gcm3WFB9Tl7E0WIdF6tM4goPqVJKKTvpqhFqZ6NIc2
         ygZZdFCVBEZgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECA16C73FF1;
        Fri,  9 Sep 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for Magnetor
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166275181696.14413.14816229046482486389.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Sep 2022 19:30:16 +0000
References: <20220819074815.22016-1-kiran.k@intel.com>
In-Reply-To: <20220819074815.22016-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Aug 2022 13:18:15 +0530 you wrote:
> Hardware variant for Magnetor core (CNVi) is added.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v1] Bluetooth: btintel: Add support for Magnetor
    https://git.kernel.org/bluetooth/bluetooth-next/c/b43331b42e44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


