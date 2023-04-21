Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304AC77B78
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjDUVKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDUVKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 17:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D59131
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 14:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C6D652D9
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72701C4339B;
        Fri, 21 Apr 2023 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682111420;
        bh=YRISEmtuXgOwk3qSPxUncvN+P71+1hIJhKkV/zP03Gk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D7WlGdnsOWTGcG5XQlI1aIqDG+ApTSgoIbf+lHYfyKdOTHezUnSaZcCG8+gFYg0OZ
         ytk0YqsrjMehV7FnssqHZa3gGAZhxMGgdWFfXfTFC3SfI6QO1+u7rJG7cWsaczv4Ra
         nFI0Hh00cmrVTIOgIPwyAwkk5VkH6tCPdkPtlyhbNQkH4u0/69lPTgke4xf69rnMh8
         Isw2uyEwRi7n2mwVEw2aMWG4L974Dgf50CT6COyLbcfWNlrDYSZtsc7xatBW8kxR2O
         XgrzoP2ra2MtsELLGYcqnB6ewYn+v04xJR4Oc2bK4278q8Pdqyeb69QETkI+lejxT4
         yKPNfzgcKp4tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57C6DE270DB;
        Fri, 21 Apr 2023 21:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluez] obexd: agent: Use if-elseif instead of multi-if to
 check error message
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168211142035.13991.9127348864681209548.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 21:10:20 +0000
References: <20230421024731.42130-1-aarongt.shen@gmail.com>
In-Reply-To: <20230421024731.42130-1-aarongt.shen@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Apr 2023 10:47:31 +0800 you wrote:
> The obex agent will return only one error message at the same time.So
> we should use if-elseif instead of multi-if to check error message which
> maybe DEBUG_ERROR_NO_REPLY or OBEX_ERROR_REJECT in agent_reply().
> ---
>  obexd/src/manager.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [Bluez] obexd: agent: Use if-elseif instead of multi-if to check error message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a0acc7984ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


