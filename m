Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512683;
	b=QNlMpOB/T4OiQzIxwoyFhOSxZnPYNfwEKmok98zfy4Ie56wJpbuvseaAdtLwBHQTd06G
	 pCwP7iXsUADAH8EgKghFOn/914BHtZhcv3PrTX+uWm8JZXAFokY9uoVvwmEl0em6qmx1t
	 1Dil5JzdZZmn2y0FkVIJRcLZd0k9NuHfqazx1qngo0uC6TkiLKkt42pyWdLRfXdK7WX4M
	 DZurTD/qjivplemO6AUWM6kbuyxK7S63DozUgG1C+9Ye7a6BrLniJsaXBXTdbU0jIWzhm
	 Lo4uUuo96a513JNjD5lQ0zMiFxqzZ0yNqsUqtSdNzLtKAY55ugsqTm33V97GDwYTgGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=07NIsoUlOpVS4uyd/2oU3IRCI7BLAE4hFajjT9Gbcr8=;
	b=NJ+d3EjMG4SQ0fFSWnTohkPBnYxTFJyoTHB5Gy/b2WerhfJ7GIahrbLLn7OyC0PpxjnV
	 k3FCq88pti2ztxcPdY/TrnwfA/3mxtos5P5rzy+e3AtQiIuG7z4RmuRwA0lEouUnDqYg2
	 bFSvZrhrs5lqVhAu9xL6dZEE9ovfGsr5eLNF5kogAyu5XMM11DI9vgTx/cveeYFjVnow2
	 TIZ97PjGS5BYWV+4g01X8OlGV1svs/7Gh7uWBe2Vu+8s7tUg073CnmilSzDRqckyQtVsC
	 Y+55a7GOsMuEmdUCMyr1q9bz+Gw69nG9nvNBMcRgISXLgzgY1SrtHP4sgHyYrJrm7NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=Zfx2apd3;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1154606A33A;
	Tue, 24 Nov 2026 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1154606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=Zfx2apd3
Received: from email.seznam.cz
	by smtpc-mxb-67bf8c997c-nxznx
	(smtpc-mxb-67bf8c997c-nxznx [2a02:598:128:8a00::1000:93f])
	id 0d45cb79bb7f666008cad131;
	Tue, 24 Nov 2026 10:31:02 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512662; bh=07NIsoUlOpVS4uyd/2oU3IRCI7BLAE4hFajjT9Gbcr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc;
	b=Zfx2apd3kEzVmvIE1qvLBIuVweXTXX4THCzqimOC/HhjK6MB6s2OUIHc4Qd/wQj3a
	 es2NjBb43/qXggX2t14WY8YqPYXOVdcPTgudbSqc8Bu+Iz44J3y52hzyaaRlpvsfD8
	 +B0SM/fvOaT8f5IHbwnYRNIs7rVmBJ9jxDWMhFEX0cXYJwuLcCa1vNc9XR15BkQ1pw
	 1Tr7d88ymTwCvAtpKlOOdmdSdJYtV3ReVo0Tzm1KNjiAuSCAxIiYMx+NLNxWP9IwZs
	 MQPPBV1hL4ycdDWb6pn4PxoLcUZ58fiSI8+LvfuhJ2ifEHquQVrDJnKEVbx8hrCS48
	 3AgxsQg0/3w1A==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-584bc557d7-pqx9t (szn-email-smtpd/2.0.97) with ESMTPA
	id da947f30-7c08-4e98-b716-1c6f96e6b293;
	Tue, 24 Nov 2026 10:31:00 +0100
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH v4 0/4] Bluetooth: find an RPA peer's connection parameters
 by its identity
Date: Tue, 24 Nov 2026 10:30:56 +0100
Message-Id: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oy07DMBBFf6XymikZ59GEFf+BWIztSRMgdjR2o
 5Yq/05cNkUsYHlH9545VxVZRo7qaXdVwssYx+C3UD3slB3IHxlGt2WlC90gFgh9EDjNMQnTBB8
 MNngPMwlNEWQm6HVZVr2pnaOD2iizcD+ebx9eXr9zPJk3tiljc8NQZDBC3g75ZBJ4PqfHiWJiy
 YVhjCnI5ea4YAb9X2dBQOjattEdFZ2x3fMc3DGIv+ztp8pCi74nVqgLLNs9YlMfsN7GQo7ff6/
 K+1X3t0e5ocih1rUxhWn7n8R1Xb8AL13DqYsBAAA=
X-Change-ID: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

v4 answers Luiz's question on v3 about hci_conn_params_add() resolving
the address before a lookup that resolves it again, and fixes what
Sashiko raised on v3:
https://lore.kernel.org/all/CABBYNZLFtpr8xFjnimRZ9VKOsEgUV-Gzf61bomK4u+SMEyqBxA@mail.gmail.com/
https://sashiko.dev/#/patchset/20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f%40podgorny.cz

The single v3 patch is now four. Patch 4 is the v3 fix itself. The
first three fix bugs in bluetooth-next that it exposes or sits next to,
and each stands on its own:

