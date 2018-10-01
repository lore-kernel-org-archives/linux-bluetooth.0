Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05558C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7F5208AE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx5fiK9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7F5208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeJAUbO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:31:14 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:37488 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeJAUbO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 16:31:14 -0400
Received: by mail-it1-f169.google.com with SMTP id m9-v6so11486140ita.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SefswlylmvuGrAK148iLwgdRy4ntVzmMwH9jsu2uf1g=;
        b=Mx5fiK9bwSemCPeLVkptpvxWTr0ka4ekpb6cMhnOnvR/YxpiPrXPTXA9LINMjvuU38
         Xxg/6/swARckvZCC9syKmo2RxJNlL2ZER/OW4Jl/VmxtdWeRlsxzBYsTfaA+Y1/yJuVB
         e7MRMsSwcAgFB88AKIDlD9M8iexdxAM/nDEALMEAEmrWhwpz+Kp8DoM5IVJ5S58y5ZxZ
         24BzRnf4J0+w1j537dGypvXSJ1ml6FraXtRaX6ftypYJoEissXlrQeCMUv1XHPwS9k9e
         TjzXgPKVoMHFRPogFAUYXqLN1wk05hDwj1hQGFGZ6NQ00wllbztLvvphAArHE/y4f4x8
         8H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SefswlylmvuGrAK148iLwgdRy4ntVzmMwH9jsu2uf1g=;
        b=YwBvvAuuKrZiFM1Ro9QTjsXxvtMY+H7OG1O7kr+EOItsvfAoIaTPmL6uFvyfrGKhbG
         t/E/46ehTxcmJ6URlewocp4/CVgibiI/Ob4U2k309iULlHyP3J6rEyD3bntXdcmHjeHY
         2f4HBcYt7JD63Y2k6pvQpx2Se35GL7b0+mzIISk6u8K9oOfwGs8PElrs53igQJohhmjS
         I7AORXuIDH06fFB3Mvn6tS2S7LRB/7otnBrWXkKmFnG/jfAeZzm2ZdDEEAL6hjAxPrOT
         KhFWpjm9rs/bQeqEckGQs74Tui8HPqIzjzq3sRCbbpQYbqSxjiXPh60IqR3XXAcMs9kF
         xT/Q==
X-Gm-Message-State: ABuFfoh8gQBtWgSNNAlXxG59QUs8ccyLkc55H01w7na5xI1GJT8M9OlM
        pLYVSYVEi87roLq+BDdi5iAY1VrslFCfdr3W0Xc=
X-Google-Smtp-Source: ACcGV62nSR31O9JiaLcpUkqkSbctF455tTWd7QuQg4NmQzOl6xJgVm65dUZasm6JIVA7yJVC1tITV1b+iHfF7Q20gLw=
X-Received: by 2002:a24:ac44:: with SMTP id m4-v6mr9675691iti.90.1538401998979;
 Mon, 01 Oct 2018 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181001102430.GA6708@amd>
In-Reply-To: <20181001102430.GA6708@amd>
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 1 Oct 2018 14:53:07 +0100
Message-ID: <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
To:     pavel@ucw.cz
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There has been a discussion on the mailing previously that covered some of this.

Is there anything in this thread that helps:
https://marc.info/?t=149208458400001&r=1&w=2

On Mon, 1 Oct 2018 at 11:25, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I'm trying to get gatt client/server to run; my ultimate goal is to
> turn Linux machine into "low-energy device", providing services
> similar to heartbeat measurement.
>
> I do have existing qt application (running on Android and PC) I'd like
> "device" to talk to.
>
> TODO says:
>
> - Add complete GATT test coverage in unit/test-gatt following the GATT
>   test
>     spec. This could use shared/gatt-client and shared/gatt-server at
>   the same
>     time to test both against each other. We should definitely have
>   tests for
>     gatt-server and gatt-client simultaneously on one side of the
>   connection.
>
>   Priority: High
>     Complexity: C4
>
> Which tells me that maybe I should consider helping with that. But so
> far I was not able to get it to work...
>
> I can use gatt-server and connect to it using gatttool, but depending
> on details during the server start (?) and phase of moon, either
> device is not enumerated by the QT code, or it is not detected as
> low-energy device, or no UUIDs are detected.
>
> My attempt at launching server is below (using python gatt-server, (1)
> ). I was doing "hciconfig leadv 0" manually at some point.
>
> Using hciconfig while bluetoothd is running sounds kind-of
> dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
> things got slightly different, but did not start to work for me. Is
> there documentation how to get this to work somewhere?
>
> Thanks and best regards,
>                                                         Pavel
>
> (3)
> sudo tools/btmgmt -i hci0 power off
> sudo tools/btmgmt -i hci0 le on
> sudo tools/btmgmt -i hci0 connectable on
> sudo tools/btmgmt -i hci0 name "some friendly name"
> sudo tools/btmgmt -i hci0 advertising on
> sudo tools/btmgmt -i hci0 power on
> tools/btgatt-server -i hci0 -s low -t public -r -v
>
> (2)
> https://stackoverflow.com/questions/29128586/bluetooth-low-energy-in-c-using-bluez-to-create-a-gatt-server#31030321
>
> (1)
> #!/usr/bin/python3
> # -*- python -*-
>
> import os
> import re
> import time
>
> def pcmd(c):
>     return os.popen(c).readline()[:-1]
>
> class Ble:
>     def down(m):
>         print("Shutting down BLEE")
>         os.system("sudo killall bluetoohd")
>         os.system("sudo killall gatt-server")
>         os.system("sudo hciconfig hci0 down")
>
>     def up(m):
>         print("Starting up BLEE")
>         os.system("sudo ../bluez/src/bluetoothd -d -n &")
>         time.sleep(2)
>         os.system("sudo ./gatt-server &")
>         time.sleep(2)
>         os.system("sudo hciconfig hci0 up")
>         ##os.system("../bluez/test/example-gatt-server &")
>         while True:
>             #os.system("sudo hciconfig hci0 leadv 0")
>             time.sleep(5)
>
>     def run(m):
>         m.down()
>         time.sleep(1)
>         m.up()
>
> b = Ble()
> b.run()
>
>
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
