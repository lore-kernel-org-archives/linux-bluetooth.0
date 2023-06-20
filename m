Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C47EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 18:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFTSa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFTSa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2610C2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 11:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0027B613F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FF3C433CB;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285824;
        bh=5ZOvxn/ue6ft8CKRq7q8k62kGoWfSWaU+d5FNR/7Rew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q2L/MbrbTe+GEuD1XKSTZ860qASMUupYpBF1hUZAV1GN7pXBGB5taxGorwFmsaRrc
         WXXUwcBKA+V0A2+A+rb89ZNFu1gEcxGbCdOVQYsru5q7V5yVwPTg+RaKvfRc2aS6G+
         pA91pS2hIL4dgSZOT8ad2ViLmljSEVAFZC/EAw2iD5LnxwIfK0EBRfKWgwBJEKCzXO
         DRp9p0MmSlWaFnO7oKx4/H2/AKmFmqo1iNGleRvaTiN8l79gg6yg61lqFwhENbI1+Y
         p2m8Hsu3Jk0lduUrU/5Y1uq++/jdaPlTdeU6ObTkvkjaggxASpC8n/ljhvdJk0IjHO
         8LS87qQX8IcMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41FC3C395D9;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v3] Bluetooth: btintel: Add support to reset bluetooth via
 ACPI DSM
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168728582425.12887.12508398484861046663.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 18:30:24 +0000
References: <20230611064342.1587278-1-kiran.k@intel.com>
In-Reply-To: <20230611064342.1587278-1-kiran.k@intel.com>
To:     K@ci.codeaurora.org, Kiran <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.nayaran@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 11 Jun 2023 12:13:42 +0530 you wrote:
> New Intel platforms supports reset of Bluetooth device  via ACPI DSM
> methods. The legacy reset mechanism via GPIO will be deprecated in
> future. This patch checks the platform support for reset methods and if
> supported uses the same instead of legacy GPIO toggling method.
> 
> ACPI firmware supports two types of reset method based on NIC card.
> (Discrete or Integrated).
> 
> [...]

Here is the summary with links:
  - [RESEND,v3] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
    https://git.kernel.org/bluetooth/bluetooth-next/c/41022e05ccf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


