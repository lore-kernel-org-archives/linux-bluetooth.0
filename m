Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08354AA419
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057738; cv=none; b=Pt+rHPEEz0JDE5OZUX7z6RwlQKEiJfl8jYqxF1hzgjB2AIb8TTSZ/5xxD25kHju14fWhLl6OvqoZYc6XoGj7vC/i867PnU/bj1joAPMSgtVPid0t+uTPRZoe3xpFLAoV6MHOz1HE6JPr93086WIv6FY8cfkZL5kyscx4/jVz0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057738; c=relaxed/simple;
	bh=0h3wyvz7+XebApSKmIxqNuKHiFlD5/dJmalJqXLCz5s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UbWj55R3pB35KDC5jlsj24JNC+9ToJmYMouOp+VjuagQFvDv9luA0b8AKNnhpYyXKgdIP6cUlLquCXOaEPcfEEx83F9Y5iyjFzekfenYoCDyXJRqg3uwaik05ADVQ+Um1nLa/KsFKedQECfZmEUeWslV8yTEc8pxJ2EjOPH8L0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YyKH34fY; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YyKH34fY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790057725;
	bh=VGd8sZKyMYtsOdx2/gQ8D1V2OGdqXZjp04vY34nWCJo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YyKH34fYM2zTyQ5NnT10ZohcZ4uAr0/37emfO9T/4CuOFLQFcrC8f7vvUsOO5zOGm
	 SM87WudW+dNb7L0M/f2RBmCfEgl60KZ53JnXE+zGrqTwYIehJXZaEccm7EAAsQVMr6
	 6uru+Hj1miIa71SSPZtiDJ89jDuT0YySAd52hCmg=
Received: from github.com (hubbernetes-node-c304087.ac4-iad.github.net [10.52.148.30])
	by smtp.github.com (Postfix) with ESMTPA id 84F20A1317
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 23:15:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 23:15:25 -0700
From: birddog87 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1170874/000000-8fb194@github.com>
Subject: [bluez/bluez] 5e5bca: input/hog: Cancel pending report requests on
 detach
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

  Branch: refs/heads/1170874
  Home:   https://github.com/bluez/bluez
  Commit: 5e5bca93ee19f1097efe6b8bbe799e8abe4219b8
      https://github.com/bluez/bluez/commit/5e5bca93ee19f1097efe6b8bbe799e8abe4219b8
  Author: Nick Hammond <blender7@gmail.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  input/hog: Cancel pending report requests on detach

GET_REPORT and SET_REPORT requests are tracked by getrep_att and
setrep_att rather than gatt_op. Cancelling gatt_op during detach leaves
these callbacks registered on the shared GAttrib connection.

A reply delivered after the HoG object is freed can therefore access a
freed report in get_report_cb or a freed hog in set_report_cb. A long
GET_REPORT read can also retain its callback through a READ_BLOB
continuation. If the HoG object survives detach, the callback can instead
send a stale UHID reply.

Cancel both outstanding requests before releasing attrib and clear their
IDs so a later attachment starts without stale request state.

This was investigated following a bluetoothd crash on Ubuntu BlueZ 5.72
during keyboard reconnection. A socketpair regression reproduces the
use-after-free on current master with AddressSanitizer as well.

Assisted-by: Codex:gpt-6 AddressSanitizer


  Commit: 6286e10b54a581740fe7c974d8da3b488a50a724
      https://github.com/bluez/bluez/commit/6286e10b54a581740fe7c974d8da3b488a50a724
  Author: Nick Hammond <blender7@gmail.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    A unit/test-hog-lifetime.c

  Log Message:
  -----------
  unit: Test pending HoG reports across detach

Exercise the real HoG, GAttrib and ATT implementations with socketpairs
for ATT and UHID, without requiring a controller or /dev/uhid.

Cover pending reads, READ_BLOB continuations and writes whose responses
arrive after detach and object destruction. Also check normal completion
and reuse of a surviving object after detach. Keep another GAttrib
reference alive to model the connection shared with other profiles.

Include hog-lib.c to construct a single report and invoke its request
handlers without unrelated service discovery or new production APIs.
The follow-up build change registers this test with make check.

Without the preceding fix, the three teardown cases fail under
AddressSanitizer and the reuse case receives a stale reply. All five
cases pass with the fix and leak detection enabled.

Assisted-by: Codex:gpt-6 AddressSanitizer


  Commit: 8fb194ba6d72dab24450271e8e14972d8ef22318
      https://github.com/bluez/bluez/commit/8fb194ba6d72dab24450271e8e14972d8ef22318
  Author: Nick Hammond <blender7@gmail.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Register the HoG report lifetime tests

Build and run test-hog-lifetime with the existing unit test suite. Link
its support sources without a second copy of hog-lib.c, which the test
includes to exercise the private report callbacks.

Assisted-by: Codex:gpt-6 AddressSanitizer


Compare: https://github.com/bluez/bluez/compare/5e5bca93ee19%5E...8fb194ba6d72

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
