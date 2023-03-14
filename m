Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1034C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCNXK1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNXKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 19:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F35367F7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A141861A7C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04ADBC433EF;
        Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678835421;
        bh=KTDqeIR8HAU6iLvFXnhz5+bemUkmPO/ZLoumjwKMzEc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sif2jruNMqRKiHfFfB6OEahDyo2UnSidflwW8tF04RkWyV1KGqqGbmU6fO6y0LgxR
         2zdt64jBPDDU1wHmc/0B37k1IvmqcWfDkKHD2J/8/9V9lSoM93Ii39jJGLzB7FTxza
         VfB7Y9jMEU8g6BacCMJbwrtHsrK24xCCu22zu87a+KLdO8rFRuzbfpeXPPs/JjVIGL
         LP1smacP0S8UqPC0rxVwRbKIEyWhAnL7Fqd0tXDC0ZQssj3eGh1L+GPk923kt1o61O
         iYOnQcmeFn1PiVMwy2Up1EuRmWDbmQAEIfgR7FawSKDhGA5GRYmOi8wdDrffKQ/5iF
         MwSCGWzmwhI9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1412E66CBC;
        Tue, 14 Mar 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Improve support for Actions Semi ATS2851 based
 devices
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167883542091.4543.4466227373690842432.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 23:10:20 +0000
References: <20230310151410.2686458-1-rcheleguini@google.com>
In-Reply-To: <20230310151410.2686458-1-rcheleguini@google.com>
To:     Raul Cheleguini <rcheleguini@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Mar 2023 15:14:10 +0000 you wrote:
> Add two more quirks to resume the device initialization and basic
> operation as the device seems not to support "Read Transmit Power"
> and "Set Extended Scan Parameters".
> 
> < HCI Command: LE Read Transmit Power (0x08|0x004b) plen 0
> > HCI Event: Command Status (0x0f) plen 4
>       LE Read Transmit Power (0x08|0x004b) ncmd 1
>         Status: Unknown HCI Command (0x01)
> 
> [...]

Here is the summary with links:
  - Bluetooth: Improve support for Actions Semi ATS2851 based devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/2dc354d004ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


