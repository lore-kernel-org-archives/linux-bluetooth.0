Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E5C3DA6E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 23:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLTXkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiLTXkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 18:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149481DF23
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 15:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9058B81A74
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 866E6C433F0;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671579616;
        bh=x9Q2VDKDHf0jg/d21gBk8XoaLCj8zGMIcJ5QXgLuy2Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EhdS/gs/rN/P4yLhiWM21j2NLCtDuhjF4qdSv45ciNRLk5TFR7wQHgb5LkzAEwDCI
         SVBEDS67vqUOcEnqARsQ5k58z6AMFWmRnkKV+13/NVzzxkIIcJAzFsotNMa/9Z7N0C
         X6yA3V+lNmdjkmvQIyxyGdooSGrWI4n943JdtrbSZyqvqNq6cALREQuoQqhUbbfbmD
         6PfxAQSF+K3rGTg6wCeGH8EmNpeAb4fIJiGbrzRtSTupbqt5oZAMZ2XIvbUt1EbNmJ
         mxvvzUcOqrQLB+q8lcnu6uRWc9v++9QwzBltYCxH9+aw4OnBwFrHO2n7A0WoFtlpMm
         Lk8vIugD+jEJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BB69C395E0;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ V2 0/6] V2 of CSIP client role
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167157961643.23834.12700684908375989981.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Dec 2022 23:40:16 +0000
References: <20221122032530.3842-1-sathish.narasimman@intel.com>
In-Reply-To: <20221122032530.3842-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Nov 2022 08:55:24 +0530 you wrote:
> Version 2 Fixed few checkpatch warnings.
> 
> Sathish Narasimman (6):
>   lib/uuid: Add CSIS UUIDs
>   main.conf: Add CSIP profile configurable options
>   shared/csip: Add initial code for handling CSIP
>   profiles: Add initial code for csip plugin
>   monitor/att: Add decoding support for CSIP
>   tools: Add support to generate RSI using SIRK
> 
> [...]

Here is the summary with links:
  - [BlueZ,V2,1/6] lib/uuid: Add CSIS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b709058c6008
  - [BlueZ,V2,2/6] main.conf: Add CSIP profile configurable options
    (no matching commit)
  - [BlueZ,V2,3/6] shared/csip: Add initial code for handling CSIP
    (no matching commit)
  - [BlueZ,V2,4/6] profiles: Add initial code for csip plugin
    (no matching commit)
  - [BlueZ,V2,5/6] monitor/att: Add decoding support for CSIP
    (no matching commit)
  - [BlueZ,V2,6/6] tools: Add support to generate RSI using SIRK
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


