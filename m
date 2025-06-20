Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB5277CBD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432761; cv=none; b=FFMWnghxkC5rGxGvNypY8m1EnDsL+YoKUHaNPeoUXmY5+e/+v7gxdH/Bg2s1EMLL5qQpV7SILZ57jNd+lwebrFqV7kkXbjQbOP9UeqHEyqFQyvTTqrjEJ5A9w6vpRWhUNHcRXu2HxduBvbIwM69bFoe1FDZGw859tbYWKPbiEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432761; c=relaxed/simple;
	bh=2nN6A4YBOA7ADL5U2joald9dsd/3oAMbXnoXDIYV38M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XQGz9oRen3Iw7oI+hVLQzO+Bw7C+v/MuxIHeON13aS5tVAuBLFo7278Qt1JL9nak91OV6YSnoaNK/+TrgI4LwEs7D8LmPjGASnGCzxAxdvdGjoQtchp4oZHrB8aIeGH3Ek0fGB19sjuCQnK77xOieRkPMRsyPY+kCYrbmNGnCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BfxgPiXA; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BfxgPiXA"
Received: from github.com (hubbernetes-node-35bff26.ac4-iad.github.net [10.52.223.63])
	by smtp.github.com (Postfix) with ESMTPA id D9A3A7012F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750432758;
	bh=M9jckJPoNvZUuwJmpFvnQz65e7e/Gf09culvb6jvamg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BfxgPiXA18pp2i8BySYkGKPB2CKpv/BoFm8iBbwBm6VAKUDm9V76TcX6VfRzZKSGi
	 2xiKmb6O8DNOxMgMd1WFfU+PcW1fQcS5ZY3487Sd0C93AFSSqU4r7o8soJ3WVQAx54
	 YLqg1qSUwXg76FPWf0w6SzuWpgI088AbZnx1LmvU=
Date: Fri, 20 Jun 2025 08:19:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974291/b53127-000000@github.com>
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

  Branch: refs/heads/974291
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
