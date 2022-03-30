Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349036AbiC3UCE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350029AbiC3UB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 16:01:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6C33E95
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF22B81E40
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 20:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA76C340F3;
        Wed, 30 Mar 2022 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648670411;
        bh=4MFVZBHnWoVqCsxf1AamHpMM2BAM7VjBIIw6W+F3q+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CdceyjRy85rlttVESDHhbnysk9j7mKJxuTfetAC9EE4Te8LFehl8XV/W0PnAelgIU
         CQYCcR6HIxoEAdX1eKEvHs3AvnobD8eVFnLUYuI+65l1t9rzKK1YxQMNzF98w4zy7W
         BgWyNt+14IqH+mu731klpzvmgPtAuohFr4nPatBnTQABurmcRuYu7g0ePi/1uKpPzE
         Lo97EcINA9Hl/6BkLop0bUyhCAFNuYc909F6v8OJK/ZjalLA/zKZHFdOkE75zkLugU
         GOZ08WYF/JQPmq3wsrKYgCe7z/ijA7lDyYo1wgvnKaFlmeVMd0OEJESKaGRv60XxFc
         4wkJfN1/Pkxmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3D88F0384B;
        Wed, 30 Mar 2022 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ,v5] a2dp: Fix crash when SEP codec has not been initialized
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164867041099.27763.12994745479318840377.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Mar 2022 20:00:10 +0000
References: <20220330092844.44762-1-frederic.danis@collabora.com>
In-Reply-To: <20220330092844.44762-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Mar 2022 11:28:44 +0200 you wrote:
> If SEP has not been properly discovered avdtp_get_codec may return NULL
> thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
> AVRCP/TG/RCR/BV-04-C.
> 
> Prevent remote endpoint registration if its codec is not available.
> 
> Remove queue_isempty check from store_remote_seps since that prevents
> cleaning up if no seps could be registered.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5] a2dp: Fix crash when SEP codec has not been initialized
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4a06a31be045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


