Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170625E455
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746822741; cv=none; b=iNkimaFLaKozvEBo2IhqHH5EbgoWQgMnMnehxZmNCvJsdtFq3CWu2gQY0e8mCmxzWmU9i+DVqLYtKYQehUzPcYW3dlXdEJCTLecoWg8LtINJcNsPIYyf/JbddZNAo078R/cfX5DCXXLNvbqciFFg6kTEzCKV7pMCDQuEmqNrj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746822741; c=relaxed/simple;
	bh=JxbFJLOfSNIyPmqcnlLjpiO9e88l0uUjXwYugxiJk5E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BQjlE4Rq/ctsH5b+BL1op4qZOGt/l8iJDUbuwHWje2fBvjHT14wBxZu5E1EbppJVIf6Exp4RF4zTYzdoqmL6nDn43r2UHjmo4cWArD+sZjp2ixOw/ZPNqTMueNenNqlABW4hJTbjNkJ9yk6ltIWQc9/I8m/aaJIvCx24MF1TxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=If/CDF0M; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="If/CDF0M"
Received: from github.com (hubbernetes-node-e259917.va3-iad.github.net [10.48.154.33])
	by smtp.github.com (Postfix) with ESMTPA id B01374E0B3A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746822738;
	bh=2xapmojcNTo7xqnXHvuk8b7+U+guEPZ0l4kmq6L4WXU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=If/CDF0MUXh+hYPtgJPY9nbqMeOL6atAx0+MGz/RrMCCowVThSds76k6Qb5Iu967d
	 Ymgw/k85or61PXaI3REN3I8ghntcz7UDgxpXGTO/eOKQRoZRkd9/YDT0O2G3mq93CG
	 5a13NK1Sh6QAcLsLcr1ITEfPEcJzvSyZLaN+Tdco=
Date: Fri, 09 May 2025 13:32:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961526/000000-c87831@github.com>
Subject: [bluez/bluez] c87831: mesh: Fix possible null pointer deference
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

  Branch: refs/heads/961526
  Home:   https://github.com/bluez/bluez
  Commit: c87831872d566586e0e5708aeec96c4a1d599063
      https://github.com/bluez/bluez/commit/c87831872d566586e0e5708aeec96c4a1d599063
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-09 (Fri, 09 May 2025)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Fix possible null pointer deference

This fixes possible null pointer deference for label reported by
cppcheck.

Fixes: https://github.com/bluez/bluez/security/code-scanning/1771



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
