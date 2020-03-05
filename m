Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73633C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA9207FD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=besson.co header.i=@besson.co header.b="bs0TlsKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8BcOyi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCEQnq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:43:46 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52621 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgCEQnq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 11:43:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A14B222E6
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2020 11:43:45 -0500 (EST)
Received: from imap36 ([10.202.2.86])
  by compute1.internal (MEProxy); Thu, 05 Mar 2020 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=besson.co; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=i63Z1TbtRkZ9pYHBEGFgYzOmCqJZhkq7pRaZZuucD3E=; b=bs0TlsKi
        inqKZPCiWGkaA1loY9xBs55AiZy07T8wWHhTFnpB7MGSB+8ClMwKkBxPna94LSGa
        QPOY9qbRUZLVoFuhnBNb3TEjjoy7/1x/HbLxe8UXehV8YWOII7rqWVeldqYdgzkI
        zq3dz6j9f1c1x/26+ahVJE3IjHG5qmp9WXeRY/rvJ8D9rFMFiHEqgfPUVQzYmKL0
        1r+KKMnIvENAcDFqAjYx1MI8s1TL1Ojr7Li8jazQuvMuEZ1H4h1YtHpwTG9Q5pSG
        uKMGgVXgKfPDcHEY2wFffn+fiFc+CH73/Ya4P12FYi2nCt5MBZOdoHkxSBIGE2wt
        pmG2g48q0OLA0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=i63Z1TbtRkZ9pYHBEGFgYzOmCqJZh
        kq7pRaZZuucD3E=; b=C8BcOyi/gs9djYr2YG6RmjUaKdF2d2IUcyTT49R0uCiDD
        g9qKGMKN6KzawjRqf/sdPR37nIpjsxdwrQakEs4fdBiQ+C0QwEp1217yiW8L+tAM
        bnaDwYcXZKCOd+oSqh+Irr6LtSDWN41JRHK5Vi1q7zpLYKRrjozSxeU94mVBA8qS
        HlMWolKgQcd/uAEY2IlytNteG+nhEuufAcmhy4JwHoOp3cfOAp0GgqV+aUn5Qy1z
        5pbjDMIj2YjMMyVGtOgqYUtpOgngp0J33fkJB3YNUb3VDkMEHsXImBTWi/xSXqF3
        c8EmDbwYibxGDlM+/Cm9A+arPPXYW6Q9kz/OdqPBw==
X-ME-Sender: <xms:QSxhXog-OothWC3Jo26C_ilFlf9harpmr_HLHP94IW8YjhOEeLB54w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfifhuihhllhgruhhmvgcuuegvshhsohhnfdcuoehguhhilhhl
    rghumhgvsegsvghsshhonhdrtghoqeenucffohhmrghinhepghdujeehudeitdefgegrrd
    hhvghrvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehguhhilhhlrghumhgvsegsvghsshhonhdrtgho
X-ME-Proxy: <xmx:QSxhXrVg4591VMKEtclXXISQIAE1SPkv82le7-8GD31M6mZ6nLVK3w>
    <xmx:QSxhXuuxpRkqN2JaC-HuJeYy9HfbsjnY5dlwT8bhutvOq8B2eZ6BPQ>
    <xmx:QSxhXuTGf9j7nJAqBDj_jFMSo26e_vH_RoEP5S_BHxsSgw46tqDimA>
    <xmx:QSxhXhR8Cxqj5rYgWN6G1EjybqSTye4aOe-dtqpUtU9jVECNKu1TVw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D70B71880062; Thu,  5 Mar 2020 11:43:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-988-g326a76f-fmstable-20200305v1
Mime-Version: 1.0
Message-Id: <3fa34b47-fd14-4672-8e95-93caa0c67397@www.fastmail.com>
Date:   Thu, 05 Mar 2020 17:43:19 +0100
From:   "Guillaume Besson" <guillaume@besson.co>
To:     linux-bluetooth@vger.kernel.org
Subject: Random segfault on mouse connection
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
On my Lenovo X1 Extreme Gen2, the bluetoothd process segfault frequently on mouse connection. The bluetooth chipset is integrated in the Intel Corporation Wi-Fi 6 AX200 card. I'm using the latest Linux kernel (5.5.4) and bluez-git (bluez-git-1:5.53.r4.g17516034a).
Here's the stacktrace from the coredump:

#0  queue_remove (queue=0x55e521458c90, data=data@entry=0x55e521454510) at src/shared/queue.c:258
#1  0x000055e51fde63fe in enable_ccc_callback (opcode=<optimized out>, pdu=<optimized out>, length=<optimized out>, user_data=0x55e521454510) at src/shared/gatt-client.c:1559
#2  0x000055e51fde157c in disc_att_send_op (data=0x55e521454b20) at src/shared/att.c:547
#3  0x000055e51fddd802 in queue_remove_all (queue=0x55e52144da10, function=function@entry=0x0, user_data=user_data@entry=0x0, destroy=destroy@entry=0x55e51fde1560 <disc_att_send_op>) at src/shared/queue.c:354
#4  0x000055e51fde285a in disconnect_cb (io=<optimized out>, user_data=0x55e521447330) at src/shared/att.c:576
#5  0x000055e51fded0d5 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:170
#6  0x00007fbccc71726f in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#7  0x00007fbccc7191b1 in ?? () from /usr/lib/libglib-2.0.so.0
#8  0x00007fbccc71a0c3 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#9  0x000055e51fded6d6 in mainloop_run () at src/shared/mainloop-glib.c:79
#10 0x000055e51fdedb58 in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
#11 0x000055e51fd56909 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:756

The syslog also adds these line just before the segfault:

Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Read Report Reference descriptor failed: Request attribute has encountered an unlikely error
Feb 19 09:12:49 geekuillaume-laptop bluetoothd[1189]: Protocol Mode characteristic read failed: Request attribute has encountered an unlikely error

The mouse is a Logitech MX Master 2 which has no problem on Windows with the same laptop. I have a keyboard (Keychron K2) connected by Bluetooth before the crash which still works after the crash. If I restart the bluetoothd process with systemctl, the mouse reconnects and it works fine but can crash again after some random period of time.

There is another issue with the mouse that could be related: sometimes, the mouse stops working and a lot of "bt_uhid_send: Invalid argument (22)" are logged to the syslog. After 10 seconds it goes back to working fine.

What to do to debug this?

Thanks.
----------
Guillaume Besson
+33 6 11 67 39 56
besson.co
