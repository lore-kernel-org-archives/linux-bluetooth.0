Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2F3E3D95
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223959; cv=none; b=XrX/zaOLt3s3n/3oQX5mZZWCuiTF+WnpGR8/A3UNNGzNU5MtAv7Us+mK8tB8cr6XW2rrSjehxDjWkfvL3rN2D8Z6gR8R0pEmvdGopNdfZV1/WtPYc1oT/w5AWX5SPSa5WD6kkFCFos+XrBMVDjeqLb/Rq9SL8TLJcVa8e2bI/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223959; c=relaxed/simple;
	bh=gI4S9yNoJuQAtXtxsGvlL+cLqr8ruvVAlSFijrNOzHo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AiRmVImyyEZOQbPRJGzsU1fz5f837Q02upt/kbTVoUd5xW4j3kW7cR3Cdm+Ez+XCNYOekjVN9d1IGkUHUxT6q2T1wJE846E/L75PDKalAk794baxawndzv//l0V669ml0Ysy/29LY2zsrEgrRSKfsid0v27NHnB/Ti0lEKiihbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X0zyBDy/; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X0zyBDy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787223956;
	bh=8vHmh0ZkTfMP076YoRSnIjD4dbRQD7McxA0gOqzgInU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X0zyBDy/doVwf9KNFGieoqnu6pHUVDhG8qVfuRFLeY328bwU6e0RRGmK6W1iPBWWy
	 KCiTBvkTm29+xBrThnO/26j/ORKZ/p2YsNBj3vmrjvOdhlDRiYTClPxDeoW6snE+9A
	 9vkSAyMEJFKZ4206eb2cFYEPGK1+kOfSLn2OpxrI=
Received: from github.com (hubbernetes-node-82e747f.va3-iad.github.net [10.48.65.75])
	by smtp.github.com (Postfix) with ESMTPA id B72077811E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 04:05:56 -0700 (PDT)
Date: Thu, 20 Aug 2026 04:05:56 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149033/000000-0e5f56@github.com>
Subject: [bluez/bluez] 2cfa33: mgmt: Add Security Level Changed event
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

  Branch: refs/heads/1149033
  Home:   https://github.com/bluez/bluez
  Commit: 2cfa331b41fb1488993b90e77f133be48f088f3a
      https://github.com/bluez/bluez/commit/2cfa331b41fb1488993b90e77f133=
be48f088f3a
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


  Commit: 748645f56595e6d5ba65250bc305c38cd9f2147e
      https://github.com/bluez/bluez/commit/748645f56595e6d5ba65250bc305c=
38cd9f2147e
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


  Commit: 30e6a91fad2e004b0c702fff88489ca0ec3278ed
      https://github.com/bluez/bluez/commit/30e6a91fad2e004b0c702fff88489=
ca0ec3278ed
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


  Commit: 4587e291ed8831f3789113d5e787a8bf517402e2
      https://github.com/bluez/bluez/commit/4587e291ed8831f3789113d5e787a=
8bf517402e2
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


  Commit: 7ecdc6def676ee1873db5e92d33a58730d409666
      https://github.com/bluez/bluez/commit/7ecdc6def676ee1873db5e92d33a5=
8730d409666
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


  Commit: 0e5f562720b3be4d5e860c85416208c5bc1d8a28
      https://github.com/bluez/bluez/commit/0e5f562720b3be4d5e860c8541620=
8c5bc1d8a28
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/2cfa331b41fb%5E...0e5f562=
720b3

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
