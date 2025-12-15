Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAB33A6F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808046; cv=none; b=tN4KfUZO1kT1ojvGcdciHAgRu4KUimwRthy93S2WdF4mtJFx2Z27crYi7h4tZfsg48jwKKo/Jll3YYyIEGrEztQIEfnsI8o8RHP6g+Vr/sPWcXPb+PNvLvv34ejx3L7qWOnu+p0qdeg+2x+IkBnVPvGMwISVlKhjehMBd3lSgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808046; c=relaxed/simple;
	bh=hLnsFrUXIecPdM+Ks2o7HKEe78khi2z0AQX5ZmnoG5k=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=k2EiamnYVUeYm6t+21zLGVWUQQN7w1vvUWSdsUhi4pVtZqhR/ye5bsrJuCZEA3Hqz0Q0DFvsWrlQT07LNhsclCwii60/azXcUf5HTrNEEgtUh4NAfF+vkbu3z6dpPJI+ja8MFh+hihd7HxP4F3WgmLUsXZ78waV6zXpb0NIddY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DcMZNy1T; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DcMZNy1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=bO7a+2gC/Dq4luZ7FTlvwDMxCFrMa4RMwgtwPKPqNVw=;
	b=DcMZNy1TJs6YeI/AUeIrzyGytzcGhcI7RVwxa7Dv90fj1ql1fb0mj1ae5cZ9CVT7GnSz
	gR+IcnCV0IarA03StVgR/fPOxyNWic+4FDH7bQKr6hX96Hg8vx29u1U1ixa7rlvEAB5/Mj
	IvVbTp6Jsz/IRGOmEL+bptfB9+AGlkOfw=
Received: by recvd-6476b67d56-qbq2q with SMTP id recvd-6476b67d56-qbq2q-1-694017AB-86
	2025-12-15 14:14:03.780767432 +0000 UTC m=+2395535.102821883
Received: from out-26.smtp.github.com (unknown)
	by geopod-ismtpd-65 (SG)
	with ESMTP id smeJSEUNTZeGl2n-9rrOMw
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 14:14:03.743 +0000 (UTC)
Received: from github.com (hubbernetes-node-756baa6.ash1-iad.github.net [10.56.203.102])
	by smtp.github.com (Postfix) with ESMTPA id E37516008A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 06:13:56 -0800 (PST)
Date: Mon, 15 Dec 2025 14:14:03 +0000 (UTC)
From: Arkadiusz Bokowy <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1033273/000000-cf6d79@github.com>
Subject: [bluez/bluez] cf6d79: client/player: Refcount registered endpoints
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2ELO+ikaWOpEJip0eb74Fuh4r3BVdAQak9xTBNPV6J60QSHxMhjmDWKIjet?=
 =?us-ascii?Q?Yk7hBnaT8ylbP+7jLMVNsrku1Mq=2FFVPTHCQqQaD?=
 =?us-ascii?Q?wMBgGUSdNugkFI3AhM9pr9Ou2KX45y9KqiLPBUs?=
 =?us-ascii?Q?YziVj8xYsVN0e=2FlxOvLUCVZd4ouKPr6GPpLWU54?=
 =?us-ascii?Q?+g5p6444brKcJStEgBrZdWCqxRWLx+SV+eDlSuT?=
 =?us-ascii?Q?INz4OjLbSfZdGCOzSeGmxZLRjDsyAz4LlCWRuqP?= =?us-ascii?Q?y17+?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1033273
  Home:   https://github.com/bluez/bluez
  Commit: cf6d7967eecaf622ddf26a13e19532029f7f4cf3
      https://github.com/bluez/bluez/commit/cf6d7967eecaf622ddf26a13e19532029f7f4cf3
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Refcount registered endpoints

In case when more than one adapter is available on the host, the
endpoint is registered on all of these adapters. When unregistering
we need to keep track of registration count, otherwise we might free
the endpoint structure prematurely (on the first unregister reply)
which will cause SIGSEGV.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
