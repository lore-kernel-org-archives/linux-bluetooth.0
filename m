Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909B35F17A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261559; cv=none; b=TQt+upVAN6WEqckVguO7MXLMyumG2cQsm6otu1DFQRvEVTApizphprCnkts+DIHlw4+0XVv8QkxJD7fnp7dQtNENF534ffjD8O9g3knd6I8SmxWgo2fJG89SMuiWmDfIdHS1XGlDwOYt1bXyBXmLhUdxBeSxLrd44Grk64Ay2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261559; c=relaxed/simple;
	bh=oQvAZMU6wWVRRaWxX2C7l0V37oZjIi4lE87Ncp/0s88=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T8es107oniOyHQ9+bm7KVjiJeoJhbfkuUyvWneUH87XnGwBEoaFEJkIgNOOBGhqz7Z6onA85tIW5+BRyhF8if75TTIMLNwIt87/578MG6YvCcF4M9qrdTO8ARozD+KJP1pqdWtBZksZaJEnHOSOsSmvV31/F1J5bJk85epJ/8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SLxgUVcl; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SLxgUVcl"
Received: from github.com (hubbernetes-node-a002ef5.ash1-iad.github.net [10.56.87.29])
	by smtp.github.com (Postfix) with ESMTPA id DD5A62E1209
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773261556;
	bh=pQ3VPN7FrgOtGZhq2zJsTinP11v3zUcOELPg1XRcPi4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SLxgUVclNRZBfR457lymBdK5dSdZ6vqMesW8eQutxG/YG0lpNKfn/HVnTFFRjeaK1
	 XPHT5Foy/MBHdvmoGGpizw7I58sVXDy9osAgDaQj0ikrMidMDnHp5hTw5W5MHAwFqx
	 NZ5Y7OjNVYkA+yn73nMln4AyawAhhDNVNG1Zj83o=
Date: Wed, 11 Mar 2026 13:39:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/121e5c-948d90@github.com>
Subject: [bluez/bluez] 1d4e25: doc/btmon: Add GATT database reconstruction
 guide
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 1d4e2532d4c37022aed9e0f9a24ba0c87a2d3806
      https://github.com/bluez/bluez/commit/1d4e2532d4c37022aed9e0f9a24ba0c87a2d3806
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add GATT database reconstruction guide

Add a comprehensive section explaining how to reconstruct a remote
device's GATT database from btsnoop traces. Documents all six phases
of GATT discovery:

- Primary/Secondary Service Discovery (Read By Group Type)
- Included Service Discovery (Read By Type with Include UUID)
- Characteristic Discovery (Read By Type with Characteristic UUID)
- Descriptor Discovery (Find Information)
- Characteristic Value Reading (Read Request/Response)
- Targeted Service Search (Find By Type Value)

Includes annotated btmon output examples for each ATT operation,
a characteristic properties reference table, common descriptor
UUIDs, guidance on bidirectional discovery, and a worked example
showing how to build the final attribute table from trace data.


  Commit: f247395a18d5c47a26a485c9b87a453c6719779e
      https://github.com/bluez/bluez/commit/f247395a18d5c47a26a485c9b87a453c6719779e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add SMP pairing flow documentation

Add comprehensive SMP pairing documentation covering:

- Pairing Phases 1-3: Feature exchange (IO capabilities, auth
  requirements, key distribution), authentication for both Secure
  Connections (public key, DHKey check) and Legacy pairing
  (confirm/random only), and key distribution (IRK, LTK, CSRK).

- Pairing Failure: Failure reason code table (0x01-0x0e) with
  diagnostic meanings for each code.

- Automating Pairing Analysis: grep patterns for identifying pairing
  attempts, detecting SC vs Legacy, finding failures, and correlating
  with encryption.

- Updated Automated Trace Analysis: Added pairing/security check step
  in the recommended workflow, SMP cross-reference in connection
  lifecycle patterns, and pairing failure debugging scenario.


  Commit: fa9eed625ad3c8b33aa3e436a9c43ea25913e39e
      https://github.com/bluez/bluez/commit/fa9eed625ad3c8b33aa3e436a9c43ea25913e39e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add L2CAP channel tracking documentation

Add comprehensive L2CAP channel tracking documentation covering:

- Fixed Channels: CID table (0x0001-0x0007) mapping to protocols
  (L2CAP Signaling, ATT, SMP, AMP Manager).

- Dynamic Channels (BR/EDR): Connection Request/Response flow,
  Configure Request/Response, and PSM-to-protocol mapping table
  (SDP, RFCOMM, BNEP, AVCTP, AVDTP, ATT, EATT).

- LE Credit-Based Channels: LE Connection Request/Response with
  MTU, MPS, and credits for flow control. EATT over PSM 0x0027.

- Connection Parameter Updates: LE peripheral parameter change
  requests via L2CAP signaling with accept/reject handling.

- Automating L2CAP Analysis: grep patterns for channel establishments,
  PSM tracking, parameter updates, and EATT setup.

