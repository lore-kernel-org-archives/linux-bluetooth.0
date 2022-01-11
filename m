Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66479C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiAKUCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:02:50 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:40133 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbiAKUCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jan 2022 15:02:49 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 15:02:49 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641931007;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=Ap8JVWwAAH/ACE+XmiLMsYxQtdo8NhijAJBY7P+vCSw=;
    b=B7+VOcAwfEbl2aI6AUj3LepKSc7FUx6h26MXKyigqZf0za7s6W40mplQp0Aei4TDS8
    YjUBDMHsAq+XbAU0nO1vvrkFPW6cqbieEt0J0PHuAuH1UTKK+QoYB44IS6MfKrQgycKV
    6StVq1nycAaoCYrBwwar0mBZ+OLqdCr5hNsX64YzZXq64oJrLYHvkJmkcRYsTXoNs2v6
    QuZL4bX3kfNhFGorYLOTEfuGSvptHZEzyI7k1t1ze1i9MXAWxKxGxms7492/gODiD9AI
    RcpXu49sidYulUcCGnKggJ65VSTI0bvuDNHSW1ZE3c9CYWJfqkIj74vnGQ7LsMjjXp3M
    s9tQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVvBOfBkHJSg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfa:f904::923]
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Rb080by0BJulDsY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-bluetooth@vger.kernel.org>;
    Tue, 11 Jan 2022 20:56:47 +0100 (CET)
Message-ID: <0015e594-d888-f664-56c3-f4022286c736@hartkopp.net>
Date:   Tue, 11 Jan 2022 20:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Latest Linux tree (merge window): BT mouse does not work
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

after upgrading from Linus' tree 5.16.0-rc7-00108-g800829388818 to the 
current merge window version 5.16.0-05432-g6f38be8f2ccd my BT mouse is 
not working anymore.

I now get two new error messages:

	hci0: unexpected event 0xff length: 5 > 0

and

	hci0: unexpected event 0xff length: 7 > 0

Any idea? Any new firmware required?

Best regards,
Oliver

[    8.790201] Bluetooth: Core ver 2.22
[    8.847435] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 
2015
[    8.853022] Bluetooth: hci0: Device revision is 16
[    8.853025] Bluetooth: hci0: Secure boot is enabled
[    8.853026] Bluetooth: hci0: OTP lock is enabled
[    8.853027] Bluetooth: hci0: API lock is enabled
[    8.853028] Bluetooth: hci0: Debug lock is disabled
[    8.853028] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    8.855879] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi

[    9.422098] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.423532] Bluetooth: BNEP filters: protocol multicast
[    9.423537] Bluetooth: BNEP socket layer initialized
[    9.439281] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
[   10.391796] Bluetooth: hci0: Waiting for firmware download to complete
[   10.392752] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
[   10.392789] Bluetooth: hci0: Firmware loaded in 1492456 usecs
[   10.392985] Bluetooth: hci0: Waiting for device to boot
[   10.404942] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
[   10.404971] Bluetooth: hci0: Device booted in 11747 usecs
[   10.405416] Bluetooth: hci0: Found Intel DDC parameters: 
intel/ibt-12-16.ddc
[   10.407835] Bluetooth: hci0: Applying Intel DDC parameters completed
[   10.408848] Bluetooth: hci0: Firmware revision 0.1 build 50 week 12 2019
[   10.468582] NET: Registered PF_ALG protocol family
[   11.277319] Bluetooth: RFCOMM TTY layer initialized
[   11.277343] Bluetooth: RFCOMM socket layer initialized
[   11.277367] Bluetooth: RFCOMM ver 1.11


