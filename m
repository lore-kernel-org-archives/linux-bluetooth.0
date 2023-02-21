Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7AC61DA3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Feb 2023 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBUWa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBUWaZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 17:30:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48732CF2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 14:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671AF611EE
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 22:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1862C433D2;
        Tue, 21 Feb 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677018618;
        bh=02j/BttkKv+dLKaxtCqwcxG9pJzi5r3gX+S7zmzm8fc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hZdZ/5hL4SEXXWJ6ERTUG9mRyKF5MBlSigAXV0wYAklYyEJsfkv1Xu1UyNUwoFse4
         qdPdgRZqHXpOAClDMsRQ3C4m1po0OlLK2cnuYq7RSVNpkAayvXUqVCiLg75scSgFAp
         k8/IWlwSKVmHwQ0CS9fBy/mJ1rmXdSbow2mKowFT5Rx8NP3rDGDp4A2g/nA3YYynFh
         wdyHnAYqecIpywwNmyn9zNKHfwwqwoCX9Y96+Uott7NR7XvKMRizMnuP99cLFkw1Od
         rRgocyK3JU9hzx055ZnhsCTUf/lcG3+18NaEKYADVJ2XrH0Ig4dsiMIkdJqdLO3ics
         Mk+lG6fHC0GnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4F41C43161;
        Tue, 21 Feb 2023 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v2] configure: Check ell path
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167701861873.4644.12485324441456071942.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Feb 2023 22:30:18 +0000
References: <20230220181205.1577283-1-hj.tedd.an@gmail.com>
In-Reply-To: <20230220181205.1577283-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Feb 2023 10:12:05 -0800 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> If the 'enable-external-ell' is not specified in the configure parameter,
> the build system assumes that the ELL source is located same level where
> the bluez source is cloned. But the configure doens't check the folder
> and user will get the build error while building the source.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] configure: Check ell path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1106b28be85a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


