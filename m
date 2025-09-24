Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72564A8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729490; cv=none; b=gqwzlgW51WF04C1RT5O6Y+AmMLAps7JhiOBwjGAmXHD96ZvacsJThf9YCPsb9P/nq8khK+krajLuvUTKEyWyZkOgNJs/uCGicx9vvgYRg7w0eLfNjBBvvWLo6ubS1CWWU3e0NIZBEX1Okp7XjEWshItRYm1gBLjOMMAD7DhQbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729490; c=relaxed/simple;
	bh=LFXXRMK6kr1Wn9ac6uoQKWj7Pxc0U6OwWB6rZJWl+B0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cnVAvDaUENj/WU8c42elQdzjIZkbWRurriA248yYsohi8gj9j9b15kovARwplMex+2qaywd8eTk/nASq5Xx5Z7kzEb3z7bniRpMOG1pKRgzVqPAggJynIC4AZ9zzm8ShhyLHlgmCJolAjbBB72Y6R7IC5MJ5dPYuDam68jyvFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m0nPCUwd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m0nPCUwd"
Received: from github.com (hubbernetes-node-74f6c74.ac4-iad.github.net [10.52.184.43])
	by smtp.github.com (Postfix) with ESMTPA id AB1F46402FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758729488;
	bh=6vTPCIF0VqML81rqDXQP6+dkh2SBlbgRx2Vr6CouRPE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m0nPCUwdgbBTz2s4rL63ZmXDfDB8AfmNatK/2R0eQqI1Ywx4cAUGKQNf44XBPFuGP
	 rwhgR1DSnn8BzorcrmLtNbTw0PzGhozMjW60wcE2WcKBzTcwAkc+C68a/sCsNaB/Ax
	 KQqmYymBUhOXCb8z+pWwpVLHGcqR5SJZqGBXasD0=
Date: Wed, 24 Sep 2025 08:58:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995294/eb3c17-000000@github.com>
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

  Branch: refs/heads/995294
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
