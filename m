Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12573CD8CAC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 19:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJJTAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjJJTAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 15:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3093
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 12:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1D21C433C9;
        Tue, 10 Oct 2023 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964427;
        bh=3w0yveWHspSd50Jeu6a9zonjU6wQVEkzHym4yMEn1xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KjFrot4Ix0+2SbK6olbUGOdrhZCf1O8IEUfwV593wjIkW4ny0RNecOYWPOYE/p+xi
         SrH/UIuJ31joxqnYqablct4GcqZyEka7gqyQPYZVJ+LIeGUSPzedSj5e6t8K461XWT
         Z1WijJmQ4nUx+iRjbrpZcX6NiAbv02hmdQgq/coV5lsnLMibzR31G64xdHU/bd3w1V
         SXxOix4VXuiGqilZmayxy2R8Ok3GHzbRYcI2LPHZtv8xgFM4Po3htDAL10Zh9Ym9wJ
         ixDobe8DXJqGTSZ3RxSqnA/5Jf4PiV4+flh2P+rFOOhwpRfpC2kv3cgC/nlr/wLsao
         4xEGADbP5SYng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6AECC41671;
        Tue, 10 Oct 2023 19:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/11] doc/adapter-api: Rename to org.bluez.Adapter.rst
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169696442780.605.17167604884979162226.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 19:00:27 +0000
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Oct 2023 16:29:23 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This renames adapter-api.txt to org.bluez.Adapter.rst and generate a
> manpage org.bluez.Adapter.5.
> ---
>  Makefile.am               |   8 +-
>  doc/adapter-api.txt       | 373 ----------------------------------
>  doc/org.bluez.Adapter.rst | 412 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 416 insertions(+), 377 deletions(-)
>  delete mode 100644 doc/adapter-api.txt
>  create mode 100644 doc/org.bluez.Adapter.rst

Here is the summary with links:
  - [v2,01/11] doc/adapter-api: Rename to org.bluez.Adapter.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f7effa4534f
  - [v2,02/11] doc/device-api: Rename to org.bluez.Device.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=359132ba897e
  - [v2,03/11] doc/agent-api: Rename to org.bluez.Agent{Manager}.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42e2934c2356
  - [v2,04/11] doc/profile-api: Rename to org.bluez.Profile{Manager}.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5729e61b150
  - [v2,05/11] doc/network-api: Rename to org.bluez.Network{Server}.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6481b9095b34
  - [v2,06/11] doc/input-api: Rename to org.bluez.Input.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfc76016b4d4
  - [v2,07/11] doc/advertising-api: Rename to org.bluez.LEAdvertis*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dec59a07fb11
  - [v2,08/11] doc/gatt-api: Rename to org.bluez.Gatt*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6c412d6ccbc
  - [v2,09/11] doc/battery-api: Rename to org.bluez.Battery*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cba68babe1e6
  - [v2,10/11] doc/advertisement-monitor-api: Rename to org.bluez.AdvertisementMonitor*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87151d1904ad
  - [v2,11/11] doc/admin-policy-api: Rename to org.bluez.AdminPolicy*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee27626c7a06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


