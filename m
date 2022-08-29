Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E851ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiH2UTg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiH2UTe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:19:34 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69279A9BA
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:19:28 -0700 (PDT)
Received: from github.com (hubbernetes-node-5203425.ash1-iad.github.net [10.56.201.102])
        by smtp.github.com (Postfix) with ESMTPA id 47B278403F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1661804368;
        bh=xy4ec3Xn/1PBU2lzMOYFzAEux3Jk1NTYSTA7OtlpB70=;
        h=Date:From:To:Subject:From;
        b=w5oJ43ahGwlHsnbIuP4xXYXxzEZi7IBpKuEWq9MPPEAatEz9fbfJn7YwBw0UHr9ye
         CvGSTjaYR1xcZT7+dJrsD24K0pcVir9/iWm21xQVLOmoW+IIZEhHHbVv32LhptiQhs
         b/gQdu3WkPd8UXLJ2qO10cuu5RmWwI+UKF2EmwzU=
Date:   Mon, 29 Aug 2022 13:19:28 -0700
From:   Christian Eggers <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7c2f0c-150bbf@github.com>
Subject: [bluez/bluez] ea903d: gatt-api: Add error code ReadValue/WriteValue
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
  Commit: ea903d12068092abfc380f0c78274e4608ff2bf8=0D
      https://github.com/bluez/bluez/commit/ea903d12068092abfc380f0c78274=
e4608ff2bf8=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-25 (Thu, 25 Aug 2022)=0D
=0D
  Changed paths:=0D
    M doc/gatt-api.txt=0D
=0D
  Log Message:=0D
  -----------=0D
  gatt-api: Add error code ReadValue/WriteValue=0D
=0D
This allows application to return error codes in the range allowed by=0D
the spec:=0D
=0D
 'GATT - Section 4.9.5:=0D
=0D
  Application Error 0x80 =E2=80=93 0x9F Application error code defined by=
 a=0D
  higher layer specification.'=0D
=0D
=0D
  Commit: 6b8f9fbd5bb81fe8d156155551fb727ceb21c869=0D
      https://github.com/bluez/bluez/commit/6b8f9fbd5bb81fe8d156155551fb7=
27ceb21c869=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-25 (Thu, 25 Aug 2022)=0D
=0D
  Changed paths:=0D
    M src/gatt-database.c=0D
=0D
  Log Message:=0D
  -----------=0D
  gatt: Parse error message=0D
=0D
Application can now encode an error code into the D-Bus reply error=0D
message (0x80-0x9f).=0D
=0D
Fixes: https://github.com/bluez/bluez/issues/380=0D
=0D
=0D
  Commit: 67dfe38b660d9a1461dc2acea60a1157fc7c169f=0D
      https://github.com/bluez/bluez/commit/67dfe38b660d9a1461dc2acea60a1=
157fc7c169f=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M src/adapter.c=0D
    M src/adapter.h=0D
=0D
  Log Message:=0D
  -----------=0D
  adapter: Add btd_adapter_find_device_by_fd=0D
=0D
This adds btd_adapter_find_device_by_fd that lookup a device by a fd=0D
socket destination address.=0D
=0D
=0D
  Commit: d7b78586afddeedb7759255707e3fb709c478a5e=0D
      https://github.com/bluez/bluez/commit/d7b78586afddeedb7759255707e3f=
b709c478a5e=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M lib/uuid.h=0D
=0D
  Log Message:=0D
  -----------=0D
  lib/uuid: Add PACS/ASCS UUIDs=0D
=0D
This adds PACS/ASCS UUIDs which will be used by Basic Audio Profile.=0D
=0D
=0D
  Commit: b798cec4ca623095c57fcba73148fb955db3b096=0D
      https://github.com/bluez/bluez/commit/b798cec4ca623095c57fcba73148f=
b955db3b096=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M Makefile.am=0D
    M src/device.c=0D
    A src/shared/ascs.h=0D
    A src/shared/bap.c=0D
    A src/shared/bap.h=0D
=0D
  Log Message:=0D
  -----------=0D
  shared/bap: Add initial code for handling BAP=0D
=0D
This adds initial code for Basic Audio Profile.=0D
=0D
=0D
  Commit: 47ba235f5a6ff9173727311adefab45609fc2ad8=0D
      https://github.com/bluez/bluez/commit/47ba235f5a6ff9173727311adefab=
45609fc2ad8=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M Makefile.plugins=0D
    M configure.ac=0D
    A profiles/audio/bap.c=0D
    M profiles/audio/media.c=0D
    M profiles/audio/transport.c=0D
    M profiles/audio/transport.h=0D
=0D
  Log Message:=0D
  -----------=0D
  profiles: Add initial code for bap plugin=0D
