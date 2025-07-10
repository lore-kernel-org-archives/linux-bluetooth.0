Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36E2F0E50
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182322; cv=none; b=Xl9wr3UIUh4FQY0XPiWgLibGirzUziZO9OP1USUHdp1heQgb2y6pS1f7js6LgMPxSWNHozPrVWj86LYJrbw1xdXqoOC7sN+HKTs60736kxbzuKRV2WISkmnWXCJKOPmWDQBGVz+itvYFHsmR7kyGPgaVuQ8W/gTOhTzndEbGFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182322; c=relaxed/simple;
	bh=U6WeoZg2vMGUJf80BOmRaXtQ7JWHMxOmPAREMbFqYyU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MyLZ9AUvo5wxqXMxoIYd5nEwoqP+9UUH6MgBwvpsMlWN9K/fnijoxZK/V8waaUm2Iy7+pMWzSyOOy8vCUb+e0xLLuJ3i6Wv5kTQ+x5fo1rYAV1VcvkneCRSS/xk3A9TntM+5b+D3g3u8ahF/ricra+DKawhTbTcAWlM25HmSq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xw4iqHH5; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xw4iqHH5"
Received: from github.com (hubbernetes-node-c7b99b0.ac4-iad.github.net [10.52.183.47])
	by smtp.github.com (Postfix) with ESMTPA id D7B266408ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752182319;
	bh=KL1KjHn97PxrodJVhkRKZGMNJ0Fj4QxOfErH0YVlkO0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xw4iqHH5ySNntpP0yPP9etEjaf/SEb+zgcRAZM1KUQwB4oazLmVjmLauj1fBKuOGd
	 qJ6risCdvSDxn3dM4ef8UKqVo6fnZwAaWnPwPyHmIVpIvrbZRdBsWZO7prWD20+YPu
	 uJOeZZhDnW8teQ+7/xbzTN8YnLXg7vKphIFRmJWM=
Date: Thu, 10 Jul 2025 14:18:39 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/47a4c7-806dd7@github.com>
Subject: [bluez/bluez] 806dd7: build: Fix typo in configure option help string
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 806dd732fcda584fa6c44322a74373d2b739c781
      https://github.com/bluez/bluez/commit/806dd732fcda584fa6c44322a74373d2b739c781
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Fix typo in configure option help string



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
