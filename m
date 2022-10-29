Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 17:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ2RIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2RI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 13:08:29 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412049B63
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m8DGISEllBGbiA/WT3/5rcJdHAgrHJnE8nL33v5WsVo=; b=dTD/pISfPExLDDOkciF5mhPd8F
        bDYAh68Xb5FWgIq4i7n1nRNH9ZMDdW9fud/wVhUKuZrnN0BX/CWJMtZlvPctC+WHdg+U+0Da4rtsr
        mW/B8cd/FdQIcZRw9mRFgfXImtY9vxlrPi4TR4CKYbgOXQD8iDnEknAEJm1ZZbtYlYz86S30BGNzG
        8wIBHakb/s3AZ4sEE0sdt9sMg5F/dUzgGOFXNY1FLy7CWIzuFYVMRJgq9wnjgZb9ENFHCCwZn3qlv
        CTtoGEmusP3iJJkqcfZDgbre+9o+nmMMzz97yxpyI/T8/zk4uV44jntVAaexlTINTkU6BQgrYB8VA
        mdjPYmAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35026)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oopJn-0001mI-6y; Sat, 29 Oct 2022 18:08:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oopJj-0003hy-MG; Sat, 29 Oct 2022 18:08:19 +0100
Date:   Sat, 29 Oct 2022 18:08:19 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: BTLE scanning - requesting duplicates
Message-ID: <Y11eA1+dXINIpfn1@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm aware that in the bluetooth dbus API, there is the facility to
request duplicate filtering to be enabled or disabled. I wish to
disable duplicates, as some BTLE devices I have publish data rapidly
in their manufacturer data which I would like to capture.

However, it seems that setting a filter specifying the state of
DuplicateData in a filter does nothing - I get an update from the
MyNewt NumBLE based device about once every scan (so once every 10
seconds) which is way too slow.

I haven't found a way to speed this up. However, what I have noticed
is that no matter what I do, btmon says:

< HCI Command: LE Set Scan Parame.. (0x08|0x000b) plen 7  #88 [hci0] 149.394365
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4               #89 [hci0] 149.395217
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2    #90 [hci0] 149.395313
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The hardware is always told to filter duplicates no matter what I do.

Looking at the kernel code, net/bluetooth/hci_sync.c,
hci_active_scan_sync(), it seems that the facility _not_ to filter
duplicate data has never been implemented, except if we have
an "advertisement monitor" attached (what's one of those?)

Is there a reason why bluetoothd doesn't pass the request for
duplicate data to the adapter? Can it be made to do so? How would
that be achieved - can the management commands be modified to do
this?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
