Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D6264A74
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789004; cv=none; b=Y0912/zCcvKuU55husQWflXezUdHBjsbr4Yc+9U3v+T8bw1miY+fqqYkmgcpYjAN9emaicIjqom5T3SgqqWi58IyNg7xKALU3FxvssukpsEHwv1aCWijYGA0rnD9QLaZSve6HVF+3Vr4LfRS8mCmtOV9kFv79aSEHubhHMpfEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789004; c=relaxed/simple;
	bh=S9RqXFRcV0QK4V+jCTIZwgz96lhVctSbgl5lWrfKBBE=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=k1/K7YGHpH/3PIf+1Ivz7yKfNmhvAyyuCSyQ/lkGyL9CF0UPzacmBV9rjok3S67NDTUepQxpyw18ePjOS4AX6j5YbU/ELQIuKbSVfqcQIoeTYKqcISsc+9/fBgOUH7TQNFshI4VZuwiuCS0RsgfmKx3rj9tWcn5mTEVlEKNCXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jCN8mFrm; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jCN8mFrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=y49SLQt7RXrXOphcq56kEs3ZlNpwYtBX0JzalW3cRNA=;
	b=jCN8mFrmOWTo1tYZayBOihNEAhChdJzRTKm0W4B5Mm/Gu4AuIVZQ6bggpf8wpPMz5Qcw
	Ln7bRGZnIbQYIDor6pYUXte6s8FnUvIJXNTUcs13A84eS+gDYNHlkQXPwIUY9mfrT09mTe
	Ss83RHfMK1zY42zvoYthCZl/6PLnPvfA4=
Received: by recvd-d89877956-n7p2g with SMTP id recvd-d89877956-n7p2g-1-693FCD49-79
	2025-12-15 08:56:41.808312288 +0000 UTC m=+2375103.059259126
Received: from out-17.smtp.github.com (unknown)
	by geopod-ismtpd-44 (SG)
	with ESMTP id gsPzfoblRcGpoAUtPtco3w
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 08:56:41.762 +0000 (UTC)
Received: from github.com (hubbernetes-node-c927bd0.va3-iad.github.net [10.48.173.39])
	by smtp.github.com (Postfix) with ESMTPA id 1B3114E0B42
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 00:56:35 -0800 (PST)
Date: Mon, 15 Dec 2025 08:56:41 +0000 (UTC)
From: michael kong <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1033107/000000-8f3f8b@github.com>
Subject: [bluez/bluez] 8f3f8b: client/palyer: Fix QoS 32_2_1 in
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
 =?us-ascii?Q?u001=2E7DP9+jHbJwUHEnmaJzlq5XyhFOW0wLmaf9jpel9rrsG7fJ6VMsVFEoeHC?=
 =?us-ascii?Q?FuS=2FY1SASRoU6gykB9Fdmia5xTf1FNeR4NOtgYL?=
 =?us-ascii?Q?wAuLgXOZjPm+xZjZyph7xESm4HZLdn=2FlhR=2FcpOk?=
 =?us-ascii?Q?9YMIB9YQ4CrbVgKv9AuszL8yZ7EMTJSTiLwaNPM?=
 =?us-ascii?Q?OeJHnh=2FjTjmt9a6js+myIR=2FpYQH4MsaPkJKb=2FgD?=
 =?us-ascii?Q?tjvxN=2Ft3beYsPAyBYTFJiDzITBcDoNlsGNGx7KA?=
 =?us-ascii?Q?=2FIdO?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1033107
  Home:   https://github.com/bluez/bluez
  Commit: 8f3f8bb3bab31dba401cbc1b66737d83788cb2ce
      https://github.com/bluez/bluez/commit/8f3f8bb3bab31dba401cbc1b66737d83788cb2ce
  Author: michael_kong <kx960506@163.com>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/palyer: Fix QoS 32_2_1 in lc3_ucast_presets



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
