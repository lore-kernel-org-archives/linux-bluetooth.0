Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EE2D23BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140675; cv=none; b=mok/o3yr5gnfmN9uhjZzOrmmlRxGVetyl4KAbD7MLH9ObzCwZynzt51cKdvhTkmcE7qQUuaGm4TWFQSl0BbItBLRYYwOLZabWqHIxVLyH9XqdX38QDxOsbQd1B2MIc2m7S4A2JNrWL5NK06GBXM6XT9AfSs1kakxELOTF1V1Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140675; c=relaxed/simple;
	bh=7MZx0Xxs3qpzKUA/g4zdCP24Nn3Lc+4C1gYidh3CcWw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E0mJ/KeDC/HD/zbRSdPAKgwxANk3opZFLV9s0Ebrk9vAhAITdUMjdyIB9H4y288qHYUHDCPVzsqd0KRxw8cSoY27PybBz+rMoRCrsAvZQCkrVzEqCBef8OCViYKeKdJYT27qr7YlWRdQAZOn5yga5U1BOl+Wg1WHKwgl+2fMgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hjrNYx55; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hjrNYx55"
Received: from github.com (hubbernetes-node-58e3acf.ac4-iad.github.net [10.52.157.16])
	by smtp.github.com (Postfix) with ESMTPA id DD4734012F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763140669;
	bh=kcPdlMOJYgI4ROKww3yHfFJy98hkCvZvXtHlBjr8NgY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hjrNYx55XQ49XWNLCSkT2dnFk59FWUN5yRIgak8pgBsHwDO86KpPmKeCKrYkHaSut
	 /UQ7UD5E9PIjC/Yeq+KQPquJ6LTp0SUN2hM6NfeVjSzmc6Rl/fcqW6fxvvWt0z3g9L
	 0zb0AddV0OvqjBzi7G7a5hdFC3XuLcyiXeAr17x0=
Date: Fri, 14 Nov 2025 09:17:49 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5e41d1-4bf47f@github.com>
Subject: [bluez/bluez] e9b4bf: shared/hfp: Add simple 3way calls support
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
  Commit: e9b4bf2917a33537ab8251349f4bec5d1c69ae8c
      https://github.com/bluez/bluez/commit/e9b4bf2917a33537ab8251349f4be=
c5d1c69ae8c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add simple 3way calls support

This adds support for the AT+CHLD=3D0 (Releases all held calls or set
User Determined User Busy for a waiting call), =3D1 (Releases all active
calls and accept the other call, held or waiting) and =3D2 (Places all
active calls on hold and accept the other call, held or waiting)
commands and the +CCWA (Call waiting notification) event.


  Commit: 300ec5a46f691e104025934587538c086ac5e1f3
      https://github.com/bluez/bluez/commit/300ec5a46f691e104025934587538=
c086ac5e1f3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add tests for simple 3way support

This add the following tests:
- /HFP/HF/TWC/BV-01-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting and that the HF sends the User Determined User Busy
  (UDUB) indication to the AG (AT+CHLD=3D0).
- /HFP/HF/TWC/BV-02-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can end an active call and accept the other
  (held or waiting) call (AT+CHLD=3D1).
- /HFP/HF/TWC/BV-03-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can place an active call on hold and accept
  a call waiting (AT+CHLD=3D2).


  Commit: 708bf7d11056daa715267d6ba66fa038693e6a55
      https://github.com/bluez/bluez/commit/708bf7d11056daa715267d6ba66fa=
038693e6a55
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: use AM_DISTCHECK_CONFIGURE_FLAGS

DISTCHECK_CONFIGURE_FLAGS is meant for users to be set on the command
line.

https://www.gnu.org/software//automake/manual/html_node/DISTCHECK_005fCON=
FIGURE_005fFLAGS.html


  Commit: 057da54566f6ca8f0e795ec53fdd569607d61758
      https://github.com/bluez/bluez/commit/057da54566f6ca8f0e795ec53fdd5=
69607d61758
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix distcheck by hardcoding non absolute paths

Pkg-config gives out absolute paths that don't fare well with distcheck
that needs to install files into its own prefix.

Disable cups for distcheck as well so that only dbus needs this
handling.

You can learn more about this type of issue here.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1123963

See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")


  Commit: ebd6f9fefa269535b76e28ccc3fa64764f4bd98b
      https://github.com/bluez/bluez/commit/ebd6f9fefa269535b76e28ccc3fa6=
4764f4bd98b
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: obexd: Revert "Fix make distcheck"

Fixes: https://github.com/bluez/bluez/issues/806
Reverts: 9cc8b97b8 ("build: obexd: Fix make distcheck")


  Commit: f67b72b4cc39eb14748914a1293c33cbe5517f3d
      https://github.com/bluez/bluez/commit/f67b72b4cc39eb14748914a1293c3=
3cbe5517f3d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add page information to print_features_subpage

This makes print_features_subpage print the page they belong:

> HCI Event: Command Complete (0x0e) plen 253
      LE Read All Local Features (0x08|0x0087) ncmd 1
        Status: Success (0x00)
        Page: 10
        Features[0/0][8]: 403900f301000080
          LL Privacy
          LE 2M PHY
          LE Coded PHY
          LE Extended Advertising
          LE Periodic Advertising
          Periodic Advertising Sync Transfer - Sender
          Periodic Advertising Sync Transfer - Recipient
          Connected Isochronous Stream - Central
          Connected Isochronous Stream - Peripheral
          Isochronous Broadcaster
          Synchronized Receiver
          Connected Isochronous Stream (Host Support)
          LL Extended Feature Set
        Features[1/0][8]: 0000000000000000
        Features[1/1][8]: 0000000000000000
        Features[1/2][8]: 0000000000000000
        Features[2/0][8]: 0000000000000000
        Features[2/1][8]: 0000000000000000
        Features[2/2][8]: 0000000000000000
        Features[3/0][8]: 0000000000000000
        Features[3/1][8]: 0000000000000000
        Features[3/2][8]: 0000000000000000
        Features[4/0][8]: 0000000000000000
        Features[4/1][8]: 0000000000000000
        Features[4/2][8]: 0000000000000000
        Features[5/0][8]: 0000000000000000
        Features[5/1][8]: 0000000000000000
        Features[5/2][8]: 0000000000000000
        Features[6/0][8]: 0000000000000000
        Features[6/1][8]: 0000000000000000
        Features[6/2][8]: 0000000000000000
        Features[7/0][8]: 0000000000000000
        Features[7/1][8]: 0000000000000000
        Features[7/2][8]: 0000000000000000
        Features[8/0][8]: 0000000000000000
        Features[8/1][8]: 0000000000000000
        Features[8/2][8]: 0000000000000000
        Features[9/0][8]: 0000000000000000
        Features[9/1][8]: 0000000000000000
        Features[9/2][8]: 0000000000000000
        Features[10/0][8]: 0000000000000000
        Features[10/1][8]: 0000000000000000
        Features[10/2][8]: 0000000000000000


  Commit: 4bf47f880d061891effbf0f9532c4e2277a4ece6
      https://github.com/bluez/bluez/commit/4bf47f880d061891effbf0f9532c4=
e2277a4ece6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix set_bredrle_commands

This fixes set_bredrle_commands which was overriding the list of
commands previously set, so instead of setting the extra command
after the command list of the specific version this is now merged
together with each version that requires the extra commands.


Compare: https://github.com/bluez/bluez/compare/5e41d1e1d361...4bf47f880d=
06

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
