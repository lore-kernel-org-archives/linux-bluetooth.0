Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE8C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBNUkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBNUkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 15:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302E2B2BA
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 12:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 422E8B81F1C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 20:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A794C4339B;
        Tue, 14 Feb 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676407217;
        bh=EaJ2+adD5MddIxnJ2Od4wJOTl0AMQF/WNuW6fjGV0Nk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fByuUdBG/5r5T9kJdwhRcDyg3F8DXjKCrv7/jWaWdHnnrw8pWE4bRV+Lg7Fs0hK9d
         SVUQYWaKPyDoFcVnU+KwOuVGiCnNqZcvro/flmHrf2PS6Rb/F+dT/fx0/TWl0pIhC5
         Bc8I2ko1MUwlTQUS9hLowV8kHHuw4kAtSNA1G0fNdmkEX6v0ryLLEx5aMaUBUgf5Yn
         GNMarr5ScHyQEgfJHchCuWsyqwCCcXbiQtUAGBGWnn8ufaka4TymE6wfntNlyr28Og
         H/1EqVawgHRDkx8baYzhpyOg7Q0dm7qwd56A/3HXhA9bOtX5OBLyvs3c3jjCEqAPOl
         t/LxSNeAZX5ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E45B9E68D35;
        Tue, 14 Feb 2023 20:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Do not require hardcoded interface numbers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167640721693.14815.1829404547628242837.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 20:40:16 +0000
References: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
In-Reply-To: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
To:     =?utf-8?q?Tomasz_Mo=C5=84_=3Ctomasz=2Emon=40nordicsemi=2Eno=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        carles.cufi@nordicsemi.no
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 7 Feb 2023 12:57:41 +0100 you wrote:
> Remove hardcoded interface number check because Bluetooth specification
> since version 4.0 only recommends and no longer requires specific
> interface numbers.
> 
> While earlier Bluetooth versions, i.e. 2.1 + EDR and 3.0 + HS, contain
> required configuration table in Volume 4 - Host Controller Interface
> Part B - USB Transport Layer, Bluetooth Core Specification Addendum 2
> changes the table from required to recommended configuration.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Do not require hardcoded interface numbers
    https://git.kernel.org/bluetooth/bluetooth-next/c/dbf27f4a6adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


