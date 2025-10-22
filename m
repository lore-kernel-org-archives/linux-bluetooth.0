Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BF2773C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140810; cv=none; b=lV1xPLv5bMZ30Y00nW5TnZ1bglNH3C5yUB7FLudmsQk512FxXvoyQCpkQCWhjPOagypyzkSHObL9o0mKGQkbIire4UANNxNxQgOD9gw+hauTDnHiV0AnMbrZvrTavGlfKsGR1LMKieIRei12nUfiSLSSVRsqOHaQ4/Zoo0nwYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140810; c=relaxed/simple;
	bh=NOqRf7i8SKNzXFW4xuzYsYiLjgJNvTGuLXMAG6z6Xrg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h18TkO3+/PcMqwydNpwIjRDY7m/R1I3iIO8G7/XsGmkaPZwVlKkp+tE67QaVbSR+V/9103R8YRVQCAc0w45ccRyLn/OdrVx8u4BHR0dFd7eUM/Hd+7eTcbBNguSLWtC5KZ+iZdJZYMd7nH+QKqjNqJANVT07qbFUV0Q4GyaVPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QYR2nkQg; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QYR2nkQg"
Received: from github.com (hubbernetes-node-2e2a1fd.ac4-iad.github.net [10.52.149.42])
	by smtp.github.com (Postfix) with ESMTPA id 9AC45208E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761140806;
	bh=sCSadoNsx0TZfYjXJxNWVWAY5SRqSht8zxWMzp7ZlmI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QYR2nkQgIQYPgkBMpXXt/1t/+PyhafK8JiiKIpdcYrva7ujullijtrKRZiziY+VTY
	 rbiI9DkJ38Ad2+y2hFlkPYEI7diHoTTg52vN1iWaTNvWaMn19/+rkDRRNuB4uqkENO
	 CtjIsZTRRAb7JlpMQBdIHA0w71YJUKjmOtphzAUg=
Date: Wed, 22 Oct 2025 06:46:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014533/000000-106401@github.com>
Subject: [bluez/bluez] 106401: ioctl-tester: Fix handle value
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

  Branch: refs/heads/1014533
  Home:   https://github.com/bluez/bluez
  Commit: 106401a780f93874cc1e58ea4ceae04f387c441c
      https://github.com/bluez/bluez/commit/106401a780f93874cc1e58ea4ceae04f387c441c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-22 (Wed, 22 Oct 2025)

  Changed paths:
    M tools/ioctl-tester.c

  Log Message:
  -----------
  ioctl-tester: Fix handle value

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
