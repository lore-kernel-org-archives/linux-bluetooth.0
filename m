Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC02DC76A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806098; cv=none; b=k2SCw7zRdH5PD1hedp72hUVC4BS67mhvwFSgqCpfoV2yDNtAx4dISsmt5f7Z92GjIW72y5TstVEy913e+8gBXVbsmN4PbPCNcnOYqnM8Ix5Qdv2pH5YP0TbVszd8kfv1RievMnQ2BKlxc2xF1H7kcTV6u/nW8KSkVXhJxyqp0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806098; c=relaxed/simple;
	bh=rdR4v9ll8P/uhyAjFYhDT8zCx19/OncH5tek+tf/f8U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F0aIBQrvXyM7Uwk/7cLL4iPPo2YqFCtZ3WQiK5cIcYrCIynA0IdHFDACq83hBtkWqMPzfRaYXFIbKTl4qeLFRkd8ZXgXlOap9TLXqhpOSquXZ1LnEzPKmEJGWkxZlin1X1M896y9aq7eZQG7O8gW9wbT9qWehrwFikIFy97ES3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=md1DFW7Q; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="md1DFW7Q"
Received: from github.com (hubbernetes-node-d016534.ash1-iad.github.net [10.56.173.18])
	by smtp.github.com (Postfix) with ESMTPA id 13D2F92128A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806093;
	bh=HIQwaqOwy4XPCjv7Nnrv4iPT0qSZHrMaZs2cNn+Q170=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=md1DFW7QNRZTmMLSRobgxWoMAElKognh/1l5ERZJ0b3yIT7Q8lHQkBhMPDw8TEejT
	 PbqQhvEhOgYSYmpFbGUoVT8tpxie4q8HmtrJrEKSBLHlLHvEEshmXaXgBMQzxGRjYI
	 +9U6XJagnr7hMGThO1H5t4kiJA1MRuFk7aY6ElzE=
Date: Mon, 10 Nov 2025 12:21:33 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ec5819-a7b0f2@github.com>
Subject: [bluez/bluez] ca70a0: emulator: Generate PA Sync Lost
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
  Commit: ca70a0b7d58a242bdb0dc151425edf3cc91f2cf6
      https://github.com/bluez/bluez/commit/ca70a0b7d58a242bdb0dc151425ed=
f3cc91f2cf6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Generate PA Sync Lost

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.


  Commit: d9b71705bc4091a380139d340549c9bf85960a49
      https://github.com/bluez/bluez/commit/d9b71705bc4091a380139d340549c=
9bf85960a49
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Add support for terminating a BIG

This adds support for sending BT_HCI_CMD_LE_TERM_BIG via
bthost_terminate_big.


  Commit: 2c17c9929b62e4ab2ef51ddf51c4dc9334c0391b
      https://github.com/bluez/bluez/commit/2c17c9929b62e4ab2ef51ddf51c4d=
c9334c0391b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for checking proper handling of Sync Lost

This introduces the following tests to check if BIG/PA Sync Lost are
handled properly:

ISO Broadcaster Receiver Sync Lost - Success
ISO Broadcaster PAST Receiver Sync Lost - Success


  Commit: 1302116ea4b622342f1dfc3f797536335680eb08
      https://github.com/bluez/bluez/commit/1302116ea4b622342f1dfc3f79753=
6335680eb08
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not cleaning up delegator properly

When BIG sync is lost, or the assistant modify removing all streams,
delegator should be freed to so the assistant can start over and share
another stream.


  Commit: 51197aac23384bb81cc183d9bf27c7021c40d887
      https://github.com/bluez/bluez/commit/51197aac23384bb81cc183d9bf27c=
7021c40d887
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix endless loop if accept return -EBADFD

In certain cases, e.g. ISO Broadcast Listen, the listening socket may
get into an invalid state (CONNECTED) if the PA Sync is terminated
causing an endless loop of accept syscall.


  Commit: d33b9b7c9e7ea7012835cffb0107c42ef8c1f988
      https://github.com/bluez/bluez/commit/d33b9b7c9e7ea7012835cffb0107c=
42ef8c1f988
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Enhanced Call Status support

In case remote device supports the Enhanced Call Status the calls are
created, updated or removed based on results of AT+CLCC commands.
This implies to send an AT+CLCC command on reception of +CIEV events
for <call>, <callsetup> or <callheld> indicators instead of managing
calls directly.

This updates the tests using FULL_SLC_SESSION:
- /HFP/HF/ENO/BV-01-C
- /HFP/HF/ICA/BV-01-C
- /HFP/HF/ICA/BV-02-C
- /HFP/HF/ICA/BV-03-C
- /HFP/HF/ICA/BV-04-C-full


  Commit: 173e9963df4b56c8179db5805835a7be785cd76d
      https://github.com/bluez/bluez/commit/173e9963df4b56c8179db5805835a=
7be785cd76d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Enhanced Call Status tests

This add the following test:
- /HFP/HF/ECS/BV-01-C
  Verify that the HF can request the status of current calls in the AG.
- /HFP/HF/ECS/BV-02-C
  Verify that the AG can send the correct call status when an SLC is
  initialized.
- /HFP/HF/ICA/BV-07-C-full
  Verify that HF can connect to an AG that is receiving an in-coming
  call.


  Commit: bfbd3d902981665c08223515513dac457a721f29
      https://github.com/bluez/bluez/commit/bfbd3d902981665c08223515513da=
c457a721f29
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: make SetConfiguration() work similarly for ucast and bcast

Change ucast SetConfiguration() to always create a new stream.

Previously, it also removed all streams, but this is not useful now as
it prevents client from creating multiple streams, and since it can use
ClearConfiguration() to remove streams.


  Commit: 5d7693dc3b4ce9d106f93d340e17317f04ea2ccf
      https://github.com/bluez/bluez/commit/5d7693dc3b4ce9d106f93d340e173=
17f04ea2ccf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    A .github/ISSUE_TEMPLATE/issue.md

  Log Message:
  -----------
  github/issue_template: Add basic issue template

Add issue template that instructs to use btmon and indicate software
versions.


  Commit: a7b0f2355bb513293c60dc976b3ff839533d1f08
      https://github.com/bluez/bluez/commit/a7b0f2355bb513293c60dc976b3ff=
839533d1f08
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix keeping PAC caps <-> metadata correspondence

In PACS, Metadata is associated with a specific PAC.  bap_pac_merge()
mixes up metadatas from different PACs if some PAC has no metadata.

Fix caps<->metadata correspondence by explicitly storing 0-length entry,
instead of skipping it altogether, if metadata (or caps) is missing.


Compare: https://github.com/bluez/bluez/compare/ec5819b88281...a7b0f2355b=
b5

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
