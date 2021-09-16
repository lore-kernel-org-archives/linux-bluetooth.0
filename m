Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0217E60F4A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhIPV5s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhIPV5r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 17:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 445F861074;
        Thu, 16 Sep 2021 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631829386;
        bh=KqcwjMSbYMAR0WEwC7rc9H2/fH2JYcnSySalojHI2s8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYAKiL9AXWsjfc4KK/mv+LhMr9K+MeXxcID0ZGH0gEpcTDCQRLGN8FXJfCZ6hBba9
         y22LP+aQQwuJ8XdpbzGtCef34GrQu1R6LrQBWWMLO25szksQOeQs+XJTkMOicDSv6K
         AscvhFdlC5crsYEeL9W0e81LQW32SOGpR1wcnMdez0HrSlgCShVGMM7jfGzKjoXR6l
         m/5yFyvCcnx4GLS4mBgDWIPhY2iaZTpRLSI5cXIlmoywpNC6zRUCnebtKiNzR5yCs5
         F3TeQZ1OLb7cIXljHx83Hx+8tyO7SqqHImuyyWy/NzlYlt33h1AzbmWyzNwd/RmDHi
         3VfTp577mF20g==
Date:   Thu, 16 Sep 2021 14:56:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Intel bt broken on linux-next?
Message-ID: <20210916145625.4e0b8c8e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <ae7804e8a9877f94a7c798ac4c787a7f7f7f21af.camel@linux.intel.com>
References: <20210916132747.218fb12f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <ae7804e8a9877f94a7c798ac4c787a7f7f7f21af.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 16 Sep 2021 14:46:13 -0700 Tedd Ho-Jeong An wrote:
> > looks like my Bluetooth stopped working after upgrade to linux-next 
> > as of yesterday (next-20210915). Is this a known problem?
> > 
> > [   19.594522] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
> > [   19.595515] Bluetooth: hci0: Device revision is 2
> > [   19.595517] Bluetooth: hci0: Secure boot is enabled
> > [   19.595517] Bluetooth: hci0: OTP lock is enabled
> > [   19.595518] Bluetooth: hci0: API lock is enabled
> > [   19.595519] Bluetooth: hci0: Debug lock is disabled
> > [   19.595520] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> > [   19.661829] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
> > [   19.661924] Bluetooth: hci0: Boot Address: 0x40800
> > [   19.661925] Bluetooth: hci0: Firmware Version: 6-12.21
> > [   21.971023] Bluetooth: hci0: command 0xfc09 tx timeout
> > [   29.970995] Bluetooth: hci0: Failed to send firmware data (-110)
> > [   29.971108] Bluetooth: hci0: sending frame failed (-19)
> > [   29.971119] Bluetooth: hci0: Intel reset sent to retry FW download
> > [   30.123040] Bluetooth: hci0: sending frame failed (-19)
> > [   32.097392] Bluetooth: hci0: command 0xfc1e tx timeout
> > [   32.097408] Bluetooth: hci0: Failed to read MSFT supported features (-110)
> > 
> > I think it's part of:
> > 
> > 00:14.3 Network controller: Intel Corporation Cannon Point-LP CNVi [Wireless-AC] (rev 30)  
> 
> I don't think it was known issue to me. 
> What was your previous kernel before switching to next-20210915?

v5.14.3

> Also, do you still have a problem after cold reboot the system? (completely shutdown and wait some
> seconds before start).

Let me get back to you on that.

Thanks!

> From the log above, the command (0xfc09) is failing which the device may in the weird state.
