Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FE24BD03
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042878; cv=none; b=aYSHx31HgFBTOcahROxAVzlYbJMEWeP4UhwlyBvQ+r11wIvSiXCQSJKA/4yzkHtmnVO3fCissJHM9cOzWJ5tacQtg4ArsK525rxdxnIZnMphgWGX+1IcaXaBgmYXsvsGjwoBsirHLWc1P1Kj5S+tYwFl5BugaGX7rkTpIdlR05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042878; c=relaxed/simple;
	bh=BKbnhPFfRJlxkZpwhW5qotzXxFZFFpDkHSkaWAfbkNY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q8LqKgNO81cX9b05UxPnrjYAAnREVEWCDiRZtnrBfznmteEoZCfW0WrEMqcPeqthw6PMMfCH9YkDR1tLFIp+0AZDB5PJG9jwNJo0UXwE+eyCbHRIahFaUa0unTeZjhHbUKB/8CBzZHKwQOSiE/nkfYHR9esly4a8drhisDNmZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RSZCDArT; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RSZCDArT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042876;
	bh=tKo1AyV+ICEKsDB85BwalS4yIeNm6MEvdLPpB2rES8E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RSZCDArTYeBniuWg0exQQdJQ3q4PQviBEQmpp9ktnMA9ZLWqUFv1SFt0mA32l8Vfp
	 BdeP/yrEO/vZliM+g4BdS1W4WPMJMCVIDcDjyzfXpJfWHxGypuJmnlikIbr36y38LL
	 OcvNJCay783ak9GM5uyrmSInvx8QR/dl1o4zD4tM=
Received: from github.com (hubbernetes-node-4e2a151.ac4-iad.github.net [10.55.93.36])
	by smtp.github.com (Postfix) with ESMTPA id DD963780AA2
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:07:56 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:07:56 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108825/000000-0aee36@github.com>
Subject: [bluez/bluez] 0aee36: shared/bap: Transition ASE to QoS Configured on
 CI...
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

  Branch: refs/heads/1108825
  Home:   https://github.com/bluez/bluez
  Commit: 0aee365bc6f29c2b2625b8ec057de32f1bbe2420
      https://github.com/bluez/bluez/commit/0aee365bc6f29c2b2625b8ec057de32f1bbe2420
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Transition ASE to QoS Configured on CIS loss

stream_io_disconnected() only handled the Releasing state, leaving
Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
unexpectedly. The ASE shall autonomously move to QoS Configured on loss
of the CIS and notify the peer; add that transition.

Fixes PTS test BAP/USR/SCC/BV-167-C



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
