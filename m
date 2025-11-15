Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20E254B19
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215139; cv=none; b=WTkW02wGgejTrgPnrD/X6hybmLJ73O/Fuj0lDrNfkI9fmGR77VuugolmImzpcIeRsIorAlpqLERvNS2pHNW7QtXYOhqr0mpEclqyEzYuWkdcqX8AgoLpJa6jCuVdWNPnw2omMNYpFf48KKQJ8RF1bcTcTFZp6zO0rL0pEAsqMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215139; c=relaxed/simple;
	bh=TKxq4ZecBiKb7ZZOv8UIq70r8HDjeAoFXrpaibLFZ4o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t+7LpkECEqej9imgPjWpI+GBW6v9W7bpp5H9xaUfsDSFiOx5urkY2N4c35Y7amNsN812kl3LU8H4n/USbJcq7iqtz7mPWHnx8snsohhyfkn2w3rtsMeXGo5bb6EBNCMePmGgha3H+svDG3zZfg4RbH5DznkWsVI5WuHzxAPdnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gq84d7Ul; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gq84d7Ul"
Received: from github.com (hubbernetes-node-6e58c9b.ac4-iad.github.net [10.52.81.27])
	by smtp.github.com (Postfix) with ESMTPA id 78F1020399
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 05:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763215137;
	bh=YKpcwM0GF76tuVVAWX0nlrRxVbniFfMNEaIi997zg8E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gq84d7UlRYy2DemVYS18JVrehjEy7OP0OGVwgAxZ7ELLA+Cj1nz8TtPIl/D5My6vt
	 6Hi+xgirrqUqyPPjvhEpp6Qc6TsAI8kNXKgCxQesOSOKiWjJSA5UScwRg9YU1Durf4
	 oPOg1h+KHd81T4pFOem4UH9r9bwrAezCCKe4o9HY=
Date: Sat, 15 Nov 2025 05:58:57 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023829/3c55fe-000000@github.com>
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

  Branch: refs/heads/1023829
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
