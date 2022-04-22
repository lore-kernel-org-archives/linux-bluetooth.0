Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3EC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiDVWNb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiDVWMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 18:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEAD307278
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F53B83250
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 20:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC86EC385AB;
        Fri, 22 Apr 2022 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650658213;
        bh=pQz51My2lNbQSNuTSHibh+i85JBBWCH6j8RvlAJkRKY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XvjUL3AXkbrphXJhT8fj6YTIr5lMNLv3FWj+Fb23XxswCVkMNKaZw9tm4QuJud3tU
         fBjFn6V5PjUBCzvWIZIpvf01sNdECV/WUV2f2ur4Br12E82c8Vo4Wd/IuIObpG1lfO
         7kx8+yzcSizkNd7bnTN9kIJYC7QhaERqKYtUq9slRkG5fcwWV0iYMdnE6KrdA1GrPK
         ddiQn7RbxvhpR3XrhFj0xOtjYp1GPz2KhihiFGfApuwxVE4uvEeOdAzsQAJLnxi6sb
         7d7Av5iMG0UgvFRAWhPJ8cw0HpJn42eIBVC745OyEVt17DVU6BaxK1ThnkqKL9tT/f
         uluqy8MDimqNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFD5DE8DBDA;
        Fri, 22 Apr 2022 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] hog-lib: Check if Report ID is set before prepending it
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165065821284.18982.9282084380045919340.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 20:10:12 +0000
References: <20220420201437.2855806-1-luiz.dentz@gmail.com>
In-Reply-To: <20220420201437.2855806-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Apr 2022 13:14:37 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Before prepending the Report ID check if it is non-zero:
> 
> BLUETOOTH SPECIFICATION Page 16 of 26
> HID Service Specification
> 
> [...]

Here is the summary with links:
  - [BlueZ] hog-lib: Check if Report ID is set before prepending it
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c535623a713c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


