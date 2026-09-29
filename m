Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D54E66AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689878; cv=none; b=d8B2cQTHZqpPgylJ7CYKBi1LydlSc5pepPiSU96q+h58N948NmyyxzdN5w38ixr4sT9JgawYgip3X69+hEOLxTi42IygWmQU4Vp6Jvz0djop50TaWeVuOOsP6ihyAxxqCM1Ftk1m7rI8900zX9UQlKjQn7YKQb6vXCX6r5uqz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689878; c=relaxed/simple;
	bh=PphuBjra+6yKPYYihfkfdctCWpPTXQNUviJ2Ma/9Y/I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uc23226Be9Bb24NJHVuoiSloq0VDTt7mMT+FHCC+oWQ2uc6ADZMFmTnwmBkdzUMFK9TGn7YCq9RNWJk/rKRhiPkUtM2Jy7Y+EEMdKI29hBmguoU0pHEk3azwfy/0957eDLzlPkU2t94ardfeq2EGLCb3kiE+l5qorJNjvILBnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=gxkgDtrM; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="gxkgDtrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790689875;
	bh=NA8qMrLzHi8cFCN5/HGYOOzb918vX95l2DXH4maf9o4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gxkgDtrMb7Gz4ZZbtV8ywJ/HBMWQdVLEP1Ut/4hOoAafDlQ+Z4lrGdEZinfYxAI34
	 5taj/77qXn22i4BEVVUu9kTZeyfEDxh6Gu6GJgnsbVaMY9D6pazBznPUh8m2plt9XG
	 mcMKV59ZKgWEoZD+P3xYqj+C9rpPAp8d/70gQlkPVyPNpmoA4y7R31XY75d+GmLi91
	 daLpPL/StKOOY3BrZSVFQAxN38py3+36W5ZnR3Cr0ry7OOpt8htQynIvg1OuGQWnLv
	 Vxtbt4kUuU4EtPylbXyZW+EKMvHJKDukzZLFxdYXo6MXSWS3sVfoQMY+sqOV36pL73
	 EjBzpVOaaGvpw==
Received: from github.com (hubbernetes-node-f059f6e.va3-iad.github.net [10.48.72.46])
	by smtp.github.com (Postfix) with ESMTPA id A8E1D341CA3
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:51:15 -0700 (PDT)
Date: Tue, 29 Sep 2026 06:51:15 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175995/000000-3c1e78@github.com>
Subject: [bluez/bluez] 72a2ea: mgmt: Add Security Level Changed event
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

  Branch: refs/heads/1175995
  Home:   https://github.com/bluez/bluez
  Commit: 72a2eadbe4f7bd8d945ab59a0a9f9470de9d5996
      https://github.com/bluez/bluez/commit/72a2eadbe4f7bd8d945ab59a0a9f9=
470de9d5996
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Security Level Changed event

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.


  Commit: 2413764a2b365463aa3a3d483ed8df418e51634c
      https://github.com/bluez/bluez/commit/2413764a2b365463aa3a3d483ed8d=
f418e51634c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Security Level Changed event tests

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 9d9278579e597647d4c287147b50e5bc9e5dfd21
      https://github.com/bluez/bluez/commit/9d9278579e597647d4c287147b50e=
5bc9e5dfd21
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for Mgmt Security Level changed event

@ MGMT Event: Security Level Changed (0x0034) plen 16
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Security Level: No security (0x00000000)
        Encryption Type: No encryption (0x00000000)


  Commit: 07ebd1186895fcd7b442d3b15ea712e9c980344e
      https://github.com/bluez/bluez/commit/07ebd1186895fcd7b442d3b15ea71=
2e9c980344e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SecurityLevel properties to org.bluez.Device1

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.


  Commit: 9cc1ab28d052a4e52c8b35e4fff79d294b6abc63
      https://github.com/bluez/bluez/commit/9cc1ab28d052a4e52c8b35e4fff79=
d294b6abc63
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Security Level related properties

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.


  Commit: 3c1e7855a1d353e39751db5c3157c5e775bda82b
      https://github.com/bluez/bluez/commit/3c1e7855a1d353e39751db5c3157c=
5e775bda82b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/72a2eadbe4f7%5E...3c1e785=
5a1d3

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
