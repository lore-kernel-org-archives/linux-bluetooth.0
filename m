Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AF21ABBF
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432396; cv=none; b=AWacGE6M6MJogHBycCYkWD5qtWeg2uCKJQWDkeNQwLzqnj1ca7k3i5lt/LUu39VyMLgZ8r29ApmY6i1vNaXZMEmw9NksaTyQQHGbpp6tSHiGNMsszCcHSpkPEUUIYzQQiCv9YXQMxaddy4Sl4NwXA+SsT5ARdU0suQKojcTjols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432396; c=relaxed/simple;
	bh=qiO52vzdh06BamAU54st0Cuyvn+aAInk1RtjUyTnUtc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BpPUp9Ttj16NtalEKB6iPHEYV9b47bmIfu0VdWU9pYM9snPHg6yIvWqyXMdhh5UnG/BZOS2nTwu1IDZ9+G4pJ54k1tM7Pxx3LveNh963yUVr1Voe1kcW0N3HfkO/WJ2O/2NdYGrk9mr7xbBIHO/YbEVFLCEaNsWgXsCRW8GAAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hVBXvruD; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hVBXvruD"
Received: from github.com (hubbernetes-node-4ecc2e5.va3-iad.github.net [10.48.162.10])
	by smtp.github.com (Postfix) with ESMTPA id 79D6E8C09CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747432394;
	bh=A0gvbZnkRytyWVwPFborGg5zQa7Bo+2r24GQcqYX3JA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hVBXvruDMScLT0aY6uWser0cpQeG65eo/TVFoN9ntllJyUmGg+MEXEe0S/97LFYko
	 KZ2OgXMyXMxWGfKj112S0NPDHTHP5zEdYY0tmU7HuhN5s/J5bDKK2r119jPt+xLBY2
	 YvqrHptAIRmiBHGIP6HcoV4A1FBHZv7wQu1xvJVM=
Date: Fri, 16 May 2025 14:53:14 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/05f8bd-cdcdfb@github.com>
Subject: [bluez/bluez] cdcdfb: a2dp: Fix not destroying streams when
 unregistering
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
  Commit: cdcdfb4843b485e08f6a1460b5a03a3420453a51
      https://github.com/bluez/bluez/commit/cdcdfb4843b485e08f6a1460b5a03a3420453a51
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix not destroying streams when unregistering

When a2dp_unregister_sep it must destroy the stream queue before freeing
the a2dp_sep otherwise it will cause memory leaks.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
