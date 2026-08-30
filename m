Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA73191BD
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124562; cv=none; b=ZK3cVaPYwBYI5hvBjM4Gc3zrtrq4XRxZKyxpm7awiKqEFOj4MJyyt0oMQAtBVpW3Y/UjowSMfsJEYa6Llop8JO3Ft7WNTjAuo+xpgO86cZEyLPZAwo03BeAAJJcHJNp3v+mTZ2/ehTa/dnOaAMWJiSWsk+no3cL0HZyzMeRZOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124562; c=relaxed/simple;
	bh=2VE2c27MTfwbm4/XCqCISPaOVqxHVIlPBk5JfnEo1gc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C8u+BQ4SOyZlH4uplP1BZ/xaGhT3i7DonuVIBr6n0Yhl2OdzwTEFczz8Aha7HRiA4a/y59wl4uCPJW3/0+vPPx5CIugV9qIAORifhLBvKe86Ac+pX7zCgjYobHyOwvthE+7w5sJcH6jAlXJN491fXtOZdPT/P1ZtkotOjuJbPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=adz8SgQj; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="adz8SgQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788124560;
	bh=YJR9H8YAXxklaQgRP10bxbpwSEmFHRJgciEfLQ4UkU8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=adz8SgQjsP82lir8f40Q9c4seifhY4MSLaf3n/QIN/EWe/zNenypHLRRSi9kqDiWL
	 Yv5+acyyPTqMwVmdfDVGufEjqxtJSTh+jJr2oSCTxYa4kUKk6iZj3oGc+BCNLXwaF0
	 lEb91m0GEY1mGYTb+MpdHSvjhcneX5RLA+36assc=
Received: from github.com (hubbernetes-node-0d55a1f.ash1-iad.github.net [10.56.201.107])
	by smtp.github.com (Postfix) with ESMTPA id 5E41818027E
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 14:16:00 -0700 (PDT)
Date: Sun, 30 Aug 2026 14:16:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153956/6f01a4-000000@github.com>
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

  Branch: refs/heads/1153956
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
