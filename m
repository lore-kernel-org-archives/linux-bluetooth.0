Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649844;
	b=MZWJel/zoae8vyNKjBuq50GXG2Kl6kGrVyFHkvQu5TE3BlRQmr3C0wqmi1p5uRfnxn08
	 SVy1331MwL313tIqRDODkL2Iano8lp94dm3ASgykMicPMYbOhEeRd2Bx6PvkS+rX49tRi
	 3sWw0HKNYcIfFaMvdQy5XevyEa2MHhqSOzQ0IamQtqNSrfNcpUAmY3lARZNTa3OxnHzl4
	 adnaAY2UMdRDBE28P61TDS6soEodFBtnuvuZME8YsXTNPyUQWT/SgmoIx61mU+XHCHAN7
	 yPEkBh8Oi7DeuNaRI6ZUOVeXfub8kC0NIrazzzQDBYk5jF4xbXdVXBmk5Ce23zFi18Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649844;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=SfDHpU8LuWRCLw2p5KGjDm/w3KzUirNSauuMVlPYQ9A=;
	b=NkLbkVdrg+PeIZkVKk0wZlrHtnPvf3nh54ZtcxQ5DK0v6nZmo1MOf4VT0OMwTdy6Bk0v
	 qeaNwU8rEXyu6g777fBTYF30ulPoCbhM0KMUzv1KzbUE0oSoY+cGHUzNmWEjY0Eu8W9i3
	 bLv9j6VqQ+Jm/FNGvPzQQDlUr5ryyy864oWKFnFrYN6qoM3QPnNCEnV0G5UBZKlkhZMq5
	 Ew6+pMoOmIg98/7xmjyliwKDl/bo7ZO4mZERBlR4YmI6KszkHW6rg67YJlFpBlAldnY0J
	 CN5vFJrIIG7gV0YNCUzMYaltxQT6jiaGT+Z5Ntm1Ow8nA30mitfxD/bGmoSZWD22YWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=S7nv9ZpW;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6E606A327;
	Wed, 25 Nov 2026 23:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB6E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=S7nv9ZpW
Received: from email.seznam.cz
	by smtpc-mxb-67bf8c997c-nxznx
	(smtpc-mxb-67bf8c997c-nxznx [2a02:598:128:8a00::1000:93f])
	id 2a232a219c1987382fac3069;
	Thu, 26 Nov 2026 00:37:16 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649836; bh=SfDHpU8LuWRCLw2p5KGjDm/w3KzUirNSauuMVlPYQ9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc;
	b=S7nv9ZpWdj91RUabA2FfWJhsm5pKFPZBvQ+EQb84J+TNrw2Ciwzh53dWBByQwrixl
	 lPeK9EeImbkEvc9AMwKXVs76CtucBqnfGEBriRK+KfibQ48doUxNMhPS5bqGBGIj1b
	 obRobI5BOq6S9+nDuXSVQwMogGrxPWMdAVdp5XesaRUb570CASGwrUQo78IElcjBHz
	 ziQpEKI12QpEWO/HwD9LExSLgb6/MKLU1w/SmrXgDKEUBl4zFOpHcPm/g/SJumP8fY
	 DEWmyyUgPyk5E0ropIQ8JKxQActFjyCnn89UxdOicLVm00WVGsz5T2FWDy9+2gVbKj
	 8gAm5b/5HZPxg==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-pdzw7 (szn-email-smtpd/2.0.97) with ESMTPA
	id d870e73d-3c78-4312-8876-939f30094604;
	Thu, 26 Nov 2026 00:36:51 +0100
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH v5 0/4] Bluetooth: find an RPA peer's connection parameters
 by its identity
Date: Thu, 26 Nov 2026 00:36:47 +0100
Message-Id: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QwW6DMAyGX6XKee5wSCjstPeYdkiIU9hGgpwUt
 at490F3YeqhO/6W/8+ffBWJuKckXnZXwTT1qY9hCfppJ9rOhCNB75YsZCErxALBR4bTmDKTGeC
 LoI0hwGjYDAl4NOBlWSpvtXPmIBbKyOT78+3C2/tvTif7QW1eseuGNYnAsgltt45shkDn/DyYl
 InXha5POfLl5jjhCvq/zoSA0NR1JRtTNLZtXsfojpHDZd9+i1VokluiQllgWe8RK31AvZTZOPq
 8b5XbVvPYo1xQxqGU2trC1v6eqDZEqR4TFRTLt53TZBV6pf8S53n+ATUG7KLdAQAA
X-Change-ID: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

v5 folds the lookup of a peer's connection by its IRK into
hci_conn_hash_lookup_le(), as Luiz asked on v4:
https://lore.kernel.org/all/CABBYNZKCSXsMb++hkgxk+Q8m1W1=+=Z_sgpaQFgWtnSJg8G43w@mail.gmail.com/

Patch 4 is the v3 fix itself, and the first three fix bugs in
bluetooth-next that it exposes or sits next to. By patch:

