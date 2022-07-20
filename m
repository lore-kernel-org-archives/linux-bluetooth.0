Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D82C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiGTQU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiGTQUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D9AAE72;
        Wed, 20 Jul 2022 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 510D4B81FB7;
        Wed, 20 Jul 2022 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65AFFC341D1;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658334017;
        bh=BM8hJxS2c6lrxc3PihLVapgJizE+rdCx1seTN/YGxkg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vFOHZKHmjQsn6d4jyaspOT2m71xAx0gwI6AeXalaulv6Qc9wSMke9wZmM5DeQLhzO
         JkO3BvCH5b6cP3LcJTMDDcu91JoHFBMjcovnGg68sLDjUPS/5fCBpvAo/62X09yzER
         jKKlDBdga/soLklUSGgBLV6e/BMPk9/7FDRkZ+hVK3sEj1wSrQMlIVsFEP/yAvH1Yu
         5vN9Y79PvZ7r5QgoBbvcvxKxyeAhkxLDJufquHu1ZCZpZVgBHZa8ClrcGb6PEkRzuV
         /U6uzoo0tPxa64CiG84fknSVohVATnL4z8CiudOfit3SSS2qPTjY3cyq0USpAgE0do
         CUKcn7YU6Gtjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4ED0CD9DDDD;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165833401732.6265.16625108181654949341.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 16:20:17 +0000
References: <20220625090358.9373-1-xw897002528@gmail.com>
In-Reply-To: <20220625090358.9373-1-xw897002528@gmail.com>
To:     xhe <xw897002528@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Jun 2022 17:03:57 +0800 you wrote:
> From: He Wang <xw897002528@gmail.com>
> 
> Add VID/PID 0489:e0e2 for MediaTek MT7922 Bluetooth chip. Found and
> tested with Asus UM5302TA.
> 
> From /sys/kernel/debug/usb/devices:
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/b4e7b216fd4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


