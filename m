Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0E1C5D72
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581891; cv=none; b=lRUaOEvZBTyxtaNwG2y17pNMxjr6lkEdY7LlrwvY+ZN4k/mV1tqCTZwIM9esy0aDw73Er5YLr1rOaTocUrjIhSad1Uask0OTQGGi/sqkc3SgyGOTVC9n9UZyz2a57mBBWh1pdn8aDSZFzlADmXLNsMQYvqA3P3EOGW9wq/0RYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581891; c=relaxed/simple;
	bh=/lEQ9Lp8ur68f+iNezUgi9CrKfP8+HabYnOTaXJOqTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqPfjUMvp9qrNhZCJPwI6GsikYkn6QSJybp6Iu4WVfMxgHZUh4vUlu0ad+Ife4HqLKatvj+ixns9m7D9GIyGLr5bUFKUZ2XX3LjpZLaSkd/7TxJkYPuAlfR+rm+3+uo/sKLqC1Jh6+WVe0piXhuP3qBitO/Wg0hGizQA38EB+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BAA81F68F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:51:24 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Prepare for meson build system
Date: Thu,  7 Aug 2025 17:50:28 +0200
Message-ID: <20250807155115.1037982-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepgeeuvdegvdejtefghfehieeghedvteefjeehvddtjeeuhfetjeeiuddutddvhfeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

Changes since v1:
- Fixed make distcheck

