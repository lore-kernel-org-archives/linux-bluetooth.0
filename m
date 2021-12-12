Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Dec 2021 14:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhLLOt4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Dec 2021 09:49:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41299 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLLOt4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Dec 2021 09:49:56 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0BD2ECED20
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Dec 2021 15:49:55 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: Reconciling hcidump output with btmon
Date:   Sun, 12 Dec 2021 15:49:54 +0100
References: <202112120540.1BC5evj82621220@d7010.compata.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <202112120540.1BC5evj82621220@d7010.compata.com>
Message-Id: <506218C2-CFDA-4DD9-A55B-14C8A8E3D5C2@holtmann.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

> When I run "hcidump -R", I see (among other output) lines like these,
> 
>> 04 3E 26 02 01 03 01 69 57 93 F1 99 F8 1A 02 01 04 09 09 39
>    36 37 35 39 39 38 46 07 16 09 18 EB 03 00 FE 04 16 0F 18 3E
>    A5
> 
> But trying every available option for "btmon", I can't find anything
> remotely similar. How can I get this information using "btmon"? Or can
> I -- does "btmon" show this type of information? Is there some other
> command that would be more appropriate?
> 
> I understand that "hcidump" has been deprecated for several years. Yet
> the output of "btmon" seems to imply that it is calling "hcidump". That
> doesn't make sense to me. For example,
> 
>  @ RAW Open: hcidump (privileged) version 2.22 {0x0002} [hci0] 1.894682
>  @ RAW Open: hcidump (privileged) version 2.22 {0x0003} 1.894702
>  @ RAW Close: hcidump                          {0x0003} 1.894708
>  @ RAW Close: hcidump                          {0x0002} [hci0] 1.894718

I don’t know what that is, but it seems that something else in your system is calling hcidump binary. However it is for sure not btmon calling the hcidump binary and you can verify that in the btmon source code.

The hcidump -R functionality is rather useless. If you really want it, then you can get it by opening the monitor socket directly. I really don’t know what you wanted it for.

Regards

Marcel

