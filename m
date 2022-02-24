Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F20C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 15:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiBXPoH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiBXPoG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 10:44:06 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51E1A39F8
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 07:43:31 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee05.dynamic.kabel-deutschland.de [95.90.238.5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D108A61EA193B;
        Thu, 24 Feb 2022 16:43:29 +0100 (CET)
Message-ID: <fc74637a-f3c8-7870-82ec-90bf55b60462@molgen.mpg.de>
Date:   Thu, 24 Feb 2022 16:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
 <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
 <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Maxim,


Am 24.02.22 um 14:01 schrieb Maxim Levitsky:
> On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:

>> On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky wrote:
>>> Today I updated to a new kernel and I am bisecting few 
>>> regressions:

[…]

> I do notice that even on 5.16 kernel, I am not able to use the HSF
> or whatever low quality bi-directional bluetooh protocol is called
> for my headset. Used to work, I don't know what broke it, likely not 
> related to this.
> 
> I also updated bluez to 5.6 by installing fedora 33 package, and 
> initially it seems to work, but after reboot, the issue shows up 
> again. Looks like sometimes the scan does work. So far I wasn't able 
> to make it work even once since then. Reloading btusb doesn't help. 
> Can't install newer package due to deps on glib sadly. I might be 
> able to compile it from source, but that will take some time to 
> figure out how the components of the bluez stack are connected 
> together.
> 
> For the reference I have 'Intel Corp. AX200 Bluetooth' and I have
> the same device on my AMD laptop and both have USB ID 8087:0029 My
> AMD laptop has Fedora 34 though.

Sorry, I lost track, if it’s still about one regression, you 
successfully bisected or not.

Anyway, passing through the USB Bluetooth device to QEMU helped me [1], 
and might help you to overcome the dependency problems. (My steps 
actually worked, but turned out the Linux kernel commit I tested with 
had another regression not making the Bluetooth controller initialize.)

Marcel also replied, he is using btproxy to debug issues, but I did not 
try it, as it wasn’t clear to me how to get it working easily, and he 
also wrote something about non-public patches.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-bluetooth/5891f0d5-8d51-9da5-7663-718f301490b1@molgen.mpg.de/T/#u
