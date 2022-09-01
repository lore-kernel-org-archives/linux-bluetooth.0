Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DDEECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiIASuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiIASuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 14:50:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFD5EDD0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63863B82793
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C2A9C433D6;
        Thu,  1 Sep 2022 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662058216;
        bh=a+mKRPfJFxoS1Wgi2vbHB3K8TRTBvxsu7gsFrgRTCfw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hOlh3uDzuV2QLHIw+Pr3mFznEWJMmESTGA37OWqaweTfuBfsm5TYqj1WtUn5aQ4Jr
         Rfu+jfEf9JE/iv53hOFt/AYTG2HDWJMjgNbWnWUthd4IKawsEeFfu46TBtiPkjjcJL
         Ca3EWMTgC+9WFn5J7pglPyJxQXTqnS/YuHn88rubtIOHwppnaKgcU4s6rB7nDe4ZBb
         EywZtruiMUup0NHhhLW4PPrtbpWZA4DuWvR0+kaV1tfvxCB0iepjkgr32V5cIHiaRo
         4X29zPdgNzpn6YGA91if98Zqr93VBB6TODNlTA7OCkERPJN3vr53CfPHBz/aVIk+Dy
         6KrFbBpQdatyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C06E924DA;
        Thu,  1 Sep 2022 18:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 1/6] adapter: Keep track of whether the adapter is
 rfkill'ed
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166205821606.5769.2196808396648976031.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 18:50:16 +0000
References: <20220901110719.176944-1-hadess@hadess.net>
In-Reply-To: <20220901110719.176944-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Sep 2022 13:07:14 +0200 you wrote:
> Instead of only replying to D-Bus requests with an error saying the
> adapter is blocked, keep track of the rfkill being enabled or disabled
> so we know the rfkill state of the adapter at all times.
> ---
>  src/adapter.c | 25 +++++++++++++--
>  src/adapter.h |  1 +
>  src/btd.h     |  1 +
>  src/rfkill.c  | 89 ++++++++++++++++++++++++++++++++++++++-------------
>  4 files changed, 91 insertions(+), 25 deletions(-)

Here is the summary with links:
  - [BlueZ,v7,1/6] adapter: Keep track of whether the adapter is rfkill'ed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abf5ba6b80ad
  - [BlueZ,v7,2/6] adapter: Implement PowerState property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58021a665b7f
  - [BlueZ,v7,3/6] client: Print the PowerState property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48992da64f52
  - [BlueZ,v7,4/6] adapter-api: Add PowerState property documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6e49216ad47d
  - [BlueZ,v7,5/6] adapter: Fix typo in function name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61f4f2895882
  - [BlueZ,v7,6/6] adapter: Remove experimental flag for PowerState
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


