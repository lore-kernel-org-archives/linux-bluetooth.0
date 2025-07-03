Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA32D3740
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533009; cv=none; b=s+XPXqyz113a7+9uNfQUU+z1DHKAXjTQyeL78p5ziTEPdFk5+/YBl1E9fSoKCW92nb9ARlJHP+nZs7TsRAeasu36qvTNGNdNtfJscFGdhLeba7VvE/J8Y1sXrVosl4fYameOmjd2x1hTKHKy7gNZh7+IG+JKh0ujEVFhp6gYym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533009; c=relaxed/simple;
	bh=OhjMOxAWtQ2pzdQ9tlPa6Od6a3+IotEeJmUwzKAR1CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAJqYR1aCPxgUY849kC7a7IaJHbJUkT0ZBdfBj92yQRtGQ5ve291nmZpXjFsqok0k7PdWTAz92DZaivgrH/YvGNdH+hLtzilCKFN90ooc4x91z/PMP3Ahqh+1FnOmGG1db+i9jr0HqKg5OVbG3Pe+Mcz8kxHHiwRBpWae99/D6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539E24317C;
	Thu,  3 Jul 2025 08:56:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 00/19] Fix typos
Date: Thu,  3 Jul 2025 10:53:08 +0200
Message-ID: <20250703085630.935452-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffteektdejuddvhfdtfedtvdetgeeileethfetgfdtheekvefgueeifffhvefhfeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Used codespell to detect typos, and my head to remove the false
positive.

Please review line-by-line before applying, it's long, but won't be as
long as fixing those typos ;)

