Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B953C944A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045137; cv=none; b=hPpt19wJ/doSuRUTTF1QygzYwReP9nRulgiSJsuQ37KPVsFLv2kP7lEVwcUNjzjz77fp74F0wdS694I6Cqviv9zfAPy16WRigebSkGj10GV8GWXdfzV3ge3x0GNdR2xtGeKMRQ2w9NHit7NHVkGpZK7GgxIDMtBwQ2AX9rM5TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045137; c=relaxed/simple;
	bh=VMQkeNOVYGLyIb9Qm0MheBYVz81uPz1ZWwgSFQ4kAto=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=occdbE+taGqhE2jQA6+Mej7NLqvIlFyt55yxTq259kntT3DvTXxu1wSKFMSVC00vLcgY1kqZ+eCJ9o44zZI7OTGFk4Ivt1bjuBnVr00ZpvuhV/6bIiP0yeUKVJyp1eBIqux1vQyqueENV/W20a8L5uYp6a9zVABnjLOOwL35H/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HOWh+WFx; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HOWh+WFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777045135;
	bh=32aOz+AOY/KmT2ZzZGNwbl77R61ys6XtOjhucpqndTg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HOWh+WFxhVmnEIWGjtO/i+XSbe6kHdcrZdnGVKfWS01XdBedMOkrrRpi+J46S+OLA
	 n2PwdlmxqsCr0ExvXO8gnXZKCb0m4U+SiPROmnAfGpo/zCsSkF6Ispl1n2wpzny1kR
	 pkknid64yiqBmHffYbmI9xom9nELj7bCpDoVaTdw=
Received: from github.com (hubbernetes-node-a1ae01e.ac4-iad.github.net [10.52.207.59])
	by smtp.github.com (Postfix) with ESMTPA id 5F93B941092
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 08:38:55 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:38:55 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085227/000000-713b66@github.com>
Subject: [bluez/bluez] 3464e8: client: add public-broadcast advertising
 command
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

  Branch: refs/heads/1085227
  Home:   https://github.com/bluez/bluez
  Commit: 3464e8c6114561c15efd0b2938662a3d4025f7ed
      https://github.com/bluez/bluez/commit/3464e8c6114561c15efd0b2938662a3d4025f7ed
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add public-broadcast advertising command


  Commit: 713b66d6075ddb8ff8adaca90276b3058803fffb
      https://github.com/bluez/bluez/commit/713b66d6075ddb8ff8adaca90276b3058803fffb
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client: make advertise.name use public broadcast name


Compare: https://github.com/bluez/bluez/compare/3464e8c61145%5E...713b66d6075d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
