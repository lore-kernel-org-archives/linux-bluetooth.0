Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7413DDAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509519; cv=none; b=n86g7sTXAXEGBT/J9xgFIyg78FniidqibgNsxjPZOC02XnA39bMJc0N8ed3bz++MRVaXYpUGFXehdnfrLUnOASpOcSlMB6RaqutGW+SNm8iBYrYb+qYoiorG5xoxlx9EBl4+bWPRgZAEMs618v6tFLKidCL4pyNAs7YmNxv5cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509519; c=relaxed/simple;
	bh=4rL4X7rRZKUCmsVGBzE21XE+hqno9h8IfeBTsc0hQS4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u0B9cjwv0yuw9ZRCrDDLDPl0CWDoZ03YXG48UjgaKNF2DwpV3au1deUuvZT/+wk4nnzVRgdEO6q42I21+wtg2mrUz8HT3vFl6oUJu7Mf2cD2W0aO3Fsv2tVG+wcFXHbZRLhIb9f6PGNpil4SWh2pQsTg+iyTVZlxQ7WGkfAahJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a/e3hmQL; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a/e3hmQL"
Received: from github.com (hubbernetes-node-1e4d2da.ac4-iad.github.net [10.52.210.29])
	by smtp.github.com (Postfix) with ESMTPA id 1D939700927
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509517;
	bh=7PAch83PPYVoRRRN7MLXPF1Zy0Reem1oZGd2uiqar0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a/e3hmQL0il7slmoAs/3CbX8Uwvx0T6QdX9f4SF8VjGT8drkDz6psQEnNuv8PPlMb
	 xdebuVegpGFVVRYRwNvuSE6eV4kUT7WErrEez3+0a2Rx94QcpY6ZWkmF8u37fGrOUb
	 GgCu6AouvZvT+GqziJUXMPGsi886zLJEdlMIo1zM=
Date: Thu, 24 Apr 2025 08:45:17 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/954076/000000-c2e574@github.com>
Subject: [bluez/bluez] 13d214: device: Reset svc_resolved on
 device_discover_serv...
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

  Branch: refs/heads/954076
  Home:   https://github.com/bluez/bluez
  Commit: 13d214c19f71e47a30cfd77c4a868e6fab683ebd
      https://github.com/bluez/bluez/commit/13d214c19f71e47a30cfd77c4a868=
e6fab683ebd
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Reset svc_resolved on device_discover_services() request

This allows profiles requesting to re-retrieve the services records
(SDP or GATT) to be called back once the services are completed using
device_wait_for_svc_complete().


  Commit: c2e574bf2f97482df99435ae9bf34a1b7932693c
      https://github.com/bluez/bluez/commit/c2e574bf2f97482df99435ae9bf34=
a1b7932693c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: device: Browse SDP records if not cached

For a HID paired device, if the cache file containing the SDP records
is not present this will prevent the device to connect and need to
remove it and pair again.

Current bluetoothd traces:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:83:50:76:BD:67
  connected eir_len 31
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 17
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 17
profiles/input/server.c:confirm_event_cb()
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 19
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 19
profiles/input/device.c:hidp_add_connection() Could not parse HID SDP
  record: No such file or directory (2)
profiles/input/device.c:ctrl_watch_cb() Device EC:83:50:76:BD:67
  disconnected
profiles/input/device.c:intr_watch_cb() Device EC:83:50:76:BD:67
  disconnected

This commit tries to retrieve the SDP record from the remote HID then
to add the HIDP connection.


Compare: https://github.com/bluez/bluez/compare/13d214c19f71%5E...c2e574b=
f2f97

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
