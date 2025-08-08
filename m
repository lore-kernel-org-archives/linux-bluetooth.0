Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8535948
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681151; cv=none; b=Z37sqtNkgHZI7Htj2MLdd/+YIHNqQ0wkTR1EfCAfe3rrk0eY5iKA23xxuwB0G7NPTgEhmIdJLNCSQdgSNDhjn75cNGteVXrB1cc5dm/y8JpTbKDzZB+jnX42GfI326+wQqT5foyeK/l2+LYCNspXOXBRdgDoRZPKIO3jw/tyRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681151; c=relaxed/simple;
	bh=5PSr0veEX55Imtac1nQrjXujGS1EW2qZD+wVDOeqlNw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WGR/ORowEN0ClRT5MXKQsDJ/JKggnlK8qqkf/vfOlaalSJ0/hX1FC1Go0iRPJxbzFROfPhAh2CjkFFXylgM5o6qeTcKkCoMcTQ/zcjg69kO0uhC9YDPVFOZ8eW+YzG3azmoaP1WHCSyJYzTn6DXVsprdSjg++ER6SdKvGpmsb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MZ8V8gxi; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MZ8V8gxi"
Received: from github.com (hubbernetes-node-2412146.va3-iad.github.net [10.48.173.26])
	by smtp.github.com (Postfix) with ESMTPA id D44354E1175
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754681148;
	bh=O79zdarrdyoXE6VQ4OWcfQKR1hYksNJ/yV0JnIVkh6A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MZ8V8gxi+3fKC5YXl5+tCqM2bh7ID++OUYTTUiHCGduL0P4Oi7dGL2I/aPJqSvbY9
	 QcDhz3q6/8gLAmXzECsf/g4jP5v1O2NXoMDVzDl2KidLjQbZqK5AT/meoy+j6rlSwB
	 ++S8jppXxzt8wXQMU187UdG+XY+iCQ7eE8RWodeI=
Date: Fri, 08 Aug 2025 12:25:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989510/000000-3d764d@github.com>
Subject: [bluez/bluez] 3d764d: iso-tester: Add ISO Reconnect Send and Receive
 #16
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

  Branch: refs/heads/989510
  Home:   https://github.com/bluez/bluez
  Commit: 3d764d8582c50b5be017650076c68b78cfad14e5
      https://github.com/bluez/bluez/commit/3d764d8582c50b5be017650076c68b78cfad14e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add ISO Reconnect Send and Receive #16

This adds ISO Reconnect Send and Receive #16 which test reconnecting,
send/receive datas, 16 times to stress test the handling of reconnecting
logic and confirm tha POLLOUT is generated everytime:

ISO Reconnect Send and Receive #16 - Success - run
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #16...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #15...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #14...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #13...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #12...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #11...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #10...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #9...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #8...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #7...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #6...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #5...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #4...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #3...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #2...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #1...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
ISO Reconnect Send and Receive #16 - Success - test passed



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
