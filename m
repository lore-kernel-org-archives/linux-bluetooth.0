Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B4C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 16:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjEBQkb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjEBQk3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 12:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D91704
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 09:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A09F361CC2
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DEC9C433D2;
        Tue,  2 May 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683045625;
        bh=gTv/s2Fw0HGLsxyhJekqNjnZFobd8a3vyyWQ8J55j7A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GU//+vduFnvAT877z1EAcEv4WAzu1Iikyu1Nck7JPh8/WKg8LcHR7Vtjotfkfvn75
         kdLJ2buJZAfktnkDWPFSSakoZikv7q8Ttv36E2Yde5DTXO7y06ZAdj7Dc1gyPSd/VX
         Ich+kwA/SiQslUCtFTS/i5dXUBU/rIllgx+94vcnLGCfAxR8P7xPC7SYwdwQFIqT5T
         uUHGvM7FTqbbNbx6Ohj6Y60P11g+Rm9QVu/i0YHftP0kGf6uLCHqZ3MgebbVV2gDf7
         y0SxYoFK0gawh5sDj4SQQYBFzHFdaaO9G9Xj4GZpCaHC/iCBzsBKwl+/if3ofUrvSU
         MusGWq3D3m3pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3C19C3959E;
        Tue,  2 May 2023 16:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v3 1/4] client/player: Add support for Metadata in BAP
 Profile
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168304562492.30534.15786529408054715744.git-patchwork-notify@kernel.org>
Date:   Tue, 02 May 2023 16:40:24 +0000
References: <20230501224410.1119023-1-luiz.dentz@gmail.com>
In-Reply-To: <20230501224410.1119023-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 May 2023 15:44:07 -0700 you wrote:
> From: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
> 
> This adds support for Metadata in BAP profile.
> In order to register zero Metadata, 0 shall be
> entered when prompted.
> 
> [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Enter Metadata (value/no): n
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] CIG (auto/value): a
> [/local/endpoint/ep0] CIS (auto/value): a
> Capabilities:
>   03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
> Endpoint /local/endpoint/ep0 registered
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] client/player: Add support for Metadata in BAP Profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9376b13b3fe
  - [BlueZ,v3,2/4] client/player: Fix crash when RegisterEndpoint fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=416b8375ffde
  - [BlueZ,v3,3/4] shared/shell: Fix not releasing prompt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b88ee29ff1d
  - [BlueZ,v3,4/4] shared/shell: Fix smatch warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3818b99c764e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


