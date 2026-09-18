Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8E2D73B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753144; cv=none; b=TzOlD7rihY/RPcPlgekM2EG+IfmpZf/SbGDeLwGQuZ8vyJaGOaBY0SmvJp6I1Fqrb/P662OUHSBPhTzO8BthoSqMiBTvSk4YnR2+x8d0ygaQAZBK/jFF5SlxHpLzv4chSF/vplBOJuneRvkjbT9c8nAhW8akOxtssK9lRYPCncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753144; c=relaxed/simple;
	bh=QCUZYBkT+Tcyv+r/IZV/53DIbwO/MuXa2eVdfUp34+0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D4IXT/oz9BgcqgAHTwTUIJkFCq+Z98FSt6YUFZzpD0Ykktlw0i9PIdC3y9tQrs31r2IO/G0+DgIes/9FJizlM0CBP9lcOEcraDSEkqB+u4wDMGgzrYO5dwVKS/PDOR/IqXZc0R58pLfyT3OS1F1g8kapodHoX03lkcpXAnuRdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QWcx8W89; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QWcx8W89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789753140;
	bh=cHJcPMnGp07xNz11fykib5w4MIV8Njr4MygYgIALDwY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QWcx8W89WtIhoZChXrDJegxdw8LBxpWXJJcPbwX6NHkcC214l2A3qc9IFtZE5coH/
	 5GcXp5UKOthrEFq8pRNwt4eqpt2CgQmlqXSGLJ/yajkUhzAt4PG1579D33VkwBXOJd
	 FTk7O8wQaAVVz1KKYFZ7XQQ4B7pV0E42x3/iOtK0=
Received: from github.com (hubbernetes-node-5787ef0.ash1-iad.github.net [10.56.195.36])
	by smtp.github.com (Postfix) with ESMTPA id D0A9F840D39
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:39:00 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:39:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/240105-084d21@github.com>
Subject: [bluez/bluez] 37e483: mgmt: Add defines for the long term key types
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
  Commit: 37e483b0687e95f05a8ab445a3f1c33061278739
      https://github.com/bluez/bluez/commit/37e483b0687e95f05a8ab445a3f1c=
33061278739
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add defines for the long term key types

Add defines for MGMT_EV_NEW_LONG_TERM_KEY key types.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: a82606b8e1f85a56d8639542a4f07d3d4eda349d
      https://github.com/bluez/bluez/commit/a82606b8e1f85a56d8639542a4f07=
d3d4eda349d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M profiles/audio/csip.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Remove unused central field from struct ltk_info

struct ltk_info::central is only read in btd_device_get_ltk(), but its
only caller in csip.c does not use the output parameter.

Remove the unused field and adjust btd_device_get_ltk() accordingly.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 4d97be27a1fbf438a91b95aba1e35b2b43fde90c
      https://github.com/bluez/bluez/commit/4d97be27a1fbf438a91b95aba1e35=
b2b43fde90c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix resolving a coordinated set over Secure Connections

Commit 9251e630efdd ("device: keep the long term key of both roles")
adds separate central/peripheral slots for LTKs.

Kernel only sets LTK event central flag for legacy pairing:
net/bluetooth/mgmt.c:mgmt_new_ltk() sets it if key->type =3D=3D SMP_LTK.
For Secure Connections there's then no role difference, and BlueZ puts
those keys to peripheral slot.

CSIP coordinator is GAP Central (CSIP 4.2). To decrypt SIRK in
btd_device_add_set() / add_set() it reads device->ltk central key
which then never exists with Secure Connections.

test_bap.py:test_bap_unicast_set_* implicitly use legacy pairing since
pytest-bluezenv=3D=3D0.1.9 powers controller on before bluetoothd, so the=
se
tests miss this bug.

Fix by tracking the MGMT LTK type in struct ltk_info so the code knows
which kind of key it has.  For Secure Connections, store the same key in
both slots.  If key type changes, drop both slots, to avoid mixed
legacy/SC keys.

This fixes test_bap.py:test_bap_unicast_set_* with SC enabled, ie if
controller is powered off before bluetoothd start.

Assisted-by: qwen3.8-flash-next


  Commit: c67833ce2ff8760d914ba6e3bce4c0170fafcf4f
      https://github.com/bluez/bluez/commit/c67833ce2ff8760d914ba6e3bce4c=
0170fafcf4f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: run CSIP test for Secure Connections & Legacy Pairing=


Parametrize test_bap_unicast_set_transport_created() to test CSIP with
and without Secure connections, toggling it with btmgmt before pairing.

test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts=
7-vm3-sc]
test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts=
7-vm3-legacy]


  Commit: 12fc9c791485fb1bcf7a7ea7248583400870effc
      https://github.com/bluez/bluez/commit/12fc9c791485fb1bcf7a7ea724858=
3400870effc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    A doc/qualification/ascs-pics.rst

  Log Message:
  -----------
  doc/qualification: Add ASCS PICS file


  Commit: 92f13ea19b67bc7d6905ea559132303bff6a9f26
      https://github.com/bluez/bluez/commit/92f13ea19b67bc7d6905ea5591323=
03bff6a9f26
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    A doc/qualification/ascs-pts.rst

  Log Message:
  -----------
  doc/qualification: add ASCS PTS tests documentation


  Commit: 11bf67364e554be735241d4794d40d0d68be4865
      https://github.com/bluez/bluez/commit/11bf67364e554be735241d4794d40=
d0d68be4865
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Skip local metadata Config callbacks

When reconfiguring a client stream that is already Codec Configured,
setup_config() queues Codec Configuration and then caches metadata.
stream_metadata() emits a same-state CONFIG notification for that local
update. The profile callback treats it as the peer's configuration
completion and clears config_pending before the peer has responded.

If the control point response precedes the ASE state notification, QoS
setup can run while need_reconfig is still set and fail locally.

Cache client metadata in CONFIG without emitting a state notification.
Keep genuine peer CONFIG notifications and server metadata handling
unchanged.


  Commit: 72a5ce497f34b2e5f1e8e8d831d7f7e5a5ec403b
      https://github.com/bluez/bluez/commit/72a5ce497f34b2e5f1e8e8d831d7f=
7e5a5ec403b
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Pass unicast preset metadata to config

Custom presets retain metadata, but endpoint.config copies only their
codec capabilities and QoS into SetConfiguration. Copy the metadata too,
and free configuration buffers on completion and immediate failure.


  Commit: 084d21fe4708c1af7532f78f18a29f808474832a
      https://github.com/bluez/bluez/commit/084d21fe4708c1af7532f78f18a29=
f808474832a
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test-functional: Cover BAP metadata reconfiguration

Reconfigure both unicast streams using custom presets with empty or
Media metadata at ATT MTU 64. The second Configured notification arrives
separately, exposing premature QoS setup from a local metadata callback.

Check that old transports disappear, both replacements retain their
codec configuration and metadata, and both can be acquired.

Remove the fixture's redundant configuration command: SelectProperties
already configures both streams after pairing.


Compare: https://github.com/bluez/bluez/compare/2401054ca67a...084d21fe47=
08

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
