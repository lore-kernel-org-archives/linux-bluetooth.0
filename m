Received: from o5.sgmail.github.com (o5.sgmail.github.com [192.254.113.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218832549B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822770; cv=none; b=sSm+0mWh1GjzZ33XkkLW3GZJGRQR43/ZAW3qBwMMpXZvWVTs9z5KFMyf6Z2uHXTv59w5Ipf3hj0H8i3iJekEbbJcM9Q6FLBu/YsuktImjIixSAaUjlPrU4QdWnW4a9QLLnvwuXtoU9jgS5iU4/jlpJulrtPrf/I4bbjgcFOdkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822770; c=relaxed/simple;
	bh=SP73Hse/2I0wO0v4eMt+r5w2lmQoxSlbbsY7VTRxYaI=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=p+gQIJcxQgsVRMcZ9ekSO8cw8ZxedEeo9haOFjDmmul+qyxQng4CpBzasIizTDTldfeI4SrCrog2nsBi4GMFJfGOvTCo0MJf86HI5nHcj/WaqdvzW8fYe2aoL2TwzxDwLFCC2NSKBRkMLfZXWpnfLoQo/Mq/pou23AFguGbzlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hpkTC5aV; arc=none smtp.client-ip=192.254.113.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hpkTC5aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=6MiiCzylc5CrURVGyP7oo8b0WaGgJIleNAG1Ryu6msk=;
	b=hpkTC5aVAimD1u5VLsTTQVKxYWvNWAblsPN+gdKqEsNxA+f9hJ/xd/Kg8uzkBBo5H02s
	Ag8uwhKX5BYzI1wVwwmSIeLxPmhmnceFXM0BSefF3kJ19108VmG5JM2l4dZuBgQny2WEVv
	Uz+EalOUb52ghI7FGkpAiclR+c32oUJ4M=
Received: by recvd-88f758c66-jz5hk with SMTP id recvd-88f758c66-jz5hk-1-6940512F-54
	2025-12-15 18:19:27.674259586 +0000 UTC m=+2409381.077689338
Received: from out-20.smtp.github.com (unknown)
	by geopod-ismtpd-18 (SG)
	with ESMTP id NF5xHHPNR7WX4KMEujzsiA
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 18:19:27.640 +0000 (UTC)
Received: from github.com (hubbernetes-node-9a75562.va3-iad.github.net [10.48.179.49])
	by smtp.github.com (Postfix) with ESMTPA id 8355F3C1117
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 10:19:20 -0800 (PST)
Date: Mon, 15 Dec 2025 18:19:27 +0000 (UTC)
From: Arkadiusz Bokowy <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/2ec29c-ba4978@github.com>
Subject: [bluez/bluez] cc64a4: client/player: Fix QoS 32_2_1 in
 lc3_ucast_presets
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
 =?us-ascii?Q?Yk7hBnaT8ylbP+7jLMVNsrku1Mq=2FOteylRhk1hi?=
 =?us-ascii?Q?13kEzJ1OtHk1fEIq9HJg9jObgFuGh1hdrMcSswH?=
 =?us-ascii?Q?ATO=2FHb5svUpoMfUYfjz+uMnzIjaY+T6R9dtW=2FoV?=
 =?us-ascii?Q?mWuLNFUxwl6tiEJ1rlDAJKJK5wxHdSaozIacPPC?=
 =?us-ascii?Q?XYK2p4faKiyY62O7Cpv9EUDYJfMxaYwIwJGYLlc?= =?us-ascii?Q?brFQ?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: cc64a44d77e5df60f0ce5a13a2c8463960b0b027
      https://github.com/bluez/bluez/commit/cc64a44d77e5df60f0ce5a13a2c8463960b0b027
  Author: michael_kong <kx960506@163.com>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix QoS 32_2_1 in lc3_ucast_presets


  Commit: ba4978255c3cfb244a89782b30b115c2c9b58c81
      https://github.com/bluez/bluez/commit/ba4978255c3cfb244a89782b30b115c2c9b58c81
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


Compare: https://github.com/bluez/bluez/compare/2ec29cc98ad5...ba4978255c3c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
