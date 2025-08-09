Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F911F237A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754762376; cv=none; b=gmeFttPCTMfkvcO75TGNDDym0RH9OKj2e9V043lVMZxZh1UxsfN/Een9NJb+00ReHWXOyCsUwWD+3bCtoKK3uy3jf1vrYZKoGe24MWAAu88iW4AixhmwDpXutwlgbSjmxoo4T0MD6bX1w823g2qQ/9abp8vlBKgUKO+4CM4c8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754762376; c=relaxed/simple;
	bh=IsXrdIFSbuJ66R0WzS8yQssLJRj5XfhdT1ClDy2WtD4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q3YVfbKU6LZ7BEcw44AMUH+Vnk536RTxnehIqMfv42WIcL0oOozD3qeUxET8etQfoce+qRnivlljEuV8TCn4u8IBXyNJkovedVnLK2p6HNoLNvlwQQzeq6L0r6jZNUHezq7BMuADJEQES1nyN/xQzv0INDzzwqGtFIpj1aLZNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e79eJ2L2; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e79eJ2L2"
Received: from github.com (hubbernetes-node-6e2ddfe.ash1-iad.github.net [10.56.166.38])
	by smtp.github.com (Postfix) with ESMTPA id 128F960028F
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754762374;
	bh=MvLgBc6m4JGiTNdVG+Onck4kN98MOLCNoeeRDx1KIN8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e79eJ2L2WL6AwGstB+5VilFnt5hXwzBvu13V4L6MoqRVCu/ife86eJXEYNYqPcyun
	 C4jIlORPiWMv6/1TeS8yveuIVJX4ISoGmaHYRLyoO4QqlwMsGdbRoP5AxpzlAxu4jI
	 T711W+pZEHGnsSbUAz5eM0rdXZx0b88y75P9iqbU=
Date: Sat, 09 Aug 2025 10:59:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981156/1501a1-000000@github.com>
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

  Branch: refs/heads/981156
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
