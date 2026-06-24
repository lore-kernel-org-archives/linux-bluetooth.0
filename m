Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBA1EDA0F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323074; cv=none; b=Gf/GEU+ZNDG41FDSFzR2VExpJNaZ8/vumKdvh64OjOmR0IGR/Sqioa2ZfJtvDbSTUSOhOxZG8cJSvUPJG08d5Mz1Cwgsv3VmK2axC+cupcw/2VnJ8dfIPq9veTmLpx2iriXvlZfHJrF9hV2CPFDjpp0GWKkPeiImdSSFymmtl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323074; c=relaxed/simple;
	bh=ymAwthht2xBrAUTMwehVjizbX96c6P6I1qFioiN1hoM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Av0ObpNQJjmhCmAJjGXPaKpUNwUirY386UxeYliKS3ENv6SdE118GImlpr9C+0Rr8a5lHPZB1mMbk2axkcCGEhkPKroJWQ0b+5yMhjDkUs70eyyDr6dzE5olyUJwh/wjt3zsUQdKX2KeyEXSnorduXVnN9ejO52APVXMXONYRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BMQug1fb; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BMQug1fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782323072;
	bh=sa7jY/ybWIoliVK/YwO5Xdi9T02fbMOfiiJ08g2od8c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BMQug1fb+CoFRdukTpNlyU+t0TPFJAXJqlbjfCEp1vvN5dpc0p5FCDBcmDbHvzW/z
	 HY1hzFQGMywMW8wEIXzoiHjdeNiR3Gfnyt8lRWpjE/JmfPH+IsbB9R7hRgrHISeN+h
	 Xjm52SOUGbVSg3JcniVKzeHHYoEpgdVHvLIsAuBY=
Received: from github.com (hubbernetes-node-db87272.ac4-iad.github.net [10.52.86.41])
	by smtp.github.com (Postfix) with ESMTPA id 5E59040225
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 10:44:32 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:44:32 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/912f5e-eb9b35@github.com>
Subject: [bluez/bluez] 7efd93: shared: rap: Defer CS Event registration until
 con...
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
  Commit: 7efd9383f0a1ea20226c63494bc0bcb9a3e2a8fa
      https://github.com/bluez/bluez/commit/7efd9383f0a1ea20226c63494bc0b=
cb9a3e2a8fa
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-24 (Wed, 24 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  shared: rap: Defer CS Event registration until connection setup

Move LE CS event registration from rap_probe()
to rap_accept(). rap_probe() runs during service discovery
while no ACL connection or connection handle exists,
so connection-scoped CS events cannot be delivered or
associated with a device. rap_accept() is called
after the ACL link is established, when a valid
connection handle is available and the HCI layer
can route events correctly.
Registering events at this point ensures
proper handling of CS events.


  Commit: 40a58272a58fdfb00081289ab41fa6d4cebfb935
      https://github.com/bluez/bluez/commit/40a58272a58fdfb00081289ab41fa=
6d4cebfb935
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-24 (Wed, 24 Jun 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Fix step payload pointer in parse_step

util_iov_pull advances iov_base before returning the new pointer, so
mode_iov.iov_base was set to the start of the *next* step's data.
Every step was therefore parsed using its successor's bytes.

Switch to util_iov_pull_mem which saves the original base, advances
iov, and returns the pre-advance pointer =E2=80=94 correctly pointing to =
the
current step's payload.


  Commit: eb9b35c8d13dffcaf4f6f4b5bee29a18c860ba04
      https://github.com/bluez/bluez/commit/eb9b35c8d13dffcaf4f6f4b5bee29=
a18c860ba04
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-24 (Wed, 24 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit: test-bap: disable optimization to speed up compilation

Compilation of this file with optimization takes 12 min with ASAN, 1 min
without.  This is too long, and the -O2 doesn't serve purpose for unit
tests.

Disable optimization to reduce to 30 sec with ASAN (5 sec without).

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.


Compare: https://github.com/bluez/bluez/compare/912f5efb0dd9...eb9b35c8d1=
3d

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