=0D
This adds initial code for bap plugin which handles Basic Audio=0D
Profile, Publish Audio Capabilities Service and Audio Stream Control=0D
Service.=0D
=0D
=0D
  Commit: fcc16be9053affea6ea02b3b038422905bd321cb=0D
      https://github.com/bluez/bluez/commit/fcc16be9053affea6ea02b3b03842=
2905bd321cb=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M Makefile.am=0D
    A src/shared/lc3.h=0D
=0D
  Log Message:=0D
  -----------=0D
  shared: Add definition for LC3 codec=0D
=0D
This adds the definition for LC3 codec capabilities and configuration.=0D=

=0D
=0D
  Commit: 3579cf8bf6a7b85997917cd30606a9eb7b9ed41e=0D
      https://github.com/bluez/bluez/commit/3579cf8bf6a7b85997917cd30606a=
9eb7b9ed41e=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M doc/media-api.txt=0D
=0D
  Log Message:=0D
  -----------=0D
  media-api: Add SelectProperties=0D
=0D
This adds SelectProperties which is a more extensible version of=0D
SelectCapability since it takes a dictionary rather than a byte array=0D
and define new Properties for LE Audio.=0D
=0D
=0D
  Commit: f081ac8845910eb9a047fdd68687dcbab1c9937b=0D
      https://github.com/bluez/bluez/commit/f081ac8845910eb9a047fdd68687d=
cbab1c9937b=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M test/simple-endpoint=0D
=0D
  Log Message:=0D
  -----------=0D
  test/simple-endpoint: Add support for LC3 endpoints=0D
=0D
This adds support for LC3 sink/source endpoints.=0D
=0D
=0D
  Commit: dc61ec4419ebb656943c502ba60d2f7a6639315f=0D
      https://github.com/bluez/bluez/commit/dc61ec4419ebb656943c502ba60d2=
f7a6639315f=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M client/player.c=0D
    M tools/bluetooth-player.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client/player: Add support for PACS endpoints=0D
=0D
This adds support for PAC_SINK and PAC_SOURCE endpoints as well as LC3=0D=

presets.=0D
=0D
=0D
  Commit: 9e298f8402d9e7aabce491ad9700f9ca267335fb=0D
      https://github.com/bluez/bluez/commit/9e298f8402d9e7aabce491ad9700f=
9ca267335fb=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M client/player.c=0D
    M tools/bluetooth-player.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client/player: Use QoS interval on transport.send=0D
=0D
This makes use of QoS interval when sending a file.=0D
=0D
=0D
  Commit: 34e8c20d488f8f596857813b615f81355ab70c47=0D
      https://github.com/bluez/bluez/commit/34e8c20d488f8f596857813b615f8=
1355ab70c47=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/transport.c=0D
=0D
  Log Message:=0D
  -----------=0D
  profiles: Allow linked transport to release the fd=0D
=0D
Multiple transports can be linked when using LE Audio BAP.=0D
In this case only one transport is used to Acquire the file descriptor=0D=

which will be shared by all linked transports.=0D
In the same way, any transport can Release the file descriptor.=0D
=0D
=0D
  Commit: b843a5c5b4b52faa19a8926c4b8f6da185a386bc=0D
      https://github.com/bluez/bluez/commit/b843a5c5b4b52faa19a8926c4b8f6=
da185a386bc=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/transport.c=0D
=0D
  Log Message:=0D
  -----------=0D
  profiles: Update transport Links property on state change to QoS=0D
=0D
Currently, the Links property is only sent after the first call to the=0D=

Acquire method, this cmay result in a rejection if a linked transport tri=
es=0D
to call the Acquire method before receiving the Links update.=0D
=0D
=0D
  Commit: 9b93d958845bb31415b62fa09cb3dcb2e8da23e8=0D
      https://github.com/bluez/bluez/commit/9b93d958845bb31415b62fa09cb3d=
cb2e8da23e8=0D
  Author: Christian Eggers <ceggers@arri.de>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M client/main.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client: Add missing return statement in error path=0D
=0D
Client will SEGFAULT if default_ctrl=3D=3DNULL=0D
=0D
=0D
  Commit: 147cc4cf99fdb24f77b46472386e2fdff3098451=0D
      https://github.com/bluez/bluez/commit/147cc4cf99fdb24f77b46472386e2=
fdff3098451=0D
  Author: Christian Eggers <ceggers@arri.de>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M client/advertising.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client/advertising: Fix typos: *_exits --> *_exists=0D
=0D
=0D
  Commit: 150bbff449c787f26b7de3e6006bdb2ea6365b08=0D
      https://github.com/bluez/bluez/commit/150bbff449c787f26b7de3e6006bd=
b2ea6365b08=0D
  Author: Christian Eggers <ceggers@arri.de>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M tools/btmgmt.c=0D
=0D
  Log Message:=0D
  -----------=0D
  tools/btmgmt: add missing return statement=0D
=0D
Leave function on error instead of printing (possibly) invalid flags.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/7c2f0c037e92...150bbff449=
c7=0D
