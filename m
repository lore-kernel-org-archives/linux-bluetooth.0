Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 21:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353696AbiETVhX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 17:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETVhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 17:37:22 -0400
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355E179C3D
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:37:21 -0700 (PDT)
Received: from github.com (hubbernetes-node-61794aa.va3-iad.github.net [10.48.204.33])
        by smtp.github.com (Postfix) with ESMTPA id 58A415C0BD9
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1653082641;
        bh=IsJCFCC5y9Rs+NQ0rSJzyubmI5CA8pgZUUvKy7sgVnY=;
        h=Date:From:To:Subject:From;
        b=xbgpf70XIQhzizTdpqY9bgo//j4PY6u9vGbe/bYBptFSPTvxv2o4/F5mK6scpVmFo
         yZaMD3q3yd8XuBu53FzWgc2C86iAUrqFkCD0DdGuiSPEzeeZJFJVCK5RZWol4IWHjH
         WzohFTkllRF9goB2h1LQKwx2sXG0DeOu9M1PVklk=
Date:   Fri, 20 May 2022 14:37:21 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bd6b90-f1069c@github.com>
Subject: [bluez/bluez] f1069c: gatt-server: Fix crash while disconnecting
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f1069c4fe1060dec1565eef3d2b1ec31ed713fba
      https://github.com/bluez/bluez/commit/f1069c4fe1060dec1565eef3d2b1ec31ed713fba
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-20 (Fri, 20 May 2022)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix crash while disconnecting

If there is a pending notify multiple the code was not removing before
freeing the object causing the following crash:

Invalid read of size 8
   at 0x4A3D10: notify_multiple (gatt-server.c:1703)
   by 0x4D05F0: timeout_callback (timeout-glib.c:25)
   by 0x4956900: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49560AE: g_main_context_dispatch
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49557C2: g_main_loop_run
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
   by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2B0CD1: main (main.c:1276)
 Address 0x6ca35c8 is 136 bytes inside a block of size 144 free'd
   at 0x48470E4: free (vg_replace_malloc.c:872)
   by 0x415E73: gatt_server_cleanup (device.c:698)
   by 0x415E73: attio_cleanup (device.c:715)
   by 0x47745B: queue_foreach (queue.c:207)
   by 0x490C54: disconnect_cb (att.c:701)
   by 0x4CF4AF: watch_callback (io-glib.c:157)
   by 0x49560AE: g_main_context_dispatch
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49557C2: g_main_loop_run
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
   by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2B0CD1: main (main.c:1276)


