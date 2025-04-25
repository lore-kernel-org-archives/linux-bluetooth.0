Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86621CC6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608254; cv=none; b=QpWo4OVY59Us5DGccI+MNYIzTkTtqa4Eyey2sYNS9PdibevK4GrkDEr2Mx+zrA39DBL4703gyYpCHAb6Mt1pQADZrKGTWH4TM1C96EVBTvufHEBkK19JaelJIExIRSIKcAF+rELNjZBm3dWifYH9mdCKpM5gQo17PrYsjUMLBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608254; c=relaxed/simple;
	bh=DHOT/Skxw+LVjGS7y18LDnDUry6hZScsgLc1sgvnr98=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rCnSRYvaP3vSwMYvOfIPw5e4H5B4T59oG6oDzIKH71Xr3X7V/kWrp9Bm7ONyaZ5YHmXYWkFwIUY9j0JT53YyI3Qo1Vm8ATCFumXHlsATu8EE4It6pZRWfkUiORm9pRoldxVJ4SC37lmh4wvgju81uZa/y0YSBy1VoGJExg+55P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Knj4+HUl; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Knj4+HUl"
Received: from github.com (hubbernetes-node-ea73e02.va3-iad.github.net [10.48.151.34])
	by smtp.github.com (Postfix) with ESMTPA id 3E0628C06E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745608252;
	bh=lNPgs19MfF5/+UByE9Vjy+wyaT7hUFnOxdg3ET2SBg0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Knj4+HUl3vGZBQeCIPj9GTsLR5021/dBRYHqIe7Dz550apXx3lgrUSryJrpfepaQu
	 cv5tMLQxmqmW4kYe4Jja5j6GXf0FAdBUQA1LCeFGGXwyXGRipOnv80ZEGYLa8c3Bje
	 ZFMY6+XeeK+a0pZmgQWKZmD9Esv6bhcnKEFAcEMY=
Date: Fri, 25 Apr 2025 12:10:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957057/592727-000000@github.com>
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

  Branch: refs/heads/957057
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
