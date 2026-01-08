Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AC2D131D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902112; cv=none; b=CExYQby+OJ55SllD5vQOEejsCZnCpo3wjoIBhcxU1pKEStt/kxm8CJOvSDCq7Kfu+2qnk3sVGuK0+p8CaZNLTVXKPkhxbRBnu03bv1lsrSQvMEUI2xmy8V6w7CmhvJyO+k432Htu4jqPYzjXGODE8ojsuvJa8+kEsyp9F0UgqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902112; c=relaxed/simple;
	bh=oqYrFE1fE2mgftSQG/IoYJvMBmFFOJJ7/8+5dseZz3o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a/RejJHUdX8bZw+A4wHh3e4uHWc/QcefRh8jNUPrDy2A3PnsRes3XcMxRrla3k0eanwqWfQfM9KcDdhkL/DZJw0lusu0ozFOCewq5/vhKNjQuwu4LWVj3J2ozspv71f9EKD6KadfbF3dkLsU76IZaLYgxsa/8GK44NjvE6dfHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZcIY1da2; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZcIY1da2"
Received: from github.com (hubbernetes-node-04a2db5.va3-iad.github.net [10.48.210.47])
	by smtp.github.com (Postfix) with ESMTPA id A66AC4E02CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767902110;
	bh=z6AY/VwHwHGlukrGLrLqJZphgPy2rcZOH4SOTVdoyBE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZcIY1da2UWy2pAsmVEmD37NjyGjps1/ZGqzG07vyYqCaNIwJ/26wl4YLyG+TzhUM9
	 XmG9WKupXelnafUh+rbFVCRp62E3UuSuHZR9cbkne00TcVLJUBb3MV7yuM/SJ9ztVP
	 LR9JnyP5pwt99/WB7RiKO+2B889Yae0YVMm38ZsE=
Date: Thu, 08 Jan 2026 11:55:10 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038698/246e27-000000@github.com>
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

  Branch: refs/heads/1038698
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
