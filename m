Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283936196E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952602; cv=none; b=HLoTvsTyjNj/gkEH4ZJRgqj3VGlQG/aT2CjkTYdm6ERZ3XjPFAumV4ZJOhfquCeQS1oIGlD3TQNGhHdPSpEoZUh8v257p3g2+zUPkP7QPsAm7CYtb9dVVpztdAVwCRoVHG1MbCt/427VCf7iv0/w/Kn8kyyKiomP6rvKv4gq1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952602; c=relaxed/simple;
	bh=kIpJQvO1c4slEYdGqPPd+9KpY0LRAXB17RMwKxi+Cxc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oXzn4YPgS1OsspJK/PEIR01Lu4OKAcxfBLS4/9Hi0v1p1yHaMr8mMrm3k4c/QeQDEzy2NoxKdFVlS5lYN0HVgpGHvmkv+iNwn8p6gYpKMySAGDF3WV1/3TvqDR1LR1hhqKbOVyy9vOJy9rSxBLCVy/8klzfkYxpKx7vgQz3z0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NVIBKT0B; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NVIBKT0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787952599;
	bh=wS1MKd7JRi5iTH1QgE1hk26TQ5eFR/6qyutbpKgGyi8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NVIBKT0BIrSa+m1CBNNJ1DO25VJ9nleEP57sstOWhWceHo0lIfKORA4YSprbEeaxk
	 UNsMFE8FonIe0z1D2wTmBeA0m4jswRH1bCZ6UpZufqju8RgdN2JFHnaT5aNk2+WqAF
	 zzeG4xhf/dYzHH2sDxJRTWc7tjk/RngWaBr9kYu4=
Received: from github.com (hubbernetes-node-b990268.va3-iad.github.net [10.48.147.15])
	by smtp.github.com (Postfix) with ESMTPA id 1300850072A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 14:29:59 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:29:59 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/49592c-e81413@github.com>
Subject: [bluez/bluez] 79918b: SECURITY: Add top-level security doc
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
  Commit: 79918b87dccdb804c1fe338fe8fdfcb77a0e8293
      https://github.com/bluez/bluez/commit/79918b87dccdb804c1fe338fe8fdfcb77a0e8293
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

  Changed paths:
    M Makefile.am
    M README
    A SECURITY.md

  Log Message:
  -----------
  SECURITY: Add top-level security doc

This will replace the existing documentation written 5 years ago to take
into account the new tools and the new rules around dealing with
security issues.

The new workflow replaces email-based reporting with the GitHub security
advisory tools, explains the CVE ID assignment process, and places strict
limits on the amount of work that can be demanded from BlueZ developers.

It is customary in 2026 to have a top-level SECURITY.md file which
explains the vulnerability workflow.


  Commit: e8141342284be2a52e16565b96b513ebe1297d84
      https://github.com/bluez/bluez/commit/e8141342284be2a52e16565b96b513ebe1297d84
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

  Changed paths:
    R doc/security-bugs.rst

  Log Message:
  -----------
  doc: Remove obsolete security-bugs.rst


Compare: https://github.com/bluez/bluez/compare/49592cbc1416...e8141342284b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
