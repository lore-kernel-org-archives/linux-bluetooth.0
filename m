Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051E161
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834925; cv=none; b=fAJDgIiwfSS5fM0rq6sbroJ1yjU6DlxZRnZjIr77bw3zVEJc/I/YgYR/Vt52nhvs4H6wa+XuXMvKhajitqqLm4m94KbfwJa/+bAjc1A6Kw7QZ09y5ihZQjOJkYHBmQ0+jQal/PJ7q3LiSHnn46BQw3Cz8TIA2YUymYU+stjVTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834925; c=relaxed/simple;
	bh=ZFmdcGnOD8CJCan2F3bR5zLdJjnGCkShXA+4dfTlIZY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eih01P6+deKvgjbPt8E/B+tpUJwGGnayPG9y2o+CoiQO8TRBEudN7oLRZ7Czsmu9KDZjI/VCcw9YXoSXw95tbx2Rte8BDVEi5HwIBH0nrrKqrpC7ZnpTWligbHMG6+n+oAyQPc6WovZwJD563mGO2XJXusOHPzgTKrxYuGA65dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wn4eUyYK; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wn4eUyYK"
Received: from github.com (hubbernetes-node-222d189.va3-iad.github.net [10.48.133.37])
	by smtp.github.com (Postfix) with ESMTPA id 9BB08E13B9
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1709834921;
	bh=OD2VujMQb3UXpzKZNLbVeJO3lfD6kjzuAryvLnCtKFc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wn4eUyYKLGI+kGga3tCr3AIsdcjGJYhJO14Pi4pY/PChymXuqhYfG9xygINba5t5D
	 vAJhtNubeigFLiCsnVaWi6vMTNSU/ENZvBWeeSzuKkDztdR2GmlggdXxgsPNrvndaW
	 zVlZTapsl0uxYRPfPyRpoj7Ki8yS0Waaw5+G/SGk=
Date: Thu, 07 Mar 2024 10:08:41 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b16b19-19f8fc@github.com>
Subject: [bluez/bluez] 7c4956: btdev: Fix set PA data array overflow
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7c49568a27580674e14f682fa0f6a7d555f8468c
      https://github.com/bluez/bluez/commit/7c49568a27580674e14f682fa0f6a=
7d555f8468c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix set PA data array overflow

This fixes an array overflow that can happen if the user issues the
LE Set Periodic Advertising Data command with data length exceeding
31 bytes.

The PA data set by the user is copied in an array of fixed length
(31 bytes). However, the data length might exceed 31 bytes. This will
cause an array overflow when the PA data is later processed (for
instance, when sending PA reports).

According to specification, the data length provided at LE Set Periodic
Advertising Data command can be maximum 252 bytes. The stored data len
should also be true to the length copied in the array.


  Commit: 24d97e35fcde16ab988699dd1516d992053c50ac
      https://github.com/bluez/bluez/commit/24d97e35fcde16ab988699dd1516d=
992053c50ac
  Author: Ajay KV <ajay.k.v@intel.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid: Add GTBS UUIDs for Call Control Profile


  Commit: 93d88ecd0714fc32b62109904b5ac7eff1b9aa26
      https://github.com/bluez/bluez/commit/93d88ecd0714fc32b62109904b5ac=
7eff1b9aa26
  Author: Ajay KV <ajay.k.v@intel.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M lib/uuid.c
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid: Add support to compare 16bit uuids


  Commit: 5c89c54d2db1676f160d3085ab035265da7ef5be
      https://github.com/bluez/bluez/commit/5c89c54d2db1676f160d3085ab035=
265da7ef5be
  Author: Ajay KV <ajay.k.v@intel.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M Makefile.am
    A src/shared/ccp.c
    A src/shared/ccp.h

  Log Message:
  -----------
  shared/ccp: Add initial code for Call Control Profile for Client Role


  Commit: b097bf6d302e045143902154a7aae1bf8dcfac4c
      https://github.com/bluez/bluez/commit/b097bf6d302e045143902154a7aae=
1bf8dcfac4c
  Author: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Enable the notification logging support for the CCP


  Commit: 094f3fdcc0ac57c9feee8a1a3f458ab27f5f593f
      https://github.com/bluez/bluez/commit/094f3fdcc0ac57c9feee8a1a3f458=
ab27f5f593f
  Author: Szymon Janc <szymon.janc@codecoup.pl>
  Date:   2024-02-14 (Wed, 14 Feb 2024)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Fix typo in external-plugins configure option

This was causing build errors as macros were also generated with typo.


  Commit: b55d98e5cc97e4ff8c3980b84f46c84f3b1c1ee3
      https://github.com/bluez/bluez/commit/b55d98e5cc97e4ff8c3980b84f46c=
84f3b1c1ee3
  Author: Szymon Janc <szymon.janc@codecoup.pl>
  Date:   2024-02-14 (Wed, 14 Feb 2024)

  Changed paths:
    M bootstrap-configure

  Log Message:
  -----------
  bootstrap-configure: Enable external plugins

Make sure we build this code while in development mode.


  Commit: 247ae8524888268bb075ff90a3d77a9b4449d08f
      https://github.com/bluez/bluez/commit/247ae8524888268bb075ff90a3d77=
