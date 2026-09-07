Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094836F91B;
	Mon,  7 Sep 2026 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823499; cv=none; b=kbw+0EuKlOi16BDoKY+mxiFX0IHK3q9yT6gXaR4wqpEoPSIzXTuZSoZQD3ArLt2pMytU5/KePG8UtZ2rWkeox1z5eOkeXehR1aBugowZYjMdBzN/+GOWz7p0PzBcvh5Vs0pwjogX7I1OdVwraA/lfz4IvmRqO8YZUGDWzOdBmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823499; c=relaxed/simple;
	bh=OhIW2M7BxV6zinvDvuXBBuN1jSBlx14delyvj5Ry7f8=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version; b=bt8oJAZnoYPo/6MkB4VeAcMkFXxivgJkHQkJHYwqYt/LycRElTGOSD3MJqwX5s7DQuAV4m+T8LuNNwGr6UF5t8aI7AZwhzRaFSybg+K2/ZjxXj2+IvR+hfMLnIaT8Kfw6A6ws2HWh6yQqi+yWtlnKdM+1P+d4rnCUjeLDdVLOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=RSwwM66I; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="RSwwM66I"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-zvm85
	(smtpc-mxb-7db765f675-zvm85 [2a02:598:64:8a00::1000:90b])
	id 3b6855668d52f87f3ee74f2e;
	Tue, 08 Sep 2026 01:24:55 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788823495;
	bh=+VV3LiVXiqw5UBzA1dLk15tFV+rmus5FsHiDdTH2bik=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=RSwwM66IiEoG0t9edn3Hajeyleb1sVAMmEhNaFQehAv+jYb5ENJV3wb2gfqitfuU+
	 EunPCv47A9POF1oVHmJG4Gpuoyjc/y0t1RQNwd4NRMbe9IQP9yBOILoRkwgEZuvtMn
	 qWlah9+70IYPuG9YgM75PJKakyUhLfP5W6wwoKo7e9rLkORQNCAkxue+WfE8UYK4D5
	 UdsqI6+fRp9xzZlpSsmCBuv5yzCritMxS0DOwsxuQAZ6RHWWOITvTZaIdZIrEzE7tW
	 mhAJhhENlfuumywgWW3NLUe/IEVjNc8OHjeVo7Wf0SSmioMzNtv4EtFaeKLPEJz9y0
	 tAEPhpYIuwp2g==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-57659868b8-2vb45 (szn-email-smtpd/2.0.82) with ESMTPA
	id b9c6903e-bfbc-4d52-8210-1f3b09b5ad19;
	Tue, 08 Sep 2026 01:20:50 +0200
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH 0/2] Bluetooth: dial the peer's on-air address when we cannot resolve
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>
Date: Tue, 08 Sep 2026 01:20:48 +0200
Message-ID: <20260908012048.3681904-2-radek@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: python-smtplib (git format-patch body verbatim)

On a controller that cannot resolve private addresses, an outgoing LE
connection to a peer that is advertising an RPA goes out on the peer's
identity address and cannot succeed. It burns a full create-connection
timeout, and because such a controller also has no extended scanning it
cannot scan while it is initiating, so the adapter goes deaf to every other
device for the duration.

Patch 2 picks the address to put on air instead of assuming conn->dst.
Patch 1 is its prerequisite: choosing a cached RPA is only safe while that
RPA is still current, and nothing recorded when one was last seen.

Measured on a Raspberry Pi with two controllers, a CYW43438 as the central
and a Realtek dongle as the peer, Arch Linux ARM 7.2, BlueZ 5.87. The peer
advertises an RPA generated from a fixed IRK that is also loaded into the
central, so advertisements resolve and the conditions the patches care about
hold. Numbers are in patch 2.

Neither of those adapters reports LL Privacy, so the branch that defers to a
controller's resolving list was measured separately, on an Intel controller
that does. With the peer programmed into that controller's resolving list the
host puts the identity address into LE Extended Create Connection, and the
controller resolves it and connects:

    LE Enhanced Connection Complete (0x0a)
            Status: Success (0x00)
            Peer address type: Resolved Public (0x02)
            Peer address: 3C:78:95:78:37:C3
            Peer resolvable private address: 6D:CA:DB:24:14:E9 (Resolvable)

Before the peer is in the resolving list, the same setup dials the peer's RPA
instead. So both directions of that branch are covered: the host defers when
the controller can translate, and substitutes when it cannot.

What this series does not establish:

  - Patch 1 has no independent observable. It ships as patch 2's
    prerequisite and its effect is only visible through patch 2's behaviour.

  - Three controllers, one peer, two kernel versions. The fallback branches
    were exercised on a CYW43438, the resolving-list branch on one Intel
    controller. The peer is a Linux host running BlueZ rather than an
    embedded peripheral, so nothing here speaks to other stacks.

Two further patches were carried in earlier revisions of this work and
dropped after each was built and measured on its own; neither turned out to
have a reachable effect. An earlier form of one of them also corrupted
Secure Connections pairing. They are not in this series.

Tooling: written with Claude (claude-opus-5) assisting, per
Documentation/process/coding-assistants.rst, hence the Assisted-by tags.
The session covered reading the existing address handling, drafting the
patches, and analysing the btmon captures. Every hypothesis that could be
tested on hardware was tested there, and the ones that failed were dropped
rather than argued. All patches are checkpatch --strict clean and build
without new warnings.

Radek Podgorny (2):
  Bluetooth: record when an IRK's RPA was last seen
  Bluetooth: put the peer's on-air address on air when we cannot resolve

 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_core.c         |  4 ++
 net/bluetooth/hci_sync.c         | 82 +++++++++++++++++++++++++++++---
 3 files changed, 83 insertions(+), 7 deletions(-)


base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
-- 
2.55.0

