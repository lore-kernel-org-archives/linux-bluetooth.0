Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1639F304
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100039; cv=none; b=ulr/Ip5jjfNMBmShzj/VAkVmCzQJ9IwPCQLdrmSR2Zy1UAU1oJED5CYzqVpxKPD4jUjmZaCbR3LBWFvoXQIJanxMS3js1kgiRBfNAmRTOPAgK8A1ZuDlelUd8+vF7rOzjXl61aB15gEj/dZuvmurdtMp0u6YWtlGVNZ1sVcnR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100039; c=relaxed/simple;
	bh=D38ZgbS3/J0TQgPHeSOupw1IlUOQqKrFc2XxFk2VDCI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AdBsI976fS+Murum1ZdxX576TZTwqx58RDWMnCtUAnBo8SPboRRyJUomHdGh87FrEeSqvwwb28oIRYH/eraDbKGHDFXHAr7Irr8VjN5rS9Dsqi0zTiiS9tKtvp1L4ofJWkvDQ+GW4UHAaYvDeg9btDFGU1f54kqTM7stR3MiEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K5ofLhde; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K5ofLhde"
Received: from github.com (hubbernetes-node-7d992c4.ash1-iad.github.net [10.56.224.30])
	by smtp.github.com (Postfix) with ESMTPA id DFFD3922273
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769100027;
	bh=+dpjo7pyvraDDrGirpr2tNpgayT3UwMhptIC50oet/I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K5ofLhdePuM3X8liAZk45tDQg0c9iTiFBXGhDOcbgX9B9RNMdO0QXD7n5iL6SH2ye
	 qSIdEhjiLDP0hiJVsVA0mSzcr/uz66bp5DeICXv6YOBAlgMrr0QEEzBiYUBdA8dUlE
	 hy10oAdd2akq1b0cCDsOqlA5oqVfjBJ6zAjl5OBA=
Date: Thu, 22 Jan 2026 08:40:27 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c24f0b-8dea25@github.com>
Subject: [bluez/bluez] fdf82c: adapter: Fix bt_uuid_hash() crash
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: fdf82c79f8f3b94963c0d8f578b4f8e0ddb06883
      https://github.com/bluez/bluez/commit/fdf82c79f8f3b94963c0d8f578b4f=
8e0ddb06883
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix bt_uuid_hash() crash

This is reproducible on Ubuntu 24.04, which enables libasan, by
calling org.bluez.AdminPolicySet1.SetServiceAllowList() method with
an array of UUIDs like ['110c','110e']:

bluetoothd[9975]: [:1.1435:method_call] > org.bluez.AdminPolicySet1.SetSe=
rviceAllowList [#468]
bluetoothd[9975]: plugins/admin.c:set_service_allowlist() sender :1.1435
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9975=3D=3DERROR: AddressSanitizer: unknown-crash on address 0x763ae=
f383ee4 at pc 0x648113f85064 bp 0x7fffe4db4970 sp 0x7fffe4db4960
WRITE of size 16 at 0x763aef383ee4 thread T0
    #0 0x648113f85063 in bt_uuid16_to_uuid128 lib/bluetooth/uuid.c:35
    #1 0x648113f85063 in bt_uuid_to_uuid128 lib/bluetooth/uuid.c:73
    #2 0x648113e90459 in bt_uuid_hash src/adapter.c:3891
    #3 0x763af2700a5b in g_hash_table_add (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x49a5b) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #4 0x648113fa7232 in queue_foreach src/shared/queue.c:207
    #5 0x648113eb69df in btd_adapter_set_allowed_uuids src/adapter.c:3924=

    #6 0x648113cd6f11 in service_allowlist_set plugins/admin.c:165
    #7 0x648113cd8162 in set_service_allowlist plugins/admin.c:382
    #8 0x648113f97564 in process_message gdbus/object.c:293
    #9 0x763af2f6f553 in dbus_connection_dispatch (/lib/x86_64-linux-gnu/=
libdbus-1.so.3+0x18553) (BuildId: 47829078e4267099473c6cf5f5742f16ccb2644=
d)
    #10 0x648113f86d47 in message_dispatch gdbus/mainloop.c:59
    #11 0x763af271440d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d40d) =
(BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #12 0x763af2773766  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc766) =
(BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #13 0x763af2714ef6 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x5def6) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #14 0x6481140bf9d8 in mainloop_run src/shared/mainloop-glib.c:65
    #15 0x6481140c0306 in mainloop_run_with_signal src/shared/mainloop-no=
tify.c:196
    #16 0x648113c93d58 in main src/main.c:1550
    #17 0x763af1a2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
    #18 0x763af1a2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #19 0x648113c96854 in _start (/home/fdanis/src/bluez/src/bluetoothd+0=
x65d854) (BuildId: 4e2b98c227059c308efb311ffe5b023d60e142ac)

Address 0x763aef383ee4 is located in stack of thread T0 at offset 36 in f=
rame
    #0 0x648113e903df in bt_uuid_hash src/adapter.c:3884


  Commit: ad1ab05699b125ea41626217fbde116af3ae86a3
      https://github.com/bluez/bluez/commit/ad1ab05699b125ea41626217fbde1=
16af3ae86a3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/qualification/l2cap-pics.rst
    A doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the L2CAP qualification


  Commit: 8dea2591fcc2e9bd5a44646d7e41da0cf5c0359a
      https://github.com/bluez/bluez/commit/8dea2591fcc2e9bd5a44646d7e41d=
a0cf5c0359a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Fix eir data on GAP device found event

This allows to pass GAP/BROB/OBSV/BV-05-C test with auto-pts.


Compare: https://github.com/bluez/bluez/compare/c24f0b487ca3...8dea2591fc=
c2

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
