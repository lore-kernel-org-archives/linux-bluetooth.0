Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D323C7E15
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777813804; cv=none; b=uhqQN+XzYRjUvMhMwOqgMNkaLxDGGJMCN8BWfBV/Ia0XO1i+e9MyeMLW/S5xvwmE2+vJZIdXC4wwAT21X6EF+N984NSU/z5ipYGZ0ndJYSiA3Ta6jUPnbPXEUrGzYMvhn8gTja5XN9p26Ha4QL2BograWubM3BoZLfw0xs5RDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777813804; c=relaxed/simple;
	bh=PVVNKBDHsdFWJkxf8fMRIfBOUB6o1A1t82yyYtmR4no=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oPpKMIbBaHDolCRSGq3k9tG36n5eg6bEzcvC+mmQ3C6XS8RL/4ZemTfpDJMbgUN/ypoxT3i1wIR5pdocjv/vJ+tzlqpZ9A61YYS3ftA4c9crdV4S8VrWYSPImBGJdvTUjdo62Aq7eM3JbeQC6HsuVtsAPmXU0WMhxHC/i8eWKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kA//hRy9; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kA//hRy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777813802;
	bh=TLnKiD9BUYPyolQCHrc1AGjLxFiqN5dWuckJq+6AKEU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kA//hRy9G5xjcTgfD12+fjjxV/ZIXk3v33Ud/iyoex5Mp4gktw3p6sfoiN0Z0VDR7
	 jNymvfasD9iJwlL9bVfN93Kn4REy4nTSO26q2tIDOKt9EpcuzNeJ6KxT4a0OOQ+GEZ
	 wdfAoNMg/BkGH2b0K1igCZPWTHZ2dWqe19II8mBI=
Received: from github.com (hubbernetes-node-3335f64.ac4-iad.github.net [10.52.211.58])
	by smtp.github.com (Postfix) with ESMTPA id E757BA10D5
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 06:10:02 -0700 (PDT)
Date: Sun, 03 May 2026 06:10:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076973/59ce83-000000@github.com>
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

  Branch: refs/heads/1076973
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
