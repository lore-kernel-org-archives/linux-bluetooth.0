Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C3326933
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896724; cv=none; b=gk/8noITHODCew1ICwHAMJM5ffVqfMj5Zf8hYM9Ackq5ljag8fjLooTG7o7tuFhaOPAf6MiPIit8Gf3+D569JZvfmWO7Ty9SlkY/Uvc5yv+t398wl43980m4Y7AphGtDQ5nq89yYQkIhqLX1SWQQQwMlqYh8Dv9dLqowsgSZiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896724; c=relaxed/simple;
	bh=J3X14k/kbjRdjIf0zL3cJ0CmNwnJfAd+sWirhAI6hL4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r4Kg9/mqAV1PyuNli6MDcjkE2IzrOLnz3Z7SlqROB5nfCtLfn5irxzEx8D59WXBFCv2WY9x1PTTwIBpp1Qr99BoNeYN+pGmdbFuGB3r/PFpZdxfZ3ib1CXXBXtPJ8fW3iLoUVb9Jt7yvI7lP11JAtBU8hgO7teQiwiR+pBNW/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ydx3VoH4; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ydx3VoH4"
Received: from github.com (hubbernetes-node-d27da38.va3-iad.github.net [10.51.99.34])
	by smtp.github.com (Postfix) with ESMTPA id F2424E0ABD
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762896722;
	bh=anptajdvGI4GwA+ae2G1v1ymcRbcYkSsyTA8TLHkoK8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ydx3VoH4/7cI43rH9jOs2pBq/Z0++ND6IgiO4YXf4FJ4tdMi4dQZf7sUS6N1o12de
	 OiKJQX5rj9BPV2v7seXJchZPOvbtJOufAZBq9t8DRfhVWq2mxB/LpC/IPRY/a9n0Q+
	 q0wg74SFTeG3P2MNyJHUmgTiis2TO+XMb8uA/xWQ=
Date: Tue, 11 Nov 2025 13:32:01 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022224/000000-63414d@github.com>
Subject: [bluez/bluez] 63414d: device: Limit the number of retries on auth
 failures
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

  Branch: refs/heads/1022224
  Home:   https://github.com/bluez/bluez
  Commit: 63414df576baf22d460f974b670299a98b2e000e
      https://github.com/bluez/bluez/commit/63414df576baf22d460f974b670299a98b2e000e
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-11-11 (Tue, 11 Nov 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Limit the number of retries on auth failures

Currently BlueZ has no retry limit on reconnection attempts in case of
authentication failures. This leads to a very unpleasant user
experince with, for example, XBox controller. The scenario is as
follows:

1. Host A is running BlueZ and XBox controller is paired and connected
   to it.
2. Host A shuts down (for example)
3. XBox controller is put into pairing mode and is paired to a Host B
4. Host B is powered down
5. Host A is powered on
6. XBox controller is powered on
7. Host A/BlueZ will start spamming XBox controller with connection
   attempts in an endless loop

What happens under the hood is:

1. BlueZ starts up, sees that there's LTK saved for XBox controller,
   so it adds it to kernels autoconnect list
2. Once XBox controller is on and advertising, kernel connects to it
3. BlueZ tries to elevate the security level, but is rejected by the
   controller with "Key or PIN missing" because the controller is already
   paired to another host.
4. Controller disconnects, controller goes back to advertising, goto 2

To avoid this, let's add a simple auth failure counter and disable
autoconnect for the device once we go past the failure threshold.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
