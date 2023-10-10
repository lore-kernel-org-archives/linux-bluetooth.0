Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3387CD98CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 23:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJJXk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjJJXk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 19:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777CC9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2DAAC433CA;
        Tue, 10 Oct 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696981224;
        bh=sZry2OL325LfLcj8MFcRLm48YYJux2YWvtP0vCNXZZM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gat5CitZGyCVxDTfhdAH+8iYZ/sik8px8vIu4lpMofdJTCymXuiFrF4n6JxR03Oiz
         Bn49pQDhVOUD69fxNJDRMxRyPpSCziMp6YDgghCGiV3KIQ+piayzKnTk8VzhoaF6bX
         lC+R/LvUPtYGKekhQQrZXK4au0xO37UyLdWW6SJ7w7k+p5g/UW6t9ZIGsH26ufeR3R
         4IDpzVsz4HCJqPkZEul/5DfeUeH+3ja5iUejv4PVRMVNFs/3kTzi1HNFMaAE+8x4Xe
         Upt+jqNMlFBFLnVs59geQDot9vKTuHq4lZm+wa56fEL2Utn8KoQsvN9LNWz2jtQkAt
         hTgRCgj9PUGQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85C1CE11F43;
        Tue, 10 Oct 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/1] VOCS Unit Test case implementation
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169698122454.27583.10967922744276267058.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 23:40:24 +0000
References: <20231010110549.14302-1-mahesh.talewad@nxp.com>
In-Reply-To: <20231010110549.14302-1-mahesh.talewad@nxp.com>
To:     Mahesh Talewad <mahesh.talewad@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        devyani.godbole@nxp.com, nitin.jadhav@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 14:05:48 +0300 you wrote:
> Hello Maintainers,
> 
> This Patch contains VOCS Unit Test case implementation:
> -Implementated all(10) mandatory VOCS unit testcases.
> -Tested above all mandatory testcases and working fine.
> -Specification referred for implementation:
> 	VOCS.TS.p1.pdf
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/1] unit/test-vcp.c: VOCS unit test case implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04f40b747fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


