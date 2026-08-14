Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E147607A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721371; cv=none; b=XN17RI/eRWybmm2TKz8m38b0iL1xVedYo3pednJPb4QjZt+toWTwgvskavigk9+p0x8CVqj9KwPU0Wp72+0TKzPXVwMv4vhsns6NszWXHRUzzeM4UE1o/vyJ3Mdsbj9JIY78QiL2DV/WxGelutlp2fClvBHSUmqu7XQc7pW1G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721371; c=relaxed/simple;
	bh=DTtMmTydnI404PadecXufFV1nJuVI2w5B+m7UNMPt3U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UI1nwjzYDOGHSd2QgS8n1P5ODNye1MYNgfnyMS3JKsDATaTCIZf4l8oZDr3kBriTMSzWGymbZVWHK0JtbJAw1TQdjqD4lsPiV0BeNKfa9S+rr5EicAn/HAS8yD4RsK8m7Nsc9mS+wkn7yJ4bEMB941wCm6gW+5Kl9VS5VBqUd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PjhY5FY7; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PjhY5FY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786721369;
	bh=LG1QxmqzTh0l9ne8biQ0kRbcvtUXEuimgh1DwobVVrY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PjhY5FY7QpfzefQjlhrLViXa8XoLrsXPnOeyLeCPGRgHrhW2d5yaCJusPGjGKgtFT
	 Lu+suWbKCRvq3cCy7QTdZPQhldH01ThXG9t8zHAyqdM2pv3LXlzaVaUgNUnBzY5aBC
	 jgBph+jh+ZGnKiBD3rLBr2ZxaCyO1mLV1oL0mODU=
Received: from github.com (hubbernetes-node-bb5ea49.va3-iad.github.net [10.48.67.88])
	by smtp.github.com (Postfix) with ESMTPA id C875D34128F
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 08:29:29 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:29:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1141524/2de22a-000000@github.com>
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

  Branch: refs/heads/1141524
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
