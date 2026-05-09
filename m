Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0461A9FBC
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289513; cv=none; b=GaEC52/FjH7595myua6B2LWwPvVCLeSHS83bQejrPSjxnR6NScw6FhaJCZSgj/Jcih1nn4Pc8o6PBwJ1bPOMBNaktiVojdB+Z9vxPlrqchpF2GwVE4m9hmW5uCwHIwbhqZZHJeoS/SCu1OeehR60nD0oJLQopraa5xrmgMuHnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289513; c=relaxed/simple;
	bh=apVgr0bYhGKhrMRAw/XF+zdkOJaDcR/UJRU+1yW07PI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N0IpWhJvzEs+wH3Ez7B7BlDZTkbuKpBpR+59qqufMf9ZLk1EyXCS87QU3ajm10wFrlJFTYnEAZJaeVt0zHgiy7iI/NBPpQhwd+t0T9QzOViq2viOqvRkgwKWYA/4ZG1iMahm+N8LfjxgiKOve78u2poELxyZpvdQGkrcg98/YeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ItR3gmFr; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ItR3gmFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778289511;
	bh=j3ry44gPQGANzyxJpKBEu3QPrYw57Qv3pLyPNy2AloI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ItR3gmFrfqh+hKYQJck38TySrSDkb8DC2HLyaPzlY+QuohnF/4YkUNwLSxl21FcdG
	 rNXDcqi3aoHvcggpvCGtNXjhF6b97E3htnUyydEluHw35Xc2gzpKcKYhIvFCRCpQo3
	 9php8IMrMzAVZKcTyUwyghkxU6by+rXktLpeJqgE=
Received: from github.com (hubbernetes-node-97b7a47.ac4-iad.github.net [10.52.202.74])
	by smtp.github.com (Postfix) with ESMTPA id 70F4174098B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 18:18:31 -0700 (PDT)
Date: Fri, 08 May 2026 18:18:31 -0700
From: Preston Hunt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091848/000000-078adb@github.com>
Subject: [bluez/bluez] 078adb: btmon: decode 0x02 as Wi-Fi Alliance
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

  Branch: refs/heads/1091848
  Home:   https://github.com/bluez/bluez
  Commit: 078adbacedc3eea2d1c9eeac052cd2b8b3a84bbf
      https://github.com/bluez/bluez/commit/078adbacedc3eea2d1c9eeac052cd2b8b3a84bbf
  Author: Preston Hunt <me@prestonhunt.com>
  Date:   2026-05-09 (Sat, 09 May 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: decode 0x02 as Wi-Fi Alliance



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
