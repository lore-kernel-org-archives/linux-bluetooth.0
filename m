Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70976255259
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592728; cv=none; b=JT010v+41WBIHn7wEJo7QXwV0xfkj1vFSCP7KLhJmbHNvZkrIJ1xeglkc7nTNJoWazlikYcFj4aZLCXgL5/mlDilB2iSEBFwI3LOXGPDu59/YSrDx7UikdoyUtvIV06Xu2aLQwHKeJPCMnuZoa5HU+TM/Fl16SPlre+ZgFbNZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592728; c=relaxed/simple;
	bh=iVUjtNgP4rX6+xI7XjbParECfryEI6ZyDHQonepayM0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j5pJHebBQeC7LCqTvaQJnadZKThDWHMxfL+Rmgktc0RwIrDTKSM7XMxX6KAoET8DhyzSMOGn34hPQpgwN8D04asoubNS6UoQZbWTpoemamo3YsENcWdXGCntLhto3kNFue1pE+odPoKQU9IYlg2iqGXh8OwFfCOrhLmjvA7SMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LRasaEt0; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LRasaEt0"
Received: from github.com (hubbernetes-node-f40e82d.ac4-iad.github.net [10.52.159.52])
	by smtp.github.com (Postfix) with ESMTPA id 76B1021388
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745592723;
	bh=1m/qCMXGlSJpa15rjXXXQTR3EfavKm2bToBLsbMjDeE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LRasaEt09xYAvCWuCDApXUuFWenaKN804kqLGCEy8YFgw0e5gArCUazyz0ZSFT+TQ
	 WwPeepGj6w41JVRyyeto3K0ClhiMa6Q2haKCbDXb358s2f7QL+vFekRnxbP4Oq4Kem
	 EaSRFZGz2UACsaBb/IU+zf24blCQOMdbgdQWltF0=
Date: Fri, 25 Apr 2025 07:52:03 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957071/000000-409078@github.com>
Subject: [bluez/bluez] 409078: device: Check presence of ServiceRecords when
 load...
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

  Branch: refs/heads/957071
  Home:   https://github.com/bluez/bluez
  Commit: 4090786a2a3d54d17526112ae3918599eb52fca5
      https://github.com/bluez/bluez/commit/4090786a2a3d54d17526112ae3918=
599eb52fca5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Check presence of ServiceRecords when loading from store

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

This commit sets BREDR svc_resolved to false if the ServiceRecords
entry is not present in the cache file, triggering service rediscover
on next device connection.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
