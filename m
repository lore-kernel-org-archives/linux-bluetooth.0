Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7023AE9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438919; cv=none; b=c28a25Blsw7xqa/oy++0xB9MwtKVEo/CSaAZ6BIq2M5KYPFJRTObcyOglOGemSJMBf7nzSgOxWthIE3btxFxK4JdBcSCxYN/5FtDmAFmgpDgX4voRnaqWTB/gDn0lnrtxFdMqolY99TcXK7suc1pMSp3K0OIyWmcI67FNZemCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438919; c=relaxed/simple;
	bh=KG5Ph7iYfO1CwIILz1fvMOiCK8t0Txd6ERdyZKC7K40=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H1QzZ4yH5ZwDSK1hBvLZEMJScPMiOUa/w2RN0xpK4LMKLx74GZ99S/QJ0VDcJ9Yh9JW0WMN/Q8SW8QuqMPAYZKSNnOUx3FcW9j6V/Bu9e7XcNYHTJmwaYK0e4wD8WwEvA/FJ07K7O6d3jQenSBp+r1e+Hr9HXc6E5s9vXcJLfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cCLq7VOY; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cCLq7VOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438917;
	bh=eJBWd2NXpH2z1JbA5uWPdz30gtu2bOHRxySw0fUhLro=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cCLq7VOYX2NLNFLBmm/HgINjhV/q2Wu7ICKqnwwYLM8zPuJRTdtxNPQCwkNS3Goqo
	 ih6o/YDt5MtruNadGFTRxs5oaaMDSnivXw8HaU0F9fPT4FzOYPv+E2AfLuSLN0SoxT
	 P59+QIEVcS8WPtgHi2k8qovWjeo6k8U4iKMEzbq8=
Received: from github.com (hubbernetes-node-8a0e00f.ac4-iad.github.net [10.52.205.53])
	by smtp.github.com (Postfix) with ESMTPA id 7FADF78050C
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:37 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:37 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111255/000000-062379@github.com>
Subject: [bluez/bluez] 9a87a6: shared/bap: Initialize ucast/bcast IDs as unset
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

  Branch: refs/heads/1111255
  Home:   https://github.com/bluez/bluez
  Commit: 9a87a631641c71b07e2c56a71c5ec144c5a01d17
      https://github.com/bluez/bluez/commit/9a87a631641c71b07e2c56a71c5ec144c5a01d17
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Initialize ucast/bcast IDs as unset

Also change some lines where CIS should be used instead of CIG


  Commit: 06237947f55082754809d11340a6639c87a2e295
      https://github.com/bluez/bluez/commit/06237947f55082754809d11340a6639c87a2e295
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't link server ucast streams before CIS IDs are assigned

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C


Compare: https://github.com/bluez/bluez/compare/9a87a631641c%5E...06237947f550

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
