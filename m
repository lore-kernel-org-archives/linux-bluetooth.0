Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924442586F
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305177; cv=none; b=QLFelIaPgDHATV60iyiXAwFWy3oZ187A5rwkDJBaBeUO5NSkRLJyNJpqYzCUeg5jpY7s1MzIjSMVOQAyTT+6+bweOxaV6RYv2Wj59Mlpnk52junjVstKxBm0yT4j/jVlQGBi9z9Are+GOSj9XiSOQ27UaohTuVhCEbqpAZDM9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305177; c=relaxed/simple;
	bh=cdNyGpjNrOAORxW5KZxIftHbujUhys1kCH5RX3LeSIs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sCu2Dbe1z/wa2eiEDQDmNL/TZpq+lccOa0Qqe4zhu/BtXvSZDR5DQaEH6CR8e0zOyOApBVf7rJ51vOKF/w3g4hxduSTkbxICAMbFfm69Uqn9kYVYwni0ZVeYiVTSXo4kfJQ9xsZwZm4qWjNeFUhjd9OdqRz2UHebTaGvlUigIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g/kYenwH; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g/kYenwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787305166;
	bh=a/ZZwaIQ2Hg5nN3kzJlaXOoxyl7UcorBY4iFd3u0sds=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g/kYenwHCzIGPIlsLVYx9YTzF909UWu/fiQ1UbieVZCKwREOPTOzQHMJrXZ9B0vxZ
	 5Im6d5TiNhk93NZg4cpVsasxwUz6cF2BD1DSLcJmu+hc6UTgDxYRsD615sgi+ZV67H
	 zkFKGekV9vEQ2wkgzPmHSggy8h0QB6t+CoIFFmVs=
Received: from github.com (hubbernetes-node-a99d03c.ash1-iad.github.net [10.56.207.20])
	by smtp.github.com (Postfix) with ESMTPA id 909FE181097
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 02:39:26 -0700 (PDT)
Date: Fri, 21 Aug 2026 02:39:26 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149614/000000-e3ef89@github.com>
Subject: [bluez/bluez] b7fdfb: mgmt: Add Security Level Changed event
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

  Branch: refs/heads/1149614
  Home:   https://github.com/bluez/bluez
  Commit: b7fdfbfda5ff74baf6865679cb0886290fb808fb
      https://github.com/bluez/bluez/commit/b7fdfbfda5ff74baf6865679cb088=
6290fb808fb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Security Level Changed event

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.


  Commit: b37d0ea6ea07e39fe4ae0b134d5f2697e6aa6a8e
      https://github.com/bluez/bluez/commit/b37d0ea6ea07e39fe4ae0b134d5f2=
697e6aa6a8e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Security Level Changed event tests

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 8c3ca2066ae4adda9084c53c078c12513aefab85
      https://github.com/bluez/bluez/commit/8c3ca2066ae4adda9084c53c078c1=
2513aefab85
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

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


  Commit: a9bbcee669f075c71ffdd363b151348e43c5066b
      https://github.com/bluez/bluez/commit/a9bbcee669f075c71ffdd363b1513=
48e43c5066b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SecurityLevel properties to org.bluez.Device1

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.


  Commit: 77d384e40acc8dbb7260111f42bc32d24e556306
      https://github.com/bluez/bluez/commit/77d384e40acc8dbb7260111f42bc3=
2d24e556306
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Security Level related properties

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.


  Commit: e3ef89048d52cdf780e7c1f9faf155af53a24b0e
      https://github.com/bluez/bluez/commit/e3ef89048d52cdf780e7c1f9faf15=
5af53a24b0e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/b7fdfbfda5ff%5E...e3ef890=
48d52

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
