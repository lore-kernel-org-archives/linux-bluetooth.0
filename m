Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21931361DA8
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886838; cv=none; b=KLZyBWC+W7AXMn3HZDxNil1pqDY89xOYJS3If3lKQDvOVkUNPVKHXwfT/f8+iuyc57WJpjcIjQ/q5QXu9hZFiQs0GaU2OC4fIgM6oKAt8vj6Nf131B3IZpwncd5Cx/Z4ZJKM8LfLXFfe4LKJwkX7d3psVtHEm45X+1s3e0R24d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886838; c=relaxed/simple;
	bh=kaAgYm2KzdI4TTcJKduLvl3UgvNJf9YQe2u0eE8i2L0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QuryrLPeg/dCj+h8pYG/+y8CScxM01oM78O6UkI6Epb58B0gbuQciZUeo1GePlj8oUaJX+iJ4MoiVEZT40poLonIWnSVFr4Bu3kpMSfnfkoZ4OiFaaT8QDwN/TcgiM6Fe1rXe59/QkS5h3G+vcxhA0UP1jEkzxieFJ4G5AE51Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=AngEgtbz; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="AngEgtbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790886832;
	bh=U0QupulUzsPJen1jSyg5D+KWwcCfWd/4BzvTOZtIHHk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AngEgtbzxz0uVaAGbf1JfMSeWYo8rxfkHAOgH35GHDBU3m9yCri4xClYK8V3jGE84
	 BDioIjN8qW9UCiOMMR5ZZSuoJBnYeEJGrt2uip5hjlTQRhzL1VzsYpMfgm0ITxGukT
	 yxr+vh9Uz0E97P5sKkR4fFQIoK3ogR3YKxHNivNiMIv2kjrYK6bHULF2Nk9wEo1bq/
	 DVbQnIeFzJR1KUu3+2/fVTwkz2pFwdlNiXXmfdSV/ZYCsfvXDkQ/femj/R8PnGhSCi
	 htlbhUOy+gO+SroCniAmP/6urVpJC60Ln8zwmdcANzGhMzUnolx9u808fIIkBgoFxs
	 mz6+8F/BnmwRg==
Received: from github.com (hubbernetes-node-f1463e4.ac4-iad.github.net [10.52.172.30])
	by smtp.github.com (Postfix) with ESMTPA id 35095320E4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:33:52 -0700 (PDT)
Date: Thu, 01 Oct 2026 13:33:52 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/549f3d-ae69dc@github.com>
Subject: [bluez/bluez] 798da8: doc: Add commit message guidelines for AI
 coding a...
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
  Commit: 798da8d7ace22ff23c0644d4fd92c67997638280
      https://github.com/bluez/bluez/commit/798da8d7ace22ff23c0644d4fd92c=
67997638280
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/coding-assistants.rst

  Log Message:
  -----------
  doc: Add commit message guidelines for AI coding assistants

Require commit messages to record only the changes and their rationale,
to follow Rule 2 of the maintainer guidelines, and to have their factual
claims checked against the diff.

Inspired by WirePlumber's AGENTS.md:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/AGENTS.=
md

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 17ea5080c481c2acfb6c532f602bf2028deba918
      https://github.com/bluez/bluez/commit/17ea5080c481c2acfb6c532f602bf=
2028deba918
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/coding-assistants.rst

  Log Message:
  -----------
  doc: Add bug fixing procedure for AI coding assistants

Require AI assistants fixing bugs to verify them with a reproducer, test
the fix, state what could not be verified and leave any submission to
the human, with vulnerabilities following SECURITY.md.

Adapted from the Linux kernel's
Documentation/process/coding-assistants.rst.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 2f1ae1462507a1e1a9eb33bfc88d3b8741b50e80
      https://github.com/bluez/bluez/commit/2f1ae1462507a1e1a9eb33bfc88d3=
b8741b50e80
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    A AGENTS.md

  Log Message:
  -----------
  Add AGENTS.md symlink to doc/coding-assistants.rst

Let AI coding assistants that look for AGENTS.md load the guidelines
automatically.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: bb98c3e02282c0383aa75651d754afd50fc385d2
      https://github.com/bluez/bluez/commit/bb98c3e02282c0383aa75651d754a=
fd50fc385d2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Security Level Changed event

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.


  Commit: 74334ac97049c8d878de9b76e6f89f0393a2c202
      https://github.com/bluez/bluez/commit/74334ac97049c8d878de9b76e6f89=
f0393a2c202
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Security Level Changed event tests

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 1391af1995a9b07a344e872d019447e315ef0486
      https://github.com/bluez/bluez/commit/1391af1995a9b07a344e872d01944=
7e315ef0486
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for Mgmt Security Level changed event

@ MGMT Event: Security Level Changed (0x0034) plen 16
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Security Level: No security (0x00000000)
        Encryption Type: No encryption (0x00000000)


  Commit: 09e58eb8da1b4d65857db900b8914173ecdd5644
      https://github.com/bluez/bluez/commit/09e58eb8da1b4d65857db900b8914=
173ecdd5644
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SecurityLevel properties to org.bluez.Device1

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.


  Commit: d3f2b6f3e142427f21eede2e7379f28e22b106c6
      https://github.com/bluez/bluez/commit/d3f2b6f3e142427f21eede2e7379f=
28e22b106c6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Security Level related properties

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.


  Commit: ae69dcddd5495c7c72b7935e12e17cf6d6b28461
      https://github.com/bluez/bluez/commit/ae69dcddd5495c7c72b7935e12e17=
cf6d6b28461
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/549f3d50686b...ae69dcddd5=
49

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
