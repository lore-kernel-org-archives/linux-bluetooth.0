Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70426F44A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895454; cv=none; b=tSwJC5AfJZpihku8ufmh59AJV9ULZmra1cca0bzr7lZJK3C8BaP/qA1yFyZmVzSw46I3fP/UgA078GTlrsdu3846tvtESuG0YOGuUsVNyjjbhIXPp/XXrGSb8X4oUq6lKKaFrAvhQvQH1bhND506TawzErhe/d/jw3oqjLIIweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895454; c=relaxed/simple;
	bh=qSctJZWko33Ic8oe2UF9LTZYMA43a/AGPNRMvPFwRW4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=awnyRVuqQb9GkltmwXThbt3qwtCmFi5aYVifc8k+jjxjIilKvC1qabUh+MHtftzo0KoHpElTBzspiOOsGVNJ6q/GCOUB+EhYL7zYu8ImIClZr483ruZLBzSH7gqUrEjaCirfOphdhKPPsh6s19VvwJTLJbLjlTC+g6CUO0/oWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hGVcEzjC; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hGVcEzjC"
Received: from github.com (hubbernetes-node-63830de.ac4-iad.github.net [10.52.141.23])
	by smtp.github.com (Postfix) with ESMTPA id 31DE8210CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1739895451;
	bh=X8QuV3hYmr/qXkyYFerdDPweNgOz2mAUVTiOoDfw+LE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hGVcEzjCnssWRLhqJVvT2pyxCBM4G1xoKME9IyNfWt+bv8G3gX1WuyG4lyRqWRgUW
	 z/OwJ4eA+o2qHmywfWuJUIkLRzVW3Qw4N4fB+4Xx2mw/Wc8o0n86rVZP6eZ1yG4ukB
	 S1M85yGLs1M4hhhENUmK956Bq+e2SX9d85Cd0R7I=
Date: Tue, 18 Feb 2025 08:17:31 -0800
From: Ludovico de Nittis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2ee08f-264bf9@github.com>
Subject: [bluez/bluez] 07c14f: shared/shell: Always set stdout to be line
 buffered
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
  Commit: 07c14fcfbd8b0843afca707b72fad77fc64a2098
      https://github.com/bluez/bluez/commit/07c14fcfbd8b0843afca707b72fad=
