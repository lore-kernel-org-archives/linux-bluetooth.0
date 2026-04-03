Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE33CA498
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238894; cv=none; b=Nbdmdgm9Bg5AxetC8omTi3yWrewHt5mdPrg7/bqYAZ1J9vJm18vJCFkqAhSkoGNnfVFOpoLkjer4zNuGcpCiN8iewSIAH3RI7w8tYHOp73mldsmPmKL+8SyzNM+cb7VD6WdsajFsViQ1K5xhqmE57hwP8yYOC0StZYkcb6w9lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238894; c=relaxed/simple;
	bh=7XKyTgRt5izfFy5HyLbVyUXqNivogquCvIeOnZfJtbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ixD6IJEKa4shm1pa0NwOERbPbW0E/q8eK/HfNpYINo5IhsvgFkvm99B9/lmkSTPcVSDZYTaP382aHLg5FHApyQvLCl6CEsHcfE8/NKllLqpzas9/bzNxT6fZe8uLRzjhTeKCGgmJgM+bYSpxIwx8jxBG6MNXxsEgcEPqrI/AnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BHEyIVv1; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BHEyIVv1"
Received: from github.com (hubbernetes-node-61689a9.ac4-iad.github.net [10.52.223.37])
	by smtp.github.com (Postfix) with ESMTPA id 72C3F300AFB
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775238892;
	bh=yYRZrQ/lwCwW1iAPoaOJqn5jX1VTBdj3DZSk/xx0UZ8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BHEyIVv1fFfS6tutwRbXWb1lvcFzn9C6pMamz/gtnAaYGOJU3iB5+9wOr5x7EBB2F
	 CYM3YHZlcHQ85p2Hpddf+lN5QljrmsD5aWZM4r7FSQzjyPVZA6JDB4nYuov5emRoxA
	 FK1IrCQegomOPRMZObA9korWCjvPyf84si9bmKek=
Date: Fri, 03 Apr 2026 10:54:52 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/000dc0-00dfd3@github.com>
Subject: [bluez/bluez] 107305: doc/btmon: Add Channel Sounding protocol flow
 docu...
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
  Commit: 10730536e5b55f93e9234fac493c7db581f7a4bf
      https://github.com/bluez/bluez/commit/10730536e5b55f93e9234fac493c7=
db581f7a4bf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    A doc/btmon-cs.rst

  Log Message:
  -----------
  doc/btmon: Add Channel Sounding protocol flow documentation

Add btmon-cs.rst documenting the complete CS protocol flow as seen
in btmon traces.  Covers capability exchange, security enable,
configuration, procedure parameters, enable/disable, subevent
results with all four step modes (Mode 0-3), result status fields,
FAE table exchange, channel classification, CS test mode, the
typical setup sequence, and common issues.

This provides LLM context so automated trace analysis can correctly
interpret CS distance measurement sessions.


  Commit: b499a284d08a03945834c602c47d7175e1e91819
      https://github.com/bluez/bluez/commit/b499a284d08a03945834c602c47d7=
175e1e91819
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M doc/btmon-cs.rst

  Log Message:
  -----------
  doc/btmon: Add RAS/RAP protocol flow to Channel Sounding documentation

Add the Ranging Service (RAS) and Ranging Profile (RAP) GATT-level
protocol flow to btmon-cs.rst.  Covers all six RAS characteristics
(Features, Real-time Ranging Data, On-demand Ranging Data, Control
Point, Data Ready, Data Overwritten), the five Control Point opcodes
(Get Ranging Data, ACK, Retrieve Lost Segments, Abort, Set Filter),
the segmented ranging data format with Ranging Header and Subevent
Header decoding, the typical on-demand and real-time data flows,
and common issues.


  Commit: 00dfd32af38ac950db32af0acfa4193511f718d9
      https://github.com/bluez/bluez/commit/00dfd32af38ac950db32af0acfa41=
93511f718d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M doc/btmon-cs.rst

  Log Message:
  -----------
  doc/btmon: Add CS and RAS state machines and combined flow charts

Add three state machine diagrams and four flow charts to btmon-cs.rst:

- CS State Machine: IDLE =E2=86=92 CAPABILITIES EXCHANGED =E2=86=92 CONFI=
GURED =E2=86=92
  PARAMETERS SET =E2=86=92 PROCEDURE RUNNING =E2=86=92 CONFIGURED =E2=86=92=
 IDLE

- RAS Data Transfer State Machine: IDLE =E2=86=92 DATA READY =E2=86=92
  TRANSFERRING =E2=86=92 COMPLETE =E2=86=92 IDLE (with ABORTED and recove=
ry paths)

- Typical CS Setup Sequence: HCI command/event timeline with
  state annotations showing the full capability exchange through
  procedure enable/disable cycle

- Combined HCI + GATT Flow: interleaved three-column chart
  showing HCI CS operations alongside GATT RAS service discovery,
  CCC setup, data ready notification, on-demand retrieval with
  segmented transfers, and ACK

- Real-time Streaming Flow: shows how HCI Subevent Results
  trigger immediate GATT notifications on Real-time Ranging Data

- Lost Segment Recovery Flow: demonstrates the Retrieve Lost
  Segments mechanism with gap detection and retransmission


Compare: https://github.com/bluez/bluez/compare/000dc08822ff...00dfd32af3=
8a

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
