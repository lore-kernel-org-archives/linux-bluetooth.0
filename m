Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB48EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHEHbg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEHbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 03:31:34 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E64EC8
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 00:31:32 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aefd9.dynamic.kabel-deutschland.de [95.90.239.217])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 752DC61E5FE06;
        Sat,  5 Aug 2023 09:31:10 +0200 (CEST)
Message-ID: <47e6ab77-e1dd-4ede-b75d-f484b2593395@molgen.mpg.de>
Date:   Sat, 5 Aug 2023 09:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
To:     Bruno Pitrus <brunopitrus@hotmail.com>
References: <2300626.ElGaqSPkdT@bruno-beit>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
        Takashi Iwai <tiwai@suse.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2300626.ElGaqSPkdT@bruno-beit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Cc: +regressions@]

#regzbot introduced v6.3.9..v6.4.2

Dear Bruno,


Thank you for your report.

Am 04.08.23 um 20:55 schrieb Bruno Pitrus:
> I am using openSUSE Tumbleweed on a Dell Precision 3551 which has a
> bluetooth adapter of ID 8087:0026 (Intel AX201). I am using a
> Logitech M575 trackball mouse which only supports Bluetooth LE.
> 
> With kernel 6.4.2 or newer, scanning for devices — using either the
> KDE gui or bluetoothctl — most of the time returns only “classic
> bluetooth” devices like computers and phones, and not the mouse. If
> the mouse was paired before, it works correctly however.
> 
> With previous kernel versions (6.3.9 and before), pairing the mouse
> worked correctly.

Are you able to bisect the regression? Please also attach the Linux 
messages. (You can also create a ticket in the Linux kernel Bugzilla [1] 
and attach everything there.)


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/