- Updated Automated Trace Analysis: Added L2CAP channel check step
  in the recommended workflow, L2CAP cross-reference in connection
  lifecycle, and connection parameter negotiation debugging scenario.


  Commit: a0e1d0b5b49c9c45bc09373e9a5a9a18ed4a0235
      https://github.com/bluez/bluez/commit/a0e1d0b5b49c9c45bc09373e9a5a9a18ed4a0235
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add LE Audio protocol flow documentation

Add comprehensive LE Audio protocol flow documentation covering:

- PACS (Published Audio Capabilities): Sink/Source PAC reads with
  LC3 codec capability decoding (sampling frequency, frame duration,
  channel counts, frame length), audio locations, and available
  audio contexts.

- ASCS (Audio Stream Control): ASE state machine (Idle through
  Streaming and Releasing), ASE Status notifications with full
  codec config decoding, ASE Control Point operations table
  (Config Codec, Config QoS, Enable, Disable, Release, etc.).

- CIS Setup and Teardown: CIG Parameters, CIS creation, CIS
  Established event, ISO Data Path setup, and ISO data flow.

- Broadcast Audio (BIG): BASE announcements in periodic advertising,
  BIG creation (source), BIG sync (receiver).

- Automating LE Audio Analysis: grep patterns for ASE state tracking,
  codec verification, CIS establishment, and broadcast detection.
  8-step diagnosis pattern.

- Updated Automated Trace Analysis: Added LE Audio cross-reference
  in workflow step 6, LE Audio reference in connection lifecycle,
  and audio streaming failure debugging scenario.


  Commit: 587f94f9170fe4cb3428a095bcdf616b189115ee
      https://github.com/bluez/bluez/commit/587f94f9170fe4cb3428a095bcdf616b189115ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add protocol error codes documentation

Add protocol error codes reference covering:

- ATT Error Codes: Complete table (0x01-0xff) with diagnostic
  meanings for Invalid Handle, Read/Write Not Permitted,
  Authentication/Authorization Insufficient, Attribute Not Found,
  Insufficient Encryption, Application Errors (0x80-0x9f), and
  profile-specific codes (0xfc-0xff).

- L2CAP Connection Response Results: Result code table (0x0000-0x000c)
  covering successful connections, pending, and all refusal reasons
  (PSM not supported, security block, no resources, invalid CID,
  insufficient authentication/encryption).

- Automating Error Detection: grep patterns for ATT errors, security
  errors, and L2CAP rejections.

- Cross-Layer Error Correlation: Common cascading error patterns
  across ATT, SMP, HCI, and L2CAP layers.

- Updated Automated Trace Analysis: Enhanced error check step with
  multi-layer grep commands, added error cross-references in
  connection lifecycle, and GATT operation rejected debugging
  scenario.


  Commit: 83f55cc4ad49217544ee391ca6d9cd81be38b2de
      https://github.com/bluez/bluez/commit/83f55cc4ad49217544ee391ca6d9cd81be38b2de
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add advertising and scanning documentation

Add advertising and scanning documentation covering:

- Advertising Reports: LE Extended Advertising Report decoding with
  event type properties, address, PHY, RSSI, and advertising data.

- Common AD Types: Table of AD types btmon decodes (Flags, 16/128-bit
  UUIDs, Local Name, TX Power, Service Data, Manufacturer Specific).

- Extended Advertising: Extended advertising parameter setup and
  data commands.

- Periodic Advertising (LE Audio): Periodic advertising reports
  carrying BASE announcements for broadcast audio.

- Automating Advertising Analysis: grep patterns for finding
  advertising reports, device names, LE Audio devices by service
  UUID, advertising setup, periodic advertising, and device
  appearance.

- Updated Automated Trace Analysis: Added advertising check step
  in the recommended workflow and updated introduction text with
  cross-references.


  Commit: 948d90c274a8a8b7ce9d4a987b224056111092cd
      https://github.com/bluez/bluez/commit/948d90c274a8a8b7ce9d4a987b224056111092cd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-10 (Tue, 10 Mar 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add BIG Sync flow documentation

Add comprehensive BIG Sync receiver flow documentation covering:
- Complete prerequisite chain (PA sync -> PA Reports -> BIG Info ->
  BIG Create Sync -> BIG Sync Established -> ISO Data Path -> ISO Data)
- BIG Info Advertising Report as the critical gate for BIG sync
- Without PAST (direct PA sync) flow with btmon output examples
- With PAST (Periodic Advertising Sync Transfer) flow via BASS
- BIG Sync teardown paths (receiver and broadcaster initiated)
- BIG Sync failure diagnosis checklist
- Updated broadcast grep patterns in Automating LE Audio Analysis
- Separate unicast (CIS) and broadcast (BIG) diagnosis patterns

The BIG Info documentation addresses a gap where trace analysis missed
that no BIG Info was received and therefore no BIG Create Sync could
be sent.


Compare: https://github.com/bluez/bluez/compare/121e5ca79be5...948d90c274a8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
