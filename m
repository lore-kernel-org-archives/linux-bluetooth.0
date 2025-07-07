Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0323FC2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912174; cv=none; b=SGO4tdWUmDezpV/P24ptB02qXmLiMFGRmGDPF8FQ0KFwbi08Squ3ePA4vSOUOgxyn9jKy77BSBEkJhlZyIBENGB7kaxlp9HRXI3Hf1c/ks9uDCA8S4segMKO3MEo4n/w1W98kcjhUGEggq/6Bpdn2YcAEKaVk7AudQG/DbwB0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912174; c=relaxed/simple;
	bh=Cl2CY1zIdtsdokwtndpIdaQeIqvMjNhiX9Ez49gXWYU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QUirwUkWgClC7xaVIsGxKVj7Gy3BTZWI2CPGDiPBDLOQuLk9YfTV/0J1NQ7ofC70YV+QvlLGNXnGeRnV4qJMpz4k02QhvpHP05jcUs100IMiOknS99d8gyviN1FxqYs36cKGd7klEfxOhn5jZTSQYU3dqD7VqQ5m3oj7m7lkOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SLRwqetJ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SLRwqetJ"
Received: from github.com (hubbernetes-node-846f401.ash1-iad.github.net [10.56.201.114])
	by smtp.github.com (Postfix) with ESMTPA id 2D9F5600C77
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751912172;
	bh=/xMq9XxerU3Qc/YGuzMJju969EfiXISHkFsSpLlSHPo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SLRwqetJ9vtWAihpg9PI6WwKmxK915J+BF8SoWy9WDxPNa81RRl2gc/m2dz1ji9Hf
	 Ojd2pYYM5NdQaVSmz6WXZV90VhzRq43iBVuFnUt9ML+1ei4G8rLxt+FhT7wQra/fZy
	 UQiwpgFqe+jfqzQs4B8zqlBL2jth5SjZ+rLg/DR4=
Date: Mon, 07 Jul 2025 11:16:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/168377-be8c03@github.com>
Subject: [bluez/bluez] d46ec5: Fix typos in top-level project docs
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
  Commit: d46ec5f46c36cc410dcd5fb31f23536b71e9badb
      https://github.com/bluez/bluez/commit/d46ec5f46c36cc410dcd5fb31f23536b71e9badb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M HACKING
    M README
    M TODO

  Log Message:
  -----------
  Fix typos in top-level project docs

Found using codespell.


  Commit: 87fb2b7b5a8068f9159c935951afb2c9f508a9d8
      https://github.com/bluez/bluez/commit/87fb2b7b5a8068f9159c935951afb2c9f508a9d8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M attrib/att.c

  Log Message:
  -----------
  attrib: Fix typos

Found using codespell.


  Commit: cb8facbd9a54a9530ab51f03593ee793998c8db9
      https://github.com/bluez/bluez/commit/cb8facbd9a54a9530ab51f03593ee793998c8db9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: 9986633b31557953e098ead468079ff639dd1221
      https://github.com/bluez/bluez/commit/9986633b31557953e098ead468079ff639dd1221
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M client/adv_monitor.c
    M client/mgmt.c
    M client/player.c
    M client/scripts/scan-delegator.bt

  Log Message:
  -----------
  client: Fix typos

Found using codespell.


  Commit: e3b9fc5ac3404674d388834316e9bcd7ced235db
      https://github.com/bluez/bluez/commit/e3b9fc5ac3404674d388834316e9bcd7ced235db
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix typos

Found using codespell.


  Commit: a1b1d08d430db17e025c67ed359e54fc839caaaa
      https://github.com/bluez/bluez/commit/a1b1d08d430db17e025c67ed359e54fc839caaaa
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix typos

Found using codespell.


  Commit: 9e9f27057784e505d0dc4877cd681f063a62f484
      https://github.com/bluez/bluez/commit/9e9f27057784e505d0dc4877cd681f063a62f484
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M lib/bluetooth.c
    M lib/sdp.c
    M lib/sdp_lib.h

  Log Message:
  -----------
  lib: Fix typos

Found using codespell.


  Commit: ce78b15e67b0a5139689aed194264845b8ab56f7
      https://github.com/bluez/bluez/commit/ce78b15e67b0a5139689aed194264845b8ab56f7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: 27b1e893cd99ea57083d0296174ba20b5102f3a1
      https://github.com/bluez/bluez/commit/27b1e893cd99ea57083d0296174ba20b5102f3a1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: ab2496cb3208ec3f39a61311ede1544ba7a68431
      https://github.com/bluez/bluez/commit/ab2496cb3208ec3f39a61311ede1544ba7a68431
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: a1f82f1020f949f07f2a57c34c6c61a42ca31b4b
      https://github.com/bluez/bluez/commit/a1f82f1020f949f07f2a57c34c6c61a42ca31b4b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M peripheral/gatt.c

  Log Message:
  -----------
  peripheral: Fix typo

Found using codespell.


  Commit: 4d68c6090471abe733cafb5995f226da46ffbafc
      https://github.com/bluez/bluez/commit/4d68c6090471abe733cafb5995f226da46ffbafc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  plugins: Fix typos

Found using codespell.


  Commit: 46e69f12e6b8b80e4d6bb9b84c5cb0ac954cef0e
      https://github.com/bluez/bluez/commit/46e69f12e6b8b80e4d6bb9b84c5cb0ac954cef0e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: 3d6b237c0d060132db708454dd118350669d6d40
      https://github.com/bluez/bluez/commit/3d6b237c0d060132db708454dd118350669d6d40
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: f019d0671875a8107463e05164b3c16250b848b2
      https://github.com/bluez/bluez/commit/f019d0671875a8107463e05164b3c16250b848b2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: 32e3d6351d3f7eb6d6bb6bb1e1566d7b4469f5f6
      https://github.com/bluez/bluez/commit/32e3d6351d3f7eb6d6bb6bb1e1566d7b4469f5f6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M test/example-gatt-client

  Log Message:
  -----------
  test: Fix typos

Found using codespell.


  Commit: de69e5a3ab7d8ee0b0c45c10874cc029c1e27161
      https://github.com/bluez/bluez/commit/de69e5a3ab7d8ee0b0c45c10874cc029c1e27161
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M unit/test-bap.c
    M unit/test-vcp.c

  Log Message:
  -----------
  unit: Fix typos

Found using codespell.


  Commit: 42f89165b0cce071f785b4defb3541447b8da257
      https://github.com/bluez/bluez/commit/42f89165b0cce071f785b4defb3541447b8da257
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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


  Commit: be8c031baaa89d35e66c3b8ce8de54519525b364
      https://github.com/bluez/bluez/commit/be8c031baaa89d35e66c3b8ce8de54519525b364
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: prevent double freeing

image_properties_complete_cb frees 'contents' after a failure.
However obc_transfer_get_contents does it beforehand.


Compare: https://github.com/bluez/bluez/compare/168377c0c8e8...be8c031baaa8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
