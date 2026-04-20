Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382238229A
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716697; cv=none; b=lu4EMvap6udrC8b/kZ4ALBcEy0kDjLiGICN87COXZ54vKzSfiFj4wJ2jOq42dR+YZC2fazMW+u5ufzspuB2XqGHyZiSbCr3Vbcg60+3XHivZ6fmpExcV6sHVh9ISX89oM478gfe25RQ1p+Yi8OMmkwWn5e9Uy+WQ6pzhulXKMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716697; c=relaxed/simple;
	bh=zdPPLMNAxtNcK5ldG6Eif2hhADt6TT8VAIJ8orcWyHY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RTikCgDj1zU/ZpWUVQP6WkycNJLQghLV8ieHkkQ/wsFzEPkbkssZJ8nU8Sa/ggA/cCmLx3h2PZi2Fxqr0wFr34eHjn1bkzd8XjDKjFLwQHRC9glHoGOPoryCH8E6JG8emlBpFFJ68xMrhRiqZbShIjs47kEFQJePjS1QeF5WQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FGn3bZ7O; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FGn3bZ7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776716694;
	bh=pgJRyZ2jAmfT+sxs5hzjBOQvaeShbCtTh5flIGGlfjw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FGn3bZ7OdiBjxlQXl7Id2vfFrgGg4kD3OEvTtKB2gGNNjJW6auXDUWGrRlvIV8+OK
	 LzLaOZNBUWlSXwnCeYkBtKW7jhLxdfQddlKQOgZAvXdmnOA1mXGIEj3NIzj7A0ak/7
	 jf9KeFA90QNHE8ogvvNqMTIpV5JTcEolVuG5r7gM=
Received: from github.com (hubbernetes-node-ae7a4ad.ac4-iad.github.net [10.52.136.17])
	by smtp.github.com (Postfix) with ESMTPA id DFF2220FC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 13:24:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 13:24:54 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/73c694-bc0a83@github.com>
Subject: [bluez/bluez] 322cc2: transport: allow setting Metadata property on
 broa...
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
  Commit: 322cc2eb736c7f2a95ea13cda14fb0fbf57cdb64
      https://github.com/bluez/bluez/commit/322cc2eb736c7f2a95ea13cda14fb0fbf57cdb64
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: allow setting Metadata property on broadcast

Also fixes a problem where 64-bit iov_len was incorrectly initialized with
32-bit value in dbus_message_iter_get_fixed_array().


  Commit: 4771fd2fed346564ed322573d8c2a691b1fe8565
      https://github.com/bluez/bluez/commit/4771fd2fed346564ed322573d8c2a691b1fe8565
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: run callback after setting the broadcast metadata

Without this callback, dbus property setting will stall.


  Commit: 9d8d8cbd47498c412021dfc76ce715678e9aa762
      https://github.com/bluez/bluez/commit/9d8d8cbd47498c412021dfc76ce715678e9aa762
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  audio/bap: fill BIG and BIS for receiver

This is for some reason a missing feature.
We receive QoS structure from the kernel via BT_ISO_QOS, but BIG and BIS
are not set there. In fact it is even impossible to pass them that way,
as it is only one structure per remote device. That's why we have to parse
BASE data to extract BIS and set it to stream->qos. BIG is not present
explicitly in BASE, but we can use subgroup index with success.

As a result of this commit, MediaTransport1 object has now a valid BIG
and BIS set in QoS property.


  Commit: bc0a839fa3839823a5c1e51a687d9adbb6156b8b
      https://github.com/bluez/bluez/commit/bc0a839fa3839823a5c1e51a687d9adbb6156b8b
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: update QoS dbus property after it is set

Dbus set and get on QoS property use different data:
- get uses bap->qos
- set uses bap->stream->qos
This works, because bap->qos is a copy of bap->stream->qos. The only
issue is when we set this property and then try to get it. We see old, not
updated copy. Simply calling bap_update_bcast_qos() fixes the problem.


Compare: https://github.com/bluez/bluez/compare/73c6943f0636...bc0a839fa383

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
