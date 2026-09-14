Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BB3A63EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412537; cv=none; b=DLr31odpQIgRDq6rr0TTZEtzb2RfxXemDGSs1s8E6tpZfxMD+uzXMv7peDD/NPYE8zrwfmhZXT7P4A6W7P8mEaWc20eEYM1Gx0Uz+FdzCEw2vIsLYcW7SqMVohjclXfDR7PV9aofDWteEV/zmEs5liK3DgJgUJ3f8XpttVQBF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412537; c=relaxed/simple;
	bh=xS+sHu/3wwCApr4N9SoPdB6vuw5OTkHAQ18CqXdmz94=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EwoULXY/qvb89YSNMPvRkJ0aJ3O/lSuWdcGzYHSts07Db++uBOWZr6xBVzv7zPdMygFJkkFW3MjCSwaIcoRSooqqa8Nrpmk/E7e6cBdREWKu3ledhe+lTJP1OD+zmcoaDkUW1pwnDB2KLNv9Z5lhNf2cr9gxgPmdUS8p+YQuBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k0+OmQDD; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k0+OmQDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789412528;
	bh=6vB8mDdskk/3FWY0j1gvJ/KAAOAZQvp/yDv19GQEBSo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k0+OmQDDn5fcL2Z/ssFksXaY2zib87/isxrD6IDLxt5ZTU8kG4cH80840pSbMXqgg
	 rHNkoqDB0GChUkDT2dkxEBwm5urM+qT7Xey0oTOOPvnGeO7CdM3y09VxyMUEMBe9v7
	 rv1oYwvIclBwco8CRQkksz4fv9qh2ekkd+Y0lqwM=
Received: from github.com (hubbernetes-node-0722a26.ash1-iad.github.net [10.56.164.17])
	by smtp.github.com (Postfix) with ESMTPA id BC09B9212A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 12:02:08 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:02:08 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/61a2b3-c8e2b9@github.com>
Subject: [bluez/bluez] 7856c9: tools/test-runner: replace alloca() based argv
 setup
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7856c910c27da2b61fbb64db15cf243375990732
      https://github.com/bluez/bluez/commit/7856c910c27da2b61fbb64db15cf243375990732
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: replace alloca() based argv setup

Rewrite alloca() based argv array construction that required manual size
counting with vasprintf string array. This allows splitting start_qemu()
to multiple functions.


  Commit: 67e1394c80547a6eb87486cd5bf83150da36d5f9
      https://github.com/bluez/bluez/commit/67e1394c80547a6eb87486cd5bf83150da36d5f9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M doc/ci.config
    M doc/tester.config

  Log Message:
  -----------
  doc: enable virtio-fs in tester kernel configs

Add support for virtio-fs in tester configs.


  Commit: 6c1985716322b5574c5f3b8107fad8260939465c
      https://github.com/bluez/bluez/commit/6c1985716322b5574c5f3b8107fad8260939465c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: use virtiofsd for filesystem passthrough

The 9p mount passthrough I/O is fairly CPU hungry and slow. This matters
for e.g. running Python in test-runner, since it has to read some amount
of files for startup.

Add support for virtio-fs, which is significantly less CPU intensive.

Enable it by default if /usr/libexec/virtiofsd is available, fall back
to 9p if virtiofsd not usable.

Before:
$ time make check-functional
real	2m9,736s
user	1m29,570s
sys	0m32,715s

After:
$ time make check-functional
real	1m35,703s
user	0m28,938s
sys	0m7,453s


  Commit: c8e2b951b07fc9b84fa7f3e70dcde2b61aab3ad8
      https://github.com/bluez/bluez/commit/c8e2b951b07fc9b84fa7f3e70dcde2b61aab3ad8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: Fix CPUID register clobbers

CPUID modifies EAX, EBX, ECX and EDX, but the inline asm clobber list is
incomplete.  Use the __get_cpuid() intrinsic instead.

Fixes rootfs_setup(r, argv) crashing due to impossible r != &rootfs due
to clobbered registers.

Assisted-by: qwen3.8-flash-next  # finding the bug


Compare: https://github.com/bluez/bluez/compare/61a2b3d93897...c8e2b951b07f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
