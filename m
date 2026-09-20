Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4956383C84
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941072; cv=none; b=q4nQDuOMbZqulICmBlB1szELWhRDuQg7qthZEZDOjJsAL5U1YVVnyNO9o84GNii9kaOcpIGhtpODcNkBFPIkDdoP5wimpbY+fwLt5Eh0gjHISQ5nbZKNk9+pRMPbgBrZkZXm9CDxcgpwZ/S5RBE3xR0u630db4dgPWjYcJce+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941072; c=relaxed/simple;
	bh=ROlmX/XTqY6y6y0+M35xUExLpZ5JUiS5TB68GEsja7Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CVA2WG3s8pps5w+XzKwu/4bZl888JrbJ1P7lg13eyJQHQP1SmJFzw439xbw5rGjZb7df7/DBqG4DMfLe/7vvh+xAxG8R0Txyaj5wT80abFe6mbIzx0TCuylBQl+dOuilUgf/HmsS+wbR/hU0cMeWHwt1mANcodfewOA+J7AT14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OHfE1UKe; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OHfE1UKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789941059;
	bh=1thCogaO/LMdzcbPTt8NWZEESHmoj7U617hHIGfb5hQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OHfE1UKe4zxClj6SibnE6WTnIw6mzVuIQLaqt00oIL9XWUBPsP+yhBcgOiEmwqzxh
	 6sS7lMZtFnsAm8uMYdxTjaJMHfwHIiHkyZSDvoUjH7f0l0YOh8PyZx+xX/LuwberE6
	 5vJFNlpVZsvmGOlpwqBb4bRSYreaRwwjN+wmux6Q=
Received: from github.com (hubbernetes-node-5a9e995.ash1-iad.github.net [10.56.211.67])
	by smtp.github.com (Postfix) with ESMTPA id 66C318407A2
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 14:50:59 -0700 (PDT)
Date: Sun, 20 Sep 2026 14:50:59 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169895/000000-24a2c7@github.com>
Subject: [bluez/bluez] 9a560b: mgmt-tester: ignore Debug feature in Read Exp
 Feat...
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

  Branch: refs/heads/1169895
  Home:   https://github.com/bluez/bluez
  Commit: 9a560bf5f3f63eb07365dccfced7227688620a55
      https://github.com/bluez/bluez/commit/9a560bf5f3f63eb07365dccfced7227688620a55
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-20 (Sun, 20 Sep 2026)

  Changed paths:
    M test/functional/test_kernel_testers.py
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: ignore Debug feature in Read Exp Feature tests

CONFIG_BT_FEATURE_DEBUG controls whether Debug experimental feature is
present. mgmt-tester hardcodes one configuration.

CONFIG_BT_FEATURE_DEBUG is incompatible with DYNAMIC_DEBUG, so requiring
test configurations to have it enabled is inconvenient.

Instead, adjust test to accept either debug present or not.

Fixes failures in "Read Exp Feature - Success"


  Commit: 0a8a880e2113fc7b73b5fdd39bc7c1706431685b
      https://github.com/bluez/bluez/commit/0a8a880e2113fc7b73b5fdd39bc7c1706431685b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-20 (Sun, 20 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix expected status for invalid key entries

Kernel commit 1e9683c9b6ca ("Bluetooth: MGMT: Ignore keys being loaded
with invalid type") made Load Link Keys and Load Long Term Keys skip
entries with an invalid address type or initiator value instead of
rejecting the whole command with Invalid Parameters.

Update "Load Link Keys - Invalid Parameters 3" and "Load Long Term Keys
- Invalid Parameters 2 and 3" to expect success.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: d9993216e9e0b3576eab2c119d8126e6008f44e4
      https://github.com/bluez/bluez/commit/d9993216e9e0b3576eab2c119d8126e6008f44e4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-20 (Sun, 20 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: mark Pair Device - Power off 1 as fail_tolerant

The pending Pair Device command is completed by whichever path wins
the race against HCIDEVDOWN: if it is still queued when the controller
is closed, __mgmt_power_off() responds with Not Powered; if the
connection failure callbacks run first, pairing_complete_cb() responds
with Disconnected.

Both are valid outcomes, so mark the test fail_tolerant, as done for
Get Conn Info - Power off

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 4ecbe91214e452c2e132a7953058e08934d19572
      https://github.com/bluez/bluez/commit/4ecbe91214e452c2e132a7953058e08934d19572
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-20 (Sun, 20 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Report unexpected status as test failure

command_generic_callback() used tester_test_abort() when the command
status differed from the expected one, making the test result in
"Not Run" and hiding real failures from the summary. Treat such status
mismatches as a test failure, warning with both statuses. Mismatches
tolerated through fail_tolerant are unaffected.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 24a2c70dcbbb4202d654574aaa2f7c84b341fb29
      https://github.com/bluez/bluez/commit/24a2c70dcbbb4202d654574aaa2f7c84b341fb29
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-20 (Sun, 20 Sep 2026)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: Count setup failures as test failures

A test whose setup stage fails ends up as "Not Run", without counting as
a failure.

Make them count as TEST_RESULT_FAILED. Setup failures are real failures,
and should not be considered same as skipped tests.

Intentional skips through tester_pre_setup_abort() still report "Not
Run".

Assisted-by: opencode:qwen3.8-flash-next


Compare: https://github.com/bluez/bluez/compare/9a560bf5f3f6%5E...24a2c70dcbbb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
