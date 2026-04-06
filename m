Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF81F5EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506088; cv=none; b=peyj+/Stw34lYnyo7WfV9u47HOaPkImCtSFaTRRVwFGV/fQN38kJfeUQEh74oGHg/jHxfrYZEQpFlyzo6/FZRVxoaaR74nmIYrQLn1dOB36013CcORwKZd/Kjqri77DJotUeiYqsVz922p1kfgpT+IozG1yUBs+Hg2M/Cw/q6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506088; c=relaxed/simple;
	bh=UZyZAX0mdGv/YWA2TUmj/zMXRBOrCop8CjoyHkWkUDI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AhfBDtF8vFh12CqtX3VQtiVrSmpSLeSpFy9ITdmmdr/x/yMj13/6WXqg39kdOxP7OvOnlghay87lAJuQkZTf7UjHmASqeKRgLdzjA9lO5HXZP+NZM2N1og8woxHzfhq5bJZwU7P/FK2GT+WsoXG3MJEbfgfywh1EIaQ+vDH936s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fc/MD8j9; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fc/MD8j9"
Received: from github.com (hubbernetes-node-6b8dd41.ac4-iad.github.net [10.52.184.45])
	by smtp.github.com (Postfix) with ESMTPA id B899530107A
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775506086;
	bh=3z8u0Doc5OstB/qo7EJCKxMAETNoPt+VcjCfYVooQ3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fc/MD8j9WFQb/n5z7FqHa6XM4nthlNAlHExSqySVtdrfuzAijteNPQdGMugnOw36m
	 4wvlEJYcgj+25E6ezjQ1joNZREqQl5UUlt55vFyC2VEb6raP/O2QCGM5bhziniLcCv
	 np8AmZIOUQB3jVT0i0sXJFiNci3InCcGyw3OHxxU=
Date: Mon, 06 Apr 2026 13:08:06 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077784/000000-7f24cd@github.com>
Subject: [bluez/bluez] 7f24cd: monitor: Fix not loading local GATT DB from
 cache
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

  Branch: refs/heads/1077784
  Home:   https://github.com/bluez/bluez
  Commit: 7f24cd6b2732404ee774381882b918cbe7cb7db6
      https://github.com/bluez/bluez/commit/7f24cd6b2732404ee774381882b918cbe7cb7db6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix not loading local GATT DB from cache

The local GATT DB maybe discover in previous connection and therefore
should be cached as well to be able to decode follow-up connections
where the discovery may not be visible.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
