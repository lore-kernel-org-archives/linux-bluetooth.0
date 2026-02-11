Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D81E9B35
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794461; cv=none; b=bt7f7P24YTUdIQHrGxRv00KWRYhff+blObrYLNaSQd+clxuBMxnA8vAi2R00ugRgZHdUSux0csrVwqrXPfX1OnlxUiiPwT/ZHjuMr1KMUH/LkJV5e+yoSEloUD94z3WP/FnkgdIBWRabwVUUxKfc6UuRc7fbvjA0+P7vgw2u04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794461; c=relaxed/simple;
	bh=gSpYfZqqFoCAJyKDDLD67T6rR8J44/S9QYR/YFrJ0Xo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Pa15fWbxkASOyomvxGqyRwwg/FKxYAEw+e9Pfz9bffXhuwYhLJIKb6T40DEBRZl07vuxThP6+hJcPtD0fBc1o4vxUomV0gNR8yTq6kV13Yr3M4lmFBkaGYJfYI/9Et7x0mgTiK3DfauFwJfYiXIoHefHCSSDT1PizMEmG3cwpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jbra1JFv; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jbra1JFv"
Received: from github.com (hubbernetes-node-deebeef.ash1-iad.github.net [10.56.157.36])
	by smtp.github.com (Postfix) with ESMTPA id 019F39211A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 23:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770794460;
	bh=Sm/ttga79SUd6L8uJQYUSdSNJYXAdExAe99r8Gln/PM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jbra1JFvn+GXONG0/y3XEaFlT+jeUddgo0nSi+nOIGKvZbxIrnKKO7r7YoZQZ6LVN
	 j2pMXHiQ5lVYNXfhNaUYXxxbk4YTug2Q2DYIDyZQ9Jymxkw0Qga/ZAoal0gvfHoBIq
	 zyE8+VEyaJ9aDuPlGXkhU8UtVW+hCvYJGCVv+OOk=
Date: Tue, 10 Feb 2026 23:20:59 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1041012/8a4a6a-000000@github.com>
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

  Branch: refs/heads/1041012
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
