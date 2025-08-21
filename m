Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D01CAA79
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809437; cv=none; b=Na8iUuk6fPvsWpkfDUl5FLC6kLaz+ollGRF9/qdeP9BFlMicdfFNpy5XJRfsfG5AB1W0UQ0jXi8lX7IUSFukmqaiM0j5k6avKV8Eg20ny+6e1OxckNALFqLJXZIR8xjAtOz4AahmTsR8QO0JH/Nq6h2LDvdLffKH8wz3sUn0t3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809437; c=relaxed/simple;
	bh=jNS6M9rqethddIP8sPWmTHyOrDNCagX6lLLB2VtrSrs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TThaevnb1eveQeoG/gYph31579Y0EJYJhpvq6BY6fwtLKBWbdUWX+SBnwIPkt89vje9rYNau1s+PZqG9JdU+cD9TMVWCjoeklJQPb1Hvir49KxgJJYDsJhPt9RsrAMJKY03Doidgt503duScuNoV81xbsMIEhdvEUgDjPWOMESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ulo0YdUh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ulo0YdUh"
Received: from github.com (hubbernetes-node-23dd079.ac4-iad.github.net [10.52.170.42])
	by smtp.github.com (Postfix) with ESMTPA id 8C389640C10
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755809434;
	bh=f2jRUHYkrOvD1XtNTE2cyNNdhA+yGAfpmCRTAIh+kCU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ulo0YdUhJLpQlNShJx/BNYDOVyLafD/NAiYsKuAykL3JuTy5QzqrToKB9GnribqYA
	 Zy2sGc6PNGf6bBoA8j0qXb3zMO86YP1yQI904IYvIfYuywgzxD0C2X+aBmuwkQN9XB
	 k5EZL0m1AhhMiSVHvsZgpb6/zL7ba9n6R9Y0Iy0w=
Date: Thu, 21 Aug 2025 13:50:34 -0700
From: "J. Nick Koston" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994230/000000-9081c9@github.com>
Subject: [bluez/bluez] 9081c9: device: Fix device removal on
 le-connection-abort-...
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

  Branch: refs/heads/994230
  Home:   https://github.com/bluez/bluez
  Commit: 9081c996fc62ab987282b7da23e0427388b02171
      https://github.com/bluez/bluez/commit/9081c996fc62ab987282b7da23e0427388b02171
  Author: J. Nick Koston <nick@home-assistant.io>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix device removal on le-connection-abort-by-local

When a LE connection fails with le-connection-abort-by-local, temporary
devices are incorrectly removed from D-Bus, preventing clients from
retrying the connection.

The issue occurs when:
1. A connection attempt fails with ECONNABORTED (including the
   le-connection-abort-by-local case)
2. The device is added to the connect list for automatic retry
3. The temporary timer (30s by default) is not restarted
4. If the timer expires before the retry completes, the device is
   removed from D-Bus
5. Subsequent retry attempts fail with "device not found"

This commonly happens with devices that abort connections during
pairing or when incomplete GATT discovery triggers an abort.

The fix restarts the temporary timer when ECONNABORTED occurs, ensuring
the device remains available on D-Bus for the retry attempt. This
matches the behavior when new connection attempts are initiated, where
the timer is restarted to allow time for connection/pairing to complete.

Reproducer logs show:
- 14:19:37.374 - le-connection-abort-by-local, retry queued
- 14:19:56.343 - Device removed from D-Bus (~19s later)
- 14:19:56.606 - Retry fails: device not found on D-Bus

With this fix, the device remains available for the retry, allowing
the connection to succeed on subsequent attempts.

Fixes: https://github.com/bluez/bluez/issues/1489
Signed-off-by: J. Nick Koston <nick@koston.org>
Signed-off-by: J. Nick Koston <nick@home-assistant.io>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
