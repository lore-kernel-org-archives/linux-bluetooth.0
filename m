Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D903D649C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630996; cv=none; b=nN5/mXNjJBx6gA8aVOrVxzKYApsB/Uy8fqd/15Lj57IX5jfyrANQHB9DQHhr2DCnMlpirEkfX0z7qiQkPN5Xe0nlcu2R4xJYyQ/pzNGM8PHjNASu8+dWE7UeLjNSdv4/UXzZBGJqHpUlZDdvEb5kb0AhtoGe8umyKn98C5/34t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630996; c=relaxed/simple;
	bh=Wb0VtH76TmieEgmVEPK/NFRYbnaQfy4ucFH6UhAK+jk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NgiSqKZv7WS4wB4vIP/43CxsJ9HtHnaRCmoioLoTZ6WcnrWeLGfe9XaQHOD+Fc/7Kiic6WQMwK3RHAZAbEVhfBB1LIX4h0V4W+lXb/8PZUDviwpUa7idtxCMzTX2IfIFD989AIsHdM9w1MxtHdbfiGjQhsEvxBwF/A6MPblt0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=g9mVkUKK; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="g9mVkUKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790630993;
	bh=gIGxC32ein7C5oMchsx6uo+ybFrPiyDyyBP7P+PL0ag=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g9mVkUKKALf7PzdIayAZrmun3vLAykz5t8Kkv9Nmbd3vAJiGuQRUVqD5FIWO4251O
	 DzX+LYHmwk8eRFXRX7iPRA3ZZKnlo/+CG5nfW7YwvfcibqBSCR+Pe1nHlZEjiIASbI
	 k3KDiDHZ84Z+WRIioHtH/1gcMW8pjTTQWyNdEIrDgvNUjPNfRY2j6hDmK8pcHuzf7x
	 nJXLWlMhrSmkiKLeWkeoCNIGAO0L9ag05upj4+04oxVzFIcH4cnmXj2XJ0bxnhoE2N
	 BZFMDM56vG6aFoi/M7oaVtnmvr6uowimsbyaWlkuJz69d1SCRJkGpucER8LDNXj7eZ
	 Ji7Yls74ZPf6g==
Received: from github.com (hubbernetes-node-3233862.ash1-iad.github.net [10.56.209.90])
	by smtp.github.com (Postfix) with ESMTPA id 9E5A3520A9D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:29:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:29:53 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8b4a41-73e934@github.com>
Subject: [bluez/bluez] 9066e2: doc/qualification: Add CSIP PICS file
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
  Commit: 9066e2678b3b9dfa8b3624fdddfcbc7a65d96fa4
      https://github.com/bluez/bluez/commit/9066e2678b3b9dfa8b3624fdddfcb=
c7a65d96fa4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/csip-pics.rst

  Log Message:
  -----------
  doc/qualification: Add CSIP PICS file


  Commit: 7333d54ed785f92a7f62d5e91e945857a1cf8b71
      https://github.com/bluez/bluez/commit/7333d54ed785f92a7f62d5e91e945=
857a1cf8b71
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/csip-pts.rst

  Log Message:
  -----------
  doc/qualification: add CSIP PTS tests documentation


  Commit: 83d3eb1f54a82da44e2003ece934a46500c95937
      https://github.com/bluez/bluez/commit/83d3eb1f54a82da44e2003ece934a=
46500c95937
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/mcp-pics.rst
    A doc/qualification/mcs-pics.rst

  Log Message:
  -----------
  doc/qualification: Add MCP/MCS PICS files


  Commit: b409d054248e37fc8561247f8d7d4638fc6c383e
      https://github.com/bluez/bluez/commit/b409d054248e37fc8561247f8d7d4=
638fc6c383e
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/mcs-pts.rst

  Log Message:
  -----------
  doc/qualification: add MCS tests documentation


  Commit: 07acc6ee5758f29c71e48e8547faf2f878948b79
      https://github.com/bluez/bluez/commit/07acc6ee5758f29c71e48e8547faf=
