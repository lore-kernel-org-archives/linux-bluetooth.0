Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD73A6B6F
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030096; cv=none; b=Q5iliHhXod9HVPGGoNXjjcBGm4mDfUtVZCvnrGeJXdjkdW9XMkPYzC9NH2799VkaDxSZQ4szF6ED/Li5Nt9Rv7KP/d+rUUdPRIUwruwxwKbd82LyoQ/Ne0vZHQ6yZ3yVVv8OrpjVBCaLyl9tErSDupGgYMbXfuB9r8OuVSywj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030096; c=relaxed/simple;
	bh=9b1ruxgh7qDcsct169lziwfMLzfpjzNi6cuZ3ZLP8j0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I/0zDR0TbbH9XLFmIEEkxe52+Mn6kmx3H6N+pjUNpx6HYKP2NjXKkQQTVDqZnaBO2fXitnQYVuNNfIMwymnFx3aGaY4kYDpPlhZEE6mJvf6bQUmMYcOBaMXK5TRmT/vrTAxuYmX48wY/dedwn+12VvsQTkrB0TAJ+tdEFz1JXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DrYk1g6e; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DrYk1g6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786030094;
	bh=GnTGBpwZumkwCKv7U42wpX1sKZL7/xwmcuF4nfhscc0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DrYk1g6et5Wf0muo2PcmGK2PREwQMGGT/5O4L0A0rggIbabeTlT5uJ1m8B74ikFUz
	 FMlQyIFuAHAQWuRxo5z1v9d0o8Hn9sqLpVnzM+S2eOj8hRE6h3WCTHE0VElVaxyFzO
	 4CO3oVGWL0Lnpr2fXndg33INkaY14YpyrdpudcOU=
Received: from github.com (hubbernetes-node-edd395b.ash1-iad.github.net [10.56.80.32])
	by smtp.github.com (Postfix) with ESMTPA id 98A6E921DFC
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 08:28:14 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:28:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140181/7cfdc4-000000@github.com>
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

  Branch: refs/heads/1140181
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
