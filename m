Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE81ACECE
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748500; cv=none; b=n4ZL1fTs+/DIUd+akeywpWUTYHA3aoOow/2KBrn1HxmuyneP1Wws8+E+Ss5yEd4uWBcaRS7RBVF0tQaSEcoKCTepZXYXvPhUawqyGSiGN78Z/gttTLBu8oJKDgSx4ea6cND5Z6iOvj334LN0gWih8L6Q2UX/k+Zs19yn7QjbQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748500; c=relaxed/simple;
	bh=RsRLKHh3jxvppwMAJQaOzH8RtJZywWK4pKwqhdtCmCU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Pv0vt8PZ/0Phs4z6ASi0ZzZJ12omF7c3Y9+9QkdHQCoLBU4iYkM87OxYkXjD9mJYO6ZjMNfTez0aHya/67JXP8GTmdO3pYcLh9/qjPmYBmbGevk/z/TAFGayWw7dyuUe/Qo+4rVwE+Biu4wOvkLXdsroIJPTlMdDVnw280fs5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ORLtBpdO; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ORLtBpdO"
Received: from github.com (hubbernetes-node-36cb194.ash1-iad.github.net [10.56.143.34])
	by smtp.github.com (Postfix) with ESMTPA id 42ACA60138A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747748498;
	bh=WOkG9rp8CCLz36K2GxbH1pdxdZW6N+jrTdSDyxP2nEI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ORLtBpdONFKZrtdM0ELeZ4IbmYB9EHvRNzczHK9WH90L+VE2zJfcQzV94T5v2VQi0
	 LHmpbBwZQPAWIWJNp1lSulQT0oursqeCVZrYc0MubhZkY2IICnoJs92by+7RRKiqXY
	 9/ilNCzu4uKMPPsetHN89K77Wcx6H3ROQWcU3Ghw=
Date: Tue, 20 May 2025 06:41:38 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964591/000000-4f2f9f@github.com>
Subject: [bluez/bluez] a81307: client: Add client-side error decoding
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

  Branch: refs/heads/964591
  Home:   https://github.com/bluez/bluez
  Commit: a81307ac5e53f91e1e83d05dcc486f3d5123d4d4
      https://github.com/bluez/bluez/commit/a81307ac5e53f91e1e83d05dcc486f3d5123d4d4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M Makefile.tools
    A client/error-parse.c
    A client/error-parse.h

  Log Message:
  -----------
  client: Add client-side error decoding

The D-Bus errors returned in a number of cases aren't in human-readable
form, but instead exist as "codes" (listed in src/error.h).

This new function will allow us to split a specifically formatted string
into a human-readable message and an error code.


  Commit: 32f440fa25e12318e67b03f78b98e7b438fc65a0
      https://github.com/bluez/bluez/commit/32f440fa25e12318e67b03f78b98e7b438fc65a0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print a human readable error message

When the D-Bus error message string contains an encoded error code and
user-readable message, parse this message to only show the user-readable
message.


  Commit: 28d460427575677734fec217cc61bb0cab718cb6
      https://github.com/bluez/bluez/commit/28d460427575677734fec217cc61bb0cab718cb6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Better "Connect" debug

Output clearer debug information so that it's possible to follow the
decisions made by the bluetoothd daemon when a client such as
bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
device.


  Commit: 4f2f9f3cd338765f5550ab82fcbcc1cc7a476f6e
      https://github.com/bluez/bluez/commit/4f2f9f3cd338765f5550ab82fcbcc1cc7a476f6e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add user-readable messages for a number of errors


Compare: https://github.com/bluez/bluez/compare/a81307ac5e53%5E...4f2f9f3cd338

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
