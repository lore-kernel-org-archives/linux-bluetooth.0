Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF9205AB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917986; cv=none; b=eiLYOxbPWfkmkdKNrRCP85WxKkC6/ceJmCWQxAClhUosNqqZx8tmbSuS/kIPSj0y1zGMaKmlEL+ebTdOJvM7O7B913KjH+ezpxLbaszy6XxCiTLWh+e70ZVZvD4j0adjFhJna5P3J/89kWRgLlBXOOL3FLEDkl2/g4fAfAfa4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917986; c=relaxed/simple;
	bh=yX2LLuvkJlBE0IV4c2juQxej+w3lQyjGx5fb3mgKJv8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Te0W/gPRoyXhKAzZCwFhux3gXQectVbQ2Fkic5dF26+GEJXnNa2kDihB46k4GCQ3OGA0Zcl7+z97r2EoIaE4s2zbTxa+QQ71y6ksmxbNtQFp62GogHQ8h8fLSxnnlfO25QIfgRiJErEipOuRE5JpV3UA5VhF7kc0rdPoe1bTw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IrUCUsLK; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IrUCUsLK"
Received: from github.com (hubbernetes-node-3f5db98.ac4-iad.github.net [10.52.181.63])
	by smtp.github.com (Postfix) with ESMTPA id 38EB0203FA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754917983;
	bh=9/ArGWRpYXYVXr9SC6zxfrJUF3OxobLPTyf2JjuvBR4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IrUCUsLK1/pANtlK5S9Vtfzp+WtsTB3uzQ+inTQff27lOqsbzGZCf92lfXNVzl7ST
	 +99syhcgwB914gnhuz3eVnE5LOPXYhT5vbtnjSWwqoUdrh0QgSTf4fRS9zy1XGpnl7
	 UMpbNWqO7AkGTLd7Dpg/yVAvS1E/Y1YdvtbVSErs=
Date: Mon, 11 Aug 2025 06:13:03 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/af816a-0cac14@github.com>
Subject: [bluez/bluez] 10977a: iso-tester: Add ISO Reconnect Send and Receive
 #16
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
  Commit: 10977abda3f8667ecdf67da1620e05e264df6c3a
      https://github.com/bluez/bluez/commit/10977abda3f8667ecdf67da1620e0=
5e264df6c3a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add ISO Reconnect Send and Receive #16

This adds ISO Reconnect Send and Receive #16 which test reconnecting,
send/receive datas, 16 times to stress test the handling of reconnecting
logic and confirm tha POLLOUT is generated everytime:

ISO Reconnect Send and Receive #16 - Success - run
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #16...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #15...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #14...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #13...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #12...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #11...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #10...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #9...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #8...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #7...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #6...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #5...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #4...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #3...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #2...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #1...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
ISO Reconnect Send and Receive #16 - Success - test passed


  Commit: ae29fcb2acc0d63935edb6c7313dbd766ef3a281
      https://github.com/bluez/bluez/commit/ae29fcb2acc0d63935edb6c7313db=
