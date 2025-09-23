Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14B2E7BD0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628672; cv=none; b=TTbLndRcTxC2akbGrUpnhiZW5UnqPFIYPGkMZkBasLy0Ydbl78mzWVikLDV8UO4ZtmFauhGCoapXJgcudXIF4IKwvg++7J3GQ5BmAixM2Uj33Wg8ME7W6d6FV6Nxe0gVuLj41WgWq7JBUfPDV5z0MGdKhwq5dyJA2zBa+tmEZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628672; c=relaxed/simple;
	bh=YmEx2PzfnnrP/ThiUW3KACCM8yjX2ZqZsSsU0TWtDaQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UowdjXZA+bYhOZeh+W5M9E2Yp+/ysrVeJr0uNxGhI7BbPgM0oZGZFbH/G2xNzy4RIfIHNjDaCYb6mExUN5h9YfmoS8Bz+QFSJc9VhAMzc//+DS295yzJUnaG5MFDFwhXTkTV9WxBzYct63tZaD1tO2InXAvM3xSw9l8nGYLQIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OipMXR9u; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OipMXR9u"
Received: from github.com (hubbernetes-node-26c3b0a.va3-iad.github.net [10.48.220.98])
	by smtp.github.com (Postfix) with ESMTPA id 6A5D78C0930
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758628670;
	bh=vpWGnq5sKuuGKXLwAVzr7EgQq2fmNtzJdyh43CTSk5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OipMXR9utKGA65Uq1dHr2hVip8XbSDXjNiDy1vz7XYknkrYQYmkPHMWR+wysoW/u6
	 EBTg0T3A2iy6o2Pmcyu5ipDE8Bek3J8Re6Nu7mNzKdeGs3umE8ojhlatBo48lTSB8R
	 VN6tHBghVoHYI2eamsb3RMQL7q15f0uDUoJAScX0=
Date: Tue, 23 Sep 2025 04:57:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994927/0e1ea3-000000@github.com>
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

  Branch: refs/heads/994927
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
