Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4862E0916
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936374; cv=none; b=ljJw04F+aJ0xkztGmj852R6NRPjODe2ZR8XUJVRR4HcfKfbD9fZhJUwMXmxGY8cApxxEzEgGHNZpOKTZRTOGRmmCSyV+CtJGlgtOFRlqw7/cS7erLD1L89/07UsBXpJ+jgcQdtU/cWMHsLlFGSnFZ0D6qGo9Q+G0QBw2YBRohMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936374; c=relaxed/simple;
	bh=pOe6I2oNZlXWXXCDFAMRSUNGk3WziPUoQHVV5MiE5IU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZbjC/pJtNc/smiPSt4mAY/xgw8aXazs4ovfpceQbZRtfZ79AGWtN8EES0S2dhaUmcDOiF6yry6/zNQkaIxEhumcCy+e1MWDfDUpX+O2suc5BUUOIlc9/g5cZORU7oOrzRxqeVWwM3ZIX93ITdfa5mJBeCdfC7lWlsv7C6L37uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dPSsgJzp; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dPSsgJzp"
Received: from github.com (hubbernetes-node-2beff56.va3-iad.github.net [10.48.204.72])
	by smtp.github.com (Postfix) with ESMTPA id EB9F84E029D
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769936373;
	bh=cX0bSyfAompA9TbFA+LyC+lShv+yX/wz8P+sRrTXcdA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dPSsgJzp0JrzrS+fQ8JMCKM9o0EPDRK4Le9nrDllov38rjcvQ7LXrZRr25nGJ0D1x
	 sS/IOluT08KOLv9TX0UZ3bnFtUYWHD5og8Y9t1DHjWiyMAM6Lr7Seh8DmQ3cT1Ma9O
	 79xpE05DnXGgOY1oUnIIZ9eot1fr4a+CmIKXQER8=
Date: Sun, 01 Feb 2026 00:59:32 -0800
From: Roushan Kumar Singh <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049427/000000-304d78@github.com>
Subject: [bluez/bluez] 304d78: Add Null Pointer Checks
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

  Branch: refs/heads/1049427
  Home:   https://github.com/bluez/bluez
  Commit: 304d782da464178045be086368eee625499473b0
      https://github.com/bluez/bluez/commit/304d782da464178045be086368eee625499473b0
  Author: Roushan Kumar Singh <github.rtron18@gmail.com>
  Date:   2026-02-01 (Sun, 01 Feb 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  Add Null Pointer Checks



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