Bastien Nocera (19):
  android: Fix typos
  Fix typos in top-level project docs
  attrib: Fix typos
  doc: Fix typos
  client: Fix typos
  emulator: Fix typos
  gobex: Fix typos
  lib: Fix typos
  mesh: Fix typos
  monitor: Fix typos
  obexd: Fix typos
  peripheral: Fix typo
  plugins: Fix typos
  profiles: Fix typos
  src: Fix typos
  shared: Fix typos
  test: Fix typos
  unit: Fix typos
  tools: Fix typos

 HACKING                                |  2 +-
 README                                 |  2 +-
 TODO                                   |  4 +--
 android/a2dp.c                         |  6 ++---
 android/audio-ipc-api.txt              |  2 +-
 android/bluetoothd.te                  |  2 +-
 android/client/haltest.c               |  4 +--
 android/client/if-bt.c                 | 16 ++++++------
 android/client/if-gatt.c               | 14 +++++------
 android/client/if-hl.c                 |  2 +-
 android/gatt.c                         |  8 +++---
 android/hal-audio.c                    |  2 +-
 android/hal-ipc-api.txt                | 32 ++++++++++++------------
 android/handsfree-client.c             |  8 +++---
 android/hardware/audio_effect.h        |  4 +--
 android/hardware/bluetooth.h           |  2 +-
 android/hardware/bt_hf.h               |  2 +-
 android/hardware/bt_hh.h               |  8 +++---
 android/hardware/bt_rc.h               |  6 ++---
 android/hardware/hardware.h            |  4 +--
 android/health.c                       |  4 +--
 android/hidhost.c                      |  6 ++---
 android/pics-avctp.txt                 |  2 +-
 android/pics-avrcp.txt                 |  2 +-
 android/pics-gap.txt                   |  2 +-
 android/pics-opp.txt                   |  4 +--
 android/pts-gatt.txt                   |  2 +-
 android/system-emulator.c              |  2 +-
 android/system/audio.h                 |  4 +--
 android/tester-gatt.c                  |  2 +-
 android/tester-hidhost.c               |  2 +-
 android/tester-main.c                  |  8 +++---
 attrib/att.c                           |  2 +-
 client/adv_monitor.c                   |  2 +-
 client/mgmt.c                          |  6 ++---
 client/player.c                        |  2 +-
 client/scripts/scan-delegator.bt       |  4 +--
 doc/intel-variants.txt                 |  2 +-
 doc/maintainer-guidelines.txt          |  2 +-
 doc/mesh-api.txt                       | 14 +++++------
 doc/mgmt.rst                           |  6 ++---
 doc/org.bluez.Adapter.rst              |  4 +--
 doc/org.bluez.AdvertisementMonitor.rst |  2 +-
 doc/org.bluez.DeviceSet.rst            |  4 +--
 doc/org.bluez.GattCharacteristic.rst   |  4 +--
 doc/org.bluez.MediaTransport.rst       |  2 +-
 doc/settings-storage.txt               |  2 +-
 doc/test-runner.rst                    |  4 +--
 emulator/btdev.c                       |  2 +-
 gobex/gobex.c                          |  4 +--
 lib/bluetooth.c                        | 10 ++++----
 lib/sdp.c                              |  6 ++---
 lib/sdp_lib.h                          |  2 +-
 mesh/README                            |  2 +-
 mesh/mesh-io-generic.c                 |  2 +-
 mesh/mesh-io-mgmt.c                    |  2 +-
 mesh/mesh.c                            |  2 +-
 mesh/net.c                             |  4 +--
 mesh/net.h                             |  2 +-
 mesh/node.c                            |  2 +-
 mesh/prov-acceptor.c                   |  2 +-
 monitor/analyze.c                      |  4 +--
 monitor/att.c                          |  8 +++---
 monitor/avctp.c                        |  6 ++---
 monitor/btmon.rst                      |  6 ++---
 monitor/l2cap.c                        |  2 +-
 monitor/ll.c                           | 10 ++++----
 monitor/msft.c                         |  2 +-
 monitor/packet.c                       | 10 ++++----
 obexd/client/session.c                 |  2 +-
 obexd/plugins/irmc.c                   |  4 +--
 obexd/plugins/mas.c                    |  2 +-
 obexd/plugins/messages.h               |  4 +--
 obexd/plugins/pcsuite.c                |  2 +-
 obexd/plugins/phonebook-dummy.c        |  2 +-
 obexd/plugins/phonebook-tracker.c      | 34 +++++++++++++-------------
 obexd/src/manager.c                    |  2 +-
 peripheral/gatt.c                      |  2 +-
 plugins/policy.c                       |  4 +--
 profiles/audio/a2dp.c                  |  2 +-
 profiles/audio/avrcp.c                 |  4 +--
 profiles/audio/bap.c                   |  2 +-
 profiles/audio/bass.c                  |  2 +-
 profiles/audio/micp.c                  |  6 ++---
 profiles/battery/battery.c             |  2 +-
 profiles/gap/gas.c                     |  2 +-
 profiles/health/mcap.c                 | 18 +++++++-------
 profiles/input/hog-lib.c               |  2 +-
 profiles/midi/libmidi.c                |  2 +-
 profiles/midi/midi.c                   |  2 +-
 src/adapter.c                          | 24 +++++++++---------
 src/adv_monitor.c                      |  4 +--
 src/device.c                           | 10 ++++----
 src/main.conf                          |  4 +--
 src/profile.c                          |  4 +--
 src/shared/att.c                       |  2 +-
 src/shared/bap.c                       |  8 +++---
 src/shared/crypto.c                    |  2 +-
 src/shared/gatt-client.c               |  2 +-
 src/shared/gatt-db.c                   |  4 +--
 src/shared/gatt-server.c               |  2 +-
 src/shared/ringbuf.c                   |  2 +-
 src/shared/util.c                      |  4 +--
 src/shared/vcp.c                       |  2 +-
 test/example-gatt-client               |  2 +-
 tools/avtest.c                         |  2 +-
 tools/bneptest.c                       |  2 +-
 tools/btattach.rst                     |  2 +-
 tools/btgatt-client.c                  |  4 +--
 tools/btgatt-server.c                  |  2 +-
 tools/btpclient.c                      | 18 +++++++-------
 tools/btpclientctl.c                   |  2 +-
 tools/ciptool.c                        |  2 +-
 tools/hciattach_ath3k.c                |  2 +-
 tools/hciconfig.rst                    |  2 +-
 tools/l2cap-tester.c                   |  4 +--
 tools/l2test.c                         |  6 ++---
 tools/mesh-cfgclient.c                 |  2 +-
 tools/mesh-gatt/mesh-net.h             |  2 +-
 tools/mesh-gatt/node.c                 |  2 +-
 tools/mesh-gatt/prov.c                 |  4 +--
 tools/meshctl.c                        |  2 +-
 tools/mgmt-tester.c                    | 10 ++++----
 tools/parser/att.c                     |  2 +-
 tools/parser/avrcp.c                   | 12 ++++-----
 tools/parser/hci.c                     |  6 ++---
 tools/parser/l2cap.c                   |  2 +-
 tools/parser/parser.h                  |  2 +-
 tools/parser/rfcomm.h                  |  4 +--
 tools/parser/smp.c                     |  4 +--
 tools/rctest.c                         |  6 ++---
 unit/test-bap.c                        |  2 +-
 unit/test-vcp.c                        |  4 +--
 133 files changed, 307 insertions(+), 307 deletions(-)

-- 
2.50.0