a9b4449d08f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-14 (Wed, 14 Feb 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Don't destroy UHID device on detach

This makes bt_hog_detach not to destroy UHID device which means the
device node don't need to be recreated in case of reconnections which
speeds up the process.

Fixes: https://github.com/bluez/bluez/issues/737


  Commit: 9698870015b0972d3d93f30a6d9de1ed029ba87c
      https://github.com/bluez/bluez/commit/9698870015b0972d3d93f30a6d9de=
1ed029ba87c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-14 (Wed, 14 Feb 2024)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/input.conf

  Log Message:
  -----------
  input.conf: Make UserspaceHID defaults to true

This makes UserspaceHID defaults to true so the plugin has more control
over the input device lifetime.


  Commit: ee880bee85864b0e691370197c9de8d2f7ba0af2
      https://github.com/bluez/bluez/commit/ee880bee85864b0e691370197c9de=
8d2f7ba0af2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-14 (Wed, 14 Feb 2024)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Don't destroy UHID device on disconnect

This makes classic HID behave like HoG which keeps the UHID device
around while disconnected so it doesn't have to be recreated on every
reconnection.


  Commit: f3c35ed835bda18573e07d02f725be5106ad8ae8
      https://github.com/bluez/bluez/commit/f3c35ed835bda18573e07d02f725b=
e5106ad8ae8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-15 (Thu, 15 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix crash on page_timeout

If remote device cannot be found after page_timeout then the code shall
not proceed to call pending_conn_del.


  Commit: fb339bde646ca9717f0787aefd6f6cbe4fb13f78
      https://github.com/bluez/bluez/commit/fb339bde646ca9717f0787aefd6f6=
cbe4fb13f78
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-15 (Thu, 15 Feb 2024)

  Changed paths:
    M tools/rfcomm-tester.c

  Log Message:
  -----------
  rfcomm-tester: Fix crash on test-basic

This fixes to following trace caused by not initializing data->io:

AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: AddressSanitizer: SEGV on unknown address
(pc 0x7f199c3a01c9 bp 0x7ffc26624a10 sp 0x7ffc26624a00 T0)
The signal is caused by a READ memory access.
Hint: this fault was caused by a dereference of a high value address
(see register values below).  Disassemble the provided pc to learn .
    #0 0x7f199c3a01c9 in g_io_channel_unref (/lib64/libglib-2.0.so.0+0x4d=
1c9)
    #1 0x5565f82fcece in test_post_teardown tools/rfcomm-tester.c:205
    #2 0x5565f83939b3 in teardown_callback src/shared/tester.c:434


  Commit: 055a83c84761705be4295c3fabb6b9038945bf39
      https://github.com/bluez/bluez/commit/055a83c84761705be4295c3fabb6b=
9038945bf39
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-15 (Thu, 15 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix wrong value used when extracting LTVs

Fix wrong value used when extracting LTVs when generating BASE


  Commit: c58a4d9f7880931a14c4733c013c08c477aefeec
      https://github.com/bluez/bluez/commit/c58a4d9f7880931a14c4733c013c0=
8c477aefeec
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-02-15 (Thu, 15 Feb 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Do not set timer if DiscoverableTimeout=3D0

According to org.bluez.LEAdvertisement.rst documentation, the value of
zero should disable timeout and keep device in the discoverable mode
forever.


  Commit: 854dcb7c2bbd8d11f1188838090d6eba3476dc85
      https://github.com/bluez/bluez/commit/854dcb7c2bbd8d11f1188838090d6=
eba3476dc85
  Author: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
  Date:   2024-02-16 (Fri, 16 Feb 2024)

  Changed paths:
    M tools/rfcomm.c

  Log Message:
  -----------
  tools/rfcomm: reset ignored signals after fork

rfcomm sets SIGCHLD and SIGPIPE to SIG_IGN, which is inherited by child
processes and preserved across execvp(). Many applications do not expect
these signals to be ignored, causing all kinds of breakage (including the=

standard C system() function misbehaving on glibc and probably other
libcs because waitpid() does not work when SIGCHLD is ignored).


  Commit: f79ccf6c429ed28e5aac8c68ed818aa2d7d5351d
      https://github.com/bluez/bluez/commit/f79ccf6c429ed28e5aac8c68ed818=
aa2d7d5351d
  Author: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
  Date:   2024-02-16 (Fri, 16 Feb 2024)

  Changed paths:
    M tools/rfcomm.c

  Log Message:
  -----------
  tools/rfcomm: _exit() on execvp() failure

When the exec fails, the child process must be terminated instead of
continuing as a second main process.


  Commit: 9fe4ccb79ffa0faa3084ce1be12685585d68e85e
      https://github.com/bluez/bluez/commit/9fe4ccb79ffa0faa3084ce1be1268=
5585d68e85e
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.am
    M Makefile.obexd

  Log Message:
  -----------
  build: rework {install-data,uninstall}-hook

Currently autoconfigure throws a useful error, about a duplicate
install-data-hook.

Address that by making the two target specific and pulling them as
dependencies.

We have to create empty ones otherwise dependency tracking and
resolution will fail.


  Commit: c2b9f357d52207ef22c9a4880cc0b5c7e8f11c5b
      https://github.com/bluez/bluez/commit/c2b9f357d52207ef22c9a4880cc0b=
5c7e8f11c5b
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: install obexd (dbus,systemd} services as needed

Currently we ship the service files, even when built with
--disable-obex.

Move the "if OBEX" guard few lines further up.


  Commit: 71d8fda25b2176a5e6b288c868195bc57aaaf9f8
      https://github.com/bluez/bluez/commit/71d8fda25b2176a5e6b288c868195=
bc57aaaf9f8
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.am
    M configure.ac
    M mesh/bluetooth-mesh.service.in
    M obexd/src/obex.service.in
    M obexd/src/org.bluez.obex.service.in
    M src/bluetooth.service.in
    M tools/bluetooth-logger.service.in

  Log Message:
  -----------
  build: handle relative libexecdir instances

With earlier commit, we've used exec_dir to reference the path of obexd
and bluetoothd within the service files.

At the same time, in my testing I was providing the complete path on the
configure command line. As result, things just worked.

In the default case, the variable contains relative references to ${}
variables, which as result end up literal in the services. Ultimately
the service files were broken.

Document are reuse the existing pattern of manually expanding the
variables.

Fixes: https://github.com/bluez/bluez/issues/736


  Commit: 344cf10cb60c2031200be1c6618a0f2b7e2b8950
      https://github.com/bluez/bluez/commit/344cf10cb60c2031200be1c6618a0=
f2b7e2b8950
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: simplify coverage handling


  Commit: bade07f43fedb221caf217bf2a98a4050292a32e
      https://github.com/bluez/bluez/commit/bade07f43fedb221caf217bf2a98a=
4050292a32e
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: drop explicit -fPIC from obexd CFLAGS

The option is handled by the global --enable-pic. Drop the local
explicit argument.

With that we can drop the standalone CFLAGS.


  Commit: 071ababfe6e340c17642889ec02083db84fa12a1
      https://github.com/bluez/bluez/commit/071ababfe6e340c17642889ec0208=
3db84fa12a1
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  gitignore: add org.bluez.obex.service


  Commit: 4d3605e472ed490ec43142580a511b3f44b29e70
      https://github.com/bluez/bluez/commit/4d3605e472ed490ec43142580a511=
b3f44b29e70
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: obexd: remove duplicate include -I$(builddir)/lib

The -I$(builddir)/lib include is already in the AM_CPPFLAGS. Drop the
duplicate instance in obexd.


  Commit: e6acec4770bb60de22b133d4e1ba554951b7b288
      https://github.com/bluez/bluez/commit/e6acec4770bb60de22b133d4e1ba5=
54951b7b288
  Author: Emil Velikov <emil.l.velikov@gmail.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  gitignore: ignore all manual pages

Drop the few explicit entries and use *.{1,5,8} instead.


  Commit: c5f1c5ba0e8d629487f610b60fc93d433d6f5614
      https://github.com/bluez/bluez/commit/c5f1c5ba0e8d629487f610b60fc93=
d433d6f5614
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Remove set lpac user data at bcast ep register

Remove set lpac user data at bcast ep register


  Commit: 5629f4784a4dfb1a3c708aca252f6f9319286807
      https://github.com/bluez/bluez/commit/5629f4784a4dfb1a3c708aca252f6=
f9319286807
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Split bap_state and bap_connecting in two functions

Split bap_state and bap_connecting in two specific functions
for unicast (bap_state, bap_connecting) and broadcast
(bap_state_bcast, bap_connecting_bcast).


  Commit: a16c2ccf9c256285188f4549b7b767cf31b100eb
      https://github.com/bluez/bluez/commit/a16c2ccf9c256285188f4549b7b76=
7cf31b100eb
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-20 (Tue, 20 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Generate one BIS BASE for

Generate single BIS BASE for a config with BIG ID 0xFF


  Commit: 8f262a27bdf233f142a7bb22bf3f8c6db53debee
      https://github.com/bluez/bluez/commit/8f262a27bdf233f142a7bb22bf3f8=
c6db53debee
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-23 (Fri, 23 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix crash unreg bcast src endpoint

In bt_bap_stream_release stream is accessed after free


  Commit: c8af669da59b264624a9c874f02e41b4a78da5e4
      https://github.com/bluez/bluez/commit/c8af669da59b264624a9c874f02e4=
1b4a78da5e4
  Author: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
  Date:   2024-02-23 (Fri, 23 Feb 2024)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/ccp.c

  Log Message:
  -----------
  profiles/audio/ccp: Add CCP plugin for call control profile

This adds initial code for CCP plugin which handle CALL CONTROL PROFILE f=
or
Telephone Bearer Services and Generic Telephone Bearer Services in the
client role.
This has been tested using teams application by initiating call between
Linux BTOE and Windows server with LE audio enabled.


  Commit: f65cd924f2e60e7bd41dc27443c020e131880e8c
      https://github.com/bluez/bluez/commit/f65cd924f2e60e7bd41dc27443c02=
0e131880e8c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-26 (Mon, 26 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix UAF on page_timeout

When the page_timeout is run perhaps the btdev had been freed already so
it needs to be checked if it still valid.


  Commit: c01c40498cfb770d4282f31edd9d75bb53646efa
      https://github.com/bluez/bluez/commit/c01c40498cfb770d4282f31edd9d7=
5bb53646efa
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2024-02-26 (Mon, 26 Feb 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix assigning mgmt callback id when adding advertisement

A struct member add_adv_id is used to track whether the adv client is
still needed for some mgmt callback. This is checked when freeing the
client to avoid UAF. We currently only set this member if we have a
callback after calling mgmt_send.

In case of extended advertisement, this is always a two-step process:
first to set the params, then the data. It is possible for the client
to be freed when we are pending on setting the params, and if we don't
set the add_adv_id (because we have no callback for setting the data),
the client on the 2nd step of the process will be invalid, leading to
UAF scenario.

This patch always sets the add_adv_id member on the 1st step of adding
an extended advertisement, and adjust the value accordingly on the 2nd
step. Additionally, this patch drops the 3rd parameter of the function
refresh_advertisement since it can always be derived from the 1st and
2nd parameter.

Reviewed-by: Hsin-chen Chuang <chharry@google.com>


  Commit: 15032315f35c44820952a9750baf58c2b4090b3f
      https://github.com/bluez/bluez/commit/15032315f35c44820952a9750baf5=
8c2b4090b3f
  Author: Joakim Tjernlund <joakim.tjernlund@infinera.com>
  Date:   2024-02-26 (Mon, 26 Feb 2024)

  Changed paths:
    M Makefile.tools
    M configure.ac

  Log Message:
  -----------
  cups: Use pkg-config to find cups backend dir

Some distributions(Gentoo) patch cups backend path to
something else than libdir. Use pkg-config to find backend
path for cups.


  Commit: 8552e06b6617a1c51558d549aab66c500c6c50c2
      https://github.com/bluez/bluez/commit/8552e06b6617a1c51558d549aab66=
c500c6c50c2
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix endpoint dir for the bcast source

Fix endpoint direction for the broadcast source


  Commit: b4f9a9fd7ed22a8da8a2d05e0bc35a8c6b421190
      https://github.com/bluez/bluez/commit/b4f9a9fd7ed22a8da8a2d05e0bc35=
a8c6b421190
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add state in stream struct for bcast source

Add state support in the stream struct for broadcast source.


  Commit: 6ea7f481094c9cad528dd1f7c50a45f177288060
      https://github.com/bluez/bluez/commit/6ea7f481094c9cad528dd1f7c50a4=
5f177288060
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support to create a stream for bcast src

Split bt_bap_stream_new and  two specific functions for
unicast and broadcast.
Add a function to find an remote endpoint for broadcast source.


  Commit: dd57562760e4e784d278b63877a3d6265c638854
      https://github.com/bluez/bluez/commit/dd57562760e4e784d278b63877a3d=
6265c638854
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add a callback to create a new stream

Add a callback to create a new stream


  Commit: 92f3ed1879042b43033241049b334404229df88d
      https://github.com/bluez/bluez/commit/92f3ed1879042b43033241049b334=
404229df88d
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Set generated BASE on all setups from the same BIG

Set the BASE generated in BlueZ on all setups from the same BIG,
and use defer to inform the kernel when to create the BIG.


  Commit: ade2b97597e13ead02293e235aa5fa93f1afa043
      https://github.com/bluez/bluez/commit/ade2b97597e13ead02293e235aa5f=
a93f1afa043
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not resetting big_handle on HCI_Reset

HCI_Reset shall cleanup BIG state including if the handle has been set.


  Commit: 44d3f67277f83983e1e9697eda7b9aeb40ca231d
      https://github.com/bluez/bluez/commit/44d3f67277f83983e1e9697eda7b9=
aeb40ca231d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-27 (Tue, 27 Feb 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Consider service state on device_is_connected

This checks if there is any service connected on device_is_connected
since some profiles maybe probed using advertising data which doesn't
require a connection.


  Commit: 3f7d81e906e09e881ca2d3f024230cae3a27ba64
      https://github.com/bluez/bluez/commit/3f7d81e906e09e881ca2d3f024230=
cae3a27ba64
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add push LTV utilitary function


  Commit: 7ec9a0f77c6e8601ac4fcc5bdfa8f1aaf1aa1c44
      https://github.com/bluez/bluez/commit/7ec9a0f77c6e8601ac4fcc5bdfa8f=
1aaf1aa1c44
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Allow reading endpoint metadata and data

Add utilitary functions to get endpoint metadata and data.


  Commit: 98aba4aaef7a574bde7363e50888527a21a0b546
      https://github.com/bluez/bluez/commit/98aba4aaef7a574bde7363e508885=
27a21a0b546
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Update local PACS for broadcast sink also


  Commit: 2ec513fc37d7ccc1143d3805b2e1e99d627f9bf5
      https://github.com/bluez/bluez/commit/2ec513fc37d7ccc1143d3805b2e1e=
99d627f9bf5
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Do stream configuration in bap_bcast_config

Stream configuration for BAP broadcast streams should be done inside
bap_bcast_config and not when setting the user data.


  Commit: d2fa46e08c3bf06d1078e84aa66b2f510ea1a900
      https://github.com/bluez/bluez/commit/d2fa46e08c3bf06d1078e84aa66b2=
f510ea1a900
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add API to add an observed BIS

Add API to add a PAC for each observed BIS that is supported by the
local PACS data.
Each BIS observed capabilities LTV is compared to the local capabilities
and when we have a full LTVs match a PAC record is created for that BIS.
Also a MediaEndpoint is registered over DBUS and the stream can be
enabled using the SetConfiguration DBUS call.


  Commit: 29fe7bd07fbd1311f3c256721c8c613157ae1e8d
      https://github.com/bluez/bluez/commit/29fe7bd07fbd1311f3c256721c8c6=
13157ae1e8d
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-01 (Fri, 01 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Do PA Sync for each BAP Broadcast source discovered

After discovering a BAP Broadcast Source do a short PA sync first to lear=
n
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a=

stream and the corresponding transport.


  Commit: 0d82dd205023b867818e0b73ef78cc3eba352799
      https://github.com/bluez/bluez/commit/0d82dd205023b867818e0b73ef78c=
c3eba352799
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Remove bt_bap_stream_bcast_new

This is now handled internally by bt_bap_stream_new by detecting if an
ATT session has been attached.


  Commit: cb7375fb8a98776e6b33adb3507e4a23224cb5fc
      https://github.com/bluez/bluez/commit/cb7375fb8a98776e6b33adb3507e4=
a23224cb5fc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M client/bluetoothctl.rst

  Log Message:
  -----------
  client: Remove Pygments dependency from manpage

This patch removes the Pygments dependency from btmon .rst file.
When the code-block type is specified, the rst2man throws a warning
asking for Pygments package.


  Commit: 9cc8b97b8f5d060e334207136100e947732aed08
      https://github.com/bluez/bluez/commit/9cc8b97b8f5d060e334207136100e=
947732aed08
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: obexd: Fix make distcheck

This fixes the following error:

/usr/bin/install: cannot remove
'/usr/share/dbus-1/services/org.bluez.obex.service': Permission denied


  Commit: d5a9195a6269e703c6e3a47c40982ec94d8cc838
      https://github.com/bluez/bluez/commit/d5a9195a6269e703c6e3a47c40982=
ec94d8cc838
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M Makefile.tools
    M configure.ac

  Log Message:
  -----------
  build: Fix distcheck

This fixes the following errors:

/usr/bin/mkdir -p '/backend'
/usr/bin/mkdir: cannot create directory =E2=80=98/backend=E2=80=99: Permi=
ssion denied
make[3]: *** [Makefile:4768: install-cupsPROGRAMS] Error 1


  Commit: 71f0a1e88d9a55d5b4a0db007ab15e5dcb525a4c
      https://github.com/bluez/bluez/commit/71f0a1e88d9a55d5b4a0db007ab15=
e5dcb525a4c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Add support for signed write command

GAP/SEC/CSIGN/BV-02-C request the ability to check that signed write has
been performed successfully.


  Commit: 3eba64ba2c856347fe311d8c547914f225c497b6
      https://github.com/bluez/bluez/commit/3eba64ba2c856347fe311d8c54791=
4f225c497b6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Update local and remote CSRK on management event

Currently the local and remote CSRK keys are only loaded to device object=

from storage during start.
Those keys are updated on MGMT_EV_NEW_CSRK event only in adapter object,
but saved both in adapter and device objects.

Those keys should be updated on management event to be able to perform
signed write for GAP/SEC/CSIGN/BV-01-C and GAP/SEC/CSIGN/BV-02-C.

This commits updates the keys on management event in the device object an=
d
move their storage to device object only.


  Commit: 7665fb5d943c3910465123fc7b08922e44adb7a2
      https://github.com/bluez/bluez/commit/7665fb5d943c3910465123fc7b089=
22e44adb7a2
  Author: Max Gautier <mg@max.gautier.name>
  Date:   2024-03-04 (Mon, 04 Mar 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  Don't install conf and state dir on systemd

The bluetooth.service file already specify the State and Configuration
directories with the correct modes, which guarantee they will be
available (with proper permissions) when bluetoohd starts.

Not installing those helps implementing the "Hermetic /usr" pattern
(TL;DR: '/usr' contains everything necessary to boostrap a working
system)

Handling this in upstream bluez (rather than in distribution packaging
scripts) avoid duplication of efforts between distros.

Links: https://0pointer.net/blog/fitting-everything-together.html


  Commit: 0bf9e6453ed5175dea94a8fc88c6b74f99999d30
      https://github.com/bluez/bluez/commit/0bf9e6453ed5175dea94a8fc88c6b=
74f99999d30
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-03-05 (Tue, 05 Mar 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix heap use after free on exit

Set the value for data.inputs and data.queue queues to NULL after
freeing, so that further processes won't use already freed memory


  Commit: a070ceac6ba897ba64021d1f9963dbb4f1a1c203
      https://github.com/bluez/bluez/commit/a070ceac6ba897ba64021d1f9963d=
bb4f1a1c203
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-06 (Wed, 06 Mar 2024)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add definitions for Audio Configurations

This adds defines for Audio Configurations so it can be used for
upcoming tests.


  Commit: 2da45fc7e2d65d31b8d90c0d94eef6c1374d53bd
      https://github.com/bluez/bluez/commit/2da45fc7e2d65d31b8d90c0d94eef=
6c1374d53bd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-06 (Wed, 06 Mar 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add STR sink tests

4.10.1 Unicast Client Streaming =E2=80=93 1 Unicast Server, 1 Stream, 1 C=
IS =E2=80=93
LC3 (Page 80)

 Test Purpose:
 Verify that a Unicast Client IUT can stream audio data over one unicast
 Audio Stream to or from a Unicast Server.

 Pass verdict:
 If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero =
or
 more length that contains LC3-encoded data formatted using the LC3 Media=

 Packet format (defined in [3] Section 4.2).

Test Summary
------------
BAP/UCL/STR/BV-001-C [UCL, AC 2, LC3 8_1_1]          Passed
BAP/UCL/STR/BV-002-C [UCL, AC 10, LC3 8_1_1]         Passed
BAP/UCL/STR/BV-003-C [UCL, AC 2, LC3 8_2_1]          Passed
BAP/UCL/STR/BV-004-C [UCL, AC 10, LC3 8_2_1]         Passed
BAP/UCL/STR/BV-005-C [UCL, AC 2, LC3 16_1_1]         Passed
BAP/UCL/STR/BV-006-C [UCL, AC 10, LC3 16_1_1]        Passed
BAP/UCL/STR/BV-007-C [UCL, AC 2, LC3 16_2_1]         Passed
BAP/UCL/STR/BV-008-C [UCL, AC 10, LC3 16_2_1]        Passed
BAP/UCL/STR/BV-009-C [UCL, AC 2, LC3 24_1_1]         Passed
BAP/UCL/STR/BV-010-C [UCL, AC 10, LC3 24_1_1]        Passed
BAP/UCL/STR/BV-011-C [UCL, AC 2, LC3 24_2_1]         Passed
BAP/UCL/STR/BV-012-C [UCL, AC 10, LC3 24_2_1]        Passed
BAP/UCL/STR/BV-013-C [UCL, AC 2, LC3 32_1_1]         Passed
BAP/UCL/STR/BV-014-C [UCL, AC 10, LC3 32_1_1]        Passed
BAP/UCL/STR/BV-015-C [UCL, AC 2, LC3 32_2_1]         Passed
BAP/UCL/STR/BV-016-C [UCL, AC 10, LC3 32_2_1]        Passed
BAP/UCL/STR/BV-017-C [UCL, AC 2, LC3 441_1_1]        Passed
BAP/UCL/STR/BV-018-C [UCL, AC 10, LC3 441_1_1]       Passed
BAP/UCL/STR/BV-019-C [UCL, AC 2, LC3 44_2_1]         Passed
BAP/UCL/STR/BV-020-C [UCL, AC 10, LC3 44_2_1]        Passed
BAP/UCL/STR/BV-021-C [UCL, AC 2, LC3 48_1_1]         Passed
BAP/UCL/STR/BV-022-C [UCL, AC 10, LC3 48_1_1]        Passed
BAP/UCL/STR/BV-023-C [UCL, AC 2, LC3 48_2_1]         Passed
BAP/UCL/STR/BV-024-C [UCL, AC 10, LC3 48_2_1]        Passed
BAP/UCL/STR/BV-025-C [UCL, AC 2, LC3 48_3_1]         Passed
BAP/UCL/STR/BV-026-C [UCL, AC 10, LC3 48_3_1]        Passed
BAP/UCL/STR/BV-027-C [UCL, AC 2, LC3 48_4_1]         Passed
BAP/UCL/STR/BV-028-C [UCL, AC 10, LC3 48_4_1]        Passed
BAP/UCL/STR/BV-029-C [UCL, AC 2, LC3 48_5_1]         Passed
BAP/UCL/STR/BV-030-C [UCL, AC 10, LC3 48_5_1]        Passed
BAP/UCL/STR/BV-031-C [UCL, AC 2, LC3 48_6_1]         Passed
BAP/UCL/STR/BV-032-C [UCL, AC 10, LC3 48_6_1]        Passed
BAP/UCL/STR/BV-033-C [UCL, SRC, AC 1, LC3 8_1_1]     Passed
BAP/UCL/STR/BV-034-C [UCL, SRC, AC 4, LC3 8_1_1]     Passed
BAP/UCL/STR/BV-035-C [UCL, SRC, AC 1, LC3 8_2_1]     Passed
BAP/UCL/STR/BV-036-C [UCL, SRC, AC 4, LC3 8_2_1]     Passed
BAP/UCL/STR/BV-037-C [UCL, SRC, AC 1, LC3 16_1_1]    Passed
BAP/UCL/STR/BV-038-C [UCL, SRC, AC 4, LC3 16_1_1]    Passed
BAP/UCL/STR/BV-039-C [UCL, SRC, AC 1, LC3 16_2_1]    Passed
BAP/UCL/STR/BV-040-C [UCL, SRC, AC 4, LC3 16_2_1]    Passed
BAP/UCL/STR/BV-041-C [UCL, SRC, AC 1, LC3 24_1_1]    Passed
BAP/UCL/STR/BV-042-C [UCL, SRC, AC 4, LC3 24_1_1]    Passed
BAP/UCL/STR/BV-043-C [UCL, SRC, AC 1, LC3 24_2_1]    Passed
BAP/UCL/STR/BV-044-C [UCL, SRC, AC 4, LC3 24_2_1]    Passed
BAP/UCL/STR/BV-045-C [UCL, SRC, AC 1, LC3 32_1_1]    Passed
BAP/UCL/STR/BV-046-C [UCL, SRC, AC 4, LC3 32_1_1]    Passed
BAP/UCL/STR/BV-047-C [UCL, SRC, AC 1, LC3 32_2_1]    Passed
BAP/UCL/STR/BV-048-C [UCL, SRC, AC 4, LC3 32_2_1]    Passed
BAP/UCL/STR/BV-049-C [UCL, SRC, AC 1, LC3 44_1_1]    Passed
BAP/UCL/STR/BV-050-C [UCL, SRC, AC 4, LC3 44_1_1]    Passed
BAP/UCL/STR/BV-051-C [UCL, SRC, AC 1, LC3 44_2_1]    Passed
BAP/UCL/STR/BV-052-C [UCL, SRC, AC 4, LC3 44_2_1]    Passed
BAP/UCL/STR/BV-053-C [UCL, SRC, AC 1, LC3 48_1_1]    Passed
BAP/UCL/STR/BV-054-C [UCL, SRC, AC 4, LC3 48_1_1]    Passed
BAP/UCL/STR/BV-055-C [UCL, SRC, AC 1, LC3 48_2_1]    Passed
BAP/UCL/STR/BV-056-C [UCL, SRC, AC 4, LC3 48_2_1]    Passed
BAP/UCL/STR/BV-057-C [UCL, SRC, AC 1, LC3 48_3_1]    Passed
BAP/UCL/STR/BV-058-C [UCL, SRC, AC 4, LC3 48_3_1]    Passed
BAP/UCL/STR/BV-059-C [UCL, SRC, AC 1, LC3 48_4_1]    Passed
BAP/UCL/STR/BV-060-C [UCL, SRC, AC 4, LC3 48_4_1]    Passed
BAP/UCL/STR/BV-061-C [UCL, SRC, AC 1, LC3 48_5_1]    Passed
BAP/UCL/STR/BV-062-C [UCL, SRC, AC 4, LC3 48_5_1]    Passed
BAP/UCL/STR/BV-063-C [UCL, SRC, AC 1, LC3 48_6_1]    Passed
BAP/UCL/STR/BV-064-C [UCL, SRC, AC 4, LC3 48_6_1]    Passed
BAP/UCL/STR/BV-065-C [UCL, AC 2, LC3 8_1_2]          Passed
BAP/UCL/STR/BV-066-C [UCL, AC 10, LC3 8_1_2]         Passed
BAP/UCL/STR/BV-067-C [UCL, AC 2, LC3 8_2_2]          Passed
BAP/UCL/STR/BV-068-C [UCL, AC 10, LC3 8_2_2]         Passed
BAP/UCL/STR/BV-069-C [UCL, AC 2, LC3 16_1_2]         Passed
BAP/UCL/STR/BV-070-C [UCL, AC 10, LC3 16_1_2]        Passed
BAP/UCL/STR/BV-071-C [UCL, AC 2, LC3 16_2_2]         Passed
BAP/UCL/STR/BV-072-C [UCL, AC 10, LC3 16_2_2]        Passed
BAP/UCL/STR/BV-073-C [UCL, AC 2, LC3 24_1_2]         Passed
BAP/UCL/STR/BV-074-C [UCL, AC 10, LC3 24_1_2]        Passed
BAP/UCL/STR/BV-075-C [UCL, AC 2, LC3 24_2_2]         Passed
BAP/UCL/STR/BV-076-C [UCL, AC 10, LC3 24_2_2]        Passed
BAP/UCL/STR/BV-077-C [UCL, AC 2, LC3 32_1_2]         Passed
BAP/UCL/STR/BV-078-C [UCL, AC 10, LC3 32_1_2]        Passed
BAP/UCL/STR/BV-079-C [UCL, AC 2, LC3 32_2_2]         Passed
BAP/UCL/STR/BV-080-C [UCL, AC 10, LC3 32_2_2]        Passed
BAP/UCL/STR/BV-081-C [UCL, AC 2, LC3 44_1_2]         Passed
BAP/UCL/STR/BV-082-C [UCL, AC 10, LC3 44_1_2]        Passed
BAP/UCL/STR/BV-083-C [UCL, AC 2, LC3 44_2_2]         Passed
BAP/UCL/STR/BV-084-C [UCL, AC 10, LC3 44_2_2]        Passed
BAP/UCL/STR/BV-085-C [UCL, AC 2, LC3 48_1_2]         Passed
BAP/UCL/STR/BV-086-C [UCL, AC 10, LC3 48_1_2]        Passed
BAP/UCL/STR/BV-087-C [UCL, AC 2, LC3 48_2_2]         Passed
BAP/UCL/STR/BV-088-C [UCL, AC 10, LC3 48_2_2]        Passed
BAP/UCL/STR/BV-089-C [UCL, AC 2, LC3 48_3_2]         Passed
BAP/UCL/STR/BV-090-C [UCL, AC 10, LC3 48_3_2]        Passed
BAP/UCL/STR/BV-091-C [UCL, AC 2, LC3 48_4_2]         Passed
BAP/UCL/STR/BV-092-C [UCL, AC 10, LC3 48_4_2]        Passed
BAP/UCL/STR/BV-093-C [UCL, AC 2, LC3 48_5_2]         Passed
BAP/UCL/STR/BV-094-C [UCL, AC 10, LC3 48_5_2]        Passed
BAP/UCL/STR/BV-095-C [UCL, AC 2, LC3 48_6_2]         Passed
BAP/UCL/STR/BV-096-C [UCL, AC 10, LC3 48_6_2]        Passed
BAP/UCL/STR/BV-097-C [UCL, SRC, AC 1, LC3 8_1_2]     Passed
BAP/UCL/STR/BV-098-C [UCL, SRC, AC 4, LC3 8_1_2]     Passed
BAP/UCL/STR/BV-099-C [UCL, SRC, AC 1, LC3 8_2_2]     Passed
BAP/UCL/STR/BV-100-C [UCL, SRC, AC 4, LC3 8_2_2]     Passed
BAP/UCL/STR/BV-101-C [UCL, SRC, AC 1, LC3 16_1_2]    Passed
BAP/UCL/STR/BV-102-C [UCL, SRC, AC 4, LC3 16_1_2]    Passed
BAP/UCL/STR/BV-103-C [UCL, SRC, AC 1, LC3 16_2_2]    Passed
BAP/UCL/STR/BV-104-C [UCL, SRC, AC 4, LC3 16_2_2]    Passed
BAP/UCL/STR/BV-105-C [UCL, SRC, AC 1, LC3 24_1_2]    Passed
BAP/UCL/STR/BV-106-C [UCL, SRC, AC 4, LC3 24_1_2]    Passed
BAP/UCL/STR/BV-107-C [UCL, SRC, AC 1, LC3 24_2_2]    Passed
BAP/UCL/STR/BV-108-C [UCL, SRC, AC 4, LC3 24_2_2]    Passed
BAP/UCL/STR/BV-109-C [UCL, SRC, AC 1, LC3 32_1_2]    Passed
BAP/UCL/STR/BV-110-C [UCL, SRC, AC 4, LC3 32_1_2]    Passed
BAP/UCL/STR/BV-111-C [UCL, SRC, AC 1, LC3 32_2_2]    Passed
BAP/UCL/STR/BV-112-C [UCL, SRC, AC 4, LC3 32_2_2]    Passed
BAP/UCL/STR/BV-113-C [UCL, SRC, AC 1, LC3 44_1_2]    Passed
BAP/UCL/STR/BV-114-C [UCL, SRC, AC 4, LC3 44_1_2]    Passed
BAP/UCL/STR/BV-115-C [UCL, SRC, AC 1, LC3 44_2_2]    Passed
BAP/UCL/STR/BV-116-C [UCL, SRC, AC 4, LC3 44_2_2]    Passed
BAP/UCL/STR/BV-117-C [UCL, SRC, AC 1, LC3 48_1_2]    Passed
BAP/UCL/STR/BV-118-C [UCL, SRC, AC 4, LC3 48_1_2]    Passed
BAP/UCL/STR/BV-119-C [UCL, SRC, AC 1, LC3 48_2_2]    Passed
BAP/UCL/STR/BV-120-C [UCL, SRC, AC 4, LC3 48_2_2]    Passed
BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_3_2]    Passed
BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_3_2]    Passed
BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_4_2]    Passed
BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_4_2]    Passed
BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_5_2]    Passed
BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_5_2]    Passed
BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_6_2]    Passed
BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_6_2]    Passed
Total: 128, Passed: 128 (100.0%), Failed: 0, Not Run: 0


  Commit: 25507ba0d465ff359e43ab7cf866170e28993b3d
      https://github.com/bluez/bluez/commit/25507ba0d465ff359e43ab7cf8661=
70e28993b3d
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-03-07 (Thu, 07 Mar 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Add missing binaries to .gitignore


  Commit: 17cd5563f83769fe9f69802dcc05faf41f780b7a
      https://github.com/bluez/bluez/commit/17cd5563f83769fe9f69802dcc05f=
af41f780b7a
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-03-07 (Thu, 07 Mar 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: 19f8fcdc2084048bebe5bd9ea4fb97f7ece16df0
      https://github.com/bluez/bluez/commit/19f8fcdc2084048bebe5bd9ea4fb9=
7f7ece16df0
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-03-07 (Thu, 07 Mar 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.73


Compare: https://github.com/bluez/bluez/compare/b16b19885c53...19f8fcdc20=
84

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
