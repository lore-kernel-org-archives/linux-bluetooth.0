Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC054657D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054986; cv=none; b=FTgIfefu/FttJCJtQCUyQ9LkhLcUEOCe5EvtWhaISOxB1qYDQVuGzhTtb3RJXZ7mGlwoJJwRBDZ9qrt2wVuOQIeH+XxaK9tc6fQR34Z3MKKLHb5IMcWDNJmCp+jNeg/H5wZyNg/THo+JsroR8CeKzB1Ep7sj3P38a2a/2X6gwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054986; c=relaxed/simple;
	bh=FTkjliXrELN+bA/GU8muW89JQ2UAPTgO6Mz4deWTIrE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fcpusmYunaiWUSmgitsWqnwGTqTl83Rz06HfxrF5hkIpyc8vtPrOA4zcEktxm1qo/nY+6qb7NjccxifkJiTSh494sGPJpbHZ2Falh/YsT3gLdQehs+C8PEj6oXhQOUQz5bhIxsthikVoewKqz5X94INWi59A0UqQugpgbBxT39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bFJP54d7; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bFJP54d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789054984;
	bh=/RREA60Ydhc9J1UH1/1A+y8fbaSaW57qCxjFbiHczkc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bFJP54d7jUUBXClJPjJTGVvH6wd15h2GNigeqstcllR6Nt+OSHfgP54cXcqRCGmxg
	 JQXD6YI705vuelA8dFIODetNcHb39QNLGlDmjjEUHAEjKiyCNUbQLmjd6VMuB62tno
	 xRB57UcBHMrYGFMz2H/oPxvzKpj90ZAYCg+N4iq0=
Received: from github.com (hubbernetes-node-6b2b666.va3-iad.github.net [10.48.77.76])
	by smtp.github.com (Postfix) with ESMTPA id 8097E1801B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:43:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:43:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/8ef6a7-171e7d@github.com>
Subject: [bluez/action-ci] 171e7d: cleanup_pr: tell submitters to resend the
 change t...
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
  Commit: 171e7d99f66b8120ef4b1f7e7e50b8849cb4ebef
      https://github.com/bluez/action-ci/commit/171e7d99f66b8120ef4b1f7e7e50b8849cb4ebef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py

  Log Message:
  -----------
  cleanup_pr: tell submitters to resend the change to the mailing list

Both the closing comment on the pull request and the archive notification
email now state that, if the change should still be considered, it must be
resent as a patch to the Linux Bluetooth mailing list.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
