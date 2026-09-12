Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23547ACD7
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237864; cv=none; b=LR8JqmUi3DlJeuXXTpUQmBVMm3B4mkGKVWf+azwBhDOVbNza1/Mu4skIFusFKcicCkbNvZXtsNTLf49BxzJXqt4ttRoH5+WmYZeJ1iDVVzrMWkI8cIq43dzNdPPMg+itVbrfR9cd/67fOmJaw716xJYPxVchS6g56cafulr+Aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237864; c=relaxed/simple;
	bh=R1ICEUy/iN1auXQLWr2n+dhgs2IisqnVG9bQUgpIrhs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J9MILCGlCFA3OSP0hzJFKoYEqkTlpSFaKVx3axmBqMLBPO4887qUbufB9rdXWOG9CdleC2LsvsHTmA9Q0MzWTM8ynz4EYDE0+RqYJT5eNHHkzi34Tg7hABOZu18swzIhLvteyy8FSC37mExCIADbTERyQyzjndznt/wRzahiICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EkWz2w3+; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EkWz2w3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789237861;
	bh=7JId5RnjdNev3ZdMYyeFiQN9FxDJPFLi5V16j6ZpWq8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EkWz2w3+8ijLHoQ8GqrFJnS9n5z4g8BHD/eRLa32sx2/S8BNHEsrUPN3TkT+aJpzL
	 fw2bEcoAmnlAWyL9fT/TGDJGZrYsagKiT5ofK7iMuzZxVAwMNXJE5eJ0F6TITYJVjh
	 MNOD7+0Xsf1IU4ki9xxryAMYyuHDIPyQjsqfTSFA=
Received: from github.com (hubbernetes-node-54e685c.va3-iad.github.net [10.48.183.60])
	by smtp.github.com (Postfix) with ESMTPA id 41D353402C5
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 11:31:01 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:31:01 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1163573/000000-3e9e53@github.com>
Subject: [bluez/bluez] 184a6a: tools/test-runner: replace alloca() based argv
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

  Branch: refs/heads/1163573
  Home:   https://github.com/bluez/bluez
  Commit: 184a6aa44191bc3c19982a50ce433dba846785db
      https://github.com/bluez/bluez/commit/184a6aa44191bc3c19982a50ce433dba846785db
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-12 (Sat, 12 Sep 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: replace alloca() based argv setup

Rewrite alloca() based argv array construction that required manual size
counting with vasprintf string array. This allows splitting start_qemu()
to multiple functions.


  Commit: 86bb2bc82beaff6bd628f2a0e1226480f099276a
      https://github.com/bluez/bluez/commit/86bb2bc82beaff6bd628f2a0e1226480f099276a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-12 (Sat, 12 Sep 2026)

  Changed paths:
    M doc/ci.config
    M doc/tester.config

  Log Message:
  -----------
  doc: enable virtio-fs in tester kernel configs

Add support for virtio-fs in tester configs.


  Commit: 2a1af9efff54c6ff9eb20688ea494c0ceaa02d99
      https://github.com/bluez/bluez/commit/2a1af9efff54c6ff9eb20688ea494c0ceaa02d99
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-12 (Sat, 12 Sep 2026)

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


  Commit: 3e9e53361bfb26d8b5f9eec41441d382d4e539da
      https://github.com/bluez/bluez/commit/3e9e53361bfb26d8b5f9eec41441d382d4e539da
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-12 (Sat, 12 Sep 2026)

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


Compare: https://github.com/bluez/bluez/compare/184a6aa44191%5E...3e9e53361bfb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
