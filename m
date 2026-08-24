Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CF382299
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605286; cv=none; b=aLzFZ5AM2BF/3lTsVz8ADnWbcPpDDFnvoLTC5Lr4AuxKf+ONaaS9sUOihPPQ9IJPNent6G5DvWfYeV75cFtZI1+7kAVAM3TZOl1OzT2ixRXRKVHbrNSH2YD/OR4n449l6pWGKcaQfiYW6PP7hYWu4YZ9NZGzKTPQSzYvxcBihtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605286; c=relaxed/simple;
	bh=sk1GFxyNvaT9Xn1l+3cKio0SLbAiBlTF8FRYO5ywvC0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j6OWpPU04IMbYPCOp31FFWhjoydfTnfzvwD/HQki2J1frvZxoQBakzPdGLgiwNBSzY8yNBJkpHPKKQlA/hVh0hkoQ58lbZwNeXaxX5FTEaT8OIf/5lswA/L4L5V+BNX6kGnMEeeTJdKOw9aw1hmMIpl4/KFbpkj3y1bmhjZXr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IO8XBa0a; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IO8XBa0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787605284;
	bh=pHPY9prlHp4gKpVz4OqDDbmpKPEz21zFD+dhR9S1Q4o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IO8XBa0aS99qhaIXW08h8Jm48vHjwXLny9K4K4SfkLhl08QTA4QvnDj2IcZpjACp2
	 v5jys7p+lBupn4jJ5/XhVou47LqTrC5iO4erE4V4g0Q7503zUWclpQSjiNClCAjw+T
	 6IBDZUB0ASQoPQyw8XM90UYKs/9B4NrC43ohyXYY=
Received: from github.com (hubbernetes-node-a30ee59.ash1-iad.github.net [10.56.165.34])
	by smtp.github.com (Postfix) with ESMTPA id 44F20181473
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:01:24 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:01:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134469/68cf12-000000@github.com>
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

  Branch: refs/heads/1134469
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
