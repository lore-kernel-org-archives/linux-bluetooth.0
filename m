Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFE3D9695
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654291; cv=none; b=pNQY40KBXMomb5Y6aVwdKdtGTKRdYEM13M9wNbU5xtW7bT4kOY9mDOVvAFOFhvFKggH/1m6xQZgfhmxqTZgB1eJ6eJr8r1X2WObaVUxbKkRn1IYDY+SaAqlWs+vUxpoVSKpM9CoVbm32pV4B8tDsNSRfUPM09rDFG40tYzBXs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654291; c=relaxed/simple;
	bh=dJImpBT27IQM1CcKyPwfIIqn+RQDAdyYGtcEYPbSjk8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gdqw/BWvnf5TjRsOcjRuKKb1QX6VMHet9bKsPvU2RX2t2xgxbQhV3Z9i36Z5Q694PbTekymzQhqPvppiSLVuNA/WHLixMjINN5jtPFZkXrAbrZFJ9w4SVDxg6PoawcCFgZ7jbatV9U9wI7JKJBVyl6Z2lSQqBXy3TTs1pPHTOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P2M4vFEd; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P2M4vFEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780654290;
	bh=tnACt+i/53ERE5gAchYALQH3fN/rYYpxGC/hLbYjLUs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P2M4vFEdpfbkMdUUaOkcoJ5SqqYpMhvCZbQzE0VUwHnTjCH+h/f9n9LLZvW7WxFJO
	 Rr10F5udKlpWdPHl2NucNdJ2VzleWIi1QEBDl7WE4l3xZ7RW65Km2949c5vfE1ml6a
	 tqjyYrYe4UN7xMCgxql69fpRl6xaibZimjncpAq0=
Received: from github.com (hubbernetes-node-a5c81b1.ac4-iad.github.net [10.52.148.34])
	by smtp.github.com (Postfix) with ESMTPA id 190D932132C
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 03:11:30 -0700 (PDT)
Date: Fri, 05 Jun 2026 03:11:30 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106487/000000-8650ce@github.com>
Subject: [bluez/bluez] 8650ce: test-mesh-crypto: Fix retval for skipped test
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

  Branch: refs/heads/1106487
  Home:   https://github.com/bluez/bluez
  Commit: 8650cea314a4b2414f639438d18989782d08e1b0
      https://github.com/bluez/bluez/commit/8650cea314a4b2414f639438d18989782d08e1b0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-05 (Fri, 05 Jun 2026)

  Changed paths:
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  test-mesh-crypto: Fix retval for skipped test

Skipped tests should return 77, so they will be marked as skipped in
reports:
  $ make check
  make --no-print-directory check-TESTS
  [...]
  PASS: unit/test-gatt
  SKIP: unit/test-mesh-crypto
  [...]
  ============================================================================
  Testsuite summary for bluez 5.86
  ============================================================================
  # TOTAL: 39
  # PASS:  38
  # SKIP:  1
  [...]
  ============================================================================



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
