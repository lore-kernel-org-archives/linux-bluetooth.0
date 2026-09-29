Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E1560AD4
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708131; cv=none; b=l0t+xMAMAfiz8isa+nrkWt2IThtB2mZLBYi6vVKztBBC6L4ZZLnRSTHFi/kNWJAbC6fRirl8KczY9PfwBRn7ltpcE9rHkHcYEUEFInzhV1fMil8Yk7O81PiFusMHb3HuuRbnurFFLeSymqKyxQDiPoVnIm4KUONo3ehzNLRyDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708131; c=relaxed/simple;
	bh=IoWXAe3L0hjcCGiYBWfxaU26LPZi8IcifO0V1iYoC4o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YuB0B1PlSBzajF1jdEsKd/iHGbNvqs8eVff8WRrKLQA8gzPWeFRR0ZNU3mZH0DJrxpuZMyxOxJBEL2qvDO2KHTFLTs/XtgIo9Gh2l56F4J5Kdc5kuIbVoOBioPv4yGQ9ZL019Te3XDbY6yruEn8obWYt3hwTPVW/Po0svtkHK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=PRReEIo8; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="PRReEIo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790708126;
	bh=QkD5B4GDWn7b2CPeEgIyddhWNhjRJGAPi1uCPc4LnZY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PRReEIo8b/N8cXxlY5L8TkuUo0yfVBpi0pvPUvrvbscukKJkCC1cRypvbkpZuSU5N
	 h66vtg7Kgzz3q6pqzgnj3mHUhCsMuCkWgLCAZzS4TbAv7gb76ymR8+mOCBjzjF2OGr
	 WblEXY61UMaBDGX9NJVkPIcklKX9O7kGnD37nTO7sODy44bWcRxFmh+/DkC7xLK/5P
	 VM/AvCGlti32zNZxfhC88Z+vFyFS45ilH/Qc6GN10d2xWOb8r5THdK0VzY5WkmtWMv
	 WYUo8M8jlLxOQnXuUH6ltCyeiVmwFFOBcNHKAy2bCfg81Si92+Hk7Xc/wLB6DjVu6K
	 J7jpHOTSMypCg==
Received: from github.com (hubbernetes-node-d144d07.ac4-iad.github.net [10.52.179.60])
	by smtp.github.com (Postfix) with ESMTPA id 0FC087411E7
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 11:55:26 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:55:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/73e934-867137@github.com>
Subject: [bluez/bluez] 8814ac: build: Fix coverage target failing with stale
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8814ac26fe656afcc9bd70f0eadcefc917e612a9
      https://github.com/bluez/bluez/commit/8814ac26fe656afcc9bd70f0eadcefc917e612a9
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


  Commit: 86713777f91aa58dc5f475fa87770898f8bf1729
      https://github.com/bluez/bluez/commit/86713777f91aa58dc5f475fa87770898f8bf1729
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


Compare: https://github.com/bluez/bluez/compare/73e934ba80b6...86713777f91a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
