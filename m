Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DCC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Mar 2023 19:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCLTKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Mar 2023 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCLTKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Mar 2023 15:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB655305CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 12:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FD6DB80D0E
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 19:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F15DFC4339B;
        Sun, 12 Mar 2023 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678648217;
        bh=cZuWfMJuNVBBn9fElFVy3elEVX1H2uCsql47KF+llig=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YV/r6ivkuDbN9iM+/pd3W8E9PUrfGZZzdkiNBzPYRcFQBxo6cVlaKUXnxatiFjY8i
         uqP+Nf2dZbnjN7NXV2zyrMOYG7CIbykmKX1Yvy0H9zZb30Oidf0vdHXsASvra2U31p
         beeVzR0jcXfkJAvsP805gK748y+hdHiiuxqKXViU7rckr592hyxUUzj0O6SzgKnqJO
         E39tuKdcRGgd0/gJNeQEh5IHkwgJHAfs7SnYoZcOoISJA/7wh37Mq4W5wWoBOqs3CU
         1HfAdtOTPybW7aLKZAxw0W2ZIPEcqHsEuEgqDJ5Jb3Zlkspa3cb202LdBLbEN9h/yd
         iB9V/0FxJ7Atg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7B42E61B76;
        Sun, 12 Mar 2023 19:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: Fix node when loading from storage
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167864821688.24346.4012009584216748603.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Mar 2023 19:10:16 +0000
References: <20230310013512.425033-1-inga.stotland@intel.com>
In-Reply-To: <20230310013512.425033-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     brian.gix@intel.com, brian.gix@gmail.com,
        linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Thu,  9 Mar 2023 17:35:12 -0800 you wrote:
> From: Inga Stotland <inga.stotland@gmail.com>
> 
> This fixes adding mandatory models (config server, remote provisioner)
> to a node whose configuration is being loaded from storage:
> mesh_model_add() was called with a wrong argument.
> 
> Was:     mesh_model_add(..., PRIMARY_ELE_IDX, ...);
> Correct: mesh_model_add(..., ele->models, ...);
> 
> [...]

Here is the summary with links:
  - [BlueZ] mesh: Fix node when loading from storage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40576ac1badf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


