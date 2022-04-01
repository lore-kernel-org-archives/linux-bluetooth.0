Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C94CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbiDAXcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiDAXcD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE72109C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB6761BBB
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 23:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 504E6C34110;
        Fri,  1 Apr 2022 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648855812;
        bh=kdnOMWo0NINPsx83syrqaZjbQf8vh6R+pJYshShifns=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hG6CUl6B7duxQ5sLYD6XtTH0l0lIwkmj96IAchou3pJldp2i9H7xsUUD2F0STsJEC
         IuTPzOVbKCTISVQmriCaE87eBXirTBeoe0HBsm5qHpr9GlsenEJs69dsfWPbjhUeFU
         gWfLbe2uwX6tHa+ax1d8Rkp3oHRZSaejfUQUH7XyjDujwtTWji30T/zlB/p7WjsIKZ
         D6LFeZL4K45IhzQOBuLFN+cPOMsWu8YPhuijP1jRbfUQMqukrBkGFxddK5jrSwLbk9
         RT9KkilzDITixV//NLB/SJNX+boK8femt0fCKV2HupFZLHXkdw2ABcpqY/Xqb8sc35
         +bkwfUto6hR5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 346F5F0384A;
        Fri,  1 Apr 2022 23:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-db: Fix gatt_db_attribute_get_index
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164885581221.24141.2977608447535591250.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Apr 2022 23:30:12 +0000
References: <20220401213857.36738-1-luiz.dentz@gmail.com>
In-Reply-To: <20220401213857.36738-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Apr 2022 14:38:57 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> gatt_db_attribute_get_index was calculating the index based on
> attrib->handle - service->attributes[0]->handle which doesn't work when
> there are gaps in between handles.
> 
> Fixes: https://github.com/bluez/bluez/issues/326
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt-db: Fix gatt_db_attribute_get_index
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=234d60423c3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


