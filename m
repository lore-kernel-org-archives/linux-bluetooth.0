Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD441F5C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864046; cv=none; b=hy3AfQvIGhSNJECt6CzO9XGps1uCV/u3ME2XFYlncUCA8YkbCGTD6Po0Mz2kJb82vMxEXYPuBUQbq3JXTaIyDo+rLwB2qpaZdwC1e0AXpgr8G6W7ihssCMV3PE7wAmfOSJ62gF5Tou0T7oaMSX9MXxTWNJRTLP0yRKnyTqZtkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864046; c=relaxed/simple;
	bh=Cqao744iSf+6v1FyAuska98q+H0GkE9wcYIAp1DWmYc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kPFPzrm9bOwOAdy82UqexFS0WSWN9kpLRwSdh43Lime6GiSAt7yAHZTa3hrFoe4L7EtiZrhkHvyBUgoWFXwFB/XKLWJJ0lSbcwCMr7Kynb3MfKn8T7PGOXLTOCyriVHuHY/vQ/cQieipg7zAtRWT5BYegI+IgPb0malNYPSGvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ikGu6lQR; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ikGu6lQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864044;
	bh=UiHP/T+Fle1Odfy+DF++kl79irLV5Y2TNOpdNaQiTkc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ikGu6lQRv4Fw4lRo/QIVdJ5VBB1Fsf9sPqUHWBZZtbBVvPNKAACnJoYIxpUx0gwgq
	 ol3C1E+hcLL8xQQso5v1Z+mOi1+XhGbaLEDDafSweXsFmBvpK+kwRDwfOvqlQT3Z1R
	 9FonZQ01uDy80tlvfViw+nNFpy6okP2EshO25FriH+Ym2ltDpYneA5Nlxl8wIKxA0s
	 m0muYuSMGmNb1kFHFukUM6AwpUneAUOxCD6hEnWumkh1mfwWjWref6eVrsJT7LW1Tw
	 xMcFwqNr3665arYrzSGM5ytrbgRB4eTgJJtP8PzSilUsFzRILIKW/IgwvI9k2ihP96
	 tJVnsYJXy77CQ==
Received: from github.com (hubbernetes-node-5cccdc6.ash1-iad.github.net [10.56.77.33])
	by smtp.github.com (Postfix) with ESMTPA id 49FE260085F
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:44 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184361/000000-4577d1@github.com>
Subject: [bluez/bluez] 4577d1: asha: use robust streaming connection
 parameters
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

  Branch: refs/heads/1184361
  Home:   https://github.com/bluez/bluez
  Commit: 4577d174036d4738d32ce7768d2feb527f095bb5
      https://github.com/bluez/bluez/commit/4577d174036d4738d32ce7768d2feb527f095bb5
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M profiles/audio/asha.c

  Log Message:
  -----------
  asha: use robust streaming connection parameters

The tested renderer requests a six-second supervision timeout and
latency of five events. Use these values instead of the one-second
timeout and ten-event latency that accompanied link failures.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
