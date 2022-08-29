Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EBDECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 18:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH2SsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH2SsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 14:48:18 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E4832FD
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 11:48:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-fc89b3b.va3-iad.github.net [10.48.206.72])
        by smtp.github.com (Postfix) with ESMTPA id 166723400DC
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1661798897;
        bh=zbf7ZAAJQ+SAKJpgn6aWfhZfvQ5pz/36u8s8yhZjH64=;
        h=Date:From:To:Subject:From;
        b=bnKhnPwXTTn3MwllaGqtODvQDfdVypFZC0dQY4xqj30rkpwX60seHZ/tW6E52qbU2
         wI+3rD8DlBDln4c3vBfxUjRfn0RNVFsKOyfdQ02DNS3qnePGVYFL0bC9YziqmYo/4M
         htLPmfgr7laOAKlzDnwGl1n8N3BvMijAvR7fzzt0=
Date:   Mon, 29 Aug 2022 11:48:17 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/06f646-7c2f0c@github.com>
Subject: [bluez/bluez] 9c3f35: iso-tester: Introduce tests for
 Disconnect/Reconnect
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
  Commit: 9c3f35d6fd126ab843dff47ff27ad59cf1529a90
      https://github.com/bluez/bluez/commit/9c3f35d6fd126ab843dff47ff27ad59cf1529a90
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-15 (Mon, 15 Aug 2022)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Introduce tests for Disconnect/Reconnect

This introduces a test that do use shutdown to disconnect an ISO socket
and then another one that attempts to reconnect it again to emulate
upper profile transitions.


  Commit: c47730b2d563fee4837a5b758f35b6aa3d35bff7
      https://github.com/bluez/bluez/commit/c47730b2d563fee4837a5b758f35b6aa3d35bff7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-15 (Mon, 15 Aug 2022)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  adapter: Check flags are supported

This makes sure the flags are supported before attempting to set it.


  Commit: 64abbf7cee18801ef87cc41be45467d088fdc715
      https://github.com/bluez/bluez/commit/64abbf7cee18801ef87cc41be45467d088fdc715
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-15 (Mon, 15 Aug 2022)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client: Move admin submenu

This moves admin submenu to admin.c so it is not mixed up with other
submenus code.


  Commit: fdc788f576cf79cde8e3d431d46b58d2374f7c64
      https://github.com/bluez/bluez/commit/fdc788f576cf79cde8e3d431d46b58d2374f7c64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-15 (Mon, 15 Aug 2022)

  Changed paths:
    M bootstrap-configure

  Log Message:
  -----------
  build: Enable admin plugin

This enables admin plugin with bootstrap-configure so it is normally
build by the likes of CI.


  Commit: 952c08ff50c5f18b61e99262b93ba679d5f71cc7
      https://github.com/bluez/bluez/commit/952c08ff50c5f18b61e99262b93ba679d5f71cc7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-16 (Tue, 16 Aug 2022)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Don't restrict Report MAP size

Although HIDS spec is quite clear the Report MAP shall be limited to
512 bytes it doesn't seem OS do enforce that on the profile/client side
and since there isn't any qualification test enforcing it either there
are quite many devices which uses Report MAP bigger that 512 bytes
(e.g.: Brydge W-Touch and Lenovo Duet 3 BT Folio).

https://github.com/bluez/bluez/issues/377


  Commit: 60663d4af3ffb6f82e75a3a4bc73b8b8887a3353
      https://github.com/bluez/bluez/commit/60663d4af3ffb6f82e75a3a4bc73b8b8887a3353
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-16 (Tue, 16 Aug 2022)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix scan-build error

This fixes the following errors:
profiles/input/hog-lib.c:600:19: warning: Access to field 'handle'
results in a dereference of a null pointer (loaded from variable 'chr')
        report->handle = chr->handle;
                         ^~~~~~~~~~~
profiles/input/hog-lib.c:637:11: warning: Access to field 'value_handle'
results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~
profiles/input/hog-lib.c:1240:11: warning: Access to field 'value_handle'
results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~


  Commit: 4999f80c1f56774b5511cf16b38600d016ed892b
      https://github.com/bluez/bluez/commit/4999f80c1f56774b5511cf16b38600d016ed892b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-19 (Fri, 19 Aug 2022)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix using shutdown(SHUT_RDWR)

