Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10962C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiCEAWB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCEAWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 19:22:00 -0500
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 16:21:11 PST
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05F259F5A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 16:21:11 -0800 (PST)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4K9Q3x5HGczDS3
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 19:06:05 -0500 (EST)
Received: from xps-7390 (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4K9Q3t4mvPz2t2f;
        Fri,  4 Mar 2022 19:06:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1646438763; bh=casus4L3TbPO2zm3BnR5igubAf9LxZR+oexTj4DCcrM=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=vkZLEOQKrBtu5oe4ZGzZAn3HG7sHolnEU0ds+AsXQ4I6KkhL4SxVPmDwdlJW6jTco
         8pG1Uu9/FNdapKjNkOSYLXUQRmxwSCd7PRuLKXSFzzNxD1Jenl3aVsD8enz7Kt7R/0
         nmt5boFy0qpMx/xZoPc9XZ0yTrwdKiV1Qc4ESHt4=
Date:   Fri, 4 Mar 2022 16:03:52 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>, regressions@lists.linux.dev,
        marcel@holtmann.org
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <3bc9bbab-b3cd-4c52-cc33-5d723d973deb@panix.com>
Message-ID: <28e1099-76a-3b8d-b6d2-84dbde9ab853@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com> <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
 <76f65c9-e031-3870-9dfb-49f8969534ae@panix.com> <6f3b9dbb-6ecf-cfea-2127-cb3360d78431@panix.com> <3bc9bbab-b3cd-4c52-cc33-5d723d973deb@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Sat, 29 Jan 2022, Kenneth R. Crudup wrote:

> So, it turns out that my lack of discoverability is also tied into this last
> series of BT commits

So, after "for-net-next-2021-11-16" was pushed into Linus' master, my Laptop's
Bluetooth has been horribly broken; I can't add new devices (says "can't put
your adaptor into Discoverable mode"), and my MS ArcTouch mouse (and who knows
what else) doesn't work anymore. I also get stalls/crashes from the BT system
when trying to shutdown or reboot.

This is a *serious* regression- I had to revert the entirety of that merge.
I keep checking the BT changes that have made it to Linus' master of late (and
even monitoring the Bluetooth git), after nearly 6 weeks, BT is still broken-
certainly I can't be the only person seeing these issues. I did see where
someone had a regression about not being able to do scans, and that was fixed,
but trying that commit (since merged to master) doesn't fix anything for me.

My BT adaptor is an Intel AX201 on USB:

----
[Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
[Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Boot Address: 0x24800
[Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Firmware Version: 126-5.22
----

----
Bus 003 Device 003: ID 8087:0026 Intel Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x0026
----

What can I do to help you fix this?

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
