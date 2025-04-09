Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4F18C937
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208140; cv=none; b=Z8r9+SAmkBpz+zxBeMk7iJaD5R8jVs+mMf1o1a8fxOyNiOysYqi7hAcc57kv8xF7xPqizNtHl+bvO+6NwcXC0r8kWSYiIX64+vpEF7tendp4WazUtuNqkxiQR5viDEyxSHT1K15CdW/siAzxJ8sOCJICyyVWOqqkxA1lrbvWslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208140; c=relaxed/simple;
	bh=ZnmwfuVGyKAXYr9oHvVlfb7GtuB8t6WzZGvgTAgQQPk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wwl/O+mn+MFThUjBzyxppNTf/76WPdb+cmYTRyXzWNo6UAfgiITTO8UoPbl6BnI0J8EU1abv8AT39gJnc1ITaXcdvrnz9nUgVnw1cK3bXJv6H69egOaH+4maDEEnCvLRgRuoKpzjVa+a/584pSovPAnWZ7u9h3+52UX2ggPlUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GLLRT26u; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GLLRT26u"
Received: from github.com (hubbernetes-node-11db1a0.ash1-iad.github.net [10.56.162.40])
	by smtp.github.com (Postfix) with ESMTPA id 4271B60159C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744208138;
	bh=4nH7uqaGlLIGtuDH6OvzawKCu3dG6zQT7GyJBvHSBvY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GLLRT26uuGwxRdOHATpxwlKvBte1Kqsd0OkQH8gYaIc1lC7xcZDTzGb1BxLdKZEHS
	 dw6KKMv4iSLoQMlQoDF0S2UfaZq9/eUnPTour/jn1uxHc7APKGqK3DY8vr8fm275hS
	 AXXHYFTer4dk/5SBd3+H6pm8xpZuL1YtlVYxT0jQ=
Date: Wed, 09 Apr 2025 07:15:38 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/956b27-1288fa@github.com>
Subject: [bluez/bluez] b19d44: shared/io: add watcher to be used with TX
 timestam...
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
  Commit: b19d445b01920ba5ffdcbe320d406cd5ddac8746
      https://github.com/bluez/bluez/commit/b19d445b01920ba5ffdcbe320d406cd5ddac8746
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M acinclude.m4
    M configure.ac
    M src/shared/io-ell.c
    M src/shared/io-glib.c
    M src/shared/io-mainloop.c
    M src/shared/io.h

  Log Message:
  -----------
  shared/io: add watcher to be used with TX timestamping

Add special implementation of fd watcher GSource for audio use.

For audio use cases, sound server may turn on TX timestamping on a
socket that we are watching.  In this case, we shall not consider the TX
timestamping POLLERR as a socket error condition, nor read the TX
timestamps.

When TX timestamps appear in errqueue, switch from fd poll wait to
polling the fd at regular intervals.  This is because unread errqueue
causes poll() to wake up immediately, so the mainloop cannot block on
that, and we have to use a timer instead with some reasonable timeout
for the use case.

This rate limits wakeups on new TX timestamps we aren't going to read,
and also avoids the busy looping if timestamping was left on but
errqueue is not flushed.

Kernel does not provide any way for user applications to disable wakeup
on POLLERR currently.  Note that even with epoll() POLLET it still wakes
up on every timestamp.

Implement this only for io-glib; it is only needed for audio use cases
that anyway are using glib, so add a glib-specific API for it in
addition to the 'struct io *' one. Uses features from GLib 2.36 (from
2013) so update configure.ac also.


  Commit: 0e831d8e67096eacfe9870f8d8c1134fc0b045d3
      https://github.com/bluez/bluez/commit/0e831d8e67096eacfe9870f8d8c1134fc0b045d3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: don't consider TX timestamps as errors

Use io_add_err_watch to avoid considering TX timestamps as errors in the
transport io channel.


  Commit: 9f167d495adb47cef9482ed6c4344d4c953d26b8
      https://github.com/bluez/bluez/commit/9f167d495adb47cef9482ed6c4344d4c953d26b8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c

  Log Message:
  -----------
  bap: don't consider TX timestamps as errors

Use io_add_err_watch to avoid considering TX timestamps as errors in the
transport io channel.


  Commit: 1288facd554823b302024d7f0589a68a58fa2ac8
      https://github.com/bluez/bluez/commit/1288facd554823b302024d7f0589a68a58fa2ac8
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitorManager.rst
    M doc/org.bluez.Agent.rst
    M doc/org.bluez.AgentManager.rst
    M doc/org.bluez.GattCharacteristic.rst
    M doc/org.bluez.GattDescriptor.rst
    M doc/org.bluez.LEAdvertisement.rst
    M doc/org.bluez.LEAdvertisingManager.rst
    M doc/org.bluez.Media.rst
    M doc/org.bluez.obex.Agent.rst
    M doc/org.bluez.obex.AgentManager.rst
    M doc/org.bluez.obex.FileTransfer.rst

  Log Message:
  -----------
  doc: Fix various typos in D-Bus interface documentation


Compare: https://github.com/bluez/bluez/compare/956b277f8da6...1288facd5548

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