1. hci_connect_le() keeps pointing into an IRK after leaving RCU.
2. A connect to a peer's RPA misses the connection the peer already
   has under its identity and adds a second hci_conn.
3. A second advertising report before LE Create Connection is sent
   adds a second hci_conn for a peer dialled under its RPA.
4. The connection is created with the controller-wide defaults instead
   of the peer's own parameters.

Patches 3 and 4 use helpers added in patch 2; patch 1 is independent.

Tested on v7.3.5 (the flags tests need &c->flags there) on a Raspberry
Pi CYW43455 central and a peer on a resolvable private address whose
parameters are loaded under its identity: first with three successive
builds of v4 applied as one patch (17 of 17 connects), then with this
series for three days (6 of 6 forced reconnects and 179 connects in
normal use). Every connect was one Create Connection to the RPA,
including across RPA rotations between attempts, and those captured on
air carried the identity's parameters. With the peer connected, an
L2CAP connect to its current or a previous RPA now finds the existing
connection, as one to its identity does; without the changes it adds a
second hci_conn under the RPA and waits until it times out. Not
exercised: a controller that resolves the address itself and a peer
with no cached RPA, which this controller and peer cannot reach, and a
second advertising report before LE Create Connection is sent.

Known limitations, raised by a local Sashiko run and left as they are:

- Patch 3: if an explicit connect was made to a peer's RPA before its
  IRK was known, auto-connect to the identity gets -EBUSY until whoever
  made that connect cancels it, which for Pair Device is userspace: a
  connect that was never started has no timeout. Reusing that
  connection instead hands the auto-connect params a reference they do
  not own. Avoiding both needs the explicit connect moved to the
  identity when the IRK is added, which is a separate change.
- Patch 2: Cancel Pair Device by an RPA no longer finds a pairing
  started by that RPA when the IRK was already known. It now behaves as
  a pairing started by the identity, which is how bluetoothd starts one
  for a peer whose IRK it holds.

Per Documentation/process/generated-content.rst: the patches and this
message were done with the Claude coding assistant (model as in the
Assisted-by trailer). The prompts asked it to fix the issues Sashiko
raised on v2 and v3 and the question raised on v3, then to review the
result with a local run of Sashiko and with Sashiko's published review
prompts, and fix what that turned up. The author directed the work and
reviewed the result.

---
Changes in v4:
- Split into four patches (Sashiko)
- hci_conn_params_add(): resolve once, through a new
  __hci_conn_params_lookup() that does not resolve again (Luiz, Sashiko)
- New patch 2, hci_connect_le_scan(): resolve an RPA to the identity
  first, so a connect to an RPA neither creates its connection under
  the RPA nor misses one the peer already has under its identity
  (Sashiko). Add Device, which Sashiko also named, accepts only
  identity addresses
- New patch 3, hci_connect_le(): when the lookup by address misses,
  find the peer's connection by IRK and refuse it with -EBUSY, also
  while scanning, since a scanning one then belongs to other params. A
  second advertising report before LE Create Connection is sent no
  longer creates a second hci_conn (Sashiko). This replaces v3's reuse
  of a scanning connection found by IRK, which patch 2 makes
  unnecessary
- New patch 1: copy the RPA dialled out of the IRK under RCU
- Rebased on bluetooth-next
- Link to v3: https://patch.msgid.link/20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f@podgorny.cz

Changes in v3:
- Look up the identity instead of the RPA, not after it, so an entry
  left under the peer's pre-bonding RPA cannot shadow it
- Copy the identity out of the IRK under rcu_read_lock(), since SMP can
  free the IRK without hdev->lock
- hci_conn_params_add() stores a new entry under the identity
- load_conn_param() and load_conn_subrate(): look up the connection with
  the entry's address type
- hci_connect_le(): find the scanning connection of a connect made to
  the peer's RPA by its IRK, so it is not duplicated once the identity
  entry is pending, even after the peer has moved to a new RPA, and
  also when the controller resolved the advertisement or no RPA is
  cached for the peer. Kept in this patch, since on its own it would
  leave a reference imbalance until the lookup is fixed
- Rebased on bluetooth-next
- Link to v2: https://patch.msgid.link/20261104120138.1165715-1-radek@podgorny.cz

Changes in v2:
- Resolve the RPA inside hci_conn_params_lookup() rather than at the
  hci_le_create_conn_sync() call site, as Luiz suggested, so no other
  caller can miss the entry
- Rebased on bluetooth-next
- Link to v1: https://patch.msgid.link/20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz

---
Radek Podgorny (4):
      Bluetooth: copy the peer's RPA out of its IRK under RCU
      Bluetooth: connect to an RPA as to the identity behind it
      Bluetooth: refuse to dial a peer whose connection is under its RPA
      Bluetooth: find an RPA peer's connection parameters by its identity

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 75 ++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_core.c         | 50 ++++++++++++++++++++++++---
 net/bluetooth/hci_event.c        |  4 +--
 net/bluetooth/mgmt.c             |  4 +--
 5 files changed, 125 insertions(+), 10 deletions(-)
---
base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f
change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7

-- 
Radek Podgorny <radek@podgorny.cz>

