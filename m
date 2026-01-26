Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0D2DC35C
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465988; cv=none; b=rWi+DSIBhzwAPeEd4N8q5F/je2mk0QFOWkDE9Z/RuiKoDsj/yZZl4ysd+/ZtE3mEVCxqFhOqv52PSbk7ADDcnEhSBy89P8xiwyn/GHJs1f99YcAqwJx5cQCeInmo2pnyufJG/Le8Pdmz5JK/XnENNWnP0FVC0fRmDylRZNdRzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465988; c=relaxed/simple;
	bh=1huek5YrSrX74g3LE8mMKhDac22A+SyLRtd1c69Sk04=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FkzyCE6vUQur+Y4n2lq0MADqO8lDiT5u9nAN/c8JiYXezfdHxQ9VZfXQLVng3Am3ypdm141hh/M54GX3DnWY5kEJW4UDvj2HNV/fnxbg3OxyEn1PrEZeQ8sdjXOrYY2Bc9l7TYUSZaKPln70cPk8FqLcy2RymiKuXaRDOwgHcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kqWeNlkM; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kqWeNlkM"
Received: from github.com (hubbernetes-node-fd612dd.ash1-iad.github.net [10.56.155.23])
	by smtp.github.com (Postfix) with ESMTPA id ED30214125A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769465987;
	bh=DQyxZSYvEl7m7jaPlDHac4g2KRWRhG++R3mNio3psBw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kqWeNlkM7QmKduExnpwNf5OoPMX1QXQji0mA2oMPViN6PVbNknJiSCCvYQ6lib795
	 lVVEg5zbju64zFYbjNJRElXv23Tb1dLAPtJ3uWySV2W+RTACamdaw8bRZIp1YZ4KfM
	 2zDN8zp8Rk4aNGfQlOXkIlfkNTumWXDega5Nflak=
Date: Mon, 26 Jan 2026 14:19:46 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046203/3283ef-000000@github.com>
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

  Branch: refs/heads/1046203
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