1. hci_connect_le() keeps pointing into an IRK after leaving RCU.
2. A lookup by a peer's identity misses its connection while
   hci_connect_le() is creating it under an RPA, so a second
   advertising report before LE Create Connection is sent adds a
   second hci_conn.
3. A connect to a peer's RPA misses the connection the peer already
   has under its identity and adds a second hci_conn.
4. The connection is created with the controller-wide defaults instead
   of the peer's own parameters.

Patch 4 uses the helper added in patch 3, and patch 3 relies on patch 2
to find a connection still being created; patches 1 and 2 stand on
their own.

Tested on v7.3.5 (the flags tests need &c->flags there) on a Raspberry
Pi CYW43455 central and a peer on a resolvable private address whose
parameters are loaded under its identity: first with three successive
builds of v4 applied as one patch (17 of 17 connects), then with the v4
series for three days (6 of 6 forced reconnects and 179 connects in
normal use), and then with v5 through its review rounds, each build with
three forced reconnects, Device Flags by RPA and the probes below. Every
connect was one Create Connection to the RPA, including across RPA
rotations between attempts, and those captured on air carried the
identity's parameters. With the peer connected, an L2CAP connect to its
current or a previous RPA now finds the existing connection, as one to
its identity does; without the changes it adds a second hci_conn under
the RPA, which is never started. Not exercised: a controller that
resolves the address itself and a peer with no cached RPA, which this
controller and peer cannot reach, a second advertising report before LE
Create Connection is sent, and an IRK arriving while an explicit connect
to the RPA waits.

Known limitations, raised by local Sashiko runs and left as they are:

- Patch 2: if an explicit connect was made to a peer's RPA before its
  IRK was known, it is never started, and other connects to the peer,
  auto-connect included, get -EBUSY until whoever made it cancels it,
  which for Pair Device is userspace; Disconnect by the identity now
  cancels it too. Reusing that connection hands its
  reference to params that do not own it, and a connection of their
  own would be dialled to the same RPA, where le_conn_complete_evt(),
  which matches by address, completes the older one and leaves the new
  one blocking every LE connect after it, as happens without the
  series. Avoiding all of these needs the explicit connect moved to the
  identity when the IRK is added, which is a separate change.
- Patch 3: Cancel Pair Device by an RPA no longer finds a pairing
  started by that RPA when the IRK was already known. It now behaves as
  a pairing started by the identity, which is how bluetoothd starts one
  for a peer whose IRK it holds.

Per Documentation/process/generated-content.rst: the patches and this
message were done with the Claude coding assistant (model as in the
Assisted-by trailer). The prompts asked it to fix the issues Sashiko
raised on v2 and v3 and answer the questions raised on v3 and v4, then
to review the result with a local run of Sashiko and with Sashiko's
published review prompts run on the GLM model through the oh-my-pi
agent, and fix what that turned up. The author directed the work and
reviewed the result.

---
Changes in v5:
- hci_conn_hash_lookup_le(): fall back to finding the peer's
  connection by its IRK when given its identity, out of line since
  smp_irk_matches() is private to net/bluetooth (Luiz). This replaces
  le_conn_lookup_irk() in hci_connect_le() and hci_connect_le_scan()
- hci_connect_le(): refuse a connection found by IRK by comparing its
  dst with the address given
- hci_connect_le_scan(): refuse with -EBUSY a connection still
  scanning under an RPA with params of its own there, an explicit
  connect made before the IRK was known that is never started, instead
  of waiting on it (local Sashiko)
- hci_explicit_conn_params_set(): look up and add without resolving
  again, through __hci_conn_params_lookup() and a new
  __hci_conn_params_add(), and so does Load Connection Parameters after
  resolving once; Set Device Flags: a single add instead of a lookup
  and an add; hci_conn_params_del() and Unpair Device: match exactly,
  as before. An IRK arriving in between can then not make any
  of them act on the identity's entry (local Sashiko)
- hci_connect_le_scan_cleanup() and le_conn_complete_evt(): back to
  hci_conn_params_del(), which matches exactly; load_conn_param() looks
  the connection up with the type it resolved
- Set Device Flags: send Device Flags Changed for the identity whose
  flags changed when given an RPA (local Sashiko)
- New Connection Parameter: name the identity whose entry was updated
  when the connection is still under an RPA (local Sashiko)
- Patches 2 and 3 reordered: 2 is now the lookup and the refusal,
  3 the resolve in hci_connect_le_scan()
- Link to v4: https://patch.msgid.link/20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz

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
      Bluetooth: find a peer's LE connection by its IRK as well
      Bluetooth: connect to an RPA as to the identity behind it
      Bluetooth: find an RPA peer's connection parameters by its identity

 include/net/bluetooth/hci_core.h |  33 +++---------
 net/bluetooth/hci_conn.c         | 110 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_core.c         |  77 +++++++++++++++++++++++----
 net/bluetooth/hci_event.c        |  10 +++-
 net/bluetooth/mgmt.c             |  44 +++++++++-------
 5 files changed, 214 insertions(+), 60 deletions(-)
---
base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f
change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7

-- 
Radek Podgorny <radek@podgorny.cz>

