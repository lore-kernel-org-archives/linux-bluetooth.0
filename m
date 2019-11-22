Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB65C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518F20707
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVJyW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:54:22 -0500
Received: from jax4mhob02.myregisteredsite.com ([64.69.218.82]:60068 "EHLO
        jax4mhob02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfKVJyW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 04:54:22 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail02pod5.registeredsite.com [10.30.71.85])
        by jax4mhob02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id xAM9sGWG019556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 04:54:18 -0500
Received: (qmail 170896 invoked by uid 0); 22 Nov 2019 09:54:16 -0000
X-TCPREMOTEIP: 65.41.18.216
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@65.41.18.216)
  by 0 with ESMTPA; 22 Nov 2019 09:54:16 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 918481540883
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 04:54:15 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2YQyzzevAqVx for <linux-bluetooth@vger.kernel.org>;
        Fri, 22 Nov 2019 04:54:13 -0500 (EST)
Received: from nm-ws (unknown [192.168.2.3])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTPS id 2ABBB154042B
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 04:54:13 -0500 (EST)
Message-ID: <9086014f29a8ba454d301e5e77ab7ec597e5617b.camel@ewol.com>
Subject: BlueZ mesh-cfgclient: throws SIGSEGV after commit 81f7c2e15
From:   Steve Brown <sbrown@ewol.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 22 Nov 2019 02:54:11 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It appears that the signatures suggest more args than are actually
passed at tools/mesh-cfgclient.c:548 & 550.

It only shows up on an rpi3 and ubuntu aarch64.

Steve

Program received signal SIGSEGV, Segmentation fault.
__strlen_generic () at ../sysdeps/aarch64/multiarch/../strlen.S:98
98	../sysdeps/aarch64/multiarch/../strlen.S: No such file or directory.
(gdb) bt
#0  __strlen_generic () at ../sysdeps/aarch64/multiarch/../strlen.S:98
#1  0x0000aaaaaaad1364 in l_dbus_interface_method (interface=0xaaaaaab42800, name=0xaaaaaaad9c18 "PromptNumeric", flags=0, cb=0xaaaaaaab7388 <prompt_numeric_call>, 
    return_sig=0xaaaaaaad9c10 "u", param_sig=0xaaaaaaadb148 "s") at ell/dbus-service.c:320
#2  0x0000aaaaaaab4ddc in setup_agent_iface (iface=0xaaaaaab42800) at tools/mesh-cfgclient.c:548
#3  0x0000aaaaaaad289c in _dbus_object_tree_register_interface (old_style_properties=<optimized out>, destroy=<optimized out>, setup_func=0xaaaaaaab4d00 <setup_agent_iface>, 
    interface=<optimized out>, tree=0xaaaaaab3c750) at ell/dbus-service.c:1385
#4  _dbus_object_tree_register_interface (tree=0xaaaaaab3c750, interface=<optimized out>, setup_func=0xaaaaaaab4d00 <setup_agent_iface>, destroy=<optimized out>, 
    old_style_properties=<optimized out>) at ell/dbus-service.c:1349
#5  0x0000aaaaaaab47d0 in register_agent () at tools/mesh-cfgclient.c:1755
#6  register_app () at tools/mesh-cfgclient.c:1755
#7  client_ready (client=<optimized out>, user_data=<optimized out>) at tools/mesh-cfgclient.c:1785
#8  0x0000aaaaaaad3e28 in get_managed_objects_reply (message=<optimized out>, user_data=0xaaaaaab3ecf0) at ell/dbus-client.c:572
#9  get_managed_objects_reply (message=<optimized out>, user_data=0xaaaaaab3ecf0) at ell/dbus-client.c:536
#10 0x0000aaaaaaac93dc in handle_method_return (message=0xaaaaaab41450, dbus=<optimized out>) at ell/dbus.c:216
#11 0x0000aaaaaaaca394 in message_read_handler (io=<optimized out>, user_data=0xaaaaaab395f0) at ell/dbus.c:276
#12 0x0000aaaaaaac7420 in io_callback (fd=<optimized out>, events=1, user_data=0xaaaaaab1be10) at ell/io.c:126
#13 0x0000aaaaaaac83d8 in l_main_iterate (timeout=<optimized out>) at ell/main.c:473
#14 0x0000aaaaaaac84b8 in l_main_run () at ell/main.c:520
#15 l_main_run () at ell/main.c:502
#16 0x0000aaaaaaac86d4 in l_main_run_with_signal (callback=callback@entry=0xaaaaaaac3c00 <l_sig_func>, user_data=user_data@entry=0x0) at ell/main.c:642
#17 0x0000aaaaaaac3cd4 in mainloop_run_with_signal (func=func@entry=0xaaaaaaac2110 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-ell.c:87
#18 0x0000aaaaaaac3374 in bt_shell_run () at src/shared/shell.c:1174
#19 0x0000aaaaaaab42d8 in main (argc=<optimized out>, argv=<optimized out>) at tools/mesh-cfgclient.c:1969


