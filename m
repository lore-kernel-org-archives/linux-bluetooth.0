Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786439EF01
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310090; cv=none; b=CMAuxFjtKiszq8i6yEuZVipopj68Ye1dLBJVCxH7QWB96GdvmSN99MCze4nwPCGpId4TRAqwxjtVzeCcnbar+zmNt3pxZ2G9krkF7FTHTzaSJN2FxU8ffOFraix4jrJ14HJYZTo3JXk9zgmC+bTHsM10t31d+Vu7PDjPafkkKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310090; c=relaxed/simple;
	bh=RDZDz9j9Vr8d66PL7uCSvFrPunGEy4bnsfKySPwRttQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V/JnlLR6WZkl8QzWt6v0WPTc9AVet/bqxtq1TPtZtJuFtRov/Rwl4QG8KWRQrszscPykuD+cqoVHyZlUTJBp5C7wc7L/TmvvHOTE5D+L1z4zmlHMCNlJgDndRoxWoGvrnwf468SPZP0MudkX9E/YX3z2bMr6FmgMBJuvF8+x9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fp9MG0C2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fp9MG0C2"
Received: from github.com (hubbernetes-node-118d706.ash1-iad.github.net [10.56.226.45])
	by smtp.github.com (Postfix) with ESMTPA id B61CD14128E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773310088;
	bh=9l5xvlSduXHF0pQ1fVeqNptN2KmeEL73JDm3lh7uA2Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fp9MG0C2LfhaWAroaBCx+QEmXcKG2kduwUYEF1M09zbl3RzfZL/QIM3xYibR3BYKU
	 CtINGnPQGy5VP5JtNwDv+iD73O31/LE3NPLoiIsshGTUyk1y8+UC4YdY+abNyepvcY
	 JTcibfOI+18Kn78sIxmjPF07CKyphhVOVUgKlAmE=
Date: Thu, 12 Mar 2026 03:08:08 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/826174/000000-994184@github.com>
Subject: [bluez/bluez] 994184: ] mesh-gatt: Fix JSON files missing from dist
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

  Branch: refs/heads/826174
  Home:   https://github.com/bluez/bluez
  Commit: 9941843db4c4185cc1c04dfd0de6935d7a0d22d4
      https://github.com/bluez/bluez/commit/9941843db4c4185cc1c04dfd0de6935d7a0d22d4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  ] mesh-gatt: Fix JSON files missing from dist

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
