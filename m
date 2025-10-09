Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B22222D0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045592; cv=none; b=erd+LLqTpdX5X9I248OW9g59N7TFj5mQKYFQ2QcScNvBs3LSVr7fAXbFQ7DxsxyjA62bK8aisWSswih1Hp21v2bKnn/xMbCsxOcnkI5aZrEb5BWRE0o+RYEQt+LbAPKEWlCL1SLLKsxehUCey/Vv1vBmemAGzfCB67BlF9iLYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045592; c=relaxed/simple;
	bh=EZIizctPuIKo8BV5q1bUwalaGVVmidFX5RcXOb4KvA4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p3QLKyiHfJHjYOgZHDbITecw1X5J9Ljm+lYojIAXHWyOckqZ1/K4f/JHtF5f8T5hxKvwZn9xbF3s+Rs+7iu2Vbiwuskr+uQ10fiUTU2cCi4GJUSJDFZNLnzhmb+pW1x3IbPinYv/6+TxTYdVjqG6Ur3xQEHYY8NgFzZg2mEcVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fv/EpOxE; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fv/EpOxE"
Received: from github.com (hubbernetes-node-b723778.ac4-iad.github.net [10.52.150.45])
	by smtp.github.com (Postfix) with ESMTPA id B32D921019
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760045589;
	bh=c94QVU5h0mx7dsC3qVItwm+mbcTK48MSPUbi26G9XXU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fv/EpOxEbS8MbyeRx9VVoQ6WfvZKoBsoNGBR5OSgbDikvj4nI120KlIZqQKAogsHB
	 9Q9DM1yyvSCawioiX+B3O+8vvtjobXoxtTA44roch11CplHjm5eYbA6NOh1ENFy7IR
	 EXHgShYoFtLlHQ9s/g9LgDxKw5CaCvP77K1Hll0U=
Date: Thu, 09 Oct 2025 14:33:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009899/000000-77f8a3@github.com>
Subject: [bluez/bluez] 56bce1: monitor: Use PAST to refer to Periodic
 Advertising...
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

  Branch: refs/heads/1009899
  Home:   https://github.com/bluez/bluez
  Commit: 56bce1b861c9085f96c920e5e67325a67d15c5f6
      https://github.com/bluez/bluez/commit/56bce1b861c9085f96c920e5e67325a67d15c5f6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use PAST to refer to Periodic Advertising Sync Transfer

This simplify the command and event names and their structs to just
use PAST in place of other terminology currently in use.


  Commit: 399b3fc01cfffb6b494a7f0caad97d6cf0706d2b
      https://github.com/bluez/bluez/commit/399b3fc01cfffb6b494a7f0caad97d6cf0706d2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/scripts/broadcast-sink.bt
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: Add initial support for PAST


  Commit: 16fd854e29c5a0308b9cca74ccb19da74147bb31
      https://github.com/bluez/bluez/commit/16fd854e29c5a0308b9cca74ccb19da74147bb31
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for PAST procedures

This introduces the following tests that test PAST procedures both as
a sender, either for colocated broadcast source or a third peer, and as
receiver:

ISO Broadcaster PAST Info - Success
ISO Broadcaster PAST Info RPA - Success
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success


  Commit: ebeb466ee743b28af21e33ced09cc34492e58d3d
      https://github.com/bluez/bluez/commit/ebeb466ee743b28af21e33ced09cc34492e58d3d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for PAST MGMT settings and flags

This adds parising support for PAST MGMT settings and device flags.


  Commit: e62cf61dbdafdf27dbf1bfd37e5ecd9b3f901795
      https://github.com/bluez/bluez/commit/e62cf61dbdafdf27dbf1bfd37e5ecd9b3f901795
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M doc/mgmt.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  MGMT: Add PAST Settings and Flags

This adds PAST Settings and Flags definitions and documentation.


  Commit: 15f020dfdfb31bb30cf5035fcc2f114ec8a2cdb3
      https://github.com/bluez/bluez/commit/15f020dfdfb31bb30cf5035fcc2f114ec8a2cdb3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add initial support for setting DEVICE_FLAG_PAST

This introduces device_set_past_support which can be used by drivers
to indicate that DEVICE_FLAG_PAST shall be changed.


  Commit: c8f768da56e6b8389433480d8ee1a9554a9bcf22
      https://github.com/bluez/bluez/commit/c8f768da56e6b8389433480d8ee1a9554a9bcf22
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add support for setting DEVICE_FLAG_PAST

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.


  Commit: 2040ff0f28a639c3817aa028ccff20d0f70dcc32
      https://github.com/bluez/bluez/commit/2040ff0f28a639c3817aa028ccff20d0f70dcc32
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M doc/iso.rst

  Log Message:
  -----------
  iso.rst: Add documentation for PAST/rebind

This documents how to use PAST procedures by doing bind on already
connected socket.


  Commit: 68530426c8b2a5184d5a5caa4017fcd8ab1b3b33
      https://github.com/bluez/bluez/commit/68530426c8b2a5184d5a5caa4017fcd8ab1b3b33
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M src/shared/bap.c
    M src/shared/bap.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Add callback broadcast instances

This makes bt_bap_register have a dedicated callback for broadcast
instances and also fixes bt_bap_stream_io_get_qos to handle broadcast
streams.


  Commit: ce99fe1658886cd44c528a422aeb1339fde6d217
      https://github.com/bluez/bluez/commit/ce99fe1658886cd44c528a422aeb1339fde6d217
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  MediaAssistant: Add Device option to Push

This enables MediaAssistant.Push to work with local broadcast sources.


  Commit: ba09d981b34caaab03e7467c5723bfc058b883e9
      https://github.com/bluez/bluez/commit/ba09d981b34caaab03e7467c5723bfc058b883e9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  bass: Implement Device option for Push

This implements support for MediaAssistant.Push with local broadcast
sources.


  Commit: aa1c15c9f8befd20eeb863613cb6d601435a9fd0
      https://github.com/bluez/bluez/commit/aa1c15c9f8befd20eeb863613cb6d601435a9fd0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/assistant.c
    M client/mgmt.c

  Log Message:
  -----------
  client/assistant: Handle assistant.push to own broadcasts


  Commit: 77f8a35df71a40e18b68f6e3273c2dc7c65d2170
      https://github.com/bluez/bluez/commit/77f8a35df71a40e18b68f6e3273c2dc7c65d2170
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Detect if object already contains a valid BCode

If assistant object already contains a valid (non-zero) BCode
(e.g state=local) use it instead of always request the user to
re-enter.


Compare: https://github.com/bluez/bluez/compare/56bce1b861c9%5E...77f8a35df71a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
