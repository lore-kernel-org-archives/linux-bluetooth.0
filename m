Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4303E8FDC2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjJCXUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJCXUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FAEA
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64A4EC433CD;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375229;
        bh=Op44w+dedUEBys0nuiVoZMAEbd0x5es+D7Qx1hIE+HE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A0ONHQnHaRoRZqJW/Lducdp7cMGWDdMqPmylv4myiP9ZOAvbx4QOca9PsUAsmGzAl
         kqIuXVPmS9D8R7iuo+wdrJ84JT3O1CYSFjHN+dYM7w3fUYTKXE7Vd1TpV5mnxdrqbn
         SK3oM9Q1YPo0HcgUw8+XgyvemKn9WZ3Ic34qg415C7QRYbPQn/1rAXmoXVDsvXS4+N
         ps0nGe9cPnMF+kEO7JJ1OJiZo9EKbmA1CbJi+3rqOJSsiEKEs9MBVS5RwP3eyswUUQ
         Vz0BbpraCyaMaNW3SVFPnYTVR5FHnWSBjdTOIf4pmhqdqsTqF3oVbqu+BXnbHjVE9q
         sHk+iSa0G+j2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 495FAE270F0;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] bap: use MediaEndpoint related properties
 consistently
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169637522929.21629.18022470109434488634.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 23:20:29 +0000
References: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
In-Reply-To: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Oct 2023 22:19:03 +0300 you wrote:
> Use the documented name "MaximumLatency" for the MediaEndpoint QoS
> Max_Transport_Latency field, in SelectProperties input parameters and
> expected client MediaEndpoint properties.
> 
> Put QoS fields to a "QoS" dict in SelectProperties input.
> 
> Fix typoed ppd_min -> ppd_max in SelectProperties input.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] bap: use MediaEndpoint related properties consistently
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e582e34e392
  - [BlueZ,v3,2/2] doc: clarify org.bluez.MediaEndpoint documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6683305d827a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


