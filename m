Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA40175A8D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153215; cv=none; b=kqJ5Fcg2HzEcej8LSiNjeo6WbhovmdU2yHklQik6rHD7ykY8PsEW0lnGx3QoYpr0NTeSI08uv3eBJSwJ7Y0uiJ5j0ChKYXAvA/m+JHIVES0eD0di9Gz3EgpslvapH1d5hsI14UgN34ZOBUXsf531MvS1RNZngTcvWaJJ43SHKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153215; c=relaxed/simple;
	bh=qDIspGK2jBA74NYEomJufSN1FTeW70gLQ8L42JDm514=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ivfsk6gZ+GrA1r2WJmjhleWiZ0gEmrEg6D+zPSy5CNVU1eqV47xx+u7glcqm2uiMLkW7G3yW5JJw0cK7715oFhE2UFFghOvz4cOl+kdYJyGzqqTGcrvFcBbApnyh7kL33pljmSCrtQaYMSUDRGNJ5J7jucHXS3fqNPV3JaMuxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KZv+nm8s; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KZv+nm8s"
Received: from github.com (hubbernetes-node-b0f768f.ac4-iad.github.net [10.52.154.36])
	by smtp.github.com (Postfix) with ESMTPA id C7D1580096
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775153213;
	bh=sogY/lF62vb4G4K1JPyK8QjN+csJJagNOsDBbhTKfwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KZv+nm8sTcdPk0xEizIYAQnCJ4nWys4EwjryMeVpkwbW5Tnr60L5xP5H6Hlufq5/q
	 MP9eofutDZ4q9YKT22NkcKDeuVNvyp9v++eMQaxVOfeM1XD1Aed1K/MTiDD6/bs7sJ
	 TDs6bPfSdFt1X2Zo6HnUatK78OyG3hJX0U8uDqFs=
Date: Thu, 02 Apr 2026 11:06:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076592/000000-c8d25d@github.com>
Subject: [bluez/bluez] bb9298: doc/btmon: Add Channel Sounding protocol flow
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

  Branch: refs/heads/1076592
  Home:   https://github.com/bluez/bluez
  Commit: bb92984ff247b06450fc6e91b1f63d9134ae39a4
      https://github.com/bluez/bluez/commit/bb92984ff247b06450fc6e91b1f63=
d9134ae39a4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-02 (Thu, 02 Apr 2026)

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


  Commit: ac0383f3cd2d19860a8d4884a5a152de30bf2231
      https://github.com/bluez/bluez/commit/ac0383f3cd2d19860a8d4884a5a15=
2de30bf2231
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-02 (Thu, 02 Apr 2026)

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


  Commit: c8d25d070335e78579c0f95982b14e6829cea039
      https://github.com/bluez/bluez/commit/c8d25d070335e78579c0f95982b14=
e6829cea039
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-02 (Thu, 02 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/bb92984ff247%5E...c8d25d0=
70335

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
