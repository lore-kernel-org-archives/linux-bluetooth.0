Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B095592EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980084; cv=none; b=sBSfEPBB4+Hpq4QuckZzB/xTajZXIR9T3eKlDJ2rCzXflzDOjLVYspJgG+soOO2pKeSfwzGoFWyXZMf+PM8xK67UotjbFUfw7NYHZGE6rtv+Y0kB0Mj2zdz8fYi/JwHfDi4pgq/mdQdnLx+RdRBfFGUQFo0+0MJAGV8T39AsvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980084; c=relaxed/simple;
	bh=BNvvoc+UYOjWcKx5U0vd21gNBUVcHLNDtzOoqfPwtAo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QYxcGHpCsC27ICL9jKC+RpjseS3KRdMp74ZwV8ZESRshMzPx0c84+7/21Jfoar6qnQW4+JRaqRg0eep5pwox4hto4NCax8CSVmmp4HR1i1tDtYeUJTwKOaSaatWL3hcWS1u0/yA5DHYWI0Q5JHk8yYMqVmNfH/KNB5fHCAAGSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AOvBMno8; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AOvBMno8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788980080;
	bh=4sYq56qjbEKdgxne0Qw9LdLPnAPWNWU88t7kIwPrV0M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AOvBMno8ufjoSBVp1iXR5gRk+JDvclmSNN4uT4ufB8LGEbJQZDtPGVlRETv3Gdl1o
	 V7oqiHNU0LUWp0TKfBlVsISQCwusSdj8wwBiWKsQjObFf8ZH8NisEbVlFJDYj1DebV
	 hFL3/+sy8NAnbH6R8OE1UuwcX2L6BSNMfH4VHVs8=
Received: from github.com (hubbernetes-node-4045bf4.ac4-iad.github.net [10.52.208.87])
	by smtp.github.com (Postfix) with ESMTPA id D7F1032016F
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 11:54:40 -0700 (PDT)
Date: Wed, 09 Sep 2026 11:54:40 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/1e08fd-9693b1@github.com>
Subject: [bluez/action-ci] c01507: Use AddressSanitizer instead of Valgrind
 for testers
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: c01507fbe25ba02f0274de077dae262d9d0c96da
      https://github.com/bluez/action-ci/commit/c01507fbe25ba02f0274de077dae262d9d0c96da
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M ci/testrunner.py
    M ci/testrunnersetup.py

  Log Message:
  -----------
  Use AddressSanitizer instead of Valgrind for testers

On blueztestbot/bluez-build:latest (d5484a10bde6) from 2022-12-20,
testers ran with valgrind work, but they fail with timeouts when using
image rebuilt from https://github.com/BluezTestBot/docker-bluez-build
(89186b243e08) that should correspond to the source of the original
image.

As we cannot stay with unreproducible CI image, this should be fixed.

As the cause of the issue is unclear, switch to using ASan instead of
valgrind.

Example (with intentional crasher added in iso-tester)
------------------------------------------------------
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Sanitizer errors:
==33==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7bab5fd7f2e2 at pc 0x55d17f8a90d6 bp 0x7fff0e52b3c0 sp 0x7fff0e52b3b0
WRITE of size 1 at 0x7bab5fd7f2e2 thread T0
    #0 0x55d17f8a90d5 in test_connect_close tools/iso-tester.c:3714
    #1 0x55d17f9737c9 in run_callback src/shared/tester.c:512
    #2 0x7fab627fbb9a  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x60b9a) (BuildId: 2426ee6f828a10bf4da963a4c474752c33742359)
    #3 0x7fab627fd1d6  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x621d6) (BuildId: 2426ee6f828a10bf4da963a4c474752c33742359)
    #4 0x7fab627fd576 in g_main_loop_run (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62576) (BuildId: 2426ee6f828a10bf4da963a4c474752c33742359)
    #5 0x55d17f977c08 in mainloop_run src/shared/mainloop-glib.c:65
    #6 0x55d17f97853a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #7 0x55d17f9766fb in tester_run src/shared/tester.c:1085
    #8 0x55d17f8a3951 in main tools/iso-tester.c:4402
    #9 0x7fab61f87600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #10 0x7fab61f87717 in __libc_start_main_impl ../csu/libc-start.c:360
    #11 0x55d17f8a8ef4 in _start (/work/base/bluez/tools/iso-tester+0x16bef4) (BuildId: c55e00a4de821cd607408898c962c16c12e2322c)

Address 0x7bab5fd7f2e2 is located in stack of thread T0 at offset 34 in frame
    #0 0x55d17f8a8fcf in test_connect_close tools/iso-tester.c:3706

  This frame has 1 object(s):
    [32, 34) 'buf' (line 3710) <== Memory access at offset 34 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow tools/iso-tester.c:3714 in test_connect_close
No test result found


  Commit: 9693b14748368889034e742eae601c1a6fa7c8b7
      https://github.com/bluez/action-ci/commit/9693b14748368889034e742eae601c1a6fa7c8b7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M Dockerfile

  Log Message:
  -----------
  Use CI image in Github container registry

Use image from Github container registry, built via Github actions so
that it is easier to manage, without needing dockerhub or any other
additional secrets.

This image includes LLVM 23 prerelease from kernel.org.

NOTE: The image is currently built from my personal account,
https://github.com/pv/bluez-ci-image/pkgs/container/bluez-ci-image but
probably the repository should be copied in the organization and the
image name changed accordingly.


Compare: https://github.com/bluez/action-ci/compare/1e08fd655d42...9693b1474836

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
