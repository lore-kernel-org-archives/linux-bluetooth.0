Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FBC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913422074F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587913479;
	bh=xFvY3gcKWHJNHEWrcuJuogWR/gCNV5LWSpRQNFluZqg=;
	h=Date:From:To:Subject:List-ID:From;
	b=I+x/VRAhCoAUdnUx4QyhdD/41FbHTRqtRpJEiA+G2XXZi5wQ60LgjTnj17TUXuNYd
	 CKxU70x9e22MkmWXLmqPZwH/XgBdsymRJG8dfoUkzT3/5s3zf4jc59MyuP9cAYDNSq
	 rWLTTuTBqtu+n8PMiVp52h8o8e7TDnXO3dbwPzh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZPEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDZPEj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Apr 2020 11:04:39 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9955C206D4;
        Sun, 26 Apr 2020 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587913478;
        bh=xFvY3gcKWHJNHEWrcuJuogWR/gCNV5LWSpRQNFluZqg=;
        h=Date:From:To:Subject:From;
        b=CfDWxfMF7zYkhl8ecpXgcaQDlRunNX4HU8dmmzKyQEQsWo+uIGaT9as7S6ACPX/Cp
         VatJkYfC1iwxV7FDmeoWbcqWIl7Lc0WEFU0BN5U5zvde4+6e29VbaVLjQOQSBlPx52
         N/BAjr0CLBc1e6KAg9yfl7yKrftVVk4syYfbv2FA=
Received: by pali.im (Postfix)
        id AABC6B71; Sun, 26 Apr 2020 17:04:35 +0200 (CEST)
Date:   Sun, 26 Apr 2020 17:04:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: bluetoothd crashes when tryting to change A2DP codec via DBus
Message-ID: <20200426150435.s562o34mertpj6ct@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

Bluez bluetoothd daemon compiled from git master branch crashes when I
try to call DBus method for switching A2DP codec. Below is stacktrace
from gdb. It looks like NULL pointer dereference. It is reproducible.

Program received signal SIGSEGV, Segmentation fault.
0x000055e1b3659c1a in avdtp_find_remote_sep (session=0x55e1b408bf80, lsep=0x0) at profiles/audio/avdtp.c:1221
1221            if (lsep->info.inuse)
(gdb) bt
#0  0x000055e1b3659c1a in avdtp_find_remote_sep (session=0x55e1b408bf80, lsep=0x0) at profiles/audio/avdtp.c:1221
#1  0x000055e1b36568fc in find_remote_sep (sep=<optimized out>, chan=<optimized out>, chan=<optimized out>) at profiles/audio/a2dp.c:1169
#2  0x000055e1b3656955 in a2dp_reconfigure (data=0x55e1b40a1e10) at profiles/audio/a2dp.c:1188
#3  0x00007f4e07e90863 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#4  0x00007f4e07e8fdd8 in g_main_context_dispatch () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007f4e07e901c8 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007f4e07e904c2 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x000055e1b36ef725 in mainloop_run () at src/shared/mainloop-glib.c:79
#8  0x000055e1b36efb02 in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
#9  0x000055e1b364b15e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:770
(gdb) print lsep
$1 = (struct avdtp_local_sep *) 0x0
