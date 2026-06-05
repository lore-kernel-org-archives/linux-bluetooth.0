Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E233859CF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680636; cv=none; b=Q2AUBdF0BOWBaqBkws1CrNl4VzbxHW1XfpDZgHFVZoYhGRGacBFDjZPmpEYCdOY7AEs5QBtRGdg83bF1JfJ1ACW7S5fvBI3STzoCHUirowR9fzY7F/HMGA2NG6xA+vNmJOdHZH3gZT9TWu9mANUsQq9pa/05CdNpAQzBa3BqVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680636; c=relaxed/simple;
	bh=UrCZa0e6lHDMrByIDEA5++AIMem9KNsjlleRj7117eU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sI2GZBdS9WnNBzUeewf1DGd1fvdjhnGadkTpD8+CEMOrzzJcL4S3HEG+JsJJ5PfoTM4ikerLtE90Z3jKrf1LMtg/7SyOXrfVj8uhoz/fqc4NSST9EUEX3k49ynA5bNEdLsCK2AZ7RKMczFSs8opDQTZE9bqiacnO7wpd/gotIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kyZDzB0M; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kyZDzB0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780680631;
	bh=dMGbACSFYEYNRyLZGoZLN/I+XVmUQkVqgXAE/ZZYuv8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kyZDzB0MCXjUfgcsSffL8QKJFjCy6uRy+MQi48nr2V2seCfh8Tg5DwdtK6uVxjRqU
	 LYbN4ULtuFtK5hSS5TIQj1x7Qx08rCnDbmTEVcp8ccjriIuZfkl0oXsHrVIrq9jKQL
	 f6LPrc/uP6bFUmxlze1/pv2uzNxVuog4HM2/e6DU=
Received: from github.com (hubbernetes-node-991b743.va3-iad.github.net [10.48.125.52])
	by smtp.github.com (Postfix) with ESMTPA id 8CE6B341068
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 10:30:31 -0700 (PDT)
Date: Fri, 05 Jun 2026 10:30:31 -0700
From: shengzhiyuan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/42b2c5-7a0c8e@github.com>
Subject: [bluez/bluez] 80e9eb: test-mesh-crypto: Fix retval for skipped test
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
  Commit: 80e9eb51c4c9f60316c189f3498b137bfbbee7d3
      https://github.com/bluez/bluez/commit/80e9eb51c4c9f60316c189f3498b137bfbbee7d3
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


  Commit: 7a0c8ebf91e69c3b2d2d48f8f4b0074fddde1fa4
      https://github.com/bluez/bluez/commit/7a0c8ebf91e69c3b2d2d48f8f4b0074fddde1fa4
  Author: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>
  Date:   2026-06-05 (Fri, 05 Jun 2026)

  Changed paths:
    M obexd/plugins/pbap.c
    M obexd/plugins/phonebook-ebook.c

  Log Message:
  -----------
  obexd: fix PBAP PullPhoneBook failure with ebook backend

phonebook_pull() in phonebook-ebook.c does not set *err = 0 on the
success path, unlike phonebook-tracker.c and phonebook-dummy.c. The
caller vobject_pull_open() in pbap.c declares 'ret' without
initialization and passes &ret to phonebook_pull(), so 'ret' retains
an indeterminate stack value when the ebook backend is in use. The
subsequent 'if (ret < 0)' check then incorrectly triggers and rejects
the request with Internal Server Error.

Fix this by setting *err = 0 on success in phonebook-ebook.c, and
initialize 'ret' to 0 in vobject_pull_open() as a defensive measure
to guard against any backend that omits this assignment.


Compare: https://github.com/bluez/bluez/compare/42b2c543a70c...7a0c8ebf91e6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
