Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48413559F8
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784406321; cv=none; b=AuJltYXrHmX1Jwk647+J/Rr8Kq9MIInPoGETWWGgqg+nsocdCWqLDnM3OaKDAKC7GOPZaUSw0Uur8lebgQozZ6jA53Rw1bwWwj/j1PFHBe1gFezFXQUZwYjHOep1+GSgx+0dPyPm0i9B/u3s00UP/69CUt7/hdHKTIBg0frXQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784406321; c=relaxed/simple;
	bh=8L20etyvML+fPhafpAZ++/ynEVm7KP72pC6qHsUm5VY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=atMbZa4fHnUtreUp9CcQZ+/tRVxoQFIgOK91ogShPdPOpP8QdFw7n4oufe902GG1o4uvAN+pmtdv8r7iu8z7RHTru6Iv83lrnwOoBLTUjN7OotMC6m/+L4RaDkyUklyLbgEzTjqAm8EBSMMbrAVpuU0FJ2wBwu0TdALYMhw+b/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lQISysZB; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lQISysZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784406318;
	bh=2QQDJefyzFcrmm8nIEqcdgnkP6aYrBc4FD1T/RaHXRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lQISysZBInVrvQNUAEn1xrljF0iZYTg2vpTz20biLieNJGkgXrYitqlJTqqVIv1kZ
	 aTYxo2LmCnI7NAh0xy96jPuUJ3YaEpFx+UZ8BXlz4ew0Wfrx+c4L6wyOJbZ1qYKIwr
	 4CDkuNVgAO4PGMVTXWykdJB1dGPob76DwPm4vTMk=
Received: from github.com (hubbernetes-node-01c312e.ac4-iad.github.net [10.52.211.59])
	by smtp.github.com (Postfix) with ESMTPA id A00FF781021
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 13:25:18 -0700 (PDT)
Date: Sat, 18 Jul 2026 13:25:18 -0700
From: Philipp Dunkel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130150/000000-4df3db@github.com>
Subject: [bluez/bluez] 45fc10: shared/att: don't auto-bond on reactive
 elevation
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

  Branch: refs/heads/1130150
  Home:   https://github.com/bluez/bluez
  Commit: 45fc1030b964091e556343571b76be0ca64be664
      https://github.com/bluez/bluez/commit/45fc1030b964091e556343571b76be0ca64be664
  Author: Philipp Dunkel <pip@pipobscure.com>
  Date:   2026-07-18 (Sat, 18 Jul 2026)

  Changed paths:
    M src/device.c
    M src/shared/att.c
    M src/shared/att.h

  Log Message:
  -----------
  shared/att: don't auto-bond on reactive elevation

When bluetoothd connects to a freshly discovered LE peer it probes it as
a GATT client through its built-in profiles (battery, mcp, ...). If one
of those reads a characteristic the peer has protected, the peer answers
with Insufficient Authentication (0x05). change_security() reacts to that
error by raising BT_SECURITY on the ATT socket, and on an unbonded LE
link raising security starts SMP pairing.

The result is a bond that nobody asked for: no user, no agent, and no
application requested it. It logs as a device_bonding_complete() bond
with a (nil) requestor, and the user is shown a pairing prompt for a
device that merely came into range and connected. On phones and laptops
that expose authentication-gated GATT characteristics this fires on
essentially every connection.

The existing opt-out cannot prevent it. change_security() only returns
early when chan->sec_level != BT_ATT_SECURITY_AUTO, but
bt_att_chan_set_security() records sec_level solely for BT_ATT_LOCAL
channels. An L2CAP/LE channel keeps its zero-initialised value (AUTO)
for its entire lifetime, so the guard never triggers and the link
always elevates.

Add bt_att_set_no_auto_sec(), a per-bt_att flag that makes
change_security() refuse to elevate. Set it from gatt_client_init() for
any connection that is neither bonded nor in a requested bonding, so a
speculative profile probe that hits an authentication-protected
characteristic fails on the auth error instead of silently pairing.

Devices being bonded via Pair() are unaffected: device->bonding is set
before the connection is established, so gatt_client_init() takes the
existing elevate-for-bonding branch and never sets the flag. Already
bonded devices are unaffected too: they are elevated proactively at
attach time when their LTK is available, and reconnections see
device_is_bonded() and skip the flag.

Tested against Android (Galaxy Z Flip 4), iOS (iPhone) and macOS
(MacBook): each connects and is probed by the built-in profiles with no
unsolicited pairing prompt, while explicit pairing continues to work.

Assisted-by: Claude:Opus-4.8
AI disclosure: this change was developed with the assistance of an AI
model (Claude Opus 4.8). The author reviewed every line. The fix was
built and exercised on real hardware -- against Android (Galaxy Z Flip
4), iOS (iPhone) and macOS (MacBook) peers -- and its behaviour was
observed directly, not inferred.


  Commit: 4df3db7680e9da534458880a0b8a778a559a610f
      https://github.com/bluez/bluez/commit/4df3db7680e9da534458880a0b8a778a559a610f
  Author: Philipp Dunkel <pip@pipobscure.com>
  Date:   2026-07-18 (Sat, 18 Jul 2026)

  Changed paths:
    M unit/test-gatt.c

  Log Message:
  -----------
  unit/test-gatt: cover no-auto-sec on auth error

Add a regression test for bt_att_set_no_auto_sec(). The client reads a
characteristic and the peer answers with Insufficient Authentication
(0x05). Security is armed to BT_ATT_SECURITY_AUTO so a reactive elevation
would normally fire and retry the read, but no_auto_sec is set, so the
error must instead be delivered to the caller with no second request on
the wire.

This is the /auto variant (which does retry after elevating) with the
elevation forbidden. With the flag honoured the read fails once with
0x05; without it the client retries and the test aborts on the
unexpected Read Request, guarding the fix against regression.

Assisted-by: Claude:Opus-4.8
AI disclosure: this change was developed with the assistance of an AI
model (Claude Opus 4.8). The author reviewed every line. The test was
run against the built tree: it passes with patch 1 applied and was
confirmed to fail (client retries, harness aborts) without it.


Compare: https://github.com/bluez/bluez/compare/45fc1030b964%5E...4df3db7680e9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