2f878948b79
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/micp-pics.rst

  Log Message:
  -----------
  doc/qualification: Add MICP PICS file


  Commit: 0c19f5a09b906eb710a78ff6c4428d775f8bfe7c
      https://github.com/bluez/bluez/commit/0c19f5a09b906eb710a78ff6c4428=
d775f8bfe7c
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/micp-pts.rst

  Log Message:
  -----------
  doc/qualification: add MICP tests documentation


  Commit: f6e495f67becda0f76fd61e5674415d9eaed5566
      https://github.com/bluez/bluez/commit/f6e495f67becda0f76fd61e567441=
5d9eaed5566
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/vcp-pics.rst

  Log Message:
  -----------
  doc/qualification: Add VCP PICS file


  Commit: eb62c7d5e5f91f8e4a1c5ad9c817b5255ce0ff1b
      https://github.com/bluez/bluez/commit/eb62c7d5e5f91f8e4a1c5ad9c817b=
5255ce0ff1b
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/vcp-pts.rst

  Log Message:
  -----------
  doc/qualification: add VCP PTS tests documentation


  Commit: c2ef55e49f2b9340ea7b9446ed69a017b386dadc
      https://github.com/bluez/bluez/commit/c2ef55e49f2b9340ea7b9446ed69a=
017b386dadc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/mainloop.c

  Log Message:
  -----------
  shared: mainloop: Skip removed mainloop events

mainloop_remove_fd() on an fd that occurs in the same epoll_wait batch
as the current callback, causes ASan crash.

Several callsites do this, crash is sporadic since it requires suitable
timing.

Fix by adding registration ID in each event and dispatching only if that
registration is still active.

Fixes random btvirt crashes.

Log:
ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7576be3f18
READ of size 8 at 0x7b7576be3f18 thread T0
    #0 0x5637f7b4014f in mainloop_run src/shared/mainloop.c:104
    #1 0x5637f7b41f79 in mainloop_run_with_signal src/shared/mainloop-not=
ify.c:196
    #2 0x5637f7aa598b in main emulator/main.c:310
freed by thread T0 here:
    #0 0x7f45788ee4cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x5637f7b40d05 in mainloop_remove_fd src/shared/mainloop.c:213
previously allocated by thread T0 here:
    #0 0x7f45788ef24f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x5637f7b4034b in mainloop_add_fd src/shared/mainloop.c:142

Assisted-by: opencode:gpt-6-sol


  Commit: 45c3b69db034cf2a3fcf3de5bf0bb9cdc86f934c
      https://github.com/bluez/bluez/commit/45c3b69db034cf2a3fcf3de5bf0bb=
9cdc86f934c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-mainloop.c

  Log Message:
  -----------
  unit: test-mainloop: add basic mainloop test

Exercise basic mainloop fd add / remove / modify and timeouts.

src/shared/tester.h depends on mainloop and cannot be used here, so
write tests without the framework.

Add tests:

Test Modify File Descriptor
Test Re-Add Other Callback
Test Timeout

Assisted-by: opencode:gpt-6-sol


  Commit: d09935d34414728f23572a731190976343719762
      https://github.com/bluez/bluez/commit/d09935d34414728f23572a7311909=
76343719762
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A doc/qualification/bap-pics.rst
    A doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the BAP qualification


  Commit: 5b37dbfb30153fc1d56457f4fed26725f8fdcee0
      https://github.com/bluez/bluez/commit/5b37dbfb30153fc1d56457f4fed26=
725f8fdcee0
  Author: Raghavendra Rao Sidlagatta <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add BAP/UCL tests


  Commit: 73e934ba80b6b437e8cf8c4789a2412f75bd2eb2
      https://github.com/bluez/bluez/commit/73e934ba80b6b437e8cf8c4789a24=
12f75bd2eb2
  Author: Raghavendra Rao Sidlagatta <raghavendra.rao@collabora.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add BAP/USR tests


Compare: https://github.com/bluez/bluez/compare/8b4a41760638...73e934ba80=
b6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
