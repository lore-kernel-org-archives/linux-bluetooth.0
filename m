Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589B395254
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209123; cv=none; b=BlqOjM1jq/p5hejJiHSxnonPar0+Niw3wvYorq+l3F2flmUvkSxLNAUHTcTp3KHCV5E3tDlgi4Be3ZaoMcAAdtX8Qtx/uy4O6vBM3fLSufKfJMXRSZXiM+DnmL6DpgTHxYjFUgC1FxdF9Q8kbLITkbnU0zKlO6hHoCe4qSQ2bII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209123; c=relaxed/simple;
	bh=nOGUPm9LZDC9WekL8gtR2XoU89OQz576uKrgNiYVMOA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BNASUnNFXjqta3/eoWHZjlaw/yFSxVbx1p1ynS6aiBzND2gX9ZzcOt9T6G/0UrhRyKz6RCfDsaa2JGwC1fRNXn8/fetVWUFlW+tjCaFIO02Lbww3H5VvhuqXG5H2fVY2zXExaj1UapC032ffBPosd6zbhyyHXzJFPkvTly7dkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l/WC0IQB; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l/WC0IQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788209120;
	bh=JoZZKd3/2+KNplHZQT/NQCAJeNifhAMcA3N+TEV+quY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l/WC0IQBUhkvrOL+wJ19WISZ2PyBbuSYj5Uw8zT8tDipvAUTUbcJj1AKUifJMbpV2
	 AdgOhAvqaFzvZH5Dfxz1hrfSCLIr0/cklK0SAmdUv1BSNWdHXUWyRWR506jgfg3gxP
	 jQS88/B6tBFNsNUA/dYNRfL0w3Ysmc4gwY+BWy0w=
Received: from github.com (hubbernetes-node-11e764c.ash1-iad.github.net [10.56.156.39])
	by smtp.github.com (Postfix) with ESMTPA id DE79584124E
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 13:45:20 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:45:20 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e81413-3a2d54@github.com>
Subject: [bluez/bluez] c53a16: emulator: bthost: don't crash on ecred_conn_req
 wi...
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
  Commit: c53a16afa33dc1afc0b1c5540191a563c4b4a8ec
      https://github.com/bluez/bluez/commit/c53a16afa33dc1afc0b1c5540191a=
563c4b4a8ec
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: bthost: don't crash on ecred_conn_req with too many scid

l2cap_ecred_conn_req() crashes if the request contains more SCID than
specification allows (5).

Respond 0x000C - All connections refused =E2=80=93 invalid parameters to =
such
invalid requests.


  Commit: 0b66bd5335d068e4ec11333a36768fc7f4e9f871
      https://github.com/bluez/bluez/commit/0b66bd5335d068e4ec11333a36768=
fc7f4e9f871
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: add test for too many ECRED deferred sockets

Add test tries to trigger connection with 5+1 ECRED channels, and
require the last connect() shall fail with -EPROTO.  On some kernels
this causes invalid ECRED REQ be sent with 6 SCID, and stack overwrite.

L2CAP Ext-Flowctl Client - Defer limit


  Commit: d52d9a173a5fd0bec9e38bbfba29da622792a1b9
      https://github.com/bluez/bluez/commit/d52d9a173a5fd0bec9e38bbfba29d=
a622792a1b9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: bthost: add function for sending raw L2CAP sig commands

Add bthost_l2cap_sig_raw() that tests can use to send raw L2CAP
signaling commands.


  Commit: 3a2d543c4c21d9c1dab246d46d76a11996a69bf2
      https://github.com/bluez/bluez/commit/3a2d543c4c21d9c1dab246d46d76a=
11996a69bf2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server=


Add test that checks Ext-Flowctl server handles invalid connection
requests with ident collisions. This triggers null-deref crash / hang on
some kernel versions.

L2CAP Ext-Flowctl Server - Nval Conn Req


Compare: https://github.com/bluez/bluez/compare/e8141342284b...3a2d543c4c=
21

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
