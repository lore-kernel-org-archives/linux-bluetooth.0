Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52917E8FDC1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjJCXUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjJCXUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52EB4
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E96CC433C7;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375229;
        bh=ehYrD4zXwvJPWzahML2a/wbsaszioVaGbZzGsslQXsY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qYOvHLveC9RJ8L+gOUhNB6E7i4jVLjb2+N6+/dUsSwVUkUFdRYYeYznSi8EH3ONPj
         8S4G+0oNmDs9cki5eush0kbNoRDhyimS0OjGa66Y2+3huHKPsZvRMVPZVz1gfAN2do
         4XtBiZq2FdaiEL9mFPRhZCNJDX7ZzlPXyxqimc6ER6LraMm8VpU13I5V2jzVAx0QS3
         NPy6ZqeF+0Rq4/toFvB71x5ZqwGEAbbfLkA242O8+OUYqKTLM7mhSpa3n4CB8qSEys
         3JAY7W//T4TUazk1EYdzCjs2PtMSUyUF3EqPYQbZ5LoRVUkshtxmwAUQ7hmYG1K3cn
         FX3WPc01icHyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27DB9C595D2;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/6] shared/csip: Fix returning invalid data to
 attribute Size reads
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169637522915.21629.5652337863475710909.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 23:20:29 +0000
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Oct 2023 16:13:05 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The attribute Size value is stored in the size_val not on size member
> which represents the attribute object.
> ---
>  src/shared/csip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/6] shared/csip: Fix returning invalid data to attribute Size reads
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b938b05559d3
  - [BlueZ,2/6] shared/csip: Fix not requiring encryption
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1920af6f81f
  - [BlueZ,3/6] shared/csip: Fix not always reading SIRK value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=65b53b0d3a88
  - [BlueZ,4/6] device: Add btd_device_get_ltk
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c35304f32c42
  - [BlueZ,5/6] csip: Add support for SIRK encryption
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=267bf36d844b
  - [BlueZ,6/6] main.conf: Fix default of CSIS.encrypt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=954b8e5324fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


