Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7B346AC4
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777944; cv=none; b=nD/jowvxCXY1IvMaEQFsCc9APEpUFmPUybxo7CDayFZ6FDRPsfCrbdCPe0C0uDMmj4oWnDgSX8BxMadStoZYEUpITda6Wt3zOGFxxxApUPaVkPjCi9QRf6Pzo2SXNBptpmRujWssILJvxQbQNDCglg2UdYo25yYDVI347Fptsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777944; c=relaxed/simple;
	bh=I6L+o0gDeJHSnio+g8nnRYtytym22mpQZfHIhNSqvIE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jq6k/yXZhuzZ3vc9WArskH15/mugZOKrnk0MDSHgqUxS5BIgDjbfpITVEC+t6oFDT0m9SyH5+N8N5are4oJNiBEBH/3pO2g4HSoUOACnVQZJbmNFOWi6VSpLpqYv5IakHIC8NzpKWzYaAysgHbUqOU9rL1zKF/028v2P2EV/xtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LReZrdOb; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LReZrdOb"
Received: from github.com (hubbernetes-node-3727ac4.ac4-iad.github.net [10.52.182.48])
	by smtp.github.com (Postfix) with ESMTPA id 72E527011C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773777942;
	bh=zh2C+law8+84sY02gqCkhQWJYL6sSggr9ardE3SdNk8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LReZrdObRJ4inAezfiqEYuEsN3Hm7E7KTfA+N194Fbf8BbztP0o344GtYaEuOSqwI
	 qf15ITtAeilEnIUPp1O6vlP026vbgjBTzXCLQ2hrCNwQtXME9CSf5WbtmuK1VAiBk9
	 BE5l0fjnD1qljbX3El+4EDjmCWj5Rhs1yldtflFc=
Date: Tue, 17 Mar 2026 13:05:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1064985/8e04c2-000000@github.com>
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

  Branch: refs/heads/1064985
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
