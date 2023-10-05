Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EDE92FC3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjJEVAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjJEVA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2C9F
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D544C433CD;
        Thu,  5 Oct 2023 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539628;
        bh=XezX4ACnFw+z6PgQVDu2GVFQqm+UZjeAJtQ0l5CvBxk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gn0TUNO1Esc0G9VoR5D2MnvS1eJ3RHrf/J5kezbKIFqi7Zrc/SzPamG09IX9tXJlm
         XXcgyJpJfL9wdBU9P8bMsx45s812D0UD5r5t2/5l8GRXp8pWxCoKgTf3LFLKLNYPKj
         Qm5KZxaHUMlldq3nIqYpxoI4Vj7727g3cr6jdRnwere/26ai671zdvkhc6ujbaT2cP
         FcIwICu6ReFNNapflwEVnFF4bKptfIroInt4v6pK0N47p44sbX4ymyDk8BvgdWdNhL
         0IHmMojRL34Ncq40UESHso/mojeJKoKxjZpl8NHVIwRhnRps7EfOOoRdAIpjHpmKJN
         pD6pIVwH5SdLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 035FCE632D8;
        Thu,  5 Oct 2023 21:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/2] MICP-MICS implementation's memory fix and Unit
 Test case's fix
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169653962801.16076.5132668673425089326.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 21:00:28 +0000
References: <20231005121544.306495-1-mahesh.talewad@nxp.com>
In-Reply-To: <20231005121544.306495-1-mahesh.talewad@nxp.com>
To:     Mahesh Talewad <mahesh.talewad@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        devyani.godbole@nxp.com, nitin.jadhav@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Oct 2023 15:15:42 +0300 you wrote:
> Hello Maintainers,
> 
> This Patch series contains following points:
> - MICP-MICS implementation[src/shared/micp.c] memory leak issue fix.
>   Tested all mandatory PTS test cases and all are passing.
> - MICP-MICS Unit test cases fix: Fixed the issue that was occurred
>   when MICP-MICS Unit Test cases ran at a time.
>   Tested all Unit Testcases and all are passing.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/2] unit/test-micp.c : MICP-MICS unit test case implementation
    (no matching commit)
  - [BlueZ,v4,2/2] src/shared/micp.c :MICP-MICS implementation memory leak fix
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a749634f597

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


