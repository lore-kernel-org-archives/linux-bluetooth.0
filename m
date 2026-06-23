Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F839B4A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246353; cv=none; b=aeez4JHesqGeLpBtkSk9gsj+Hj0GNfy4F6FEv0UvCHhW8sPaWLk+UHdiBKuAhoFh7GzeLk8OmWRQr2iFdKyken5yvePXBLTLvom8+QeAmDc3/YFhI7KLWzkPkbCgNR1dsFXqSpyMWzaZNeKFAFvDkVKDfC3V4Sb/BgWsjMg6fO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246353; c=relaxed/simple;
	bh=IGLfXJqJAqI7sGgihQMsaNvYy1JnU/hTnMZJVFs0d4Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HOhSbu0Z4B8QyglsumdQ2ny4d0M8t70vGfJB2hNY2Tx7+h7A65V88TnyfjWw1fGU0eH6xeWTCHyHj17xtVjowFLn1W2hmj6CknTaw4OPha9dn2HjQ3YeHxIubND2+rPYDF3M58uumLNlYjXc+2xQnPAZXV/Jl2Z5ZIYLmNOV9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GQWoud/V; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GQWoud/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782246349;
	bh=g5LnMsFFXoiWp9IRRbR/rQFJZe8MQduGqpsVw6fTVJA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GQWoud/V0tFaetQEX/ZMO0guJuYpWR4x98W3a6wjXuhluYhYU99cIffxnZwshs41N
	 eIqYuv8Z19Nbqk+x/0dmrliEixjhbMx8Uv24bLkL0KJLCps9UbL2QuwKonpcUj52GA
	 13BcgzGQqdeIx2hbNzKXB0vnvludook7qw2w/vO0=
Received: from github.com (hubbernetes-node-6dafd23.ac4-iad.github.net [10.52.160.34])
	by smtp.github.com (Postfix) with ESMTPA id D5602320FFF
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 13:25:49 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:25:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5792da-912f5e@github.com>
Subject: [bluez/bluez] 912f5e: a2dp: Fix handling of codec capability storage
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 912f5efb0dd9bb08e408d33371a57182c5678aef
      https://github.com/bluez/bluez/commit/912f5efb0dd9bb08e408d33371a57182c5678aef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-22 (Mon, 22 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix handling of codec capability storage

Codec capability is one byte long (max 255) the storage format is
02hhx which means each byte ends up as 2 characters so the buffer
needs to be doubled in order to handle capabilities of that size.

Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
