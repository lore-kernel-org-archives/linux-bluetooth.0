Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70007258EE9
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692747; cv=none; b=Ltblga8DVKORHhgab1SNyVTUZjEpu/WMJOiV44obfSZO4Y/ZFPdIk2hA/y/yx00ZM8g3ZOb2upNrGgvi06uOmMOVDTtJtDengJtqhSssJR4MtAjo2OBecsVXh86OP+BkkGhHHZBJJ14ciJJl1bAFxtXA7fXRCbsVhp8a7YMgrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692747; c=relaxed/simple;
	bh=1xLGeOCBIsMNBXbDASttR9FxI/WriS7sJvm7cyghbW4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DPNRQwtzriWeWqGM3EeI8EN+b10ZVJsn84WtbaYgdTcQmK+gscyF45pqt1yOjFkw0IgLV/9Jc3joGv/hwaeFzb5blttGv5zUANWowpCm6mEqoPnQzHPh0E2YpGkhBwpP/t97GK0FaGadgWPd/3lC+4G91ghSJKYuQGfPT+FCj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gK/lFvbj; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gK/lFvbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789692744;
	bh=gxwcJbKzjLmZrpl7vSjfkr80xBRXsusV2L+2+frRUM8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gK/lFvbjoV2JWlS7+kYZB24uLZjbqk9XpWMvtYdwCmzrbXvkzM7HgCwxQGwnYddON
	 Esqh5XHhZupNNuu5E0s5rtiRH99fr4S6XH/CHj0AA2toqx+CPqmeZkpBzyHVQxhx6L
	 TxCkkTzgOi64EufTU1uKRe/P4kI6GKPuNunJ1PpM=
Received: from github.com (hubbernetes-node-969143a.ash1-iad.github.net [10.56.202.72])
	by smtp.github.com (Postfix) with ESMTPA id 82082920716
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:52:24 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:52:24 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168152/000000-874084@github.com>
Subject: [bluez/bluez] 502e34: mgmt: Add defines for the long term key types
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

  Branch: refs/heads/1168152
  Home:   https://github.com/bluez/bluez
  Commit: 502e34b01ab841c0a0d4389e1a03ae697d7d79aa
      https://github.com/bluez/bluez/commit/502e34b01ab841c0a0d4389e1a03ae697d7d79aa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add defines for the long term key types

Add defines for MGMT_EV_NEW_LONG_TERM_KEY key types.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: c6f309efe3d706c3118334b6cf73d397e720fc10
      https://github.com/bluez/bluez/commit/c6f309efe3d706c3118334b6cf73d397e720fc10
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M profiles/audio/csip.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Remove unused central field from struct ltk_info

struct ltk_info::central is only read in btd_device_get_ltk(), but its
only caller in csip.c does not use the output parameter.

Remove the unused field and adjust btd_device_get_ltk() accordingly.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 2c7b8543fde51a897814274959c3b2e960d6ac93
      https://github.com/bluez/bluez/commit/2c7b8543fde51a897814274959c3b2e960d6ac93
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix resolving a coordinated set over Secure Connections

Commit 9251e630efdd ("device: keep the long term key of both roles")
adds separate central/peripheral slots for LTKs.

Kernel only sets LTK event central flag for legacy pairing:
net/bluetooth/mgmt.c:mgmt_new_ltk() sets it if key->type == SMP_LTK.
For Secure Connections there's then no role difference, and BlueZ puts
those keys to peripheral slot.

CSIP coordinator is GAP Central (CSIP 4.2). To decrypt SIRK in
btd_device_add_set() / add_set() it reads device->ltk central key
which then never exists with Secure Connections.

test_bap.py:test_bap_unicast_set_* implicitly use legacy pairing since
pytest-bluezenv==0.1.9 powers controller on before bluetoothd, so these
tests miss this bug.

Fix by tracking the MGMT LTK type in struct ltk_info so the code knows
which kind of key it has.  For Secure Connections, store the same key in
both slots.  If key type changes, drop both slots, to avoid mixed
legacy/SC keys.

This fixes test_bap.py:test_bap_unicast_set_* with SC enabled, ie if
controller is powered off before bluetoothd start.

Assisted-by: qwen3.8-flash-next


  Commit: 8740847377f05860e9d94cc009f1d264817b6a82
      https://github.com/bluez/bluez/commit/8740847377f05860e9d94cc009f1d264817b6a82
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: run CSIP test for Secure Connections & Legacy Pairing

Parametrize test_bap_unicast_set_transport_created() to test CSIP with
and without Secure connections, toggling it with btmgmt before pairing.

test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts7-vm3-sc]
test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts7-vm3-legacy]


Compare: https://github.com/bluez/bluez/compare/502e34b01ab8%5E...8740847377f0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
