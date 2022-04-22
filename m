Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 09:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446039AbiDVJdL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446108AbiDVJdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 05:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48E4EF6D
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 02:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD898B82B7F
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B3F9C385B5;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650619812;
        bh=uZair5wIdcfRAcFneI5mJ2YtmYXtWA580mHptbZYx9Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sbWaq/+hZxdZOT+Dy9hib8i8WHK0yV9E26AUROF462jxLtUSBS5/+bdQtaFRrCO4e
         IxTTUWTn4B5tXcqdgQM2qhkcgVORN8O0X62tJN8AQOQBH8at2yiNPC3GRDTUNK41Q4
         GEgQ9Hs6RoK7gaq9z+dyRSzulqbjz2Fmife2QiJ0qZNRRFK4Q53orO96slA73ZGzYc
         WDqbU1XV9w3WZbKEN3O//adSUSPGnil76oPZaAD3o4EhksysTBPwh414cHNmop+Ksi
         n608uyqbhaH+HeI2PbgjSpBbTwgdIvCsdZr7opFD7vE2X06CyWkedNflC3RSlgtB3z
         bkQ+PwMfOCNhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53761F0383D;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: use hdev lock for accept_list and reject_list
 in conn req
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165061981233.24106.17851581389197850076.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 09:30:12 +0000
References: <20220405173751.7269-1-dossche.niels@gmail.com>
In-Reply-To: <20220405173751.7269-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Tue,  5 Apr 2022 19:37:52 +0200 you wrote:
> All accesses (both reads and modifications) to
> hdev->{accept,reject}_list are protected by hdev lock,
> except the ones in hci_conn_request_evt. This can cause a race
> condition in the form of a list corruption.
> The solution is to protect these lists in hci_conn_request_evt as well.
> 
> I was unable to find the exact commit that introduced the issue for the
> reject list, I was only able to find it for the accept list.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: use hdev lock for accept_list and reject_list in conn req
    https://git.kernel.org/bluetooth/bluetooth-next/c/1072b8391c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


