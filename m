Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A4BC4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 07:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A764D61378
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhFAIAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAIAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 04:00:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F2C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 00:58:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r4so14297757iol.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bb8cLuWDTJGmbqMSaVlK1hmVmz7zZt9b8ocn5hrCOx0=;
        b=FoT2cvn5/ctUgKqcCIH3DKrcvQkXlAqpQRg7QF8kIo8J7imbL9bL6gc8gGMmRALMBm
         QZbtDiwcrOhUvjbcYTQCKILWOe237DFKFTJ4B0V3qi2sXREU58CFVGaHJ99fkxOcL/Ve
         vq+X1NkpzVfCXg14QK/soKTtGaSfL/2PTDnmYbtBjIyEdUj1Rg5iNR1ewT+xQ7GZgirE
         7wB5v/l3lLoA2zEzQoGxVVkodChYdX9Qn8ev6yqXVj8TbQj1416RX+hbkRM/74cW/hxo
         PXocXhB22edTM4d2bHBeUxpTh1Tq/jX00iTaVf4PadKjNmLQ5m6M7x901a9FJKn3EHKL
         hJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bb8cLuWDTJGmbqMSaVlK1hmVmz7zZt9b8ocn5hrCOx0=;
        b=t4k6Gfm135KxwPGOrFCNWnrasbt6cBIs5Sn4zD1o1jfKCUTq3aeRbUL9AmL3Go4rLC
         L/D0D2Ax97L7elQFTMCIfJyOpuxhwiHIwfJQEZ/KSNbwr8ncjDgeys+1n75SQ86MB0xN
         59FCdnFbO4gGmTp39bEIS5wH9ToY7Axd96ooFkMXBJFtr1JqNMoNRiwc8gS8dQKOgT/6
         BvkGy7bMWpd398YapaCjh1bV9XP+U3bzkR/zxP/od9wH3LHceYVHaJ96kympGFrti3c0
         BiWwBNN7+d4TlcqmPslBTPbp8xehYFQGeiDaz7hQ125QUWJsoDCj4pRcAFdLJUG40CuK
         s2XQ==
X-Gm-Message-State: AOAM530IJGviq3yLEseCckXJ8ek9iL+E1i9+lM+CmG8FeNVhlxjwODA4
        Vu59wmP1zMziFSWnupS4Be8+ElvKLzKuLZAkM3M1lVMEQIf3
X-Google-Smtp-Source: ABdhPJylmLSiIBZVG+4o41V9px8xtrp7Vy3+E8pe8W3L/wIc53OAg8oRKXgpQ190cI1nErzTG9z8mTfMdrPKnlpRzdU=
X-Received: by 2002:a05:6602:1243:: with SMTP id o3mr19844166iou.93.1622534336542;
 Tue, 01 Jun 2021 00:58:56 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Bian <kennybian@gmail.com>
Date:   Tue, 1 Jun 2021 00:58:41 -0700
Message-ID: <CAC9s0NZGAJH-7Ojbx_nrAu-nB+KRYKak2prD14YZhWgOx-Ow-A@mail.gmail.com>
Subject: How to install manually built BlueZ 5.50 on board?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I managed to build BlueZ 5.50 by using Ubuntu 18.04. I did the cross
compilation for the code for the armhf architecture.

I copied the build folder to the embedded Ubuntu board. I then run
"make install" but get errors:
checking whether the C compiler works... no
configure: error: in `/home/user/bluez-5.50':
configure: error: C compiler cannot create executables
See `config.log' for more details
Makefile:3310: recipe for target 'config.status' failed
make: *** [config.status] Error 77

I then tried to manually install the build on the board. I tried "make
install" on my VirtualBox Ubuntu Desktop. So I used the similar way to
install the build(all of the folders are already created):
sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
client/bluetoothctl monitor/btmon tools/rctest tools/l2test
tools/l2ping tools/bccmd tools/bluemoon tools/hex2hcd
tools/mpris-proxy tools/btattach '/usr/bin'
sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
src/bluetoothd obexd/src/obexd '/usr/lib/bluetooth'
sudo /usr/bin/install -c profiles/cups/bluetooth /usr/lib/cups/backend/bluetooth
sudo /usr/bin/install -c -m 644 src/bluetooth.conf '/etc/dbus-1/system.d'
sudo /usr/bin/install -c -m 644 obexd/src/org.bluez.obex.service
'/usr/share/dbus-1/services'
sudo /usr/bin/install -c -m 644 src/org.bluez.service
'/usr/share/dbus-1/system-services'
sudo /usr/bin/install -c -m 644 tools/rctest.1 tools/l2ping.1
tools/bccmd.1 tools/btattach.1 tools/hid2hci.1 '/usr/share/man/man1'
sudo /usr/bin/install -c -m 644 src/bluetoothd.8 '/usr/share/man/man8'
sudo /usr/bin/install -c -m 644 tools/97-hid2hci.rules '/lib/udev/rules.d'
sudo /usr/bin/install -c -m 644 src/bluetooth.service '/lib/systemd/system'
sudo /usr/bin/install -c -m 644 obexd/src/obex.service '/usr/lib/systemd/user'
sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
tools/hid2hci '/lib/udev'

My questions are:
1. How to install the build on the board? "make install" doesn't work.
2. How can I tell if the build is installed correctly?
3. How can I verify if the BlueZ 5.50 works or not?
4. I tried "sudo btattach -B /dev/ttymxc2 -S 921600", but btattach doesn't exit:
Attaching Primary controller to /dev/ttymxc2
Switched line discipline from 0 to 15
Device index 0 attached
5. I also tried "sudo /usr/libexec/bluetooth/bluetoothd". There is no
output. "bluetoothd" doesn't exit either. By the way, "bluetoothd"
doesn't run after the build is installed. So I try to manually run it.
6. By running "/usr/libexec/bluetooth/bluetoothd -v", I got "5.50".
By running "/usr/libexec/bluetooth/bluetoothd -d", I got:
D-Bus setup failed: Connection ":1.50" is not allowed to own the
service "org.bluez" due to security policies in the configuration file

Thanks in advance!
