Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5213D170A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163600; cv=none; b=RhW9Y+UffbEtcxK9H0RCr/RY9CrbublI2MdsgHlK42OrDh/ZutwPbgpPI0N9Dyyqu0qn0HNSTPkkrTtZ419+snfRM38yOtorEXnje1OdDovymq2MqEGtGUnGteGrwlq4ZzTwQycrUnrroAY5bGzEzev9wEEO484XglP3MDXrpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163600; c=relaxed/simple;
	bh=idECqdh055eoJk7Qra3hIbVDQE4Aq/yrWk014IjDt8A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W49ZoOvZwRBASQO8OoCkxfF5Xk05PllxY04YQSVEDvHyKSVoHQJLTZ6xAkl0T+K/unhPCy87vGoXx6CypRD6KV9zZDTYagOSEijhEv1rc1M05lPs42H1iEK08ZXRH7gxGwGBWuh90w+besG4Rq8/6a/fHGQjPjK03sfWKNVv8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GWdKMLmt; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GWdKMLmt"
Received: from github.com (hubbernetes-node-364bf20.ac4-iad.github.net [10.52.138.31])
	by smtp.github.com (Postfix) with ESMTPA id 00270301107
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773163596;
	bh=dXHCLUa7dcofDNeKgXzIDNkU/3HRDGupGBSvNK1O3BE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GWdKMLmtLh/Kb8oyBtOF9WtW/MQxftg87BlIL8+ehEGOcqB2aV5rRo/SKZND3KAEL
	 CHIbAWl8cySTm747r6vj0+OiFeC+X8HYDbnUuQNCGyVRxY+Wlhc+VyvN0w1pygvVte
	 YqbKUWpY5BBHXAHO9gq8K0co+V/QTd8wn8WYAXU8=
Date: Tue, 10 Mar 2026 10:26:36 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1064536/000000-f73018@github.com>
Subject: [bluez/bluez] 29b54e: doc/btmon: Add GATT database reconstruction
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

  Branch: refs/heads/1064536
  Home:   https://github.com/bluez/bluez
  Commit: 29b54e3998a748bc8259b877b6f47c7205800044
      https://github.com/bluez/bluez/commit/29b54e3998a748bc8259b877b6f47c7205800044
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


  Commit: 3434f721d76b5c0f3896ff592f45d1eb2d194eac
      https://github.com/bluez/bluez/commit/3434f721d76b5c0f3896ff592f45d1eb2d194eac
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


  Commit: 5f4cc93c9a777e313b2632bdda0df0e53f56b930
      https://github.com/bluez/bluez/commit/5f4cc93c9a777e313b2632bdda0df0e53f56b930
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


  Commit: a65c05b68af982e59c28360772eab8fec6cd2d76
      https://github.com/bluez/bluez/commit/a65c05b68af982e59c28360772eab8fec6cd2d76
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


  Commit: b52fcbc28de9d9adfc5c3040da627c1289f3e6cc
      https://github.com/bluez/bluez/commit/b52fcbc28de9d9adfc5c3040da627c1289f3e6cc
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


  Commit: f7301846e831b0d561335032feee09c6e05e07fe
      https://github.com/bluez/bluez/commit/f7301846e831b0d561335032feee09c6e05e07fe
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


Compare: https://github.com/bluez/bluez/compare/29b54e3998a7%5E...f7301846e831

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
