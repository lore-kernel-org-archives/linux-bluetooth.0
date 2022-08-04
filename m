Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B22C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiHDQag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiHDQaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 12:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2197272D
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 09:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D120614AC
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EDBFC433B5;
        Thu,  4 Aug 2022 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659630613;
        bh=65coytVEMdyZ9ofhl/jX64ytfR84M4IlBKL/srw9SEU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OKeMj/Iosx3Sm81uMuqcYSk59+WfKhKpISrPbpIb32smhoKw6WBP/FhgpSnVTQPO6
         4hug093w9MN5eTteufcWu++KG+HQE3Tr5BZiVTtiYe2L31aGEMFG216/qsCkS/obOl
         eyBLa1CkD6oGkWkGTlixveTsDEqE4ihN7d001pSb8nuOBtaSzwk0LgVIamOIwBE3Ec
         i+HLhYQrTfWLrjqrti2d8UqPWzds8P7lNE4vt1FLuZl/+W72aSf/gXBQuCGGbEZZ+D
         wIO2xu58psy0gHBQmSdZ0zZ/kxRZLVuzHVzyZNzHcY/HMzUqxa+hoVNcal/jpKBpHo
         0CDgFjH2l60lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7971FC43140;
        Thu,  4 Aug 2022 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: Test BT_DEFER_SETUP works with getsockopt
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165963061349.5660.12889968034767897427.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 16:30:13 +0000
References: <20220803172222.2952373-1-luiz.dentz@gmail.com>
In-Reply-To: <20220803172222.2952373-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Aug 2022 10:22:22 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to test BT_DEFER_SETUP is properly set when the test has
> defer flag set.
> ---
>  tools/iso-tester.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Here is the summary with links:
  - [BlueZ] iso-tester: Test BT_DEFER_SETUP works with getsockopt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d9497e0001c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