shutdown(SHUT_RDWR) results in socket being HUP immeditaly instead of
waiting for Disconnect Complete event so instead just use SHUT_WR to
start the disconnect procedure without causing the socket to HUP.


  Commit: 5bf220eb3b86e3d162b1b926c529a975821b6a02
      https://github.com/bluez/bluez/commit/5bf220eb3b86e3d162b1b926c529a975821b6a02
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-22 (Mon, 22 Aug 2022)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c

  Log Message:
  -----------
  bthost: Add destroy callback to bthost_add_iso_hook

This adds a destroy callback to bthost_add_iso_hook so its user can
detect when the hook is freed when the connection is disconnected.


  Commit: 081897da74f036a2e248956fdf16455b66bee91c
      https://github.com/bluez/bluez/commit/081897da74f036a2e248956fdf16455b66bee91c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-22 (Mon, 22 Aug 2022)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Make use of bthost_add_iso_hook destroy callback

This makes use of bthost_add_iso_hook to track when an ISO connection
has been disconnected and then set its handle to 0x0000 which is then
checked when the socket HUP to confirm the remote has properly
disconnected (e.g. received Disconnected Complete).


  Commit: 4760ada065f22604795295d1377e6a50a2d5efac
      https://github.com/bluez/bluez/commit/4760ada065f22604795295d1377e6a50a2d5efac
  Author: darkhz <kmachanwenw@gmail.com>
  Date:   2022-08-22 (Mon, 22 Aug 2022)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Correct UUID for Microphone Control

According to the Bluetooth product specification list, the allocated
UUID for "Microphone Control" is 0x184D, not 0x184C.


  Commit: 73b301372b21d56a6c8902659fbfd1c352ad55de
      https://github.com/bluez/bluez/commit/73b301372b21d56a6c8902659fbfd1c352ad55de
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-24 (Wed, 24 Aug 2022)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not setting initiator

This fixes not setting initiator flag properly when MGMT connect event
has not been processed yet but ATT is already connected or is in
progress.


  Commit: ede7b915980fbc80eff80aa189c35ca016956c61
      https://github.com/bluez/bluez/commit/ede7b915980fbc80eff80aa189c35ca016956c61
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2022-08-24 (Wed, 24 Aug 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Reset pending settings when receiving MGMT error

We set the pending settings flag when sending MGMT_SETTING_*
commands to the MGMT layer and clear them when receiving a
successful reply, but we don't clear them when receiving an error
reply. This might cause a setting to be stuck in pending state.

Therefore, also clear the pending flag when receiving error.
Furthermore, this patch also postpones setting the pending flag
until we queue the MGMT command in order to avoid setting it too
soon but we return early.

This was caught during power off test, where MGMT_OP_SET_POWERED
returns Authentication Failed because disconnection takes too long.
Future attempts to switch power will then be ignored.

< HCI Command: Disconnect (0x01|0x0006) plen 3   #17916 [hci0] 12.502908
        Handle: 512
        Reason: Remote Device Terminated due to Power Off (0x15)
> HCI Event: Command Status (0x0f) plen 4        #17917 [hci0] 12.503185
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Status (0x0002) plen 3   {0x0001} [hci0] 14.519491
      Set Powered (0x0005)
        Status: Authentication Failed (0x05)
= bluetoothd: Failed to set mode: Authentication Failed (0x05) 14.520042
= bluetoothd: adapter /org/bluez/hci0 set power to 0           14.813533
> HCI Event: Disconnect Complete (0x05) plen 4   #17918 [hci0] 16.509043
        Status: Success (0x00)
        Handle: 512
        Reason: Connection Timeout (0x08)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>


  Commit: 7c2f0c037e924dd0a9bffd60187f7b2aea36c22f
      https://github.com/bluez/bluez/commit/7c2f0c037e924dd0a9bffd60187f7b2aea36c22f
  Author: Ronan Pigott <ronan@rjp.ie>
  Date:   2022-08-24 (Wed, 24 Aug 2022)

  Changed paths:
    M completion/zsh/_bluetoothctl

  Log Message:
  -----------
  zsh: drop no more arguments message

This usage of the _message as a completion function is invalid, and
will result in an error if invoked by _arguments when the user has a
format style set for completion messages.

We can just drop this message, since it is not necessary.

Before:
  $ zstyle ':completion:*:messages' format '%d'
  $ bluetoothctl connect <TAB>
  _message:zformat:42: invalid argument: -J

After:
  $ zstyle ':completion:*:messages' format '%d'
  $ bluetoothctl connect <TAB>
  31:41:59:26:53:59  -- Bose QuietComfort 35
  11:22:33:44:55:66  -- Pixel 5


Compare: https://github.com/bluez/bluez/compare/06f6460cd121...7c2f0c037e92
