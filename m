Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 01:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJDBUV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 21:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDBUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 21:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4745178B2
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 18:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65EF561233
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C15EEC433B5;
        Tue,  4 Oct 2022 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664846415;
        bh=MT8PDJKZdk9vWvzYQyISu67vhouaJA8bamZ2ggwmsBA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G0C5sxff3Al6ihoeqngJgBXMJD19GJyP2ff5Lhz4JZ+A+Z+Xp4Mk15vuYeCff3hP2
         +d0LsrFWJTQCyJFOfEyRYE3jQ6ycVeSc2NMnl5VWk5Qw/n3s51aCAzP7RysiYourQd
         YjEHCGcOoCajKw14WU7DXlBEu830dgAt0D/2SoOWhe8tIM3ABAE3lCp+BGXr7GBax0
         iobmjYqwXw7F42aQKVg49JIk8VZpMcn6H8Gr0e8c1tHyKdjA0Isq+e6Pk2JxCjcWMA
         We/E0L4AUB2H4Q/lVhDzuBOsjl7tM7TEqa7EhhwLAZC/3DzwZfePwf9vbSA92DD5g0
         ZAF1ycEYyfrTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8C91E49FA7;
        Tue,  4 Oct 2022 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] README: Update Mesh required Kernel Config section
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166484641568.16258.16593444526139224668.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Oct 2022 01:20:15 +0000
References: <20221004001459.176032-1-inga.stotland@intel.com>
In-Reply-To: <20221004001459.176032-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Oct 2022 17:14:59 -0700 you wrote:
> Add CONFIG_CRYPTO_USER_API_SKCIPHER to the list of the required
> .config options
> ---
>  README | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] README: Update Mesh required Kernel Config section
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe9427041167

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


