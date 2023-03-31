Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3DC76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjCaWQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCaWQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:16:06 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9F18FB6
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:15:32 -0700 (PDT)
Received: from github.com (hubbernetes-node-cd626a0.ash1-iad.github.net [10.56.130.71])
        by smtp.github.com (Postfix) with ESMTPA id F3BBC900713
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1680300904;
        bh=RDlAT4dG4NcGSgtTw/lnqCsPFYz/7Jpf+sI214GNqVQ=;
        h=Date:From:To:Subject:From;
        b=PzDu5k+oTL+CkI0bDb0niCoMWN87HbOg4JYsZC8MXlpcXlenmTSWfgmoV4Av8mLct
         4FWkKLgUYtjHxoKtaRmlL2kHdJ47rAUFfqv1set32fTelhm45RC7kAV7IPnSXwCGcF
         GhpC7BrPH7oxTIKvaHjz8fVVQS+iEweHR1Iuz1qg=
Date:   Fri, 31 Mar 2023 15:15:03 -0700
From:   Hans de Goede <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5106fe-de8e7c@github.com>
Subject: [bluez/bluez] f54299: avrcp: Fix crash while handling unsupported
 events
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
  Commit: f54299a850676d92c3dafd83e9174fcfe420ccc9
      https://github.com/bluez/bluez/commit/f54299a850676d92c3dafd83e9174fcfe420ccc9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-30 (Thu, 30 Mar 2023)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix crash while handling unsupported events

The following crash can be observed if the remote peer send and
unsupported event:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b000148f11
 at pc 0x559644552088 bp 0x7ffe28b3c7b0 sp 0x7ffe28b3c7a0
 WRITE of size 1 at 0x60b000148f11 thread T0
     #0 0x559644552087 in avrcp_handle_event profiles/audio/avrcp.c:3907
     #1 0x559644536c22 in control_response profiles/audio/avctp.c:939
     #2 0x5596445379ab in session_cb profiles/audio/avctp.c:1108
     #3 0x7fbcb3e51c43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
     #4 0x7fbcb3ea66c7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xaa6c7)
     #5 0x7fbcb3e512b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
     #6 0x559644754ab6 in mainloop_run src/shared/mainloop-glib.c:66
     #7 0x559644755606 in mainloop_run_with_signal src/shared/mainloop-notify.c:188
     #8 0x5596445bb963 in main src/main.c:1289
     #9 0x7fbcb3bafd8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
     #10 0x7fbcb3bafe3f in __libc_start_main_impl ../csu/libc-start.c:392
     #11 0x5596444e8224 in _start (/usr/local/libexec/bluetooth/bluetoothd+0xf0224)


  Commit: c4d9b99db5a6b8efb7b710818a5261634086824b
      https://github.com/bluez/bluez/commit/c4d9b99db5a6b8efb7b710818a5261634086824b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-03-31 (Fri, 31 Mar 2023)

  Changed paths:
    M btio/btio.c
    M client/player.c
    M emulator/bthost.c
    M lib/bluetooth.h
    M profiles/audio/bap.c
    M tools/btiotest.c
    M tools/iso-tester.c
    M tools/isotest.c

  Log Message:
  -----------
  Split bt_iso_qos into dedicated structures

Split bt_iso_qos into dedicated unicast and broadcast
structures and add additional broadcast parameters.


  Commit: de8e7cfce25b8d717f5ee60ee3b79d426fdcc681
      https://github.com/bluez/bluez/commit/de8e7cfce25b8d717f5ee60ee3b79d426fdcc681
  Author: Hans de Goede <hdegoede@redhat.com>
  Date:   2023-03-31 (Fri, 31 Mar 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Use regular discovery for filters which only have discoverable set

discovery_filter_to_mgmt_cp() does not add discovery_filter.discoverable
to the created mgmt_cp_start_service_discovery struct.

Instead update_discovery_filter() separately checks
client->discovery_filter->discoverable for all clients.

This means that for discovery-filters which only have the discoverable
flag set, to put the adapter in discoverable mode while discovering,
the created mgmt_cp_start_service_discovery struct is empty.

This empty mgmt_cp_start_service_discovery struct then gets sent
to the kernel as part of a MGMT_OP_START_SERVICE_DISCOVERY msg
by start_discovery_timeout().

This use of an empty filter with MGMT_OP_START_SERVICE_DISCOVERY
causes some bluetooth devices to not get seen with some (most?)
Broadcom bluetooth adapters. This problem has been observed with
the following Broadcom models: BCM4343A0, BCM43430A1, BCM43341B0 .

On these models the following 2 devices were not being discovered
when starting a scan with a filter with just discoverable set
in the filter (as gnome-bluetooth does):

Device 09:02:01:03:0F:87 (public)
        Name: Bluetooth 3.0 Keyboard
        Alias: Bluetooth 3.0 Keyboard
        Class: 0x00000540
        Icon: input-keyboard
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: yes
        UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: bluetooth:v05ACp022Cd011B

Device 00:60:D1:00:00:34 (public)
        Name: Bluetooth Mouse
        Alias: Bluetooth Mouse
        Class: 0x00002580
        Icon: input-mouse
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: no
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v0103p0204d001E

Since setting the discoverable flag on a filter only is a way to
automatically put the adapter in discoverable mode itself while
it is discovering; and since this does not any device filtering
at all; modify merge_discovery_filters() to treat discovery with
such filters as regular unfiltered discovery.

This results in start_discovery_timeout() starting regular
discovery through a MGMT_OP_START_DISCOVERY message and this
fixes these 2 example devices not getting discovered by the
mentioned Broadcom BT adapter models.

Link: https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/merge_requests/163
Reviewed-by: Bastien Nocera <hadess@hadess.net>


Compare: https://github.com/bluez/bluez/compare/5106fe8c868d...de8e7cfce25b
