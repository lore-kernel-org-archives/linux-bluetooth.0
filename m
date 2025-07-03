Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF62DE701
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534151; cv=none; b=lfw7teFEaF/YxJXIgXynouV1utU7TvYVH69zFaCJ3zOpGJ5wsMs+O/8RzTx7PO80AUWyRGACF1fbVvepBpnFVLojHo633AwwIhcHd1ZqN246Hr3X9cVxb9Vtd9yAsiyWvA8Hi39BsLhcK07MIveHKKqszBlxwknYxvjngRoDL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534151; c=relaxed/simple;
	bh=Eq77SgLvjwrTNpEM2AkUblisrQgPXYF7lCemOgzs3wI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WjeppSG3tGq+5KvhFLlYh4FYN3yIhg7FwDImHXij1vnfmF7/LGPHmzGAEyWlA9pI7Lv2G7U9dNPf6bSA+nIgl06J/iL17vRxCmBqZaHQvN7lIhCZO54J1qffjPgKp/EldosBMOhZe7dz1hPOOg5Tt+sJnL6XGGfF0wgSSXSXvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hdI6eKI4; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hdI6eKI4"
Received: from github.com (hubbernetes-node-02ad76b.va3-iad.github.net [10.48.174.52])
	by smtp.github.com (Postfix) with ESMTPA id B6A118C0AF8
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751534148;
	bh=jetiLgjhkfz1ztiHbptL1JfciyD0RLma+/NnmCNYsxM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hdI6eKI4jxQcwl56gkuiXkY1K7k5TdgU6+5BHdIcccToXb0UWTyPWyr4pj7yeOmK1
	 H3kR1uwsEZhwMqka6NGQJW24ln8zweRAkxdh2U1gAa/2z53sPEasnuAQhiON6pxyVw
	 UMQecdXLxDSX+AF8pHce6aMq2RBGcUdxcU+mwJKY=
Date: Thu, 03 Jul 2025 02:15:48 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978522/000000-c171b4@github.com>
Subject: [bluez/bluez] 92d592: android: Fix typos
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

  Branch: refs/heads/978522
  Home:   https://github.com/bluez/bluez
  Commit: 92d5924acbdd6b003b7a8bb49aa068cc71a25911
      https://github.com/bluez/bluez/commit/92d5924acbdd6b003b7a8bb49aa068cc71a25911
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M android/a2dp.c
    M android/audio-ipc-api.txt
    M android/bluetoothd.te
    M android/client/haltest.c
    M android/client/if-bt.c
    M android/client/if-gatt.c
    M android/client/if-hl.c
    M android/gatt.c
    M android/hal-audio.c
    M android/hal-ipc-api.txt
    M android/handsfree-client.c
    M android/hardware/audio_effect.h
    M android/hardware/bluetooth.h
    M android/hardware/bt_hf.h
    M android/hardware/bt_hh.h
    M android/hardware/bt_rc.h
    M android/hardware/hardware.h
    M android/health.c
    M android/hidhost.c
    M android/pics-avctp.txt
    M android/pics-avrcp.txt
    M android/pics-gap.txt
    M android/pics-opp.txt
    M android/pts-gatt.txt
    M android/system-emulator.c
    M android/system/audio.h
    M android/tester-gatt.c
    M android/tester-hidhost.c
    M android/tester-main.c

  Log Message:
  -----------
  android: Fix typos

Found using codespell.


  Commit: e60eeb9aea29c30f9637036f63d05deee672d8cb
      https://github.com/bluez/bluez/commit/e60eeb9aea29c30f9637036f63d05deee672d8cb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M HACKING
    M README
    M TODO

  Log Message:
  -----------
  Fix typos in top-level project docs

Found using codespell.


  Commit: 202a9ab95f2ee6d52fe5e6a83647ac6e3e00edc2
      https://github.com/bluez/bluez/commit/202a9ab95f2ee6d52fe5e6a83647ac6e3e00edc2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M attrib/att.c

  Log Message:
  -----------
  attrib: Fix typos

Found using codespell.


  Commit: 8cae12f91ba3b0e910e423a2b67275cb8ba49e3e
      https://github.com/bluez/bluez/commit/8cae12f91ba3b0e910e423a2b67275cb8ba49e3e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M doc/intel-variants.txt
    M doc/maintainer-guidelines.txt
    M doc/mesh-api.txt
    M doc/mgmt.rst
    M doc/org.bluez.Adapter.rst
    M doc/org.bluez.AdvertisementMonitor.rst
    M doc/org.bluez.DeviceSet.rst
    M doc/org.bluez.GattCharacteristic.rst
    M doc/org.bluez.MediaTransport.rst
    M doc/settings-storage.txt
    M doc/test-runner.rst

  Log Message:
  -----------
  doc: Fix typos

Found using codespell.


  Commit: 36b0265361a36f7f8632037b7b1edfdb23cb7a6b
      https://github.com/bluez/bluez/commit/36b0265361a36f7f8632037b7b1edfdb23cb7a6b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M client/adv_monitor.c
    M client/mgmt.c
    M client/player.c
    M client/scripts/scan-delegator.bt

  Log Message:
  -----------
  client: Fix typos

Found using codespell.


  Commit: b56f734c99abc039113e26b9c3ca4a7445d5ac1d
      https://github.com/bluez/bluez/commit/b56f734c99abc039113e26b9c3ca4a7445d5ac1d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix typos

Found using codespell.


  Commit: f83264b292168c077500e41462e5ee2740f5f258
      https://github.com/bluez/bluez/commit/f83264b292168c077500e41462e5ee2740f5f258
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix typos

