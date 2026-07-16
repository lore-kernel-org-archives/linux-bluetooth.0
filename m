Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F222EA154
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202984; cv=none; b=G2XEXakx4foKrmgP7VE7itrp32yOPWhJ6Og78a/br6s+FnoUWb9v5rjs1dJzwHg0UmCzEwUijgqGwOT/2aw43hz1FVjcfMsuXIn8b4/nCFBaQkVVVvBRg3nLhvSyRC/EHV6+GrGOhl/eUn1rhBVe1JLjC/jJMrZZI7xYpGlZO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202984; c=relaxed/simple;
	bh=H5Tsn8okOF4W8C2tpZrQEFzIcNL3kxoOtkq2C0qea84=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lxknkVW+/flzIlk5VfYOAZMB8d3pTO/PlAgGWMOteUhmcoUD0Hp1DmBN5pLa44rpVgRNPlw9Md/iHjrj26zrcI+MPCXXxdlVhtXgZ10li9MjULmV8WbSxRJjW+fs1v+gPhOP34urljpDcMyLhdwoG9xEdGdnxFPD6+Ljy5NUYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mBy9smkX; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mBy9smkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784202982;
	bh=O90bssXhYHrDEhrbLSevkkRjUzvEcfg5BkRDR8LCXO8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mBy9smkXwZ7aFYLBGkqkTVjzS+wcu1hU7kzfofxD9eHLtKdv3oMfftRfiiMbP+Wzp
	 Lf19tbQhF81RJhhnvywvbm1RGbJ0lijKEUiwM9z3wGqWOuPVeJedrjIo/EMWd2XzSa
	 mczgwXtIRWwF7uzXXik4IsIjF/F8TrkRa43UsmyY=
Received: from github.com (hubbernetes-node-4cadc65.ac4-iad.github.net [10.52.205.31])
	by smtp.github.com (Postfix) with ESMTPA id 19B09940FBC
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 04:56:22 -0700 (PDT)
Date: Thu, 16 Jul 2026 04:56:22 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128757/000000-7c2359@github.com>
Subject: [bluez/bluez] 7c2359: policy: Connect profiles for bonded inbound ACL
 co...
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

  Branch: refs/heads/1128757
  Home:   https://github.com/bluez/bluez
  Commit: 7c23595c90dacdee6fdb74e8b8f286e48c8a9968
      https://github.com/bluez/bluez/commit/7c23595c90dacdee6fdb74e8b8f286e48c8a9968
  Author: Chengyi Zhao <zhaochengyi@uniontech.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

  Changed paths:
    M plugins/policy.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  policy: Connect profiles for bonded inbound ACL connections

When a bonded device initiates an inbound ACL connection (e.g. after
resume, the remote wins the page race), BlueZ accepts the ACL link
but does not establish AVDTP/AVCTP profiles. The remote's subsequent
L2CAP connect for PSM 25 fails with "security block" because the link
is not yet encrypted, and the kernel does not retry. The ACL link
stays up with no audio.

Add btd_connect_cb callback infrastructure to the adapter core
mirroring the existing btd_disconnect_cb pattern, invoked from
connected_callback so it only fires on new MGMT_EV_DEVICE_CONNECTED
events. Register a callback in the policy plugin that starts a
2-second grace timer for bonded BR/EDR connections. If an audio
profile connects naturally within the window the timer is cancelled;
otherwise btd_device_connect_services is called as a fallback, but
only if no audio profile is connected yet. The grace timer is also
cancelled on disconnect to avoid racing with device removal.

Outbound L2CAP is queued by the kernel until encryption completes,
surviving the race. The fallback is safe when the host already won
since btd_device_connect_services returns -EBUSY if a connection is
already in progress.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