Bastien Nocera (3):
  build: Move library source to lib/bluetooth
  client: Fix missing strdup/memset declarations
  mesh: Fix 'buf’ may be used uninitialized warning

 .gitignore                       |  1 -
 Makefile.am                      | 25 ++++++++-----------------
 attrib/att.c                     |  4 ++--
 attrib/gatt.c                    |  6 +++---
 attrib/gattrib.c                 |  4 ++--
 attrib/gatttool.c                | 10 +++++-----
 attrib/interactive.c             |  6 +++---
 attrib/utils.c                   | 10 +++++-----
 btio/btio.c                      | 10 +++++-----
 client/assistant.c               |  4 ++--
 client/display.c                 |  1 +
 client/mgmt.c                    | 14 +++++++-------
 client/player.c                  |  6 +++---
 emulator/b1ee.c                  |  4 ++--
 emulator/btdev.c                 |  4 ++--
 emulator/bthost.c                |  2 +-
 emulator/bthost.h                |  2 +-
 emulator/hciemu.c                |  4 ++--
 emulator/le.c                    |  4 ++--
 emulator/serial.c                |  4 ++--
 emulator/server.c                |  4 ++--
 emulator/smp.c                   |  4 ++--
 emulator/vhci.c                  |  4 ++--
 lib/{ => bluetooth}/bluetooth.c  |  0
 lib/{ => bluetooth}/bluetooth.h  |  0
 lib/{ => bluetooth}/bnep.h       |  0
 lib/{ => bluetooth}/cmtp.h       |  0
 lib/{ => bluetooth}/hci.c        |  0
 lib/{ => bluetooth}/hci.h        |  0
 lib/{ => bluetooth}/hci_lib.h    |  0
 lib/{ => bluetooth}/hidp.h       |  0
 lib/{ => bluetooth}/iso.h        |  0
 lib/{ => bluetooth}/l2cap.h      |  0
 lib/{ => bluetooth}/mgmt.h       |  0
 lib/{ => bluetooth}/rfcomm.h     |  0
 lib/{ => bluetooth}/sco.h        |  0
 lib/{ => bluetooth}/sdp.c        |  0
 lib/{ => bluetooth}/sdp.h        |  0
 lib/{ => bluetooth}/sdp_lib.h    |  0
 lib/{ => bluetooth}/uuid.c       |  2 +-
 lib/{ => bluetooth}/uuid.h       |  0
 mesh/main.c                      |  4 ++--
 mesh/mesh-io-generic.c           |  4 ++--
 mesh/mesh-io-mgmt.c              |  6 +++---
 mesh/mesh-io.c                   |  4 ++--
 mesh/mesh-mgmt.c                 |  4 ++--
 monitor/a2dp.c                   |  2 +-
 monitor/analyze.c                |  2 +-
 monitor/att.c                    |  8 ++++----
 monitor/avctp.c                  |  4 ++--
 monitor/avdtp.c                  |  2 +-
 monitor/bnep.c                   |  4 ++--
 monitor/control.c                |  6 +++---
 monitor/hcidump.c                |  6 +++---
 monitor/intel.c                  |  4 ++--
 monitor/l2cap.c                  |  4 ++--
 monitor/msft.c                   |  4 ++--
 monitor/packet.c                 |  8 ++++----
 monitor/rfcomm.c                 |  4 ++--
 monitor/sdp.c                    |  4 ++--
 obexd/client/bluetooth.c         |  8 ++++----
 obexd/client/map.c               |  2 +-
 obexd/client/pbap.c              |  4 ++--
 obexd/plugins/bluetooth.c        |  4 ++--
 obexd/plugins/syncevolution.c    |  2 +-
 peripheral/attach.c              |  6 +++---
 peripheral/gap.c                 |  4 ++--
 peripheral/gatt.c                |  6 +++---
 plugins/admin.c                  |  4 ++--
 plugins/autopair.c               |  4 ++--
 plugins/hostname.c               |  4 ++--
 plugins/neard.c                  |  6 +++---
 plugins/policy.c                 |  8 ++++----
 plugins/sixaxis.c                |  6 +++---
 profiles/audio/a2dp.c            |  8 ++++----
 profiles/audio/asha.c            |  6 +++---
 profiles/audio/avctp.c           |  8 ++++----
 profiles/audio/avdtp.c           |  8 ++++----
 profiles/audio/avrcp.c           |  2 +-
 profiles/audio/bap.c             | 10 +++++-----
 profiles/audio/bass.c            |  6 +++---
 profiles/audio/ccp.c             |  8 ++++----
 profiles/audio/control.c         |  8 ++++----
 profiles/audio/csip.c            |  8 ++++----
 profiles/audio/mcp.c             |  8 ++++----
 profiles/audio/media.c           |  8 ++++----
 profiles/audio/micp.c            |  8 ++++----
 profiles/audio/sink.c            |  4 ++--
 profiles/audio/source.c          |  4 ++--
 profiles/audio/transport.c       |  6 +++---
 profiles/audio/vcp.c             |  8 ++++----
 profiles/battery/bas.c           |  6 +++---
 profiles/battery/battery.c       |  8 ++++----
 profiles/cups/hcrp.c             |  8 ++++----
 profiles/cups/main.c             |  6 +++---
 profiles/cups/sdp.c              |  6 +++---
 profiles/cups/spp.c              |  8 ++++----
 profiles/deviceinfo/deviceinfo.c |  6 +++---
 profiles/deviceinfo/dis.c        |  6 +++---
 profiles/gap/gas.c               |  8 ++++----
 profiles/health/hdp.c            |  6 +++---
 profiles/health/hdp_manager.c    |  6 +++---
 profiles/health/hdp_util.c       |  8 ++++----
 profiles/health/mcap.c           |  2 +-
 profiles/input/device.c          | 10 +++++-----
 profiles/input/hog-lib.c         |  6 +++---
 profiles/input/hog.c             |  6 +++---
 profiles/input/manager.c         |  8 ++++----
 profiles/input/server.c          |  6 +++---
 profiles/midi/midi.c             |  6 +++---
 profiles/network/bnep.c          |  8 ++++----
 profiles/network/connection.c    |  8 ++++----
 profiles/network/manager.c       |  8 ++++----
 profiles/network/server.c        | 10 +++++-----
 profiles/sap/manager.c           |  4 ++--
 profiles/sap/server.c            |  6 +++---
 profiles/scanparam/scan.c        |  6 +++---
 profiles/scanparam/scpp.c        |  6 +++---
 src/adapter.c                    |  4 ++--
 src/adapter.h                    |  4 ++--
 src/adv_monitor.c                |  4 ++--
 src/advertising.c                |  6 +++---
 src/agent.c                      |  4 ++--
 src/battery.c                    |  2 +-
 src/bearer.c                     |  4 ++--
 src/device.c                     | 10 +++++-----
 src/eir.c                        |  6 +++---
 src/eir.h                        |  4 ++--
 src/gatt-client.c                |  6 +++---
 src/gatt-database.c              | 10 +++++-----
 src/log.c                        |  4 ++--
 src/main.c                       |  6 +++---
 src/oui.c                        |  2 +-
 src/plugin.c                     |  2 +-
 src/profile.c                    |  8 ++++----
 src/rfkill.c                     |  4 ++--
 src/sdp-client.c                 |  6 +++---
 src/sdp-xml.c                    |  4 ++--
 src/sdpd-database.c              |  6 +++---
 src/sdpd-request.c               |  8 ++++----
 src/sdpd-server.c                |  8 ++++----
 src/sdpd-service.c               |  6 +++---
 src/service.c                    |  4 ++--
 src/settings.c                   |  4 ++--
 src/shared/ad.c                  |  4 ++--
 src/shared/ad.h                  |  4 ++--
 src/shared/asha.c                |  4 ++--
 src/shared/att.c                 |  6 +++---
 src/shared/bap.c                 |  4 ++--
 src/shared/bass.c                |  4 ++--
 src/shared/btp.c                 |  2 +-
 src/shared/ccp.c                 |  6 +++---
 src/shared/csip.c                |  4 ++--
 src/shared/gap.c                 |  4 ++--
 src/shared/gatt-client.c         |  4 ++--
 src/shared/gatt-db.c             |  4 ++--
 src/shared/gatt-helpers.c        |  4 ++--
 src/shared/gatt-server.c         |  4 ++--
 src/shared/log.c                 |  4 ++--
 src/shared/mcp.c                 |  6 +++---
 src/shared/mgmt.c                |  6 +++---
 src/shared/micp.c                |  4 ++--
 src/shared/tester.c              |  4 ++--
 src/shared/util.c                |  2 +-
 src/shared/vcp.c                 |  4 ++--
 src/storage.c                    |  8 ++++----
 src/uuid-helper.c                |  6 +++---
 tools/advtest.c                  |  4 ++--
 tools/avinfo.c                   |  8 ++++----
 tools/avtest.c                   | 10 +++++-----
 tools/bdaddr.c                   |  6 +++---
 tools/bluetooth-player.c         |  4 ++--
 tools/bnep-tester.c              |  6 +++---
 tools/bneptest.c                 |  8 ++++----
 tools/btattach.c                 |  6 +++---
 tools/btgatt-client.c            | 10 +++++-----
 tools/btgatt-server.c            | 10 +++++-----
 tools/btiotest.c                 |  2 +-
 tools/btmon-logger.c             |  4 ++--
 tools/btpclient.c                |  2 +-
 tools/btpclientctl.c             |  2 +-
 tools/ciptool.c                  | 14 +++++++-------
 tools/cltest.c                   |  8 ++++----
 tools/hciattach.c                |  6 +++---
 tools/hciattach_ath3k.c          |  6 +++---
 tools/hciattach_bcm43xx.c        |  6 +++---
 tools/hciattach_intel.c          |  6 +++---
 tools/hciattach_qualcomm.c       |  6 +++---
 tools/hciattach_st.c             |  2 +-
 tools/hciattach_ti.c             |  6 +++---
 tools/hciattach_tialt.c          |  6 +++---
 tools/hciconfig.c                |  6 +++---
 tools/hcidump.c                  |  4 ++--
 tools/hcieventmask.c             |  6 +++---
 tools/hcisecfilter.c             |  6 +++---
 tools/hcitool.c                  |  6 +++---
 tools/hwdb.c                     |  2 +-
 tools/ioctl-tester.c             |  8 ++++----
 tools/iso-tester.c               |  8 ++++----
 tools/isotest.c                  | 10 +++++-----
 tools/l2cap-tester.c             |  6 +++---
 tools/l2ping.c                   |  8 ++++----
 tools/l2test.c                   |  8 ++++----
 tools/mcaptest.c                 |  8 ++++----
 tools/mesh-gatt/gatt.c           |  4 ++--
 tools/mesh-tester.c              | 10 +++++-----
 tools/mesh/agent.c               |  4 ++--
 tools/meshctl.c                  |  4 ++--
 tools/mgmt-tester.c              | 10 +++++-----
 tools/oobtest.c                  |  4 ++--
 tools/parser/hci.c               |  4 ++--
 tools/parser/l2cap.c             |  2 +-
 tools/parser/lmp.c               |  4 ++--
 tools/parser/parser.h            |  2 +-
 tools/rctest.c                   | 12 ++++++------
 tools/rfcomm-tester.c            |  6 +++---
 tools/rfcomm.c                   |  8 ++++----
 tools/sco-tester.c               |  6 +++---
 tools/scotest.c                  |  4 ++--
 tools/sdptool.c                  | 10 +++++-----
 tools/smp-tester.c               |  6 +++---
 tools/test-runner.c              |  6 +++---
 tools/userchan-tester.c          |  6 +++---
 unit/avctp.c                     |  2 +-
 unit/avdtp.c                     |  2 +-
 unit/avrcp-lib.c                 |  2 +-
 unit/avrcp.c                     |  6 +++---
 unit/test-avrcp.c                |  2 +-
 unit/test-bap.c                  |  4 ++--
 unit/test-bass.c                 |  4 ++--
 unit/test-eir.c                  |  6 +++---
 unit/test-gatt.c                 |  4 ++--
 unit/test-gattrib.c              |  4 ++--
 unit/test-hog.c                  |  4 ++--
 unit/test-lib.c                  |  4 ++--
 unit/test-mgmt.c                 |  4 ++--
 unit/test-micp.c                 |  4 ++--
 unit/test-sdp.c                  |  6 +++---
 unit/test-uuid.c                 |  4 ++--
 unit/test-vcp.c                  |  4 ++--
 240 files changed, 616 insertions(+), 625 deletions(-)
 rename lib/{ => bluetooth}/bluetooth.c (100%)
 rename lib/{ => bluetooth}/bluetooth.h (100%)
 rename lib/{ => bluetooth}/bnep.h (100%)
 rename lib/{ => bluetooth}/cmtp.h (100%)
 rename lib/{ => bluetooth}/hci.c (100%)
 rename lib/{ => bluetooth}/hci.h (100%)
 rename lib/{ => bluetooth}/hci_lib.h (100%)
 rename lib/{ => bluetooth}/hidp.h (100%)
 rename lib/{ => bluetooth}/iso.h (100%)
 rename lib/{ => bluetooth}/l2cap.h (100%)
 rename lib/{ => bluetooth}/mgmt.h (100%)
 rename lib/{ => bluetooth}/rfcomm.h (100%)
 rename lib/{ => bluetooth}/sco.h (100%)
 rename lib/{ => bluetooth}/sdp.c (100%)
 rename lib/{ => bluetooth}/sdp.h (100%)
 rename lib/{ => bluetooth}/sdp_lib.h (100%)
 rename lib/{ => bluetooth}/uuid.c (99%)
 rename lib/{ => bluetooth}/uuid.h (100%)

-- 
2.50.0

