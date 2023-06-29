Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5726CC001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF2R7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjF2R7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 13:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743391BC2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 10:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC13615C9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 17:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E65BC433C0;
        Thu, 29 Jun 2023 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061582;
        bh=xeGig3ReUOO8qDN/BrObaTpjIyCxfRS1L93AP6EdMSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HhVpV+Td3XXnYgIk0mnfhNA712MfsypchvO8JSHhHfsmygntQrtktPYGrqvBTs4Gs
         4W8jrLoUl7Rr9pAGP3olKMMtGRMmhng6U8BtS85uBOMsLn7d4QsEWpGJwwghPeTNEw
         p3cxbUULyTqYsD5pYhsm3CQ+MyDJL384kKdaOXbDlp/1QfJNFlIl0cpQi8VS+5HX2K
         xZRuPFk74m6MPvQWTjE/f7EZt0zXxX5luKmKTw3KNR1hBjgDPEiTFkX2P0F7JGcVze
         bKwtlLwM35HT6eixNeARDiW+ySeCFu6VZXMNnbmREyVa4sf5MuHcAg9YATjdPSqSuo
         u7z33ruUnh6NQ==
Date:   Thu, 29 Jun 2023 10:59:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-06-27
Message-ID: <20230629105941.1f7fed9c@kernel.org>
In-Reply-To: <20230629082241.56eefe0b@kernel.org>
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
        <20230628193854.6fabbf6d@kernel.org>
        <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
        <20230629082241.56eefe0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 29 Jun 2023 08:22:41 -0700 Jakub Kicinski wrote:
> On Wed, 28 Jun 2023 22:01:05 -0700 Luiz Augusto von Dentz wrote:
> > >  a8d0b0440b7f ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations")
> > >  349cae7e8d84 ("Bluetooth: btusb: Add device 6655:8771 to device tables")
> > >  afdbe6303877 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
> > >  d1b10da77355 ("Bluetooth: L2CAP: Fix use-after-free")
> > >  c1121a116d5f ("Bluetooth: fix invalid-bdaddr quirk for non-persistent setup")
> > >  2f8b38e5eba4 ("Bluetooth: fix use-bdaddr-property quirk")
> > >  317af9ba6fff ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb")
> > >  a6cfe4261f5e ("Bluetooth: hci_bcm: do not mark valid bd_addr as invalid")
> > >  20b3370a6bfb ("Bluetooth: ISO: use hci_sync for setting CIG parameters")
> > >  29a3b409a3f2 ("Bluetooth: hci_event: fix Set CIG Parameters error status handling")
> > >  48d15256595b ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable")
> > >  f145eeb779c3 ("Bluetooth: ISO: Rework sync_interval to be sync_factor")
> > >  0d39e82e1a7b ("Bluetooth: hci_sysfs: make bt_class a static const structure")
> > >  8649851b1945 ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
> > >  5b611951e075 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally")
> > >  00b51ce9f603 ("Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy")
> > >
> > > You can throw in a few more things you think are important and are
> > > unlikely to cause regressions.    
> > 
> > Yeah, those seem to be the most important ones, do you want me to redo
> > the pull-request or perhaps you can just cherry-pick them?  
> 
> Nothing to add to that list?
> Let me see if I can cherry-pick them cleanly.

I pushed these to net now, hopefully I didn't mess it up :)
