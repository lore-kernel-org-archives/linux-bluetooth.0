Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C4C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiF3UkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiF3UkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA98BEB
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 496A2B82D02
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 20:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3291C341CD;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656621614;
        bh=Uq+aRFu7d2EL+EhwV+5+qlpyHeK2hvs8C2M+d6XV79s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xyg62xfbvb8yHJjUH1wuUtKBXWlYuD89hCTv8D1VfoojmZP0BOqGiWrc4d2kPjb+U
         kzBV1F9Jfo4X5o6IgkSHb+N86SnWeOvQXex883e/WOd68NsKXbBN9nN3tYhQP/CLh7
         iEh+2LAwbQolGt753pL3GWSOrITZCMYzpITuwYR83p1Oo+2EzMWFTAu4XZyQZhfO59
         PZsNWkPFz0QUL2D4iiIL7NfrAWefpQ0mbnncSAib8wJG7/rnCeY942lbnBZm66cXm6
         VPZu1+ExT961QJvni/TkCgajqbYGVtuuDVqnrwl4QBjcl7sJd+nIKzop1VTZ9P/7oE
         DBnmHbVNNQi1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF91AE49BBF;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mesh: Fix snprintf return values not being checked
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165662161384.2141.11947849400356103868.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 20:40:13 +0000
References: <20220629210237.63236-1-brian.gix@intel.com>
In-Reply-To: <20220629210237.63236-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jun 2022 14:02:37 -0700 you wrote:
> Some versions of the GCC compiler complain when the return value of
> snprintf is not checked. This patch cleans up the Mesh JSON parser.
> ---
>  mesh/mesh-config-json.c | 88 ++++++++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] mesh: Fix snprintf return values not being checked
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5351d4d86a08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


