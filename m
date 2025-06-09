Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151719258E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492943; cv=none; b=enp3rETo8Jy311xjiwU1J3A+dC8WvLJnEylPG/UVmPUBSW7abvJKM3n+ySB8nQCegFX14XM5q3lSco1kF3v69Fzy8/OfPt4QhJbKN5Sa/Ffgf42jnY7dNoxWdQ1WbwHbrdHN7AS+fVEhZCZu9EFo073bhmUaXBe6GA8VCyLsck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492943; c=relaxed/simple;
	bh=/EurZ1nNojCYgLSSP2bWAbndwC+5jrMecRLA2/7FhBk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ODMsSJJTPbkoQGQHRzUyGeL6X0iyVVUich5M2y6aqAsj1KH13l2LbiIYy0X6zvrQSHlwUI3OwvaFRf2apaEJb+NAJX/Z3LcQ7wC2Knj8drffuX6hUPymUFqEAj2Ytt4tBdNkn9713lgKhyoAt18XZs5u09/MgXMqox4q2VozGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dKcbhN/Z; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dKcbhN/Z"
Received: from github.com (hubbernetes-node-741fd13.va3-iad.github.net [10.48.160.18])
	by smtp.github.com (Postfix) with ESMTPA id CA13E4E0978
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749492940;
	bh=V0hEo2xTfGAOVXPh1lMdlapt9BNfMybkZd4Qn+YazDk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dKcbhN/Z9AnA2cotK7YDRgMsqU/tZT4jsrxkabFN7U3UtAOVvMCdG0TOJ41aiMjSs
	 PhQYWmkORQDwg+4ipM+c8/1i8kgwOHw7ckl5kejaq9N4xzeNgIqF910jD/avu7BS9u
	 G5ILWpIsiEAOS/0mDlcbPshE388K3VhDz2r54zlo=
Date: Mon, 09 Jun 2025 11:15:40 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b39c37-7feff4@github.com>
Subject: [bluez/bluez] 7d8eaa: bap: do not try QoS before links are updated &
 io ...
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
  Commit: 7d8eaa56b8cb8f2981476590e8ec210eacb0c91b
      https://github.com/bluez/bluez/commit/7d8eaa56b8cb8f2981476590e8ec2=
10eacb0c91b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: do not try QoS before links are updated & io created

In setup config, QoS must be done after corresponding bap_state
callback, because stream links are updated only at that point.  If the
ASE was in CONFIG state before reconfiguration, this gets done in wrong
order.

Track explicitly that bap_state() is done after bt_bap_stream_config(),
before proceeding to QoS.


  Commit: 2f853e4d86d887a37750ae09c91f59344df5a5e7
      https://github.com/bluez/bluez/commit/2f853e4d86d887a37750ae09c91f5=
9344df5a5e7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: detach ucast io on RELEASING and unlink streams

When RELEASING, ucast stream QoS becomes invalid and client stream
transport can no longer be acquired.  Client shall close the CIS when
ASE is RELEASING (BAP v1.0.2 =C2=A75.6.6).

As client, detach IO when RELEASING. Clear the stream links, as the QoS
is no longer valid. Even if caching config the ASE may be reused for
different purpose, and stream will anyway be reconfigured & re-linked as
needed.

Also clear the stream transport, as it's not in acquirable state, and
its configuration may change after this. This makes BAP Client to have
existing transports only for streams that are >=3D QOS.  (BAP Server is
not changed here.)


  Commit: d1eb496cc605fed41ad5bc1899fb1642a4b8abb5
      https://github.com/bluez/bluez/commit/d1eb496cc605fed41ad5bc1899fb1=
642a4b8abb5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: add client ASE reuse and upper level stream locking

Change ucast client stream design so that:

* upper level locks streams to indicate which ones it is using
* unused streams are reused when upper level wants a new stream
* only locked streams are used for bidi CIS linking
* streams (still) correspond 1-to-1 to non-idle ASEs

This fixes some issues:

* bap_ucast_stream_new() could pick a stream upper level is already
  using if lpac & rpac match (can occur with multi-stream AC 6(ii) etc)
