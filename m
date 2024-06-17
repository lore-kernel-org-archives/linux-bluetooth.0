Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D69167DAC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651487; cv=none; b=TzpeeYfLrHM1MICa4gvzsrJ19CCGjODNtbiRcl7ADbX7NygM/jt3OZOOLElJFxqZ9rLqCSMASzsMR6Sj5CrOZGSZpUkrVe7HNMSXsWsJYafMLi8p0hUvkirZpi1uZxpNA4MdmnK1N93b/59NI/JjVb9bwZpQ9VfsV5OvqWmXhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651487; c=relaxed/simple;
	bh=byne2ai/NtTF5JBw7jJFcy9DJxVsq8oAmt4ky0YMfxc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GSc8kMaxbWTL6BzrhdlA2gYdHrMvYkWd2jNeVF+xvrLgeVVN8ERv99hfMw9goEDzBjL+KzD0MdP/Yj+YvA7ZjOjtoOtxc6em9FkPEtIZSw/rSnfJuXH4aNR7MvHURokHMT1+joofhPcnUek7oQhYZ2JmTytsqlTVeCD0cwpLdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I8AcLRRu; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I8AcLRRu"
Received: from github.com (hubbernetes-node-6e64cb7.va3-iad.github.net [10.48.201.118])
	by smtp.github.com (Postfix) with ESMTPA id 0AA9D4E1040
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718651485;
	bh=e2hH81VS1EVjyAxVRMUsj95511H+0GUw/yYb1y/Jx80=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I8AcLRRuYF3TGXJMptLoD7sJ9AqUPYAPpx1uB1O0/vwxccVmA12+R6yi1ci5ylMvO
	 9Zx3sVO6D4fxe6xyFOR/7gfJRz3XLY2448iIu5NsMjxpCk+bpDANZR3RRBZ9SIColK
	 Db7HP/kAN8ZM/mp8/VXya31vVe1eHeI4DOs3KDc0=
Date: Mon, 17 Jun 2024 12:11:25 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7ff745-52bda9@github.com>
Subject: [bluez/bluez] 87ad4c: transport: fix crash when freeing transport
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
  Commit: 87ad4c66b934b1280bc8843589856313ef1bc912
      https://github.com/bluez/bluez/commit/87ad4c66b934b1280bc8843589856313ef1bc912
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-06-17 (Mon, 17 Jun 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: fix crash when freeing transport

Fix UAF by freeing transport->remote_endpoint in media_transport_free,
which also frees the struct (not in destroy after the struct is freed).

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x508000022ab8 thread T0
    #0 0x493624 in media_transport_destroy profiles/audio/transport.c:223
...
freed by thread T0 here:
    #1 0x7fb057d10294 in g_free (/lib64/libglib-2.0.so.0+0x5d294)
    #2 0x49dd2d in media_transport_free profiles/audio/transport.c:1276
    #3 0x7e0e99 in remove_interface gdbus/object.c:682
    #4 0x7e8f40 in g_dbus_unregister_interface gdbus/object.c:1430
    #5 0x4935a2 in media_transport_destroy profiles/audio/transport.c:220


  Commit: 52bda9d45572ab4629bf2f686616c0398f489dad
      https://github.com/bluez/bluez/commit/52bda9d45572ab4629bf2f686616c0398f489dad
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-06-17 (Mon, 17 Jun 2024)

  Changed paths:
    M src/shared/bap-defs.h

  Log Message:
  -----------
  shared/bap: make BT_BAP_* direction defines valid bitmasks

The directions appear to be intended as bitmasks, as
bt_bap_stream_io_dir() will bitwise or linked stream directions.

Fix the defines to be separate bits.

Fixes confusion due to BT_BAP_BCAST_SOURCE == BT_BAP_SINK|BT_BAP_SOURCE,
which causes e.g. unicast transports to be in PENDING state after QoS
although this does not make sense for BAP unicast Client.


Compare: https://github.com/bluez/bluez/compare/7ff745c2bd0c...52bda9d45572

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
