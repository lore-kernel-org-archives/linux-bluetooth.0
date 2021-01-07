Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD00C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 12:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7621223355
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 12:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAGMJo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jan 2021 07:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGMJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jan 2021 07:09:43 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B82C0612F4
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jan 2021 04:09:03 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id h18so3425018vsg.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jan 2021 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LfhrvIQDRXXtGRPtwl3C+Tl4PuXsqu5Z+fIeQceqjzQ=;
        b=Hsq8PpBu9QIr5maAuEhLbOerApNb6qpFJSeTvV/6ZVWeRz+LVi34L4X/lBp6u9a+rO
         t/GbnuiwPEoHytoQ207amM+XSIzmqxrMxPVjN/1FbnzhF6y2Yf1tPNoIAXT2w1MdIT3M
         7w/UJsUJ+jrX7YVDxeq7HCg4jm5hTsahMypNWDp7avpLUMNCofLt0sTeWJkWoeCQAkVu
         msUwvq7cHUBzNn0EcSqWXiAbEBlelayJHSovDlAl2jeBlBxPQyOmiBsy8XhfvRC294Ik
         8KRSoq8j/je8swTadaOsjg/cCxj74pQFOXevKrjLXkXUu4bXMDz+312onIpoIsanqAf6
         oaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LfhrvIQDRXXtGRPtwl3C+Tl4PuXsqu5Z+fIeQceqjzQ=;
        b=nQPD9Ptc6Gv2zYiar/cDt1mL1vaPb/DA/UBZ2bCiKZTfas7xI2mqg6VIHqLRvGsZ76
         oyRCJDiqNeMWYqVblad78/EBBTIfD/LeGl0Kv2S4J719/Sy/1MOrhuJNUHnX7oBX+0FH
         f9aeeVO0lK8quDAvVV1Xsp76H3K+KxEwOgET0/Thrkce17LktUs03FQk7uI7XxjpQp7s
         fnbwLCPas4RegJVjH/NhMzwhGKk+3qy53Oy1+sXZhLD65kEt5BjgZwYHJuHFZGXLmU/y
         HMgeReLzA4+Sewd2M9szcHP3sb95CDA4CtNxsu4PVeT+g2pltFlTJaHPi//LBR154qa+
         HzGQ==
X-Gm-Message-State: AOAM531YYvsbG3yDfziD9TJT4SDek/O4t/dEQaU+zI79yafezY4AKsIj
        ahDLxQpWsuDCuQHYe5uZx7AXNskhZQ8PuiHrN5q6fY7nciREDA==
X-Google-Smtp-Source: ABdhPJydOwwppL4l4ohKKYYynNyQbFRd5JSCEfSeEOB2FMdFxNoX3SpLVWHn/ci1NQuyhkxfYd1qjWnovsFJM/cUmgo=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr7018180vsr.23.1610021342336;
 Thu, 07 Jan 2021 04:09:02 -0800 (PST)
MIME-Version: 1.0
From:   Thibaud Roussillat <thibaud.roussillat@gmail.com>
Date:   Thu, 7 Jan 2021 13:08:50 +0100
Message-ID: <CAMDdHNdD+7dh8VTmzRd0kNY4cFtXXQK4j=9c4FQ0-6Yg5TLj_g@mail.gmail.com>
Subject: Notification data limited to 20 bytes with L2CAP sockets even if MTU
 is larger
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm new to Bluez. I tried some librairies but without succes.

I try to use bluez librairies to test binary transfer over BLE
(peripheral role played by an NRF52832, service Nordic UART). I also
tried some other librairies but without finding the good one so I came
to bluez.

To achieve my test, I modified btgatt-client.c to have the following behaviour :
* Connect to a device
* Send an hexadecimal code (0x00) on the TX characteristic (RX for the
NRF) to start transfer
* Received data through notification
* If received data begin with 0x01, write 0x01 to the TX
* If received data begin with 0x02, do nothing (stop transfer)

Even if MTU is more than 23 bytes, receveid data are troncated.

I tried to do the same thing using bluetoothctl who works with DBus
and the all data are received.

I played with gdb to identified the problem and this is the backtrace
display by bt:

#0  notify_cb (user_data=0x67558, length=20, value=0x67c5b "\001",
value_handle=15) at tools/btgatt-diego.c:1106
#1  notify_cb (value_handle=<optimized out>, value=0x67c5b "\001",
length=<optimized out>, user_data=0x67558) at
tools/btgatt-diego.c:1081
#2  0x0001ed50 in queue_foreach (queue=0x678f0, function=0x16bfc
<notify_handler>, user_data=user_data@entry=0xbefff190) at
src/shared/queue.c:206
#3  0x00019934 in notify_cb (chan=0x67570, chan@entry=0x67628,
opcode=opcode@entry=27 '\033', pdu=0x67c5b, pdu@entry=0x67c59,
length=20, length@entry=22, user_data=0x677e0)
    at src/shared/gatt-client.c:2191
#4  0x00016244 in handle_notify (pdu_len=23, pdu=<optimized out>,
chan=0x67628) at src/shared/att.c:959
#5  can_read_data (io=<optimized out>, user_data=0x67628) at
src/shared/att.c:1050
#6  0x0001dc8c in io_callback (fd=<optimized out>, events=<optimized
out>, user_data=0x675a0) at src/shared/io-mainloop.c:110
#7  0x0001e308 in mainloop_run () at src/shared/mainloop.c:106
#8  0x0001ea5c in mainloop_run_with_signal (func=func@entry=0x11ed0
<signal_cb>, user_data=user_data@entry=0x0) at
src/shared/mainloop-notify.c:188
#9  0x0001184c in main (argc=<optimized out>, argv=<optimized out>) at
tools/btgatt-diego.c:1746


In can_read_data function, bytes_read = read(chan->fd, chan->buf,
chan->mtu); return a value of 20 even if chan->mtu is larger.

I tried to reconfigure the socket as found on some thread by doing this :

        struct l2cap_options opts;
        int optlen = sizeof(opts), err;
        err = getsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, &optlen );
        if( ! err ) {
                opts.omtu = opts.imtu = 40;
                err = setsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS,
&opts, optlen );
        }
        else {
                printf("=============> Unable to set socket opt");
        }

This hasn't effect on transfer.

I don't known if I don't understand something or if there is a bug...

Help is welcome.

(last chance is to communicate via DBus but not a lot of time to do this now)

Regards,
Thibaud