Found using codespell.


  Commit: 37f024edc16aced307b953d9d7a340bbcf263c88
      https://github.com/bluez/bluez/commit/37f024edc16aced307b953d9d7a340bbcf263c88
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M lib/bluetooth.c
    M lib/sdp.c
    M lib/sdp_lib.h

  Log Message:
  -----------
  lib: Fix typos

Found using codespell.


  Commit: 6938902e7662caf9239d68b497a431561c5d1c2c
      https://github.com/bluez/bluez/commit/6938902e7662caf9239d68b497a431561c5d1c2c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M mesh/README
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh.c
    M mesh/net.c
    M mesh/net.h
    M mesh/node.c
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: Fix typos

Found using codespell.


  Commit: 6f5452c4cf278de4f3d429e6a61b3694235d3afa
      https://github.com/bluez/bluez/commit/6f5452c4cf278de4f3d429e6a61b3694235d3afa
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M monitor/analyze.c
    M monitor/att.c
    M monitor/avctp.c
    M monitor/btmon.rst
    M monitor/l2cap.c
    M monitor/ll.c
    M monitor/msft.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix typos

Found using codespell.


  Commit: 11b07510f2b946881a535e13cf8d81e057cc0d2a
      https://github.com/bluez/bluez/commit/11b07510f2b946881a535e13cf8d81e057cc0d2a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M obexd/client/session.c
    M obexd/plugins/irmc.c
    M obexd/plugins/mas.c
    M obexd/plugins/messages.h
    M obexd/plugins/pcsuite.c
    M obexd/plugins/phonebook-dummy.c
    M obexd/plugins/phonebook-tracker.c
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: Fix typos

Found using codespell.


  Commit: c203d8db1f191c1207cbce70bace475e29354eeb
      https://github.com/bluez/bluez/commit/c203d8db1f191c1207cbce70bace475e29354eeb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M peripheral/gatt.c

  Log Message:
  -----------
  peripheral: Fix typo

Found using codespell.


  Commit: b722471ed4e4cba64888af09b5e618fe8affc1ad
      https://github.com/bluez/bluez/commit/b722471ed4e4cba64888af09b5e618fe8affc1ad
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  plugins: Fix typos

Found using codespell.


  Commit: d9864475537729a45407641f4cb9089684fc65d0
      https://github.com/bluez/bluez/commit/d9864475537729a45407641f4cb9089684fc65d0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/micp.c
    M profiles/battery/battery.c
    M profiles/gap/gas.c
    M profiles/health/mcap.c
    M profiles/input/hog-lib.c
    M profiles/midi/libmidi.c
    M profiles/midi/midi.c

  Log Message:
  -----------
  profiles: Fix typos

Found using codespell.


  Commit: 54ebbd039a622dbce7318a9bbe86989e89d06111
      https://github.com/bluez/bluez/commit/54ebbd039a622dbce7318a9bbe86989e89d06111
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M src/adapter.c
    M src/adv_monitor.c
    M src/device.c
    M src/main.conf
    M src/profile.c

  Log Message:
  -----------
  src: Fix typos

Found using codespell.


  Commit: e55415acaebdbb2ae9b994ce8fbc046c31d8038e
      https://github.com/bluez/bluez/commit/e55415acaebdbb2ae9b994ce8fbc046c31d8038e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M src/shared/att.c
    M src/shared/bap.c
    M src/shared/crypto.c
    M src/shared/gatt-client.c
    M src/shared/gatt-db.c
    M src/shared/gatt-server.c
    M src/shared/ringbuf.c
    M src/shared/util.c
    M src/shared/vcp.c

  Log Message:
  -----------
  shared: Fix typos

Found using codespell.


  Commit: 45c03d3c1bf06a640eb2f43e2967d7b1d2db80c1
      https://github.com/bluez/bluez/commit/45c03d3c1bf06a640eb2f43e2967d7b1d2db80c1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M test/example-gatt-client

  Log Message:
  -----------
  test: Fix typos

Found using codespell.


  Commit: 18823ab1da3d053689998882776d5dedf93271ee
      https://github.com/bluez/bluez/commit/18823ab1da3d053689998882776d5dedf93271ee
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M unit/test-bap.c
    M unit/test-vcp.c

  Log Message:
  -----------
  unit: Fix typos

Found using codespell.


  Commit: c171b42c75d3f577965d9bd4366395c9f14bea8e
      https://github.com/bluez/bluez/commit/c171b42c75d3f577965d9bd4366395c9f14bea8e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M tools/avtest.c
    M tools/bneptest.c
    M tools/btattach.rst
    M tools/btgatt-client.c
    M tools/btgatt-server.c
    M tools/btpclient.c
    M tools/btpclientctl.c
    M tools/ciptool.c
    M tools/hciattach_ath3k.c
    M tools/hciconfig.rst
    M tools/l2cap-tester.c
    M tools/l2test.c
    M tools/mesh-cfgclient.c
    M tools/mesh-gatt/mesh-net.h
    M tools/mesh-gatt/node.c
    M tools/mesh-gatt/prov.c
    M tools/meshctl.c
    M tools/mgmt-tester.c
    M tools/parser/att.c
    M tools/parser/avrcp.c
    M tools/parser/hci.c
    M tools/parser/l2cap.c
    M tools/parser/parser.h
    M tools/parser/rfcomm.h
    M tools/parser/smp.c
    M tools/rctest.c

  Log Message:
  -----------
  tools: Fix typos

Found using codespell.


Compare: https://github.com/bluez/bluez/compare/92d5924acbdd%5E...c171b42c75d3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
