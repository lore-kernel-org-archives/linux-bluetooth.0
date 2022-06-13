Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF53C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiFMTzW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiFMTzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 15:55:12 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87062A0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 11:26:36 -0700 (PDT)
Received: from github.com (hubbernetes-node-6750d85.ac4-iad.github.net [10.52.210.52])
        by smtp.github.com (Postfix) with ESMTPA id BBB6F520494
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1655144795;
        bh=ztTJ9oYcak9szUWcAdcAC0AyZO/5ybayJRP0gfhYsug=;
        h=Date:From:To:Subject:From;
        b=2QE8ULV7oE6YeGeZ/9etrQBZrEXPs9a/2FeRJOGLWyH94rQKrVvLljbyWAY0UQtbF
         p7d9RUMG1jTrgzD+5HaxNPTFQwB6UegJEnLqm8+JUvHyamgBISSBwZfyT7sRCL+AaJ
         7Bm8S2ixqB4pMOQsDzTkioryr2UbPFmuAf+YHG/U=
Date:   Mon, 13 Jun 2022 11:26:35 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/25dd56-c6d3bc@github.com>
Subject: [bluez/bluez] 5f9d9a: a2dp: disallow multiple SetConfiguration to
 same l...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master=0D
  Home:   https://github.com/bluez/bluez=0D
  Commit: 5f9d9a9a0b38d7fdbd591c859b9bf9e437fb1b39=0D
      https://github.com/bluez/bluez/commit/5f9d9a9a0b38d7fdbd591c859b9bf=
9e437fb1b39=0D
  Author: Pauli Virtanen <pav@iki.fi>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/a2dp.c=0D
    M profiles/audio/avdtp.c=0D
=0D
  Log Message:=0D
  -----------=0D
  a2dp: disallow multiple SetConfiguration to same local SEP=0D
=0D
Using the remote SEP SetConfiguration DBus API, it's possible to make=0D
multiple remote endpoints use the same local SEP, if they are endpoints=0D=

from different connected devices. This is invalid: successful=0D
configuration shall prevent a different device configuring the same SEP=0D=

(AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the=0D
AVDTP code that each SEP has at most a single stream, and causes=0D
misbehavior later on (subsequent transport acquires fail with EPERM).=0D
=0D
Fix this by first checking the SEP is free before proceeding in the DBus=0D=

API call.  Also add a sanity check in avdtp_set_configuration, to reject=0D=

configuring an already configured SEP similarly as in avdtp_setconf_cmd.=0D=

=0D
=0D
  Commit: 9c288dd23a3bbd4a4e41c69882f5f18212da62b5=0D
      https://github.com/bluez/bluez/commit/9c288dd23a3bbd4a4e41c69882f5f=
18212da62b5=0D
  Author: Pauli Virtanen <pav@iki.fi>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/a2dp.c=0D
=0D
  Log Message:=0D
  -----------=0D
  a2dp: error return paths in a2dp_reconfig must free allocated setup=0D
=0D
=0D
  Commit: 6e2066fdab73e5b028be9c5fa667a4ea03349c7f=0D
      https://github.com/bluez/bluez/commit/6e2066fdab73e5b028be9c5fa667a=
4ea03349c7f=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M tools/btproxy.c=0D
=0D
  Log Message:=0D
  -----------=0D
  btproxy: Allow to select multiple BT controllers=0D
=0D
When running on a computer with a real Bluetooth controller (e.g. hci0) a=
nd=0D
multiple emulators (e.g. hci1 and hci2) it isn't possible to use the=0D
emulators with 2 test-runner vms.=0D
If btproxy is started without index parameter the first test-runner will=0D=

use hci0, and btprox can't be started with multiple index parameters=0D
(e.g. -i1 -i2).=0D
=0D
This patch keeps the old beahvior when used without -i option, in this ca=
se=0D
it will try to use the first controller available.=0D
It also allows to select multiple controllers to be used by btproxy.=0D
=0D
=0D
  Commit: a7e2f05e029b4fab22c63318cc2763a55a524124=0D
      https://github.com/bluez/bluez/commit/a7e2f05e029b4fab22c63318cc276=
3a55a524124=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M tools/test-runner.c=0D
=0D
  Log Message:=0D
  -----------=0D
  test-runner: Add DBus session support=0D
=0D
Audio daemons requests access to DBus session to start=0D
=0D
=0D
  Commit: 096599c1ae852798a872b0294a6fb4decd1ee37a=0D
      https://github.com/bluez/bluez/commit/096599c1ae852798a872b0294a6fb=
4decd1ee37a=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M doc/test-runner.txt=0D
=0D
  Log Message:=0D
  -----------=0D
  doc/test-runner: Add audio config options=0D
=0D
List the build options for an AC97 audio card necessary for test with=0D
audio daemon.=0D
=0D
=0D
  Commit: e20e7e0b05c7edb74255c9b092916ac5bb99c97f=0D
      https://github.com/bluez/bluez/commit/e20e7e0b05c7edb74255c9b092916=
ac5bb99c97f=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M tools/test-runner.c=0D
=0D
  Log Message:=0D
  -----------=0D
  test-runner: Add audio card support=0D
=0D
With this commit audio daemons can detect an audio card with output and=0D=

input, allowing to test interaction between BlueZ and the audio daemon.=0D=

=0D
=0D
  Commit: 91a48af52efb0751fab396b2b9026c9186b10b88=0D
      https://github.com/bluez/bluez/commit/91a48af52efb0751fab396b2b9026=
c9186b10b88=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M tools/test-runner.c=0D
=0D
  Log Message:=0D
  -----------=0D
  test-runner: Add udevd and trigger events=0D
=0D
Kernel events should have been managed so the audio card is accessible=0D=

from PipeWire=0D
=0D
=0D
  Commit: c6d3bcf3d005ad9c9f8a85a68c88aa7f231d9a60=0D
      https://github.com/bluez/bluez/commit/c6d3bcf3d005ad9c9f8a85a68c88a=
a7f231d9a60=0D
  Author: wangyouwan <wangyouwan@uniontech.com>=0D
  Date:   2022-06-13 (Mon, 13 Jun 2022)=0D
=0D
  Changed paths:=0D
    M obexd/client/transfer.c=0D
=0D
  Log Message:=0D
  -----------=0D
  obexd: Fix callback->func =3D! NULL in the xfer_complete() func=0D
=0D
xfer_complete (obex=3D0x557d242c8cf0, err=3D0x557d242ca470,=0D
user_data=3D0x557d242ca300) at obexd/client/transfer.c:659=0D
659     obexd/client/transfer.c:=0D
(gdb) n=0D
661     in obexd/client/transfer.c=0D
(gdb) n=0D
663     in obexd/client/transfer.c=0D
(gdb) p callback->func=0D
$1 =3D (transfer_callback_t) 0x0=0D
(gdb) n=0D
668     in obexd/client/transfer.c=0D
(gdb) n=0D
671     in obexd/client/transfer.c=0D
(gdb) n=0D
672     in obexd/client/transfer.c=0D
(gdb) n=0D
676     in obexd/client/transfer.c=0D
(gdb) n=0D
677     in obexd/client/transfer.c=0D
(gdb) n=0D
0x0000000000000000 in ?? ()=0D
(gdb) s=0D
Cannot find bounds of current function=0D
(gdb) c=0D
Continuing.=0D
=0D
Program received signal SIGSEGV, Segmentation fault.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/25dd5613d549...c6d3bcf3d0=
05=0D
