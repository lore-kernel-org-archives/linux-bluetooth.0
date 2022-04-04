Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417EC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379249AbiDDV2b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379498AbiDDRQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 13:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FCE13F77
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 10:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A128B818B5
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 17:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 611CCC34110;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649092464;
        bh=9pf0c7Hx19r8v9dbzWRFLICrs+BULNmdoT3UWmsNl84=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t0yQD7G4wBWLVCejDwo+iZ23W44Z/4sYpAlEaXswkpa0bClCHpjA2I+tBjTCTv5GA
         KkoYsQ5oqhYZjzNwa+RTprTW5YZxM5mm6MD9GdntbDLPEnfGhNnUgZdtIIoVYJYlzZ
         bc0vBZtmOjnA4u0izlyldyxaI2nWYlnHsSid0i/O+f6tn19ZoYeBxWJFMevFJ2r01+
         +IiDg1spW55Hl7CB6oTm+Hlzy4DQoppbUXTSNDMxnYV6OD8htyTkvEXIpJZsaLo/9F
         YB4GoZ+Z3e5GXprLUY3VeZUrz/1YJWdORFz1qSxbKwFw02W3FHM6gPfakaeUOjnqrW
         c8W+lU5qmkbWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A99AE85CC2;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/7] v2 Fix bugs found by SVACE static analisys tool
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164909246430.14329.15038534057506444148.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 17:14:24 +0000
References: <20220401102757.3960551-1-i.kamaletdinov@omp.ru>
In-Reply-To: <20220401102757.3960551-1-i.kamaletdinov@omp.ru>
To:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 1 Apr 2022 13:27:50 +0300 you wrote:
> This patch set includes few fixes that was found by Linux Verification Center
> (linuxtesting.org) with the SVACE static analysis tool.
> 
> I have manually filtered out non-relevant and false positive problems and only
> procedeed with bugs that currently lead to some errors/vulnerabilities or may
> lead to them in some specific conditions.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/7] monitor: Fix out-of-bound read in print_le_states
    (no matching commit)
  - [BlueZ,2/7] tools: Fix buffer overflow in hciattach_tialt.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d328abaa1715
  - [BlueZ,3/7] tools: Fix signed integer overflow in btsnoop.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=497a0b220dbd
  - [BlueZ,4/7] tools: Prevent infinity loops in bluemoon.c
    (no matching commit)
  - [BlueZ,5/7] tools: Limit width of fields in sscanf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e664b9838cd
  - [BlueZ,6/7] device: Limit width of fields in sscanf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4afbef7790ce
  - [BlueZ,7/7] gatt: Fix double free and freed memory dereference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3627eddea130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


