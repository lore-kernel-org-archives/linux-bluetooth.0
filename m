Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939444780C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231660; cv=none; b=k5Us/4hxejTlbBFRuz4V2B7aAHFPEIJgdqBGVEpTn94R5TiYQMOG1O/8f18CVfX4euhb2FfsoLq0bBVo1rucbdBEcIwXoZz0/x4gfsYvbqfhXzeH7F2uzmJbI7oQBkzhOEXOBo14ZpAWOydwp1joTF10wOQnzsKuGWnx9Hv/uWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231660; c=relaxed/simple;
	bh=ijDziF9dfPrJb4TW4QpH3Q1ZvwjGP9dA4RuC3OwGCLM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DoeI02jiwpdb2YwjnNKxz1EYrUW37iHpEMqajaw1Vn5cUNTYxPJV5peqR4TEoA2lc6YYADWHDutAqdhTJAcfsdFPQDlltl3QtLLNC4xL2M4RaFugRb4Y15V1gpq1NKXP7JYZHvupJ7h6NXF2ysVuq1OGXcdZFyPnlq5ecTXStOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IDtdcmVF; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IDtdcmVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787231657;
	bh=ABcwub0/uaj1xxitUs3CU/79xePEuGluoEKBGQzh/eA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IDtdcmVFeZ7zRxVgTdOuyyxYNcsLcFCZ4W3Cb06GLN1FNoOrjbi2u6LFeHNIfSbLX
	 T1DERhk2V9sBZk3z5510TG6JCiU2Pm9izZaNGDS0H4PQE7t2vLriLNn/FlwBVLuWJc
	 ao2rrvEycdQIr+do93LluvmOZgdWosNTNvOxEEG0=
Received: from github.com (hubbernetes-node-9ff5a63.va3-iad.github.net [10.48.184.39])
	by smtp.github.com (Postfix) with ESMTPA id A7015281083
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 06:14:17 -0700 (PDT)
Date: Thu, 20 Aug 2026 06:14:17 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149110/000000-ce7f2a@github.com>
Subject: [bluez/bluez] a05d0a: mgmt: Add Security Level Changed event
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

  Branch: refs/heads/1149110
  Home:   https://github.com/bluez/bluez
  Commit: a05d0a3ee5086abe0489b69192b586fa94080f2d
      https://github.com/bluez/bluez/commit/a05d0a3ee5086abe0489b69192b58=
6fa94080f2d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Security Level Changed event

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.


  Commit: 73446f96026595c4fd118122ec9196af37ed8fe8
      https://github.com/bluez/bluez/commit/73446f96026595c4fd118122ec919=
6af37ed8fe8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Security Level Changed event tests

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 41bddf9081365e4f7f1233e1b4b3c222fe37e337
      https://github.com/bluez/bluez/commit/41bddf9081365e4f7f1233e1b4b3c=
222fe37e337
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for Mgmt Security Level changed event

@ MGMT Event: Security Level Changed (0x0034) plen 16
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Count: 2
        Security Level: No security (0x00000000)
        Encryption Type: No encryption (0x00000000)


  Commit: 35add0164705497fba2743028cd04afa2d6408c4
      https://github.com/bluez/bluez/commit/35add0164705497fba2743028cd04=
afa2d6408c4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SecurityLevel properties to org.bluez.Device1

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.


  Commit: 8e3446ee8835ff701f5aec1c441c9eeee81ac0d8
      https://github.com/bluez/bluez/commit/8e3446ee8835ff701f5aec1c441c9=
eeee81ac0d8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Security Level related properties

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.


  Commit: ce7f2a5277e5b7cd7f1a3469ea6291d8aacbc391
      https://github.com/bluez/bluez/commit/ce7f2a5277e5b7cd7f1a3469ea629=
1d8aacbc391
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/a05d0a3ee508%5E...ce7f2a5=
277e5

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
