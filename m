Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753ECC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiFBQAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiFBQAQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 12:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BB1451EE
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 09:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4396FB81FE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 16:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE9FC385A5;
        Thu,  2 Jun 2022 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654185613;
        bh=9Of1YxoKKXaXbUWdmBuE1s5iaiuMbG81Sq8qhibv1qc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jY7RDlEUdRV0Agd13vCc/3l/V/VeyBIGeTwBgIiRQZNWBzE3KCnXyVjpaYnVp/hu+
         zuLEPrUwv/o72m8c+Hk3fjraagE9qzIVqlgmCYvvUc2cxVtnYP3aZO/Qz8fD8VMhsw
         jz2m50P9P7w18+LcC5A4Bl0DthzzcZCJQkaWQvK3pM/Mow5XJrx0ueo/W2Jpn4DeCl
         +VmVEQ+wMkEsR4RDhhpAft5uTWq+If+Ri2ZuknbuIhJkoLJloj2yaJnzBUGhIJrsjA
         lvEQuzoYqck5YO8iD/k7xFx8IXKaaE0rm9pRq2MZXQJXxNX7UrZWXH6A6BtJbC1Qh4
         aH8f1QkNvBnCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE06AEAC09C;
        Thu,  2 Jun 2022 16:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v6 1/8] doc: Introduce the quality report command and
 event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165418561283.15613.7221303146796113568.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 16:00:12 +0000
References: <20220526112456.2488536-1-josephsih@chromium.org>
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org, josephsih@google.com,
        chromeos-bluetooth-upstreaming@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 26 May 2022 19:24:49 +0800 you wrote:
> Add the MGMT quality report command and event in doc/mgmt-api.txt.
> 
> ---
> 
> Changes in v6:
> - No update in this patch. The patch 3/8 is updated to resolve a
>   patch conflict.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/8] doc: Introduce the quality report command and event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93850c827d54
  - [BlueZ,v6,2/8] lib: Add structures and constants for quality report command and event
    (no matching commit)
  - [BlueZ,v6,3/8] adapter: remove quality report from experimental features
    (no matching commit)
  - [BlueZ,v6,4/8] adapter: support AOSP MGMT_EV_QUALITY_REPORT
    (no matching commit)
  - [BlueZ,v6,5/8] adapter: support Intel MGMT_EV_QUALITY_REPORT
    (no matching commit)
  - [BlueZ,v6,6/8] tools/btmgmt: fix quality report command
    (no matching commit)
  - [BlueZ,v6,7/8] monitor: print quality report cmd
    (no matching commit)
  - [BlueZ,v6,8/8] monitor: packet: add missing decodings of MGMT commands to todo
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


