Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36F28C5CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364547; cv=none; b=kqBP4whMljtJloUifZgnlCnWyLpcDIcEWx0pxJwWP9AxKlNBXOlhg3OhhOTdNlOs9aoIlzNFx3u3AGrTFIyippEXz3xVUEVstiRVJSTDM15YFySoh2rOOL+RGtjZNtogdYjPnJJ1mPRsNZsSeIuBAO3xvAGDrWBxb1xsl/XGM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364547; c=relaxed/simple;
	bh=nIaK9x+5ud4EP26vdxtJeaOkokH2zDabHDv5gPjWSnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KPYC9THjW8+xqu44eMfLaFbAl6ObVfYWKUzjPam3OKDBC1tPfRwwzgnlzkZApA9y+bAupUkbvgR1AiMDlL/YEJwFfm4HJutz3yvk8Bo46uIhPaqFSMi3drKWqAiu+Msr2NEPyYdQyzKGta9WV4MaREgS25Bgvkj4jCsW/DvYjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lss8HHJP; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lss8HHJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779364545;
	bh=hgz4oKhuZpJS4Sr5EFtKLBmFBIgGW5G2HSySezasf1Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lss8HHJPjyJUytOFf1++9l3EXXF4RP8cK8x8DEA5TZvSD5/5NIspEWQAsaoM9bdkK
	 y25psAH1Dvs1iPC3Sr3HD77dC5acPvijPD6o+Mjov8l/L2505jfZuhZ6qc6QCx1E9s
	 LVtoXUIdsgtwyZOHdum2TdsTvDdi9h7HHyZHG6ic=
Received: from github.com (hubbernetes-node-dd7806c.ash1-iad.github.net [10.56.226.41])
	by smtp.github.com (Postfix) with ESMTPA id 1862C361269
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:55:45 -0700 (PDT)
Date: Thu, 21 May 2026 04:55:45 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098678/000000-53ac4e@github.com>
Subject: [bluez/bluez] 53ac4e: shared/rap: Add client ranging registration and
 no...
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

  Branch: refs/heads/1098678
  Home:   https://github.com/bluez/bluez
  Commit: 53ac4ed034f11324a3d7c6f4daaa2f72e46e3fe5
      https://github.com/bluez/bluez/commit/53ac4ed034f11324a3d7c6f4daaa2f72e46e3fe5
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add client ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.

Changes in v2:
Removed unneccsary DBG logs and unused variables.
Use helper functions for readablitiy and code indentation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
