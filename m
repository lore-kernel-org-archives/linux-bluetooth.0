Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8538AC99
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714162; cv=none; b=KSR3QA21kEAUxSg9oPzlIhtOaiPr56gCe0OwOqFRpNdB9kYKLPpgrUCVAGb3Q7O7nE+5HSRSvyE19ZV/C+R6NmJiYUTzoRlSef02+tIJx/yU1pE68e8znOtgCjcvmlinhA2FvSMU7s16yfu7+7u6teMWlroSpLavhgOkjnN4LV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714162; c=relaxed/simple;
	bh=dT14reQ/V7cPngi+uq+KmTYTukBvuf7b6Z8WN4MYq0s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kOU7x7Phs8JWhqgfckGIXypiboYXDrxGK1ytM2lsYTF9K9x2KqW3v3yr8EPXRCtfNx53nu6dB3VD1U1SegsCI4wCm1+hiD8SDusGSh46W2lzrLD56ppj/Z9X6Gtw4IsjKd/n80z3kFmXAAh2OKjPXSiFmbmr19jI12NT31xK9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J8MmUQ1+; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J8MmUQ1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783714160;
	bh=o2r3zq2RZhgJ6T+QYj03kKCzwY2tCUp6bLguaJyCxug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J8MmUQ1+5aRM1BiDwoiTb1ycowNjKfLVSmAGqIdfPhc8UORXGE1tFgVKzFjx47jLB
	 tp8658l9rUWPlgHthqmTTzc+KPdwZlOoHO75JokwvzLzMWdBoH37vCl6uMJrYVakIh
	 z8jT5CfCraqadFtHSf26/ofcPgJZKD0JcWYN5mKE=
Received: from github.com (hubbernetes-node-c7cff31.ash1-iad.github.net [10.56.212.81])
	by smtp.github.com (Postfix) with ESMTPA id 178659210C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 13:09:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:09:20 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125561/000000-343365@github.com>
Subject: [bluez/bluez] 343365: monitor: Fix printing subpages bits after all
 subp...
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

  Branch: refs/heads/1125561
  Home:   https://github.com/bluez/bluez
  Commit: 343365925e013850ef33ddba1c5240de21f806ff
      https://github.com/bluez/bluez/commit/343365925e013850ef33ddba1c5240de21f806ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix printing subpages bits after all subpages

This fixes printing the decoded subpage bitfields after all subpages
rather then after the subpage itself:

before:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
        Features[1/1][8]:
        00 00 00 00 00 00 00 00                          ........
        Features[1/2][8]:
        00 00 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)

after:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
