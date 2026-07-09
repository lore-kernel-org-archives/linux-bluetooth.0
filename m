Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7AE383C84
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614654; cv=none; b=ScycSZNqtOhLkb9U0wv7r7ImoKjYcJzWUsgKm3kNkStB2JnaNvbcFeCBOxJd0YvndGfo0kLZwjy5OY9S+T/H96L4HBlzE1M9SB6dKoAkJXr3QyW1DqDUC2iVJn8ChNtzrLihguZnilvK0D46FphXh+YXypF+k1GZtWajxUhc4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614654; c=relaxed/simple;
	bh=+FPdsFlvliEK9wNgLWifoPVdYLCqhXHHMlYYJdKt9tI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l9W6NI0/xcd8uhx9xFfEBFOuvOBrxm1Zxm85jA6f3TWD66WnZw73AM7IkeAJRTnJjNdwBz69P091dnUXL3MagAZD3WvUtIWCwhmVfXQ7fPLgm/4L46/4xBHDjKP04a1hO1D0SHC7yjXv058zDYYF7FBK3TCpo1Ya7TOEBAq04M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jWU12e1B; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jWU12e1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783614649;
	bh=w+IcyztQSxvrjDQ/UD7NPK1jAckhhuABTW6wcTGCcb0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jWU12e1BSOCgOmytKAQsd6oyeKw4itTYgtz6HjJPH6fC26xVxFcXTbEjDBQ05y7rE
	 fvCgMKjRbVK1oM+JAeD/G/XJSCEMpmTHtRDktSIJuWzUqJWhnXWmsomZedseuUruGg
	 SrK/gcjnpUGIMJF7DmOc/H1ZnAbGegR4MW1WGXHk=
Received: from github.com (hubbernetes-node-4ff56b7.ash1-iad.github.net [10.56.207.21])
	by smtp.github.com (Postfix) with ESMTPA id 48630369C23
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:30:49 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:30:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1124682/48278c-000000@github.com>
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

  Branch: refs/heads/1124682
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
