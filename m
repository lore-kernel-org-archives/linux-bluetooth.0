Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1BEC7618E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 23:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjDTXUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTXUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 19:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867144AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 16:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F060060919
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 23:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50438C4339E;
        Thu, 20 Apr 2023 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682032819;
        bh=E6lOb7WH0s/PcZpge+JnJQAp4yw96WqLuwfrD10pvO8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OJKD3D6ZyNmixOa77NqFbOKeAuZtProALnEH48W5YO8EPTW8W3VBbiPDYe8wgUDOQ
         PCD0vBZiGnwAQLf7FhRTldFDbo7MZGM2VZE6OfBEHEHOvfUQCSPeTUYfOlhPZUbAze
         I8HJNGermqPb6zWnR6pbigvWveWkRhZtUXh67+PyfH2py/atIAMJREaxxsltRbntF/
         7uv38FupY32+j8O4BLifEMwVhS2gbYwcQlqsEBRqZaXOlFQurlLfHDhw085qJ0pl4D
         crRZmNSXrV0sogYeUW7AHWaK/Yk0W9EwzW7hB9qwL63vlWcpNfwGZp1b7AlSVYIb/1
         NjJ9Afy70ziTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E7AEE501E3;
        Thu, 20 Apr 2023 23:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5] obexd: AuthorizePush: Support to return folder name
 for file storage
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168203281918.18686.9493745108354852506.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 23:20:19 +0000
References: <20230420095557.22252-1-aarongt.shen@gmail.com>
In-Reply-To: <20230420095557.22252-1-aarongt.shen@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Apr 2023 17:55:57 +0800 you wrote:
> The obex agent usually returns the full path by getting the default
> folder and filename from the Filename property of the transfer object
> which is not convenient.
> 
> The patch helps that the obex agent can return the folder name suffixed
> with '/' or new full path or even null which will use the default name
> if new_name is NULL and the default folder if the new_folder is NULL in
> opp_chkput().
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5] obexd: AuthorizePush: Support to return folder name for file storage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d36160459404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