* Avoids assuming ASE enters idle state at end of stream life cycle.
  This is False for some devices like Sony headsets, which always cache
  codec config so RELEASING -> CONFIG always, never RELEASING -> IDLE,
  so ASE never go IDLE again.
* Allows reconfiguring an ASE with different codec in this case.
* Allows upper level to only QoS some of the streams.

Reconfiguring ASE in QOS/CONFIG state with different codec here results
to need_reconfig=3Dtrue state, where ASE and stream configs do not match,=

and upper level needs to do bt_bap_stream_config() to sync them.


  Commit: 40b91712b93294f68f8f52b88358ef4f08037a86
      https://github.com/bluez/bluez/commit/40b91712b93294f68f8f52b88358e=
f4f08037a86
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: lock streams when used

Indicate to lower layer when we are using the streams.

When setup is freed, make sure the corresponding stream is released
after unlocking.


  Commit: ebed99caa7a10818c7b67b72a33d923ce90d1cb7
      https://github.com/bluez/bluez/commit/ebed99caa7a10818c7b67b72a33d9=
23ce90d1cb7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add ready callback for setup configuration

Operations like SetConfiguration need to wait until setup configuration
finishes. Abstract this to a setup_config() callback emitted on QoS
completion or failure, instead of hardcoding DBus reply.


  Commit: 9e0dc968de5081106343949d2ba2947aba675c17
      https://github.com/bluez/bluez/commit/9e0dc968de5081106343949d2ba29=
47aba675c17
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  bap: support removing streams with ClearConfiguration()

Implement removing streams via ClearConfiguration().


  Commit: bb63339e4b43dc96d7cddbd3f66d289a91cd3896
      https://github.com/bluez/bluez/commit/bb63339e4b43dc96d7cddbd3f66d2=
89a91cd3896
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add callback at the end of ucast client select/config

Restructure pac_select() and add a callback that is called when all
setups reach QoS.


  Commit: 128b0695e2b5941f84099cee98e9d4318ccfced6
      https://github.com/bluez/bluez/commit/128b0695e2b5941f84099cee98e9d=
4318ccfced6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: implement Reconfigure()

Add Reconfigure() on a BAP unicast endpoint, which triggers its
reconfiguration or marks it for reconfiguration.

First, all associated streams are closed. After that, endpoints marked
for reconfiguration are reconfigured using the same flow as in the
initial configuration.


  Commit: 1d3907561f8e67a71b378ecfd2c770a5fc1766d5
      https://github.com/bluez/bluez/commit/1d3907561f8e67a71b378ecfd2c77=
0a5fc1766d5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: don't show error when releasing stream

When stream is released, just set transport to not playing and don't
show error about missing io.


  Commit: 7feff47a9fbe84604d24642ccb7285c8a0eabb20
      https://github.com/bluez/bluez/commit/7feff47a9fbe84604d24642ccb728=
5c8a0eabb20
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: delay QoS & IO creation if CIG is busy or setups configuring

Unicast Client IO creation / activation should be done synchronously for
whole adapter, as active CIG has to be removed before it can be
reconfigured (Core v6.0 Sec 4.5.14.3).  Some adapters support only one
active CIG.

Move related logic to bap_update_cig*() which does QoS and IO creation
as needed by current state.

If CIG is active or setups are being configured or closed, delay
transitions to QoS and IO recreation until that completes.  Also delay
activating CIG (=3D enabling CIS) until setups have finished readying or
closing.

Operations are delayed within the same CIG, with the exception that
streams with unassigned CIG delay every CIG. This is because such
streams are likely meant to go to some existing CIG, so we must wait
them to be configurable before asking kernel to assign IDs.

Fixes race conditions:

* setup starts readying while CIG is active
* CIG is activated while a setup is readying
* new stream creates IO before old stream IO is recreated

These result to kernel assigning new streams to a different CIG
(problematic on controllers that can do only one) or CIS ID conflicts.


Compare: https://github.com/bluez/bluez/compare/b39c37d2179f...7feff47a9f=
be

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
