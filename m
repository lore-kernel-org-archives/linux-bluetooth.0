Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhLVIoi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:44:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49632 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbhLVIoi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 03:44:38 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1E353CED09;
        Wed, 22 Dec 2021 09:44:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: Reconciling hcidump output with btmon
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <202112130042.1BD0ggg43001872@d7010.compata.com>
Date:   Wed, 22 Dec 2021 09:44:36 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DFE94A07-4AA7-483F-BC5D-3388C0A3058B@holtmann.org>
References: <202112120540.1BC5evj82621220@d7010.compata.com>
 <506218C2-CFDA-4DD9-A55B-14C8A8E3D5C2@holtmann.org>
 <202112130042.1BD0ggg43001872@d7010.compata.com>
To:     Dave Close <dave@compata.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

>> I understand that "hcidump" has been deprecated for several years. Yet
>> the output of "btmon" seems to imply that it is calling "hcidump". That
>> doesn't make sense to me. For example,
>> 
>> @ RAW Open: hcidump (privileged) version 2.22 {0x0002} [hci0] 1.894682
>> @ RAW Open: hcidump (privileged) version 2.22 {0x0003} 1.894702
>> @ RAW Close: hcidump                          {0x0003} 1.894708
>> @ RAW Close: hcidump                          {0x0002} [hci0] 1.894718
> 
> Marcel Holtmann answered:
> 
>> I don't know what that is, but it seems that something else in your system is 
>> calling hcidump binary. However it is for sure not btmon calling the hcidump b
>> inary and you can verify that in the btmon source code.
> 
> The lines I quoted are from the stdout of btmon. How would something else
> get output mixed into that? Is the Fedora version of btmon modified?

because the monitoring socket also records other binaries opening certain Bluetooth specific sockets.

And that is for exactly this reason. Something stupid is going on in your system.

> 
>> The hcidump -R functionality is rather useless. If you really want it, then yo
>> u can get it by opening the monitor socket directly. I really don't know what 
>> you wanted it for.
> 
> I wanted to see the actual data stream from my devices. So far as I can
> tell, I can't get that from any of the undeprecated Bluez tools.

It is a socket. Many tools can dump the raw socket. I think it would be a 3 liner in Python for example. Use tshark or something alike if you want a raw data stream. Looking at raw HCI data is totally pointless.

Regards

Marcel

