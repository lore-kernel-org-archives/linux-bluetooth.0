Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10E331222
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055978; cv=none; b=nn3o+eVCx6mBvkHnOCx6n5IKH9TnqyQGAgfxlnBtIjOXh3Alyf1JKQce8dn77GS1B+odmqGY4tJF6GYc4VfDYTvJZ5DJfzU5fewTzY2YyWrkP5NOHsoa8nvaU2ntn9t4avYb0VZyty3VmvQEKnScZKl72qX0iPYx0XpGTyVcvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055978; c=relaxed/simple;
	bh=W5C4FQaTNmHtypvf/HSRHA3ga0UYXIiFyR6EOLF8C5Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jimlsGo1LdUEl8zZ0SaZ3egzGyp18hNSriIvl2D9rjQIDKQfVVJcSbEwtZ+IQr2Ot1HtC/qA4CHYYSVq8jLXNFqACx8V7ZwYMGRWli0FkNVUSbLZ1kT/Yy/7OGV+7+Rhb98WKJnKI+TITcwg058uE5E3ntWMHt4ahi1bcvACqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m6iZVGqP; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m6iZVGqP"
Received: from github.com (hubbernetes-node-d1a1c43.ash1-iad.github.net [10.56.131.30])
	by smtp.github.com (Postfix) with ESMTPA id 83E57C1D9F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775055976;
	bh=n4HYcpVN3OnF3Deho/tfY81q4/q1E5g+4QWRf9CZShE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m6iZVGqPM1llnCBBQktziuxpeHTzXh+l2UN5oGv0EJX//nIE6q80/+OVRYLBGGrLs
	 8rlS8gJODVn0elJQYpoAVkrChztCstVtuQSf2/Usd1ttqWiRo1NW4muoUMeyQ1mWuJ
	 lMpBpiIEfJBerbzgFSYsCOFtBJKy8uga6swQ6iXo=
Date: Wed, 01 Apr 2026 08:06:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075447/c446bf-000000@github.com>
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

  Branch: refs/heads/1075447
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
