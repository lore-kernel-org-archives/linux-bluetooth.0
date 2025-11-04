Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455B32E73A
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268233; cv=none; b=G0TquPa6uOlVYUTtUCJztbeEHcNjVqMf+ev5815uBg28d5c3TCRNgHK4S4j1uCBC1W/ghBz1VKOJ4qAv2yMfCANqU+soxP++ITI5ZWsq85eVtWlTudjtPRQqCruMyy09sQfpTgVk/0xzHvTkm5VIPMD/2JWRUH0C2duAI2G2gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268233; c=relaxed/simple;
	bh=+cjgmcr/OEiSXErBOwU//3O2LbaH/taTQWJgIDSmluM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HanCJPtcQlulVAQ1eVz4C2pGEBuMKQ+RCLmKLWskSQQUjA+X8brdiGmqLsmVTNa0NXwNV8vY0g6YRjzhUGw7BRFXn6lmM/8GiI+3H3wPdQowyN7j6QO718+RhPUURJxffsCMtN4E4sBq7XA6wL096k+LIKFPH0gCnrDSub5Kyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YmpYtqJM; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YmpYtqJM"
Received: from github.com (hubbernetes-node-7e9c2b2.ac4-iad.github.net [10.52.211.53])
	by smtp.github.com (Postfix) with ESMTPA id C821C401395
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762268230;
	bh=nP/iSyVQqQOsleG/KXbTBRTrZd6oHB6d+6fQBhFYD74=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YmpYtqJMfQ9HR1ZjJgOHn6R9KIgqOfAHV2fgyAM+oO+BtrIfQLKutftguqxmUGIoo
	 jPzXZxNHPMftuqabVupRo0G0zxayhRchITFUhVlzfzja4aES3ZjeZJKA9jPMDk0o+/
	 o50/i8ukD7kzr+SWqjlR0hr5BWDhn7KKPCs5Nhew=
Date: Tue, 04 Nov 2025 06:57:10 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019334/b64ffc-000000@github.com>
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

  Branch: refs/heads/1019334
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