d766ef3a281
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    M attrib/att.c
    M attrib/gatt.c
    M attrib/gattrib.c
    M attrib/gatttool.c
    M attrib/interactive.c
    M attrib/utils.c
    M btio/btio.c
    M client/assistant.c
    M client/mgmt.c
    M client/player.c
    M emulator/b1ee.c
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h
    M emulator/hciemu.c
    M emulator/le.c
    M emulator/serial.c
    M emulator/server.c
    M emulator/smp.c
    M emulator/vhci.c
    R lib/bluetooth.c
    R lib/bluetooth.h
    A lib/bluetooth/bluetooth.c
    A lib/bluetooth/bluetooth.h
    A lib/bluetooth/bnep.h
    A lib/bluetooth/cmtp.h
    A lib/bluetooth/hci.c
    A lib/bluetooth/hci.h
    A lib/bluetooth/hci_lib.h
    A lib/bluetooth/hidp.h
    A lib/bluetooth/iso.h
    A lib/bluetooth/l2cap.h
    A lib/bluetooth/mgmt.h
    A lib/bluetooth/rfcomm.h
    A lib/bluetooth/sco.h
    A lib/bluetooth/sdp.c
    A lib/bluetooth/sdp.h
    A lib/bluetooth/sdp_lib.h
    A lib/bluetooth/uuid.c
    A lib/bluetooth/uuid.h
    R lib/bnep.h
    R lib/cmtp.h
    R lib/hci.c
    R lib/hci.h
    R lib/hci_lib.h
    R lib/hidp.h
    R lib/iso.h
    R lib/l2cap.h
    R lib/mgmt.h
    R lib/rfcomm.h
    R lib/sco.h
    R lib/sdp.c
    R lib/sdp.h
    R lib/sdp_lib.h
    R lib/uuid.c
    R lib/uuid.h
    M mesh/main.c
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh-io.c
    M mesh/mesh-mgmt.c
    M monitor/a2dp.c
    M monitor/analyze.c
    M monitor/att.c
    M monitor/avctp.c
    M monitor/avdtp.c
    M monitor/bnep.c
    M monitor/control.c
    M monitor/hcidump.c
    M monitor/intel.c
    M monitor/l2cap.c
    M monitor/msft.c
    M monitor/packet.c
    M monitor/rfcomm.c
    M monitor/sdp.c
    M obexd/client/bluetooth.c
    M obexd/client/map.c
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    M obexd/plugins/syncevolution.c
    M peripheral/attach.c
    M peripheral/gap.c
    M peripheral/gatt.c
    M plugins/admin.c
    M plugins/autopair.c
    M plugins/hostname.c
    M plugins/neard.c
    M plugins/policy.c
    M plugins/sixaxis.c
    M profiles/audio/a2dp.c
    M profiles/audio/asha.c
    M profiles/audio/avctp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avrcp.c
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/ccp.c
    M profiles/audio/control.c
    M profiles/audio/csip.c
    M profiles/audio/mcp.c
    M profiles/audio/media.c
    M profiles/audio/micp.c
    M profiles/audio/sink.c
    M profiles/audio/source.c
    M profiles/audio/transport.c
    M profiles/audio/vcp.c
    M profiles/battery/bas.c
    M profiles/battery/battery.c
    M profiles/cups/hcrp.c
    M profiles/cups/main.c
    M profiles/cups/sdp.c
    M profiles/cups/spp.c
    M profiles/deviceinfo/deviceinfo.c
    M profiles/deviceinfo/dis.c
    M profiles/gap/gas.c
    M profiles/health/hdp.c
    M profiles/health/hdp_manager.c
    M profiles/health/hdp_util.c
    M profiles/health/mcap.c
    M profiles/input/device.c
    M profiles/input/hog-lib.c
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/input/server.c
    M profiles/midi/midi.c
    M profiles/network/bnep.c
    M profiles/network/connection.c
    M profiles/network/manager.c
    M profiles/network/server.c
    M profiles/sap/manager.c
    M profiles/sap/server.c
    M profiles/scanparam/scan.c
    M profiles/scanparam/scpp.c
    M src/adapter.c
    M src/adapter.h
    M src/adv_monitor.c
    M src/advertising.c
    M src/agent.c
    M src/battery.c
    M src/bearer.c
    M src/device.c
    M src/eir.c
    M src/eir.h
    M src/gatt-client.c
    M src/gatt-database.c
    M src/log.c
    M src/main.c
    M src/oui.c
    M src/plugin.c
    M src/profile.c
    M src/rfkill.c
    M src/sdp-client.c
    M src/sdp-xml.c
    M src/sdpd-database.c
    M src/sdpd-request.c
    M src/sdpd-server.c
    M src/sdpd-service.c
    M src/service.c
    M src/settings.c
    M src/shared/ad.c
    M src/shared/ad.h
    M src/shared/asha.c
    M src/shared/att.c
    M src/shared/bap.c
    M src/shared/bass.c
    M src/shared/btp.c
    M src/shared/ccp.c
    M src/shared/csip.c
    M src/shared/gap.c
    M src/shared/gatt-client.c
    M src/shared/gatt-db.c
    M src/shared/gatt-helpers.c
    M src/shared/gatt-server.c
    M src/shared/log.c
    M src/shared/mcp.c
    M src/shared/mgmt.c
    M src/shared/micp.c
    M src/shared/tester.c
    M src/shared/util.c
    M src/shared/vcp.c
    M src/storage.c
    M src/uuid-helper.c
    M tools/advtest.c
    M tools/avinfo.c
    M tools/avtest.c
    M tools/bdaddr.c
    M tools/bluetooth-player.c
    M tools/bnep-tester.c
    M tools/bneptest.c
    M tools/btattach.c
    M tools/btgatt-client.c
    M tools/btgatt-server.c
    M tools/btiotest.c
    M tools/btmon-logger.c
    M tools/btpclient.c
    M tools/btpclientctl.c
    M tools/ciptool.c
    M tools/cltest.c
    M tools/hciattach.c
    M tools/hciattach_ath3k.c
    M tools/hciattach_bcm43xx.c
    M tools/hciattach_intel.c
    M tools/hciattach_qualcomm.c
    M tools/hciattach_st.c
    M tools/hciattach_ti.c
    M tools/hciattach_tialt.c
    M tools/hciconfig.c
    M tools/hcidump.c
    M tools/hcieventmask.c
    M tools/hcisecfilter.c
    M tools/hcitool.c
    M tools/hwdb.c
    M tools/ioctl-tester.c
    M tools/iso-tester.c
    M tools/isotest.c
    M tools/l2cap-tester.c
    M tools/l2ping.c
    M tools/l2test.c
    M tools/mcaptest.c
    M tools/mesh-gatt/gatt.c
    M tools/mesh-tester.c
    M tools/mesh/agent.c
    M tools/meshctl.c
    M tools/mgmt-tester.c
    M tools/oobtest.c
    M tools/parser/hci.c
    M tools/parser/l2cap.c
    M tools/parser/lmp.c
    M tools/parser/parser.h
    M tools/rctest.c
    M tools/rfcomm-tester.c
    M tools/rfcomm.c
    M tools/sco-tester.c
    M tools/scotest.c
    M tools/sdptool.c
    M tools/smp-tester.c
    M tools/test-runner.c
    M tools/userchan-tester.c
    M unit/avctp.c
    M unit/avdtp.c
    M unit/avrcp-lib.c
    M unit/avrcp.c
    M unit/test-avrcp.c
    M unit/test-bap.c
    M unit/test-bass.c
    M unit/test-eir.c
    M unit/test-gatt.c
    M unit/test-gattrib.c
    M unit/test-hog.c
    M unit/test-lib.c
    M unit/test-mgmt.c
    M unit/test-micp.c
    M unit/test-sdp.c
    M unit/test-uuid.c
    M unit/test-vcp.c

  Log Message:
  -----------
  build: Move library source to lib/bluetooth

