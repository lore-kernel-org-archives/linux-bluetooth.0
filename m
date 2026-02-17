Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F236CDFE
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340810; cv=none; b=G/fm8DFSPWIaNnd33QBm+GY2MM8jymcGnJrsIRQmrpKlvKY9o7/D8hbLT/Yti7U21AGCHgwh9zp3TdtYKnpo340RieM6z1zbe5zuks5P/x2Bwe5Pet3L5d61OUsuyOLZRmoom0D2KkVXKudpPfG0phqcJuUUmp8xzLtf04XV6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340810; c=relaxed/simple;
	bh=j88YZ9d/EuNpPpRpd+kwHV5WvU5dh6cwfC58+U7RztA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hfrcBUt1Ok2YqulMN4qRS2EIczRiw34qwDSU42ymDCeKP0Ffu+PQm+++qlpQYaL29ctmQfTY9/aEAjxoD5dV6FLcq2aautoRaRoFuYjuZPgh5m5MS0yZ4lL46rvSNmxnn3wd1dAOr60UjguosVPHkZ518eezXpaSFR5tMlOOkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R6C1u1Je; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R6C1u1Je"
Received: from github.com (hubbernetes-node-9e15691.va3-iad.github.net [10.48.124.17])
	by smtp.github.com (Postfix) with ESMTPA id 449934E13E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771340807;
	bh=kGVkn8IZvsDi39S2VyKTP1FKT1yGLeDrTapj1M5G4to=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R6C1u1JeC8agwjaeriv/np6JC8xYwUqWgcwOSFSZUSFg1S+eakDG/C1nMl9JtDzeq
	 QiG2O8xuJUus10LwoKmnrEPKKhsUCSMSPMWuwcWjDHNNfzBZMQtzAoX4r8ao2uWf28
	 GoFd374ptVmvXZJWuAhti7XwcmEpZfOi5aIjSJsc=
Date: Tue, 17 Feb 2026 07:06:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054177/f14317-000000@github.com>
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

  Branch: refs/heads/1054177
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
