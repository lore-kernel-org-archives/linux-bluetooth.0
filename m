Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238C24A067
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644508; cv=none; b=TrdBd9DnLswysfchzFZXgOc+zfo0PdlAUG0Mdo22v4KEKIouLeJ4FzYzdqyLvbQUvU5YloWLq9OITLs0RZ+8wts8DLvf9roqBHu5wOE9prQPiwILx2wTozZ7mXM8p9TUcANCuX1oZJtYeZ2UxgK9qsj727uRlFEpF4dthn8htcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644508; c=relaxed/simple;
	bh=ixeqLvPWmBNNsdU8jWoijVawxRzt+5ivrMrEk93age4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eLOSbtKT4H3FTbVcI8BCxkZOL/iJl4N0tPRQQ51PhsY7QJsdud49IDt6xQh5j0U6ehuekbxkWR5jcbiltVfUhs8cryqcfUGsgbSvHAZ3QCIp6B0nFXuZo4Nai+RhWagJA2ijYepsD52S0k/+hIwDj3Dk2fqCK92fLU1RrYz7onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SVCc4VDk; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SVCc4VDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790644506;
	bh=xn9151xtwAFK21XMcnXAfsJhMj81KvO7ix8e+B0gVXE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SVCc4VDknHMYOwN9v3uIlFHx4l0fsPv6fQ5m981fZTyZm67csghJyG4S/E1WCtvmB
	 wWKagHwBqiAu/XGOPqVZ/oxLd28uMwzlUf0stvRcrNGND8wqGvdzDiWowA5nrG9Jke
	 cPw+eKpB52guld6ey0Elex1FnBfLxJb/6ULjYUro=
Received: from github.com (hubbernetes-node-db2d540.va3-iad.github.net [10.48.76.63])
	by smtp.github.com (Postfix) with ESMTPA id 75203781149
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 18:15:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:15:06 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175652/000000-3ea197@github.com>
Subject: [bluez/bluez] 458b11: org.bluez.Device: Add Connectable property
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

  Branch: refs/heads/1175652
  Home:   https://github.com/bluez/bluez
  Commit: 458b112944943c3c20a349edb3f51b1ccabd6436
      https://github.com/bluez/bluez/commit/458b112944943c3c20a349edb3f51b1ccabd6436
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Connectable property

This adds Connectable property which indicates whether the remote
device accepts connections, as reported by its last advertising report
or inquiry result.

bluetoothd already tracks this per bearer from the Device Found event,
but it is not exposed over D-Bus, so applications cannot tell
connectable advertisers such as peripherals from non-connectable ones
such as beacons without attempting a connection.


  Commit: c358a6e18be841bc42682a1112b8694b9c51c571
      https://github.com/bluez/bluez/commit/c358a6e18be841bc42682a1112b8694b9c51c571
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add Connectable property

This implements Connectable property using device_is_connectable, which
reports whether the last advertising report on the device's bearer was
connectable, and emits PropertiesChanged from device_update_last_seen
when the value changes or first becomes known.


  Commit: 3ea1977cdc6527711d50236b966904ef50873100
      https://github.com/bluez/bluez/commit/3ea1977cdc6527711d50236b966904ef50873100
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print Connectable in info

This prints the Connectable property with the likes of info command:

bluetoothctl> info <addr>
...
	Connectable: yes


Compare: https://github.com/bluez/bluez/compare/458b11294494%5E...3ea1977cdc65

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
