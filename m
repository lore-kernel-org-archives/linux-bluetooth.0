Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02803769FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091916; cv=none; b=QfALUjlfaylToW49aCwCSN7aCaro86ur6SQGqNB0wrKZ3zZAfP4o5rZeusGqDQp6QM9eCCvxs4Xx+ERYISoRDLMcqz+0nuGMeqRncAsCRXggo881ajgOkncNq4mQVW88UlNj5N/lvHxFS+EgfE+yv6cQIyt4yNqOyMtRlkP9CLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091916; c=relaxed/simple;
	bh=pwZtvbAsFLXdkrRryKTtDPgkweiJ3YLV/AI9elfaGuw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aPPje5enBticQgaGbczbrBA+F5Gei7/h/w3XpCsO9xHcN1EX/dCsWGV//MDvtY6h+ZeuaU31/NnnxHuH/VBglM0Gz8tSNXF5MF4z1X+dtiOeJHGbB62qJr2PuTmhD3LLRjZifeO7t8GffHerpejQves8RXlfM/SHp4GL5HjQ5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MLec7ZKq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MLec7ZKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790091912;
	bh=S7S1HOQsGCmq7iqpVkxdKiZ1LF0BcTSIQoBQfzBgHZ0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MLec7ZKqbfQDUWCMm+oBPsDCcuYUchDoMo7P2QI8N7Wfixtkt0pCegJGYjQW6QIVJ
	 ZKRclZ6FzsNU7WMxNs/u4ir7f6u8dxNUAK/CjudycgQxTIJnqlw+UIjtJBPAR3StlF
	 3Y70h6v1VRtB1dcWc8iJ/LXsult9Gml/aI8SK3QM=
Received: from github.com (hubbernetes-node-fd5a6cf.ac4-iad.github.net [10.52.184.47])
	by smtp.github.com (Postfix) with ESMTPA id 9F49E9417CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 08:45:12 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:45:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/17e624-f26da4@github.com>
Subject: [bluez/bluez] 086a30: doc: describe the true wireless broadcast test
 cases
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
  Commit: 086a30e3cf47002fdc8fef82b442ee7d45960961
      https://github.com/bluez/bluez/commit/086a30e3cf47002fdc8fef82b442ee7d45960961
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the true wireless broadcast test cases

Assisted-by: opencode:claude-opus-5


  Commit: 4c8102eecc208f327c9484bf0609691887ea3ace
      https://github.com/bluez/bluez/commit/4c8102eecc208f327c9484bf0609691887ea3ace
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the true wireless broadcast assistant test case

Assisted-by: opencode:claude-opus-5


  Commit: 547afc7ef35cfdd9f9e4a7d51cbbe1fc7dd7e406
      https://github.com/bluez/bluez/commit/547afc7ef35cfdd9f9e4a7d51cbbe1fc7dd7e406
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    A client/scripts/broadcast-sink-left.bt
    A client/scripts/broadcast-sink-right.bt
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add the true wireless broadcast tests

Assisted-by: opencode:claude-opus-5


  Commit: bb59c19e299f307faf06f8d2c947c1e5e4caa0b0
      https://github.com/bluez/bluez/commit/bb59c19e299f307faf06f8d2c947c1e5e4caa0b0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: keep the push target per MediaAssistant object

Every MediaAssistant object of a local broadcast shares the bass_data of
the adapter, and pushing one stored the session of the delegator it was
pushed to by overwriting the bass of that shared data.

With a single delegator this goes unnoticed, but with one delegator per
side of a true wireless pair the second push replaces the target of the
first one, so the Broadcast Code of a request coming from the first
delegator is written to the second one, and the first never syncs.

Keep the session of the push in the assistant itself, and only handle
the changes reported by the delegator an assistant was pushed to.

Assisted-by: opencode:claude-opus-5


  Commit: e691da62c62f0e12564a9ba59f9ce0e9aa8521da
      https://github.com/bluez/bluez/commit/e691da62c62f0e12564a9ba59f9ce0e9aa8521da
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M client/main.c
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  client: connect a device that is already paired

Pairing a device that is already paired is rejected by the daemon with
AlreadyExists, which is of no use to the user: the bond asked for is
already there, and what pairing it anew takes is removing it first.

Connect it instead, telling what happened, so pairing a device is a way
of getting to it whether it is known already or not.

The documentation already described this behaviour, though as removing
the pairing first, which is not what happened either.

Assisted-by: opencode:claude-opus-5


  Commit: 98d6d1350a6aed5d3cef66732ae92cfa1416ead7
      https://github.com/bluez/bluez/commit/98d6d1350a6aed5d3cef66732ae92cfa1416ead7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    A client/scripts/broadcast-delegator-left.bt
    A client/scripts/broadcast-delegator-right.bt
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add the true wireless broadcast assistant test

Assisted-by: opencode:claude-opus-5


  Commit: ff4fae3f2d172de788b18fecba8cf75f8e3e9ce8
      https://github.com/bluez/bluez/commit/ff4fae3f2d172de788b18fecba8cf75f8e3e9ce8
  Author: Nick Hammond <blender7@gmail.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  input/hog: Cancel pending report requests on detach

GET_REPORT and SET_REPORT requests are tracked by getrep_att and
setrep_att rather than gatt_op. Cancelling gatt_op during detach leaves
these callbacks registered on the shared GAttrib connection.

A reply delivered after the HoG object is freed can therefore access a
freed report in get_report_cb or a freed hog in set_report_cb. A long
GET_REPORT read can also retain its callback through a READ_BLOB
continuation. If the HoG object survives detach, the callback can instead
send a stale UHID reply.

Cancel both outstanding requests before releasing attrib and clear their
IDs so a later attachment starts without stale request state.

This was investigated following a bluetoothd crash on Ubuntu BlueZ 5.72
during keyboard reconnection. A socketpair regression reproduces the
use-after-free on current master with AddressSanitizer as well.

Assisted-by: Codex:gpt-6 AddressSanitizer


  Commit: f26da4389e2dc9dac340182b5f618a63c0c96c08
      https://github.com/bluez/bluez/commit/f26da4389e2dc9dac340182b5f618a63c0c96c08
  Author: Tao Cai <294305068@qq.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix NULL pointer dereference in dev_property_get_uuids

The bluetoothd process crashes during D-Bus property serialization when
the device UUID list contains a NULL entry. Add a NULL check before
calling dbus_message_iter_append_basic().


Compare: https://github.com/bluez/bluez/compare/17e624d1cd9a...f26da4389e2d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
