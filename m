Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59765338F35
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626643; cv=none; b=Hm0jFhhWdrLj61DU5Jq/gO8bEii73f8NlouOO+33OTdpW0KbKemXqNdzzWngMLXKe1L/0Dh8jtediewdlFSnTRL8hYjvMXldSN2aa1vaFIu0/XlAGWXpA1iq2vFlcBDckH6vVBTmC4cGHVY2yqJVmOuHqfMgznwG34xCFDbMxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626643; c=relaxed/simple;
	bh=P1kBeAMY6ZQGK5cw+I9uuXdSzFQ24t+1NxCAjzy/Qgk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N4omg95OMl61aH95C/aLt/PetU5BjcY/XH8/bKF+Zr7xac10+oK/3xyLK+vgSvm1nGyr97HePcgxq+aGCk/VGWTtHKAcbNEi+NYGJzm55Dzweqe+LUJCvvPLbAECmGSwXnzi92pi27JJWBOwCTQrf3uf1YthsckCQX+Jv8mYfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MB0Yu1Kp; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MB0Yu1Kp"
Received: from github.com (hubbernetes-node-107305c.ash1-iad.github.net [10.56.203.111])
	by smtp.github.com (Postfix) with ESMTPA id 6E291920791
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767626639;
	bh=3szXJjA04GXwm8Ia/aF4IKUvi83+ZSeIdVgmoVxGPs8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MB0Yu1KpVvElJ0biWi+JFaQV7IQlvp8x5Zq7nqoCxiLnQDxk9R5Ua1xBAXKtLMReE
	 ZmUNWweZZPKsjA2x8V3qduHrlGUeTymRby1LNJsciO5NPgbDR9OGPRi62f0EH4Z1Ri
	 1E8IYu8BWyk+AZrtiJKM4Mz+vRIVQrSg4wQHauY8=
Date: Mon, 05 Jan 2026 07:23:59 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038129/f9f412-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1038129
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
