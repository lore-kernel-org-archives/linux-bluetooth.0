Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAF1A9B3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845243; cv=none; b=konY+nq+AEFdipq2SkoGFa2bDbUXsS+HUlTLuEM4MQFGwN2LIeZGPRVSajG9Qi9koFxSTDINcmOogz3BwA3ID4aAjTnPDWQfHdyrzGiBp3/nWFnCGyz98m3das5NBwPgEhvJHa6RSukVk7AO+/7GurVsOplQyq74LpSh4KJgq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845243; c=relaxed/simple;
	bh=CDv84cogxJmSF0a+aJ+b0Kyd+UcTjzNW++FtT30sY2Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hk+0IRYhVQjuQ3drZemsupOV7VuO1cv/C8EyD0Dd6MQa+ud2EGR5JL+BpqVBVS7x4E9/8oazwHqZrbpGbQtCXIEOXD+g8aQf2k/wSekTLEng6zucpKCysKd8IqXJ2Q0Xn28yFge7+0mBY9xfGND6lldzcI0SI2jzLtsuBTUF8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HQ+1LZW1; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HQ+1LZW1"
Received: from github.com (hubbernetes-node-34c8121.va3-iad.github.net [10.48.143.35])
	by smtp.github.com (Postfix) with ESMTPA id 1A80F8C0FB5
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1733845241;
	bh=tzSf3rb/kBzDaETli9GybG2UBHbtKm6rNstPccXVEmE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HQ+1LZW1DrUrTKjzrg4fKvcCi20EEfNt0iaEJBfrORQUjJ9Izl3bfXf/2UvsLqWKX
	 ZxQC5LcECuTcWbDY5Y/NG3KxwIZJODQVwq2lbIE1ZkRpjedG50W/ih1LXnFXUefKgl
	 XawMxjIOyOzKs9J9jBQAmRnighbVcYnCvlAXCDOk=
Date: Tue, 10 Dec 2024 07:40:41 -0800
From: Airtower <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/756d69-b1fd40@github.com>
Subject: [bluez/bluez] 0d9f5f: shared/gatt-db: Fix possible crash on
 gatt_db_clone
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
  Commit: 0d9f5f6a8c149a6fca30afdc40c10cd6557b2e73
      https://github.com/bluez/bluez/commit/0d9f5f6a8c149a6fca30afdc40c10cd6557b2e73
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-08 (Sun, 08 Dec 2024)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix possible crash on gatt_db_clone

The following crash can happen if the original gatt_db has incomplete
service definitions since the attribute might still be discovering:

 Invalid read of size 4
    at 0x1E5A39: bt_uuid_len (uuid.h:289)
    by 0x1E5A39: service_clone (gatt-db.c:284)
    by 0x1D5EBB: queue_foreach (queue.c:207)
    by 0x1E61CD: gatt_db_clone (gatt-db.c:329)
    by 0x1C18F0: btd_device_set_gatt_db (device.c:7110)
    by 0x1C9F96: foreach_rsi (set.c:295)
    by 0x1D5EBB: queue_foreach (queue.c:207)
    by 0x48EA91F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.8000.3)
    by 0x1CA2C8: btd_set_add_device (set.c:357)
    by 0x1BB9AB: btd_device_add_set (device.c:2049)
    by 0x17FF76: csip_ready (csip.c:243)
    by 0x1FD5CC: csip_notify_ready (csip.c:546)
    by 0x1FD5CC: csip_idle (csip.c:630)
    by 0x1DE20C: idle_notify (gatt-client.c:171)
  Address 0xc is not stack'd, malloc'd or (recently) free'd


  Commit: dbd6591bd1d02ace39debd8a67c75b3cbe9c4d66
      https://github.com/bluez/bluez/commit/dbd6591bd1d02ace39debd8a67c75b3cbe9c4d66
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-08 (Sun, 08 Dec 2024)

  Changed paths:
    M profiles/battery/battery.c
    M profiles/deviceinfo/deviceinfo.c
    M src/btd.h
    M src/gatt-client.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add GATT.ExportClaimedServices

This adds GATT.ExportClaimedService which can be used to allow access to
service under control of bluetoothd(1) since often times it should be
safe to allow read-only access as it shouldn't interfere with each
other, but this one step further and allow the systems to be configured
with read-write as well just in case some sort of workaround is needed,
or for debugging purposes.

Since this is now a proper system policy this removes the expections from
battery and deviceinfo introduced by 713f6f09f017
("profile: Add exception to battery profile for external access") and
0cef5a7996db ("deviceinfo: Enable external flag").


  Commit: a979a33c820f798020e368edaf7c1062405b9d47
      https://github.com/bluez/bluez/commit/a979a33c820f798020e368edaf7c1062405b9d47
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-10 (Tue, 10 Dec 2024)

  Changed paths:
    M monitor/att.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Allow caching of temporary gatt_db

This fixes the problem of not being able to decode GATT traffic when
reading the traces from a file/offline, the gatt_db would be discarded
upon the first disconnection so it didn't work if the trace contains
multiple connections.

To fix this btmon would remember gatt_db discovered at runtime so even
when there multiple connections the same db would be used.


  Commit: b1fd409960001a77cda2a09ecc00147ebd9c3667
      https://github.com/bluez/bluez/commit/b1fd409960001a77cda2a09ecc00147ebd9c3667
  Author: Fiona Klute <fiona.klute@gmx.de>
  Date:   2024-12-10 (Tue, 10 Dec 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Leave config files writable for owner

This is needed for builds running as non-root users, so the build
process and any distribution tools can create/move/delete files in the
config directory without adjusting permissions separately. Limiting
writes from the running service needs to be done in the systemd unit
(already the case) or init script.

See also: https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-74981b62ecca@gmx.de/T/
Reviewed-by: Bastien Nocera <hadess@hadess.net>


Compare: https://github.com/bluez/bluez/compare/756d69fd3db8...b1fd40996000

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
