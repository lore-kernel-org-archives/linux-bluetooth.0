Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86A3DEFF6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648703; cv=none; b=XkVzBg5oWxEdgISZBSN4q6mrlrinIpyr+c7KrW+SD77LfPYI6zRriG6/jW1QzTHzm39G8wN6im5TGDUbc8h3exK+uJ6pyIjWyFPUko6MmQpc8gOFBilZTt8dr+MqSLeEnWukO/+UO1uK36sZAOA+wSVgYt0dgVc0NuteKhWaAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648703; c=relaxed/simple;
	bh=qn/WmnpRX9YM6C6DyedVBTSn9NV69JaIz250YFbi8YQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WFR4MHNOPXodgg6ldPK1LNf9CSt5FSvTE2PdCAVuL05DM2sftF2LzJNRBTy+tz6boHjhdT25g2AZbB4GKT7AZscPUFCivBy0myaoFLz7ZEBkM3Ve2tNR69QhMpFANRu3AoJMXTRTNfj6O5k8D6Jud8TclqwJXlIdORy9cpms2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G6VuEyat; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G6VuEyat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787648700;
	bh=No06EW2CmDDpq63L2/otrEpTTGOItdjYO9pBDuK6wEM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G6VuEyatMBRoG6ZgbIw2p1JW8bWsaK6E4umcZYT2XWdODvJPTClp/CIS9JULBCjDf
	 c2uYOKy7ZCjfTCin/YI5HagzguGi8GtmqJwR+0l6ashjmWB5kphPsdj0Nar5Kj/Ny5
	 YsvIdPeSlFxb2x9RoazmkxTRIysw+z0gLWn4EGco=
Received: from github.com (hubbernetes-node-2903d7d.ash1-iad.github.net [10.56.164.28])
	by smtp.github.com (Postfix) with ESMTPA id 71D4F8413FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 02:05:00 -0700 (PDT)
Date: Tue, 25 Aug 2026 02:05:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1151364/000000-b41833@github.com>
Subject: [bluez/bluez] 74f4a4: SECURITY: Add top-level security doc
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

  Branch: refs/heads/1151364
  Home:   https://github.com/bluez/bluez
  Commit: 74f4a487bb84466497a9af5bd9ffea88e17849a1
      https://github.com/bluez/bluez/commit/74f4a487bb84466497a9af5bd9ffea88e17849a1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-25 (Tue, 25 Aug 2026)

  Changed paths:
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


  Commit: b41833b0570acc3a59e5fe885898d30b281ae181
      https://github.com/bluez/bluez/commit/b41833b0570acc3a59e5fe885898d30b281ae181
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-25 (Tue, 25 Aug 2026)

  Changed paths:
    R doc/security-bugs.rst

  Log Message:
  -----------
  doc: Remove obsolete security-bugs.rst


Compare: https://github.com/bluez/bluez/compare/74f4a487bb84%5E...b41833b0570a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
