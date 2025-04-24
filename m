Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F727F4CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509512; cv=none; b=Z75JNh2ztj2UZduvCACI564vICNb2eLFm4HKH9t7JZaZ37A93MCJA90C0f2lH3LZFLQO6B39P/jeIYjfQLHneaY27PmWtgRSFOndzxBQaPzH+hJvJ6TIwha+cIMTJhy7TrTcDmP8Vo69mNN+Fvfblhr29Y8lJAKDUy84FG7EXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509512; c=relaxed/simple;
	bh=gq1EdI5NFJ6EtpvCtBMCSWYE8eOz7Q+O8jWeWDKrHRY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tNIerN5YTVOfb6jUh27XOBRsMWemvDM1287nmYb5Jd9qa23Cfo8X2g/xVHZFozLG++7j/6E9p9MmGUkdxrvpd2Y5MYWHg2SpUK8O1HKq3UVpWuZ6zcxmFgkdsuY0QY3CtHx5KDz44UI1IEEczCwnG8StsqONcoVfuqgJXKKjU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jK2MQ8Pe; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jK2MQ8Pe"
Received: from github.com (hubbernetes-node-cc57147.ac4-iad.github.net [10.52.140.35])
	by smtp.github.com (Postfix) with ESMTPA id 660BB641000
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509510;
	bh=YD+n7oJzf++Mt7UOtySiKkJ2OV3lyBUEXl3gyqj28A4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jK2MQ8PeyRRXigZqbStzFEPnpk2pRedRv3QAmeG9BIhP7hckQ/KknPfmOgxKehcGN
	 CImjbbp8XRan7fUnL63SPzUGKsFWtpkfL1JKjzAZNN9Gaqr9F2tXu1Q3JszuAPyF36
	 gs6soY3z8SSWZzasRvDw3LXo5pqVb0LSGume3fdc=
Date: Thu, 24 Apr 2025 08:45:10 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/950146/000000-610f97@github.com>
Subject: [bluez/bluez] 610f97: tools: add BPF timestamping tests
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

  Branch: refs/heads/950146
  Home:   https://github.com/bluez/bluez
  Commit: 610f97a2c597d097846fbf646e818a9f1bb15262
      https://github.com/bluez/bluez/commit/610f97a2c597d097846fbf646e818a9f1bb15262
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M Makefile.tools
    M configure.ac
    M doc/test-runner.rst
    M doc/tester.config
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/test-runner.c
    A tools/tester-bpf.c
    A tools/tester-bpf.h
    M tools/tester.h

  Log Message:
  -----------
  tools: add BPF timestamping tests

Add some tests for BPF timestamping on Bluetooth sockets.

These require additional tester kernel config, and at build time
the vmlinux image.

Add cgroup mount to test-runner.

Add documentation to tester config for this.

Add tests:

ISO Send - TX BPF Timestamping
ISO Send - TX BPF + Socket Timestamping



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
