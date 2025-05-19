Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D81E573F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672767; cv=none; b=QF23EQdjNX8/1Pqe6LWlOE5DLK3A2OMha4MOUBb2i1y3F4Z7SrCWfkxCE9MCaVTzbyKKLn66jWjg50FFlhlRRl54Qb55vKFM6LfDsr9ouD68D85kadpFxGbQjs/02TMxlZpqW+kZ3QNh71laIb31jgg3QfQwhIREubDmdyQgNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672767; c=relaxed/simple;
	bh=N2qs+VZNHlGtCk1sZNtVbmYY8KPnfKogRvV7hSS1IJ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VyZz7HDGE6BqmW4bjSpndlyBKQvuxPNz14Gi4aLlVn4CRtkYTTYXFp5xAdpjEPUYto3cGavs78O89XvV+lP9oQGZsRknXcEtltPmsrJUdw72d0b0HR0RiPSm4qCdEI1pcrzmafExFDMFFhIv6aMYzac5h3A8c0LBF7JFYcZ42pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zfb4qEiE; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zfb4qEiE"
Received: from github.com (hubbernetes-node-3fb7cfe.ac4-iad.github.net [10.52.206.92])
	by smtp.github.com (Postfix) with ESMTPA id 3E34C64103C
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747672765;
	bh=kT3WPT78TB76S5T7WPDOc3RVqUVGN+WlAGJH4tsu988=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zfb4qEiE3s4M0ZXa8Y4TqOdo5QCO6b0mBOApvd4m5dyGXRl8vgD3XPX771srrGpYo
	 5kd4LVU+Xaaa7w8ps7uNxZMiwr0KqdcPLsFrfqunRkLv6Q8eXAPWdhX9zWYNxpxAH/
	 Pmsn1vr1m2hQNKXgRXST68HNcfoP4YKHTXQS5Q0M=
Date: Mon, 19 May 2025 09:39:25 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964261/000000-a651f6@github.com>
Subject: [bluez/bluez] b5d015: src/device: Add Disconnected signal to
 propagate d...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/964261
  Home:   https://github.com/bluez/bluez
  Commit: b5d015c03f0614beb9ad091a37aae69f68d87627
      https://github.com/bluez/bluez/commit/b5d015c03f0614beb9ad091a37aae=
69f68d87627
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Add Disconnected signal to propagate disconnection reason

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.


  Commit: 64d6e7e08f8c6f846ba94978dd0fcb7dfcc76dd4
      https://github.com/bluez/bluez/commit/64d6e7e08f8c6f846ba94978dd0fc=
b7dfcc76dd4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/device: Add Disconnected signal


  Commit: a651f60bbd2b485bbb0f06bfb1511da13be444cf
      https://github.com/bluez/bluez/commit/a651f60bbd2b485bbb0f06bfb1511=
da13be444cf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display disconnection reason

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.


Compare: https://github.com/bluez/bluez/compare/b5d015c03f06%5E...a651f60=
bbd2b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
