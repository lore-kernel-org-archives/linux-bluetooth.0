Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483472613
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702759; cv=none; b=A2OU2Qnz46iW6pWcclnDCleX/jpsAZlBfIZC1ydcI6Gy2i1EJhSOeBj4YUADzestK0IbW/zPKdD7kx90OPIW4w7/TdvQfLPZ2ZIQfe55DiOgedt5uIt7B3L1BcGowYxWxbgjJ+R005K/HFS0lTwoyVwXmILbLIMP4ph6Vw3hWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702759; c=relaxed/simple;
	bh=nr/qJphWo4ELccT4sVghkhSEHvGuSjkxkUE6/Plzm/0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DTMSW67ymkUlQiUDu1QdUJJFnDZnY7EiiixJIVrjxlsWqeCtJ2WP30CNMaRzqGAOTfMeatsojdR6DRwzPH7GFkSYMjGZjSMYVdapPdt4Y10De3LkjoWCbuoDx7HAAPcCQ+DhTIPQvSF21jWJ85Zpt99NGvHE6MmNCHJRyNYcFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fi+8g0Ul; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fi+8g0Ul"
Received: from github.com (hubbernetes-node-8ac9acf.va3-iad.github.net [10.48.205.42])
	by smtp.github.com (Postfix) with ESMTPA id EAF2F8C046C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757702756;
	bh=evPgsc8uNua/7SiPGx9DeGhp+KdZ80Ec05oaLDhTyGM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fi+8g0Ulg/f0y5mrf/NEH3rSGcj4mqrrj3Eu7lBdtQEwpCgSXMLNea6WlN+7qbPwZ
	 FboZ7t3QFx23MBih6609aFRxxU4+om8gVqFN0zN/IvPVcE8e+jgh7ITkm8JzY9eiDp
	 HegkdxZePsGYDGBwco3YyuoSP0mndodLqktQ+URE=
Date: Fri, 12 Sep 2025 11:45:56 -0700
From: Alex Studer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001921/000000-484885@github.com>
Subject: [bluez/bluez] 484885: profiles/audio/a2dp: Clear suspend timer on
 A2DP s...
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

  Branch: refs/heads/1001921
  Home:   https://github.com/bluez/bluez
  Commit: 48488578b35ed19e92f6f9e50fe7551ccc0f510e
      https://github.com/bluez/bluez/commit/48488578b35ed19e92f6f9e50fe7551ccc0f510e
  Author: Alex Studer <alex@studer.dev>
  Date:   2025-09-12 (Fri, 12 Sep 2025)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  profiles/audio/a2dp: Clear suspend timer on A2DP stream free

When an A2DP stream is created in start_ind, a timer is set, suspending
the AVDTP stream if there have been no users within 5 seconds. However,
if the AVDTP stream transitions to the IDLE state before the timer
fires, the A2DP stream is freed without the timer being cleared. This
meant that when the timer fired, it tried to suspend a stream with a
pointer that was previously freed and so segfaulted.

This commit fixes that by ensuring that suspend_timer is cleared before
freeing the A2DP stream.

This was causing random segfaults when connecting my Sony WH-1000XM5
headphones.

Signed-off-by: Alex Studer <alex@studer.dev>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
