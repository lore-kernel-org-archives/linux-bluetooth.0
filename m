Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7B21CA13
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144957; cv=none; b=epIInPNk840Ll7R1aS4e6up8uxntI9h9sJLIXx2L5RFjhVtvxn451i+gGzsJeoWe5Y/ViBMWj1F/vmlihN5Nuhn5Y9wCS7Qkq7HVSVUpQ739ZdXEvGO43rLGp5xpF9HIipYShMgC/hUrMqlJqkxpyME9JxX9I94gVhmicpcdX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144957; c=relaxed/simple;
	bh=OQ1nPu20wEbfc1pfDV6R7gF5zblUyb27mr9zzPtOr5M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JCgmEk5WbbmBQ4+DTobyE2meHtstCPVXQx0ybtzMFdk+ekoliCQdgx2A8kqGksre6Y3AfSi4rDODfjI8h2w9h7Hjm8J2E1y+VFNqcYrn6PQXQQBA9Vx4m1CK7h9pKjgQyItNIP3W8XHGET+42xh1wX/ZzhfsitGccjtJrE1kunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U5F8RWb7; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U5F8RWb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779144955;
	bh=qep7OGkBju9TN7Wu4en/EekqF4RQt5XxvrmHK7BLLVo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U5F8RWb7IxUQdCJ8UIDxkTVIQBVO0r3qdpnp8gMUIo8mO2F+bjbexWqIKknGLfrqM
	 snframu6aTARzXe2ZSDXYaCk46qi7WcMtMgEnDCj/fSFzWxQDBXvLBy91KbMPgRH6j
	 1xb4165vT2caYD/Rc3+FUda1i+0rJt40B3S7Jpqo=
Received: from github.com (hubbernetes-node-42269fa.va3-iad.github.net [10.48.162.11])
	by smtp.github.com (Postfix) with ESMTPA id 2B11E800AA1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 15:55:55 -0700 (PDT)
Date: Mon, 18 May 2026 15:55:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/45e66b-757cd9@github.com>
Subject: [bluez/bluez] e0f608: shared/rap: fix use of uninitialized value
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
  Commit: e0f608c05f9a007b9867c53234465f2b1fb0d8fa
      https://github.com/bluez/bluez/commit/e0f608c05f9a007b9867c53234465f2b1fb0d8fa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: fix use of uninitialized value

Fix error handling in send_ras_segment_data


  Commit: dc07b3d54b801dea84e82397057071a824a38500
      https://github.com/bluez/bluez/commit/dc07b3d54b801dea84e82397057071a824a38500
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Fix integer overflow in sdp_extract_seqtype

Check uint32_t value does not overflow int range.

Link: https://lore.kernel.org/linux-bluetooth/ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org/


  Commit: 1e0688e8bfdaf20a34174dcd7ec855adb8e18216
      https://github.com/bluez/bluez/commit/1e0688e8bfdaf20a34174dcd7ec855adb8e18216
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  main.conf: fix unintentionally set value

Commit 31e4fb1498f ("monitor: Add decoding support for HIDS 1.1 flags
and attributes") unintentionally set a non-default value in main.conf.

Restore the value back.


  Commit: 757cd98f4186e6e1e38b0a36539b78a20e93b5bf
      https://github.com/bluez/bluez/commit/757cd98f4186e6e1e38b0a36539b78a20e93b5bf
  Author: Zhao Dongdong <zhaodongdong@kylinos.cn>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix inverted NULL check in gatt_db clone

gatt_db_clone() returns NULL on failure so the condition was inverted.
With the old check a successful clone (non-NULL) would return false and
skip swapping the device's GATT database, while a failure (NULL) would
fall through and dereference a NULL pointer a few lines below.

Fix by negating the condition: only bail out early if the clone failed;
proceed with the swap when the clone actually succeeds.


Compare: https://github.com/bluez/bluez/compare/45e66b1c4aed...757cd98f4186

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
