Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D73F12D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397065; cv=none; b=iqrHPEIa0gK3BoulKD99E/gyIFAwLq/aMS1Fba3XV5m/PTaTeDtuuWBanjeDT8GWijyyYoxWKuyUiOhf5RKrFd39PZCwvtmW+yT2HeNq7MzuABOVWG2Vi6oPZQkUZIlFGlFBPTtXBxt4uvTu7WD/jmhBNM/N7zbCxayOrIsmn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397065; c=relaxed/simple;
	bh=C5ZxQIpzDWIc7RI/lH8BmiFp+3mp3meiR1JAZS/P328=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fY821b2IgQhiVokMowv2VqiMXuCrG9EspzpLe0fW3YkS2bco2oC4oiMofojua79+UHToU5BvaIxCJRwZxuESrolZ6sNHDGMlJ2BOaG6ruczVgIZ0EZN5/mXLK8w1ZbPj/6joAao+KsMTJvZn/FjQzAUlNPp80nTkZqlM5rckY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QkPqxqXd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QkPqxqXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789397063;
	bh=E85a0ZYxDepabZ6r4aS0yIC1YJxVHhUbGf4+vTllx5E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QkPqxqXd8xylPKbjUft7bXLOQGdpVG0JIIJFQmroO5mtlhOprzzTHgbhckIUIZFqB
	 EOJMSD2bjIGxVqn0kHB/oyqY0KdV9HCNL1Td4hmhVJKXKU7pHL555Q+dr+gSoiOKVd
	 ovXKUeUJqS4M8kLN59XCryRE51doaulO/JE8wVOU=
Received: from github.com (hubbernetes-node-6302fbf.ac4-iad.github.net [10.52.178.35])
	by smtp.github.com (Postfix) with ESMTPA id 9B00BA01B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 07:44:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 07:44:23 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/fa1938-e0b8a6@github.com>
Subject: [bluez/action-ci] b6dd0b: Add instructions for localci usage
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
  Commit: b6dd0b29c7e56b829b62f33377e321298a0c8358
      https://github.com/bluez/action-ci/commit/b6dd0b29c7e56b829b62f33377e321298a0c8358
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M README.md

  Log Message:
  -----------
  Add instructions for localci usage


  Commit: f0821a6828397be6a7062910be3d6071ddcb5e29
      https://github.com/bluez/action-ci/commit/f0821a6828397be6a7062910be3d6071ddcb5e29
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M entrypoint.sh

  Log Message:
  -----------
  entrypoint: adjust expected bluez source dir for localci

For the localci local dry run mode of entrypoint.sh, make bluez source
dir the same in kernel and user modes.


  Commit: ba88cf65ea0ff1d48662e6b960cf163550291778
      https://github.com/bluez/action-ci/commit/ba88cf65ea0ff1d48662e6b960cf163550291778
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M ci.py

  Log Message:
  -----------
  Log full errors in test runner

Make debugging the CI runners easier by logging any exceptions raised.


  Commit: 3bbb6fe6c03d1bc467d230d2114f47c5c1b19697
      https://github.com/bluez/action-ci/commit/3bbb6fe6c03d1bc467d230d2114f47c5c1b19697
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M ci/__init__.py
    A ci/testfunctional.py

  Log Message:
  -----------
  Add hook for running test/test-functional tester


  Commit: e0b8a65c986560e21d609b5d75792e214d72b8fa
      https://github.com/bluez/action-ci/commit/e0b8a65c986560e21d609b5d75792e214d72b8fa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M ci.py

  Log Message:
  -----------
  ci.py: add TestFunctional to user tests

Add TestFunctional to user tests. This includes kernel build.


Compare: https://github.com/bluez/action-ci/compare/fa19384d4c70...e0b8a65c9865

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
