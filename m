Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132D1E1C02
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340760; cv=none; b=qgVm3cn2zOWmb/FPkoe+FPPFx70LOTc679BBC6O1zrq566Eo08dc9OOeBjQE226SERgeODXwKG+bURGAc8q9GGFMCei9vW4O0MDN71hU+xzhxWZDD5vbs4u4J8ae2gXdvQTVcrAYGlmLzNDrXUGJ3bZ/Z1Ft713AK7z13fpCWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340760; c=relaxed/simple;
	bh=QS7S6kChVYkE7Oshbvrn3aCmERoGMjMAoVZSsn7zFx0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N/7XIQveuUbWNgODaN8zA+sQ3s+kkdMEFtIcnlS8oc50VNj0NpYti9nbgTQ0k6td7/3jT2DMptOXTPzfN4pYLOj3pCV5pDawOPORNzkdGghn5HKpI5YqvDe7vWquzCAP1eOK3SEEUhvh+m+6LMVgoubJU+a4f0oHymeUj9QaguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tid6zMrf; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tid6zMrf"
Received: from github.com (hubbernetes-node-c206443.va3-iad.github.net [10.48.13.62])
	by smtp.github.com (Postfix) with ESMTPA id 8FC553C12F2
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771340758;
	bh=ORM3Ux7lAs4iB7IwA3RRqNSM8c1DPrzKvq9ln7O0JcA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tid6zMrf1VmvtyOZsB2sq1I2wOPOm9rEwOKozEnMMguiCP2sn4/nGmtULU5qhAApc
	 SuPeeyDO1qnUr4bW77mWkl03zmvzJORx6yGKWE5ZbH2UMUl8mE7ifnRwop9poxYzxz
	 29l40nAFFFUl+EPdoeifhKD7fmCHqsfCDce6hPxo=
Date: Tue, 17 Feb 2026 07:05:58 -0800
From: Sarveshwar Bajaj <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/eae363-feb4ee@github.com>
Subject: [bluez/bluez] 9f11cf: bass: Fix use-after-free when rescanning
 broadcast...
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
  Commit: 9f11cf01ecb47a61d21cdff7aee102762e5c05e7
      https://github.com/bluez/bluez/commit/9f11cf01ecb47a61d21cdff7aee10=
2762e5c05e7
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix use-after-free when rescanning broadcast sources

When a broadcast source is discovered, bap_attached() allocates a new
bass_data session but does not initialize data->bap. As a result,
bap_detached() cannot match the session using match_bap(), leaving a
stale bass_data entry in the sessions queue with a dangling device
pointer after the temporary device is removed.

During a subsequent scan, bis_probe() iterates over the sessions queue
and dereferences this stale device pointer, triggering a use-after-free
crash:
=3D=3D151814=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=

0x7bad5fde0908 at pc 0x64b9501c99ee bp 0x7ffd70517800 sp
0x7ffd705177f0
READ of size 8 at 0x7bad5fde0908 thread T0
    #0 0x64b9501c99ed in device_get_adapter src/device.c:6826
    #1 0x64b95010f04c in bis_probe profiles/audio/bass.c:1561
    #2 0x64b950284395 in bt_bap_bis_probe src/shared/bap.c:5903
    #3 0x64b950104c1f in bis_handler profiles/audio/bap.c:1541
    #4 0x64b95028eb7c in bt_bap_parse_base src/shared/bap.c:7767
    #5 0x64b950104a5b in big_info_report_cb profiles/audio/bap.c:1601

Fix this by:
1. Initializing data->bap in bap_attached() so the session can be
   correctly located and removed in bap_detached().
2. Unregistering the BIS callback in bap_bc_detached() before tearing
   down the session to avoid callbacks referencing freed data.

Link: https://github.com/bluez/bluez/issues/1907


  Commit: a98f3d5abf14eb6e3ddcbf73c22362020f26e105
      https://github.com/bluez/bluez/commit/a98f3d5abf14eb6e3ddcbf73c2236=
2020f26e105
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M .gitignore
    M Makefile.tools
    A client/btpclient/btpclient.c
    A client/btpclient/btpclientctl.c
    R tools/btpclient.c
    R tools/btpclientctl.c

  Log Message:
  -----------
  tools/btpclient: Move btpclient to client/btpclient directory

This prepares the split of btp services in per profile files for
easier maintenance.


  Commit: e1c7988308e543afc7c73b5af1bf8efcacbb2221
      https://github.com/bluez/bluez/commit/e1c7988308e543afc7c73b5af1bf8=
efcacbb2221
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    A client/btpclient/btpclient.h
    A client/btpclient/core.c
    A client/btpclient/core.h

  Log Message:
  -----------
  client/btpclient: Move btp core service in its own file

Moving the btp services in their own files will simplify maintenance.


  Commit: b39c294ec4f3be4e2797942f8a3d21daf3cdbde3
      https://github.com/bluez/bluez/commit/b39c294ec4f3be4e2797942f8a3d2=
1daf3cdbde3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/core.h
    A client/btpclient/gap.c
    A client/btpclient/gap.h

  Log Message:
  -----------
  client/btpclient: Move btp GAP service in its own file

Moving the btp services in their own files will simplify maintenance.


  Commit: 066a164a524e4983b850f5659b921cb42f84a0e0
      https://github.com/bluez/bluez/commit/066a164a524e4983b850f5659b921=
cb42f84a0e0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: connect source profile after sink

Since cdcd845f87ee the order in which profiles with the same priority
are connected is the same order as btd_profile_register() is called,
instead of being the opposite order.  When initiating connections, we
want to prefer a2dp-sink profile over a2dp-source, as connecting both at
the same time does not work currently.

Add .after_services to specify the order.

Fixes: https://github.com/bluez/bluez/issues/1898


  Commit: feb4ee9dcd4b26db16b4c9ca27124850ba98fa9b
      https://github.com/bluez/bluez/commit/feb4ee9dcd4b26db16b4c9ca27124=
850ba98fa9b
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use-after-free in broadcast sink cleanup

bap_data_free() was calling bt_bap_detach() before destroying
bcast_snks queue. bt_bap_detach() frees all streams but broadcast
sink setups in bcast_snks queue were still holding pointers to these
streams. When queue_destroy() calls setup_free() as its destructor,
it attempts to access these already-freed stream pointers, causing
a use-after-free.

Fix this by destroying the bcast_snks queue before calling
bt_bap_detach() and ensuring stream references are released
while the streams are still valid.

Used safe cleanup pattern to avoid nested queue operations during
destruction as setup_free()may attempt to remove items from queue
being destroyed.

Crash trace:
  AddressSanitizer: heap-use-after-free
  #0 bt_bap_stream_unlock src/shared/bap.c:6384
  #1 setup_free profiles/audio/bap.c:1123
  #2 queue_destroy src/shared/queue.c:60
  #3 bap_data_free profiles/audio/bap.c:210

https://github.com/bluez/bluez/issues/1866


Compare: https://github.com/bluez/bluez/compare/eae36399e758...feb4ee9dcd=
4b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