This fixes the installed directory hierarchy not matching the source
directory hierarchy.


  Commit: eb40539c7e5a3acba685f6b22776ff464a316a94
      https://github.com/bluez/bluez/commit/eb40539c7e5a3acba685f6b22776f=
f464a316a94
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M client/display.c

  Log Message:
  -----------
  client: Fix missing strdup/memset declarations

bluez/client/display.c: In function =E2=80=98rl_prompt_input=E2=80=99:
bluez/client/display.c:112:24: error: implicit declaration of function =E2=
=80=98strdup=E2=80=99 [-Wimplicit-function-declaration]
  112 |         saved_prompt =3D strdup(rl_prompt);
      |                        ^~~~~~
bluez/client/display.c:112:24: warning: incompatible implicit declaration=
 of built-in function =E2=80=98strdup=E2=80=99 [-Wbuiltin-declaration-mis=
match]
bluez/client/display.c:119:9: error: implicit declaration of function =E2=
=80=98memset=E2=80=99 [-Wimplicit-function-declaration]
  119 |         memset(prompt, 0, sizeof(prompt));
      |         ^~~~~~
bluez/client/display.c:24:1: note: include =E2=80=98<string.h>=E2=80=99 o=
r provide a declaration of =E2=80=98memset=E2=80=99
   23 | #include "display.h"
  +++ |+#include <string.h>
   24 |
bluez/client/display.c:119:9: warning: incompatible implicit declaration =
of built-in function =E2=80=98memset=E2=80=99 [-Wbuiltin-declaration-mism=
atch]
  119 |         memset(prompt, 0, sizeof(prompt));
      |         ^~~~~~
bluez/client/display.c:119:9: note: include =E2=80=98<string.h>=E2=80=99 =
or provide a declaration of =E2=80=98memset=E2=80=99


  Commit: 0cac149a4bdfd96350e34bb8bcd9baff6df9f143
      https://github.com/bluez/bluez/commit/0cac149a4bdfd96350e34bb8bcd9b=
aff6df9f143
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M tools/mesh/agent.c

  Log Message:
  -----------
  mesh: Fix 'buf=E2=80=99 may be used uninitialized warning

../dist-unpack/bluez-5.83/tools/mesh/agent.c: In function =E2=80=98respon=
se_decimal=E2=80=99:
../dist-unpack/bluez-5.83/tools/mesh/agent.c:94:9: warning: =E2=80=98buf=E2=
=80=99 may be used uninitialized [-Wmaybe-uninitialized]
   94 |         bt_put_be32(atoi(input), buf);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../dist-unpack/bluez-5.83/tools/mesh/agent.c:20:
../dist-unpack/bluez-5.83/lib/bluetooth/bluetooth.h:342:20: note: by argu=
ment 2 of type =E2=80=98const void *=E2=80=99 to =E2=80=98bt_put_be32=E2=80=
=99 declared here
  342 | static inline void bt_put_be32(uint32_t val, const void *ptr)
      |                    ^~~~~~~~~~~
../dist-unpack/bluez-5.83/tools/mesh/agent.c:88:17: note: =E2=80=98buf=E2=
=80=99 declared here
   88 |         uint8_t buf[DECIMAL_OOB_LEN];
      |                 ^~~


Compare: https://github.com/bluez/bluez/compare/af816afa7ed1...0cac149a4b=
df

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