77fc64a2098
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-16 (Thu, 16 Jan 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Always set stdout to be line buffered

This always set stdout to be line buffered to avoid cluttering the
output:

https://github.com/bluez/bluez/issues/747#issuecomment-2596840382


  Commit: 07e8e726758fd957df3a1c04223c6454d1a2573e
      https://github.com/bluez/bluez/commit/07e8e726758fd957df3a1c04223c6=
454d1a2573e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-17 (Fri, 17 Jan 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Set correct length for getsockopt

When calling getsockopt for BT_ISO_BASE, this initializes the length
argument to the maximum size of the buffer where the bytes are placed.

This fixes the fact that, on a Broadcast Sink, if the BASE discovered
from a Broadcast Source exceeds a certain length, the bytes will be
incompletely read, causing issues when parsing the LTVs.


  Commit: 1479c86ec116b04bdf15b21381b32e621e034acc
      https://github.com/bluez/bluez/commit/1479c86ec116b04bdf15b21381b32=
e621e034acc
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-17 (Fri, 17 Jan 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Append extra L3 LTVs to BIS config

According to the BAP spec, the level 3 of the BASE contains codec
configuration LTVs specific to each BIS, in addition to the
configuration provided at level 2 (subgroup level) (v1.0.1,
section 3.7.2.2 Basic Audio Announcements).

Currently, when a Broadcast Sink parses the BASE discovered from a
Broadcast Source, level 3 LTV types that are not also present at
level 2 are not included in the final BIS cofiguration, causing
incorrect stream handling. This updates the BASE parsing logic to
consider level 3 LTVs.


  Commit: 2767b96ff4341d17791b4a900ee6191572bd1594
      https://github.com/bluez/bluez/commit/2767b96ff4341d17791b4a900ee61=
91572bd1594
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2025-01-22 (Wed, 22 Jan 2025)

  Changed paths:
    M src/shared/vcp.c
    M src/shared/vcp.h

  Log Message:
  -----------
  shared/vcp: add API to control volume on VCP client


  Commit: af8266af13c89c80c10eb307c3ad13fef2bb415c
      https://github.com/bluez/bluez/commit/af8266af13c89c80c10eb307c3ad1=
3fef2bb415c
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2025-01-22 (Wed, 22 Jan 2025)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/transport.c
    M profiles/audio/vcp.c
    A profiles/audio/vcp.h

  Log Message:
  -----------
  audio: connect VCP profile client to MediaTransport

It is now possible to control absolute volume of remote volume renderer
device via dbus and also get notifications if the volume changes.


  Commit: 53d3e2c5d0b940eb5cb37f04ee3391dba7141c7b
      https://github.com/bluez/bluez/commit/53d3e2c5d0b940eb5cb37f04ee339=
1dba7141c7b
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2025-01-22 (Wed, 22 Jan 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: fix memory & connection management

Those changes are mandatory to be able to connect to the same VCP
renderer more than once without need to restart bluez
- don't call vcp_detached on all cbs, as it would clean up too many
  (all) device-related objects
- vcs members can be already set when connecting for the second time


  Commit: 49c53595e50c11997ee864cc586e7c91c16c726a
      https://github.com/bluez/bluez/commit/49c53595e50c11997ee864cc586e7=
c91c16c726a
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2025-01-22 (Wed, 22 Jan 2025)

  Changed paths:
    M profiles/audio/vcp.c

  Log Message:
  -----------
  audio: fix VCP connection management

Those changes are mandatory to be able to connect to the same VCP
renderer more than once without need to restart bluez.
- use vcp_disconnect() to close client connection and reset vcs members
- call bt_vcp_detach() the same way as bt_vcp_attach - from btd_profile
  callback


  Commit: 73b251b8e8f0de46ce2fc8d1834dff529820d458
      https://github.com/bluez/bluez/commit/73b251b8e8f0de46ce2fc8d1834df=
f529820d458
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2025-01-22 (Wed, 22 Jan 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: control volume when acting as a server

Local VCP chatacteristics are now connected to transport properties.


  Commit: 628c15a5b1f6f1db9f4534b609c3732b592b0536
      https://github.com/bluez/bluez/commit/628c15a5b1f6f1db9f4534b609c37=
32b592b0536
  Author: Denis Burkov <hitechshell@mail.ru>
  Date:   2025-01-23 (Thu, 23 Jan 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: add proper line clean to bt_shell_printf

In some terminals (or all?) the line is not cleared before a new one
is output (for example, if you turn on scanning and then try to write
something to the terminal, the output will be mixed - you will get
something like this:

[JBL T450BT]# h[NEW] Device ****
[JBL T450BT]# he[NEW] Device ****
[JBL T450BT]# hell[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****

Where "Device ****" is the line that was actually fed to
bt_shell_printf.


  Commit: 9daadc32e8073f7d036e96ff14bf430892698c59
      https://github.com/bluez/bluez/commit/9daadc32e8073f7d036e96ff14bf4=
30892698c59
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-23 (Thu, 23 Jan 2025)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  org.bluez.MediaTransport: Allow Volume property to follow profile range=


This makes the Volume property to follow the profile defined range.


  Commit: 0aac6883b3a3a95d891e773b0958eb91aba01231
      https://github.com/bluez/bluez/commit/0aac6883b3a3a95d891e773b0958e=
b91aba01231
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-23 (Thu, 23 Jan 2025)

  Changed paths:
    M profiles/audio/transport.c
    M profiles/audio/vcp.c
    M profiles/audio/vcp.h

  Log Message:
  -----------
  vcp: Fix using scaled values for volume

This makes the volume range 0-255 as per VCP spec rather than scaling it
to fit 0-127.


  Commit: fac78ca5dbbdfbb2e60e8daebc8e6b353fd6b00b
      https://github.com/bluez/bluez/commit/fac78ca5dbbdfbb2e60e8daebc8e6=
b353fd6b00b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-01-24 (Fri, 24 Jan 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix crash on remote player changed

bluetoothd crashes when the remote player changes while bluetoothd
is waiting for avrcp_list_items reply.

profiles/audio/player.c:1597:9: runtime error: member access within null =
pointer of type 'struct media_folder'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D825871=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000=
00000020 (pc 0x602bb0fffabc bp 0x000000000020 sp 0x7ffef88216d0 T0)
=3D=3D825871=3D=3DThe signal is caused by a READ memory access.
=3D=3D825871=3D=3DHint: address points to the zero page.
    #0 0x602bb0fffabc in media_folder_find_item profiles/audio/player.c:1=
597
    #1 0x602bb100cd3b in media_folder_create_item profiles/audio/player.c=
:1877
    #2 0x602bb100cd3b in media_player_create_item profiles/audio/player.c=
:1928
    #3 0x602bb107eae6 in parse_media_element profiles/audio/avrcp.c:2605
    #4 0x602bb107eae6 in avrcp_list_items_rsp profiles/audio/avrcp.c:2706=

    #5 0x602bb106892f in browsing_response profiles/audio/avctp.c:987
    #6 0x602bb106892f in session_browsing_cb profiles/audio/avctp.c:1028
    #7 0x73de85b1448d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d48d) (=
BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #8 0x73de85b73716  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc716) (=
BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #9 0x73de85b14f76 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2=
.0.so.0+0x5df76) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #10 0x602bb13a22a8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x602bb13a2bb6 in mainloop_run_with_signal src/shared/mainloop-no=
tify.c:189
    #12 0x602bb0fd0257 in main src/main.c:1544
    #13 0x73de84e2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
    #14 0x73de84e2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #15 0x602bb0fd3124 in _start (/home/fdanis/src/bluez/src/bluetoothd+0=
x5c8124) (BuildId: 367892bd0501d74713dd7341977abfac1b2c5d6a)

This can be reproduced using bluetoothctl and doing "player.list-items"
just before switching music player on the remote device.

This commit discards the item list parsing if the current player has
not created a pending_list_items, i.e. it doesn't start this request.


  Commit: 29f0bdb545a4bd18435ebda9654afc949efd82d6
      https://github.com/bluez/bluez/commit/29f0bdb545a4bd18435ebda9654af=
c949efd82d6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-24 (Fri, 24 Jan 2025)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: Fix warnings when reconnecting

When reconnecting warnings could be seen due to services already
existing which is a new behavior introduced by dbd6591bd1d0
("main.conf: Add GATT.ExportClaimedServices").


  Commit: 171930d5b21599628d7dbae3063c4713faf2ab93
      https://github.com/bluez/bluez/commit/171930d5b21599628d7dbae3063c4=
713faf2ab93
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-01-27 (Mon, 27 Jan 2025)

  Changed paths:
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  transport: fix issues with BAP volumes > 127

Change types used for volumes to int, for BAP volumes > 127 and to
allow -1 as it is used to mean no volume.

Fix BAP max volume check in transport.

Fixes setting BAP volumes.


  Commit: 9f11c1817c56c550537f1d967a0589a0b20029df
      https://github.com/bluez/bluez/commit/9f11c1817c56c550537f1d967a058=
9a0b20029df
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-01-27 (Mon, 27 Jan 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: fix crash on bad attribute index

In gatt_db_attribute_get_value(), avoid NULL pointer deref if attribute
or db is in unexpected state and attrib at index-1 is missing.

Fixes btmon -r crash, on a packet capture obtained with btmon -w after
clearing BlueZ attributes & cache for the device:

=3D=3D208213=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000=
0000000c
=3D=3D208213=3D=3DThe signal is caused by a READ memory access.
=3D=3D208213=3D=3DHint: address points to the zero page.
    #0 0x5af4a6 in bt_uuid_to_uuid128 lib/uuid.c:65
    #1 0x5afd54 in bt_uuid_cmp lib/uuid.c:118
    #2 0x5d0dd2 in gatt_db_attribute_get_value src/shared/gatt-db.c:1663
    #3 0x56aeab in print_value monitor/att.c:158
    #4 0x56b80f in print_attribute monitor/att.c:207
    #5 0x5982f7 in print_handle monitor/att.c:4417
    #6 0x59b1b8 in print_write monitor/att.c:4598
    #7 0x59b796 in att_write_req monitor/att.c:4627
    #8 0x59e91e in att_packet monitor/att.c:4918
    #9 0x4f4847 in l2cap_frame monitor/l2cap.c:2567
    #10 0x4f6022 in l2cap_packet monitor/l2cap.c:2708
    #11 0x4a48f6 in packet_hci_acldata monitor/packet.c:12606
    #12 0x43952a in packet_monitor monitor/packet.c:4247
    #13 0x4170c9 in control_reader monitor/control.c:1517
    #14 0x402f76 in main monitor/main.c:277


  Commit: 6f284a920bcd442f3fb7a0f2475d6342bc7b43e7
      https://github.com/bluez/bluez/commit/6f284a920bcd442f3fb7a0f2475d6=
342bc7b43e7
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-27 (Mon, 27 Jan 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Rework transport.select

Since the transport.select command should also work for transports
created by audio servers, the transport should not be required to
be associated with a local bluetoothctl endpoint, to avoid errors
like below:

[bluetoothctl]> scan on
[bluetoothctl]> [NEW] Device 1C:F1:FA:E7:B0:3F 1C-F1-FA-E7-B0-3F
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd1
[1C-F1-FA-E7-B0-3F]> transport.select
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd
Local endpoint not found

This reworks transport.select to use a dedicated structure to hold
information about the transport and its links, instead of using the
local endpoint.


  Commit: 46fbbd600578a7edc17a1b76ac6b8673335cc601
      https://github.com/bluez/bluez/commit/46fbbd600578a7edc17a1b76ac6b8=
673335cc601
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-27 (Mon, 27 Jan 2025)

  Changed paths:
    M client/bluetoothctl-transport.rst

  Log Message:
  -----------
  client: Update transport.select documentation

This updates the transport.select documentation to explain the expected
behavior when selecting multiple transports and when an audio server is
involved.


  Commit: 36c79632fc9f172afcf0c83cdd4d89fcfa8b3912
      https://github.com/bluez/bluez/commit/36c79632fc9f172afcf0c83cdd4d8=
9fcfa8b3912
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst

  Log Message:
  -----------
  org.bluez.LEAdvertisement: Add dedicated Scan Response field

This adds Scan Response fields as experimental so we can evaluate if
this should be made into a stable API.


  Commit: ab6502473a622fa795cc45bb14b65f8d6f271ac1
      https://github.com/bluez/bluez/commit/ab6502473a622fa795cc45bb14b65=
f8d6f271ac1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Add scan response properties to LEAdvertisement1

This update introduces a few properties to org.bluez.LEAdvertisement1
for manipulating Scan Response Data, similar to the existing properties
for Advertising Data.

Fixes: https://github.com/bluez/bluez/issues/667


  Commit: f9417eafa2adffd779a01b2400145831d493830a
      https://github.com/bluez/bluez/commit/f9417eafa2adffd779a01b2400145=
831d493830a
  Author: Yuxin Wang <yuxinwang9999@gmail.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/bluetoothctl-advertise.rst
    M client/main.c

  Log Message:
  -----------
  advertising: Add scan response support in bluetoothctl

Add commands in the bluetoothctl advertising submenu to manage
scan response data.


  Commit: 1f7a7c9dcadbec6c23d2bd9e946cd706e606e837
      https://github.com/bluez/bluez/commit/1f7a7c9dcadbec6c23d2bd9e946cd=
706e606e837
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  org.bluez.GattCharacteristic: Add confirmation support to AcquireNotify=


This adds confirmation support for AcquireNotify when indication
procedure is used, also document the behavior of clients vs servers.


  Commit: 6b34b055117cebdb9fb502d138cb654c6c9949b7
      https://github.com/bluez/bluez/commit/6b34b055117cebdb9fb502d138cb6=
54c6c9949b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Implement confirmation support for AcquireNotify

This implements AcquireNotify (fd based) confirmation so servers can be
notified when a client confirm the reception of an indication.

Fixes: https://github.com/bluez/bluez/issues/1081


  Commit: f0d0266acd9d0f91f8b68ebcbf9cf0e99f62956c
      https://github.com/bluez/bluez/commit/f0d0266acd9d0f91f8b68ebcbf9cf=
0e99f62956c
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Clear only the pending flags that have been applied

When executing `btd_device_flags_changed()`, `dev->pending_flags` may
hold additional queued flag changes.

Instead of completely clearing out `dev->pending_flags`, we should only
remove the bits that have been actually applied and leaving the rest as
pending.


  Commit: 0acdf186fcde930dfe4c25175dc857ef2d73cefe
      https://github.com/bluez/bluez/commit/0acdf186fcde930dfe4c25175dc85=
7ef2d73cefe
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix the pending changing flags check

When checking if the new desired device flags are already pending, we
should compare them against the XOR of current flags and desired flags,
i.e. the flags that are going to change.

For example, let's assume the following situation:
- We have a device with `current_flags =3D=3D DEVICE_FLAG_REMOTE_WAKEUP`
(i.e. 1)
- We want to disable the `wake_allowed` property
- `device_set_wake_allowed()` will call `adapter_set_device_flags()`
with `flags =3D=3D 0`
- When in `adapter_set_device_flags()`, we'll have:
  - current =3D=3D 1
  - pending =3D=3D 0
  - flags =3D=3D 0
In this situation `flags =3D=3D (flags & pending)` would not return what
we'd expect.


  Commit: 1b37809b1df771fcfc2c46a8ece765359615ad28
      https://github.com/bluez/bluez/commit/1b37809b1df771fcfc2c46a8ece76=
5359615ad28
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M doc/supported-features.txt
    M src/profile.c

  Log Message:
  -----------
  obex: Update the MAP Client version to 1.4 in SDP record

This change is required in below PTS testcase:
1. MAP/MCE/SGSIT/ATTR/BV-10-C
Attribute GSIT - Bluetooth Profile Descriptor List, MAP 1.4

Current MAP Client version 1.2 is being deprecated and withdrawn
from BT Sig, so it is mandatory to update the version.

No additional changes are needed for supporting the new version.


  Commit: 04b220a1e485deb3bf025cdc706a4c3958a1c294
      https://github.com/bluez/bluez/commit/04b220a1e485deb3bf025cdc706a4=
c3958a1c294
  Author: Fedor Pchelkin <pchelkin@ispras.ru>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: actually try to enable MTU auto-tuning

A "0" for the input MTU passed to the underlying socket is supposed to
indicate that its value should be determined by the L2CAP layer.
However, the current code treats a zero imtu just as if there is
nothing to change.

Introduce rework the code to indicate that the zero imtu is
explicitly requested by the caller for the purpose of auto-tuning and -1
is used as not set value.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ae5be371a9f5 ("avdtp: Enable MTU auto tunning")


  Commit: 252a32ac0b3f6f2d34747fb9d9ba6f34e1b9f8be
      https://github.com/bluez/bluez/commit/252a32ac0b3f6f2d34747fb9d9ba6=
f34e1b9f8be
  Author: Fedor Pchelkin <pchelkin@ispras.ru>
  Date:   2025-01-30 (Thu, 30 Jan 2025)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: enable input MTU auto-tuning for the server

L2CAP frames are lost while utilizing some exotic A2DP transports
usually coming up with weird custom MTU sizes so take advantage of
auto-tuning it for such cases.

Found by Linux Verification Center (linuxtesting.org).

Fixes: https://github.com/bluez/bluez/issues/1080


  Commit: 1474c11618bc1092f7dd4b304d3768ce9da02b13
      https://github.com/bluez/bluez/commit/1474c11618bc1092f7dd4b304d376=
8ce9da02b13
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-31 (Fri, 31 Jan 2025)

  Changed paths:
    M Makefile.am
    M Makefile.tools
    R emulator/amp.c
    R emulator/amp.h
    M emulator/main.c
    R lib/a2mp.h
    R lib/amp.h
    R tools/amptest.c
    R tools/parser/amp.c
    M tools/parser/hci.c
    M tools/parser/l2cap.c

  Log Message:
  -----------
  build: Remove AMP related functionality

High Speed, Alternate MAC and PHY (AMP) extension, has been removed from
Bluetooth Core specification on 5.3:

    https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-en=
hancements/

The kernel already have undergone similar changes starting with
e7b02296fb40 ("Bluetooth: Remove BT_HS").


  Commit: e77884accdb22268eb65374fc96c35d9f8788d32
      https://github.com/bluez/bluez/commit/e77884accdb22268eb65374fc96c3=
5d9f8788d32
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-02-03 (Mon, 03 Feb 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: have only one volume change in flight at a time

If bt_vcp_set_volume() is called again before the previous operation has
completed, the requests get the same change counter, and all except the
first one fail.

Fix by waiting until the current request completes, and if volume was
set again during waiting, send a new request with the latest pending
volume value. In this definition, bt_vcp_set_volume() will skip over
intermediate volume updates if they are done too rapidly.

Send only volume requests that change the value to a different one than
last notification we have seen: in this case the request either fails,
or succeeds and generates a new notification.  In theory this guarantees
we always exit waiting, but safeguard it with a timeout.


  Commit: 26ef5a951e8111d360586f1169b8fac2dc2cb613
      https://github.com/bluez/bluez/commit/26ef5a951e8111d360586f1169b8f=
ac2dc2cb613
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M acinclude.m4

  Log Message:
  -----------
  build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3D3

This enables -Wstringop-overflow compiler warnings:

  'Warn for calls to string manipulation functions such as "memcpy" and
  "strcpy" that are determined to overflow the destination buffer.'

Along with -D_FORTIFY_SOURCE=3D3 so the errors like the following can be
captured:

In function =E2=80=98read=E2=80=99,
    inlined from =E2=80=98serial_read_callback=E2=80=99 at emulator/seria=
l.c:90:8:
/usr/include/bits/unistd.h:32:10: error: =E2=80=98__read_alias=E2=80=99 s=
pecified size between 18446744073709490177 and 18446744073709551615 excee=
ds maximum object size 9223372036854775807 [-Werror=3Dstringop-overflow=3D=
]
   32 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~


  Commit: de2773b659d0b25448243d8a746d1767299e8633
      https://github.com/bluez/bluez/commit/de2773b659d0b25448243d8a746d1=
767299e8633
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M emulator/serial.c

  Log Message:
  -----------
  emulator: Fix Werror=3Dstringop-overflow

This fixes the following build errors caused by buf being used as a
static from tracking progress of a packet when it is not necessary since
pkt_data exists for the same reason:

/usr/include/bits/unistd.h:32:10: error: =E2=80=98__read_alias=E2=80=99 s=
pecified size between 18446744073709490177 and 18446744073709551615 excee=
ds maximum object size 9223372036854775807 [-Werror=3Dstringop-overflow=3D=
]
   32 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~
emulator/serial.c: In function =E2=80=98serial_read_callback=E2=80=99:
emulator/serial.c:78:24: note: destination object allocated here
   78 |         static uint8_t buf[4096];
      |                        ^~~
/usr/include/bits/unistd-decl.h:29:16: note: in a call to function =E2=80=
=98__read_alias=E2=80=99 declared with attribute =E2=80=98access (write_o=
nly, 2, 3)=E2=80=99
   29 | extern ssize_t __REDIRECT_FORTIFY (__read_alias, (int __fd, void =
*__buf,
      |                ^~~~~~~~~~~~~~~~~~

Fixes: https://github.com/bluez/bluez/issues/1049


  Commit: 9dbc92a360b25446659387fadd4ab4ffb5abe76f
      https://github.com/bluez/bluez/commit/9dbc92a360b25446659387fadd4ab=
4ffb5abe76f
  Author: Pablo Montes <pmontes@shsconsultores.es>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M tools/mesh-cfgclient.c

  Log Message:
  -----------
  tools: print error on mkdir

On some fresh installations where XDG_CONFIG_SESSION is not defined,
and $HOME/.config is not created yet, mesh-cfgclient failed with no
hints.


  Commit: 9839799b505aae7a99907d71c4316b7b9b5b12f4
      https://github.com/bluez/bluez/commit/9839799b505aae7a99907d71c4316=
b7b9b5b12f4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Fix missing line returns


  Commit: 01a5a268143eb2954de2b3dfd3f27c0b5d00160b
      https://github.com/bluez/bluez/commit/01a5a268143eb2954de2b3dfd3f27=
c0b5d00160b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Add mpris:artUrl support

This commit connects to the bip-avrcp Obex service if the
org.bluez.MediaPlayer ObexPort property exists.
Once connected, the Track properties update may contain an
ImgHandle which is automatically downloaded, then a Metadata
property updated signal is sent on org.mpris.MediaPlayer2.Player
interface.

Some devices share the Obex session between multiple players. So
the Obex session is created by device.

mpris-proxy logs with cover art download and player switch:

$ tools/mpris-proxy
org.bluez appeared
org.bluez.obex appeared
Bluetooth Obex Client /org/bluez/obex found
Bluetooth Adapter /org/bluez/hci0 found
player org.mpris.MediaPlayer2.rhythmbox at :1.159 found
Bluetooth Transport /org/bluez/hci0/dev_24_24_B7_11_82_6C/fd8 found
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 found
Bluetooth Obex Create new session
Player org.mpris.MediaPlayer2.Fr__d__ric_s_S23 created
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/Filesystem f=
ound
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying f=
ound
Bluetooth Folder /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 found
Bluetooth Obex ImgHandle: 0000007
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/i=
tem2 found
Bluetooth Obex cover art available at: /tmp/session9-0000007
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 removed
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player127 found
Bluetooth Obex reuse existing session
Player org.mpris.MediaPlayer2.Fr__d__ric_s_S23_Media_Player created
player org.mpris.MediaPlayer2.Fr__d__ric_s_S23 at :1.1035 disappear
Bluetooth Obex ImgHandle: 0000008
Bluetooth Obex cover art available at: /tmp/session9-0000008


  Commit: 4bc8660651f4143956611a4418248667f8276170
      https://github.com/bluez/bluez/commit/4bc8660651f4143956611a4418248=
667f8276170
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-04 (Tue, 04 Feb 2025)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Fix infinite list items reception

Samsung Music app on Android phone send play list items in loop if
highest bit is set to 1, so limit playlist to 0x7FFFFFFF items.


  Commit: dd5316091c71c0cb3141a5f44580d973d3770eed
      https://github.com/bluez/bluez/commit/dd5316091c71c0cb3141a5f44580d=
973d3770eed
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-02-10 (Mon, 10 Feb 2025)

  Changed paths:
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  gatt: expanded maximum GATT channels to 6

The maximum value of GATT channels should be 6,
including ATT fixed channel(1) and EATT L2CAP CoC(2-6).

Fixes: https://github.com/bluez/bluez/issues/1033


  Commit: f44d3e08e9a1a6cb9570c163fd23a5dcee644c12
      https://github.com/bluez/bluez/commit/f44d3e08e9a1a6cb9570c163fd23a=
5dcee644c12
  Author: Sanchayan Maity <sanchayan@asymptotic.io>
  Date:   2025-02-10 (Mon, 10 Feb 2025)

  Changed paths:
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  shared/asha: Add support for other side update

ASHA specification requires that the status of the other side be
communicated with the start command. The status is also updated
if one of the device in the pair is connected/disconnected after
the other.

Acked-by: Arun Raghavan <arun@asymptotic.io>


  Commit: d3e40e82afba8bbc24df8c23272fbf8a68e6ed67
      https://github.com/bluez/bluez/commit/d3e40e82afba8bbc24df8c23272fb=
f8a68e6ed67
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-02-10 (Mon, 10 Feb 2025)

  Changed paths:
    M acinclude.m4

  Log Message:
  -----------
  build: check first before enabling -D_FORTIFY_SOURCE=3D3

With --disable-optimization, _FORTIFY_SOURCE=3D3 produces compiler
warnings/errors:

/usr/include/features.h:422:4: error: #warning _FORTIFY_SOURCE requires c=
ompiling with optimization (-O) [-Werror=3Dcpp]
  422 | #  warning _FORTIFY_SOURCE requires compiling with optimization (=
-O)

Before enabling it for --enable-maintainer-mode, check the compiler
doesn't fail when using the flag.


  Commit: 8fa5584e5632582583a346b7195fce0ad7d9aff1
      https://github.com/bluez/bluez/commit/8fa5584e5632582583a346b7195fc=
e0ad7d9aff1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-12 (Wed, 12 Feb 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Register bap attached/detached callbacks

This removes the bass_bcast_probe and bass_bcast_remove APIs, in order to=

decouple the BASS and BAP plugins.

Instead, since the BASS Server (BAP Scan Delegator) implementation needs
to reference the bap session, BASS registers bap attached/detached
callbacks with shared/bap.

- After receiving a request from a Broadcast Assistant, the BASS Server
creates a device for the Broadcaster and adds the UUID to probe.

- The service is probed inside the BAP plugin, where a new bt_bap session=

is attached. The service is set as user data beforehand.

- The bt_bap session is notified in the BASS bap_attached callback. The
reference to the service is accessible from the user data.

- The BASS Server takes ownership for the service by setting its user
data. This way, short-lived PA sync will be skipped inside BAP, and the
BASS Server will handle long-lived PA sync and stream configuration.

- When the bt_bap session is removed, it will be notified in the
bap_detached callback.


  Commit: f0e9ecb9f4fe3a7bdb011dc155cf6ad657a289ee
      https://github.com/bluez/bluez/commit/f0e9ecb9f4fe3a7bdb011dc155cf6=
ad657a289ee
  Author: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
  Date:   2025-02-12 (Wed, 12 Feb 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M src/profile.c

  Log Message:
  -----------
  audio: upgrade versions to latest possible to qualify

Most of the existing profile versions are withdrawn
to make PTS successfull, need to upgrade the version
for audio profiles and there are no mandatory feature
changes between these versions are seen.

Version changes
A2DP from 1.3 to 1.4
HFP from 1.7 to 1.8
AVRCP TG from 1.5 to 1.6
AVCTP from 1.3 to 1.4


  Commit: 183c843c084a2d2f9521efac2cdc81af60a75f84
      https://github.com/bluez/bluez/commit/183c843c084a2d2f9521efac2cdc8=
1af60a75f84
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-02-12 (Wed, 12 Feb 2025)

  Changed paths:
    M src/device.c
    M src/gatt-database.c
    M src/shared/gatt-client.c

  Log Message:
  -----------
  client: Set the feature when initializing the client

When writing Client Features feature values, it needs
to determine whether local EATT is enabled.


  Commit: fa4d477ab535851d70fd542968325aaf09679454
      https://github.com/bluez/bluez/commit/fa4d477ab535851d70fd542968325=
aaf09679454
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Broadcast EXT_ADV packets based on its interval

Real BLE devices transmit LE advertisement report packages in given
intervals (typically in range between 20 ms and 10.24 s). With current
kernel module Bluetooth stack implementation it is possible that the
first LE meta packet just after enabling scanning will be lost. It is
not an issue for real devices, because more advertisement reports will
be delivered later (in given interval time).

This patch changes optimistic implementation of sending only one LE
meta packets just after enabling scanning to sending LE meta packets
every minimal interval thus emulating what a real controller would do
and will work around the issue of dropping the very first LE meta packet
by the kernel. For direct advertising, the 10ms interval is used to
provide high duty cycle advertising.


  Commit: f003b90d57b59a56eaed11c0240ae2fde34c64ce
      https://github.com/bluez/bluez/commit/f003b90d57b59a56eaed11c0240ae=
2fde34c64ce
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Emit PropertiesChanged signal for Connectable as well


  Commit: 571bc32fd9d0679e22e6194ce2877bcabc97a762
      https://github.com/bluez/bluez/commit/571bc32fd9d0679e22e6194ce2877=
bcabc97a762
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Increase amount of RAM available in VM

When using default kernel configuration from Ubuntu 24.04 patched with
the configuration from tester.config, the kernel image is too big to run
on 192M bytes of RAM. As a result the test-runner exits without any
message (because of the "quite" kernel command line option).


  Commit: 8e76a4d0dc5603d8b2e3711d217cfe26b7c3b981
      https://github.com/bluez/bluez/commit/8e76a4d0dc5603d8b2e3711d217cf=
e26b7c3b981
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Remove the "-nographic" option passed to QEMU

This option causes QEMU to redirect monitor and serial to the terminal,
but also it modifies the terminal settings and clears it before printing
anything. Such behavior might be annoying because it might clear some
warning messages printed before clearing the screen. Since test-runner
disables QEMU monitor and redirects serial to stdio in an explicit way,
the "-nographic" option can be dropped.


  Commit: 54210e0210d464de0ae6d645228ec586b80dd15d
      https://github.com/bluez/bluez/commit/54210e0210d464de0ae6d645228ec=
586b80dd15d
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@bokowy.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Do not use short-form of readonly option

qemu-system-x86_64: warning: short-form boolean option 'readonly' depreca=
ted
Please use readonly=3Don instead


  Commit: 4577f50e739fc92dd633e8ac6426144a77844fba
      https://github.com/bluez/bluez/commit/4577f50e739fc92dd633e8ac64261=
44a77844fba
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-13 (Thu, 13 Feb 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Use host CPU when starting VM

When running test-runner on Ubuntu 24.04 with mainline kernel compiled
from Ubuntu default configuration with applied tester.config options,
the QEMU is not able to start the test-runner application due to illegal
instruction. Passing '-cpu host' fixes that issue.

> $ tools/test-runner -k linux/arch/x86/boot/bzImage -- tools/mgmt-tester=

> Using QEMU binary /usr/bin/qemu-system-x86_64
> Using kernel image [...]/linux/arch/x86/boot/bzImage
> Found support for Virtual Machine eXtensions
> [...]
> [    0.000000] Linux version 6.14.0-rc2+ (gcc (Ubuntu 13.3.0-6ubuntu2~2=
4.04) 13.3.0 [...]
> [...]
> Running command tools/mgmt-tester
> New process 74 created
> Illegal instruction
> Process 74 exited with status 132
> [    0.881239] reboot: Restarting system
> [    0.881431] reboot: machine restart

Potential caveat:

In case when the KVM is not available on the host, the QEMU will not
start with the warning:
CPU model 'host' requires KVM or HVF


  Commit: af3d67d799aa08a90522ff77029c8d9e3478acc9
      https://github.com/bluez/bluez/commit/af3d67d799aa08a90522ff77029c8=
d9e3478acc9
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-14 (Fri, 14 Feb 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Allow to use host CPU on demand

The "-cpu host" option for QEMU can not be enabled by default because
our CI system does not have a support for KVM. In order to allow to run
the test-runner on systems where binaries built on the host are not
compatible with QEMU CPU variant, the "--qemu-host-cpu" option will add
the "-cpu host" to the QEMU command line arguments.


  Commit: 264bf951f2d687f520898fa3e182291f1261e3a7
      https://github.com/bluez/bluez/commit/264bf951f2d687f520898fa3e1822=
91f1261e3a7
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-02-14 (Fri, 14 Feb 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  device: Clear pending_flags on error

If setting WakeAllowed, or the device privacy, fails, we may end up in a
situation where `pending_flags` is still set to some `DEVICE_FLAG_*`
values, for example from `device_set_wake_allowed()` or
`adapter_set_device_flags()`.

This can confuse further requests because they'll assume that there is
still a pending request in progress.


Compare: https://github.com/bluez/bluez/compare/2ee08ffd4d46...264bf951f2=
d6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
