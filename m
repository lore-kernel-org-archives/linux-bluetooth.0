Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3C56105A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhIPU3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhIPU3K (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:29:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DF2360FBF;
        Thu, 16 Sep 2021 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631824069;
        bh=35xd6wcthCtvlDSOMR3r3KKG6roF2GExHtBHQREnHgA=;
        h=Date:From:To:Cc:Subject:From;
        b=E//KkeOhhVRxk8nmYmvC6CtvQTYQ0UdS4N4xbPrhxgMdCTtWI56qCw+BQY3MZdAJH
         AZQnoK37NCFE1yj6pVtONHsccYz7ryMXxMR7OhSo/2mCh8lslX1UgCIUAfy11EtkpF
         46GOM3cc2xLep0NMLpp2mtc/ruVvAfAQBnT5xxArucmKHWptXVePzMUCoJ9IivAxKM
         tNCzw8TZkggCWLNUWzBKoGcZUWt//THYsI3H9F4aC90GheFKtDKoWevXNcFyAwDpj2
         BjTpl7XcONVuH3qdDbmpYpNAnGyeREH5joFvvdNf8XyvlOzLT7kRGJRds5/jkhEGTq
         snMQ64DpKX81A==
Date:   Thu, 16 Sep 2021 13:27:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Intel bt broken on linux-next?
Message-ID: <20210916132747.218fb12f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

looks like my Bluetooth stopped working after upgrade to linux-next 
as of yesterday (next-20210915). Is this a known problem?

[   19.594522] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[   19.595515] Bluetooth: hci0: Device revision is 2
[   19.595517] Bluetooth: hci0: Secure boot is enabled
[   19.595517] Bluetooth: hci0: OTP lock is enabled
[   19.595518] Bluetooth: hci0: API lock is enabled
[   19.595519] Bluetooth: hci0: Debug lock is disabled
[   19.595520] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   19.661829] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[   19.661924] Bluetooth: hci0: Boot Address: 0x40800
[   19.661925] Bluetooth: hci0: Firmware Version: 6-12.21
[   21.971023] Bluetooth: hci0: command 0xfc09 tx timeout
[   29.970995] Bluetooth: hci0: Failed to send firmware data (-110)
[   29.971108] Bluetooth: hci0: sending frame failed (-19)
[   29.971119] Bluetooth: hci0: Intel reset sent to retry FW download
[   30.123040] Bluetooth: hci0: sending frame failed (-19)
[   32.097392] Bluetooth: hci0: command 0xfc1e tx timeout
[   32.097408] Bluetooth: hci0: Failed to read MSFT supported features (-110)

I think it's part of:

00:14.3 Network controller: Intel Corporation Cannon Point-LP CNVi [Wireless-AC] (rev 30)
