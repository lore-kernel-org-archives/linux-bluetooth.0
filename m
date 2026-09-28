Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA24FD78A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631108; cv=none; b=nc1XZlRkL8qxdfatpRYo8haYOxGltEJ0a+QhM2hc7fDE59c4QrlLDt1CYdJpfQ5OhYJXlPhp+H0fDUE7Bv+JbPUGz2/wT4le2WbGEcfAYXw32u+/7HKD+f7QYhSoKCZY7hLjmvcBJftQEszf0c3bkOUSJCfRchDX1wF/XWbidT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631108; c=relaxed/simple;
	bh=COIm7onH6tx2L1p29pjUSuWMpYo0koiCX70Qcd8dtxs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tfWty6GWZ3qAcGlpQeAvXQhGUv1q6pT4DAPKMiIC1pZUCnJ567tnQJJsIXnCqAVUqEvEQT8+R4yZy2GEARf9SLW8skXse7aWn2OttTrk/pI0xqsqVRxmxcZgZxKWzvb9DfYhxrorMRmOh3F3Rpyp1YEQl+5pkdnBhiskY2RZa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E+NT0pK1; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E+NT0pK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631103;
	bh=SgH9YhpvtpkKHg5O2fD0vn56ZT7+qJsSF+6VgnmAVms=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E+NT0pK1mfdKoFodAHRSDkHmmR4+8GpmMwTteSjvFmKrjgt0bCViCAaPI4vZ4FbGl
	 VxUX8Qc20NzfxPUmOBUB5dP19wDSRsuU09Gxp4sKOWBxZwtxe/I7EvBL5+CeNdPO/6
	 ciYw9HfLQD1PCxs/7jBdF+PUi9mzy+0R9K1STwAE=
Received: from github.com (hubbernetes-node-17bcfeb.va3-iad.github.net [10.48.69.96])
	by smtp.github.com (Postfix) with ESMTPA id 63D64501650
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:31:43 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:31:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175582/000000-fe7cbf@github.com>
Subject: [bluez/bluez] 0d00bd: build: Fix coverage target failing with stale
 .gcd...
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

  Branch: refs/heads/1175582
  Home:   https://github.com/bluez/bluez
  Commit: 0d00bd2195b854115525139ed79f5b502f5b71ac
      https://github.com/bluez/bluez/commit/0d00bd2195b854115525139ed79f5b502f5b71ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix coverage target failing with stale .gcda files

Coverage data from a previous build is not overwritten by 'make check'
for binaries that are not run by it, causing geninfo to fail with a
stamp mismatch once the objects are rebuilt. Zero the counters before
running the tests and mark the targets as phony since coverage/ is also
the output directory.

Assisted-by: Claude:claude-opus-5.5


  Commit: fe7cbf16897aad7458db1f9afab4099ae596e4db
      https://github.com/bluez/bluez/commit/fe7cbf16897aad7458db1f9afab4099ae596e4db
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.tools
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Share build directory writable on coverage builds

The root filesystem is shared read-only with the guest so gcov is not
able to write the .gcda files of binaries run by test-runner, e.g. by
the functional tests. Share the build directory writable over 9p and
mount it over the read-only one when coverage is enabled.

Assisted-by: Claude:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/0d00bd2195b8%5E...fe7cbf16897a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
