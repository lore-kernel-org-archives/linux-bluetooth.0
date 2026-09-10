Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51325486B91
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065873; cv=none; b=IxK3Wr+6rNVw1YWao1X7tQa23wNauCSsCVGnbmKvG+h+ZZ0t+QwbHrOHe2RV7bAcMXlLp7U4BLYrWk0zDR1ynYSn7Xrp+ICyHfCwOxsBSJ4vbAf5myEYJk5xx/cNvJ/kjmpvYWcAzAE/pzyvefrK5PI/3IJN3pvoixYtB2Hvfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065873; c=relaxed/simple;
	bh=NlSIu+bw/zlbqSAwzBb32Heej9D06GvwJdwR/vRJY+8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eaDrqsNTi3cyWsFjkJqpR6ysDTSMsrPOKeEXBZig8ReqpLRAXSN7WwXtQoChFu59v8nMhbxq6bEUCTyIQkwNMIBmtRj1iwD2nNlQvYtZCHOHTdsjkq3U2xN1d71pd0E3mPNS+ht2VOM+O3pCSnRZDqcBd9jvm6KHlksgeeWVNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QtaED5aR; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QtaED5aR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065871;
	bh=R8h/1/P+UUJvVwrDMGOehfpfnP/UGMlwXIFTd0PB9oI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QtaED5aRGQoLf9vQTl08IQgcOnO1Y7CKTWWnL7GoJCZo9EMAySIGhJYoj+m09gfJi
	 mfNJTvoau+j/dLcWexbR1bf5BmcgOe+duGwBwpqHjzUPsJYzwr7RvghjYv8Mi3X6vn
	 o/nusBHhZd0Kql8oYhuoDbEdceo4vJN5eY70OHeY=
Received: from github.com (hubbernetes-node-9334883.ash1-iad.github.net [10.59.91.28])
	by smtp.github.com (Postfix) with ESMTPA id 3167418133E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:31 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156272/bff1d0-000000@github.com>
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

  Branch: refs/heads/1156272
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
