Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0BC32771
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 21:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIOVUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOVUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 17:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1F33E0D
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 14:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DCB62699
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 21:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10668C433B5;
        Thu, 15 Sep 2022 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663276815;
        bh=mN1LtIUNYJn6N0+VyhW2h7plZKFdhbO/EEyd5qvnWpk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=luSVh3Jt3hZp+QhmBkFx8R7zhFZFYrGhNrfizX5+8ZVbYRIQyq9kCkGkQ+oVu5/Qo
         b0SzQsYvo9fimb5d03/kFzZ8hnUKyzZ/hTo0M4fsqC65hZ4zKMRB0iAUrYo0QR51TU
         hzI5wps6cZyQKspILwIWKsXNPwssz/JJBJ2k1X0/Dmem59YF3auS+T8d5zPk5AwM1y
         ksUTIWbsu6YsGyky/RGgpdab/4QxDqz82c48wZV4qu/axlz+tD/VC23ONnAUww7ILd
         fwKVIFnEswmM0jI67SD3etiE6j7lH4lPPj4jIc+zXGkYorFiAvhXMBhXqx4eCpGE7v
         /wB5JbRCcTXPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDAB4C73FEF;
        Thu, 15 Sep 2022 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Volume Control Profile
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166327681496.24209.2369434616755923318.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Sep 2022 21:20:14 +0000
References: <20220912124657.404551-1-sathish.narasimman@intel.com>
In-Reply-To: <20220912124657.404551-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Sep 2022 18:16:53 +0530 you wrote:
> Initial Development of Volment Control profile and its service
> Volume Control Service.
> 
> Sathish Narasimman (4):
>   lib/uuid: Add VCS UUIDs
>   shared/vcp: Add initial code for handling VCP
>   profiles: Add initial code for vcp plugin
>   monitor/att: Add decoding support for Volume Control Serice
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] lib/uuid: Add VCS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af1bfbb470c0
  - [BlueZ,2/4] shared/vcp: Add initial code for handling VCP
    (no matching commit)
  - [BlueZ,3/4] profiles: Add initial code for vcp plugin
    (no matching commit)
  - [BlueZ,4/4] monitor/att: Add decoding support for Volume Control Serice
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


