Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291012F49F8
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jan 2026 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767301954; cv=none; b=AiiYQSHrJxpQN+gGoJwnxMURk6G2/XyijTWGJv5O7b/lNew888GlQgtnAyaCVE32XQGG8D1+9aYHql+wp0NDM3PTGmZJ4LqGSvU+LfA0/i+m+u8ggk5K30dlAg6a5oD1ioITCb3szls6po9he2uYvsPWNTnnLvBmrMbMkRZ2gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767301954; c=relaxed/simple;
	bh=ORGbi0Ipz21Z8RMb7GZOnYNb9Gu3+OqMkuD3VExrU+k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G804z+HYIfnDcgBSP0AAP5X/vjtLAsqTXJ+GbtEUdJZ6A5fZq4nUH3ftuTjWhjN78icIeooggjbPMT3HHKh6A21cMzOkTs9cIOYqCXN5nwTq6UJvpfcbedxegC+0y+YpFmJaX6+5HObwlKR64UVQYbnM68swzYGk0yntzf6qmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CcDXM+sT; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CcDXM+sT"
Received: from github.com (hubbernetes-node-3b28b36.ac4-iad.github.net [10.52.211.92])
	by smtp.github.com (Postfix) with ESMTPA id 5AECC640428
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jan 2026 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767301951;
	bh=Q9I2q2ZQN6hX8640bwEc+G54SRon3uMV9fKDkAnIjRQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CcDXM+sTmhReBVe3Yvhm11Hua4qtBhNJVvRta3SoFTqRyJn6ke7nHBfAx5lFb/LAt
	 GisuSBsQq3enC4ysLN83PxeAd8B9SL44DSPN0qw/wOX++5Z5/hTW9nvtHRsmrYacim
	 EHhw27DuQoWEqzbi7q0n0xeRFGsN5Imi8JRq43m0=
Date: Thu, 01 Jan 2026 13:12:31 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029869/d21535-000000@github.com>
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

  Branch: refs/heads/1029869
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
