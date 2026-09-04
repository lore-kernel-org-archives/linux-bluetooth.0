Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946A50AC08
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550056; cv=none; b=IKmPRJctw4FpgJoLMn/Zsq+i60aK3X6v3YLtoMT6wYg1rUIwQU8gzMD6G0Us+PC4/e59NiORzRsYv84LBxNV9Y0ZyZA6sSPOJCoDqEI7IIW6uSSKn2FzLiSxqW56raUaE/jCjdhqEDUXsJBxPSQIHPXlVMiyTrep22P5f0GzGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550056; c=relaxed/simple;
	bh=PXF1yrt5mualM+GxrmN10Q+Mv7BE5dXgipFpjqCa1/Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ifmN41U0/Py5HG/3y+3qC4JXw1GPam721+y1nxgP4NMHYRrpRIK/yul3koUxgzMleNU5YJW2zJyAQDkg3zmXNPQxUMEP6letc9NQc7dr+nuAZGAb5g6B5ohxovjZ3iBHgrv59iyrBNmIQNYZBn6PeNXB9wnFHTPF61H6RbeUB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S1AuJvp9; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S1AuJvp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788550054;
	bh=cvGAq/sF/IDHdzB7xlMTQ3r0dBJacNxhdGqd7JdO1Ug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S1AuJvp9Xu5PzTvwcfcv4+4fKYSwBZXKCM98bPDMhpIJM6zDB2lAEls5oIonpN6Yu
	 CanLo+rDa7v3qX2jinZci4hZAwfSsugtKdTsX2sbbpzyIoYLAhgQ4f7im8XMxcVkaT
	 EZp/qnuooOzWahDp/XWfw6SNS29i+vSpNBnia/Mg=
Received: from github.com (hubbernetes-node-2411041.ac4-iad.github.net [10.52.143.35])
	by smtp.github.com (Postfix) with ESMTPA id 6D93A780FF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 12:27:34 -0700 (PDT)
Date: Fri, 04 Sep 2026 12:27:34 -0700
From: Proxy Alt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158295/000000-b6e494@github.com>
Subject: [bluez/bluez] b6e494: shared/gatt-client: confirm a synthesized CCC
 hand...
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

  Branch: refs/heads/1158295
  Home:   https://github.com/bluez/bluez
  Commit: b6e494c6fb97d313c01100370f9c5774f7063700
      https://github.com/bluez/bluez/commit/b6e494c6fb97d313c01100370f9c5774f7063700
  Author: Proxy <proxy-alt@proxy-alt.dev>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: confirm a synthesized CCC handle before writing to it

discover_descs() still synthesizes a 0x2902 for a notify/indicate
characteristic's lone descriptor without ever asking the peer - that
part is unchanged, since always discovering costs a round trip on
every characteristic for the sake of devices that violate Vol 3, Part
G 3.3.1.1. What changes is register_notify(): before it writes to a
handle discover_descs() only guessed at, it now issues one
single-handle FIND_INFORMATION to let the peer answer for itself, and
only after that answer confirms a real 0x2902 does the CCC write
happen at all.

If the peer's answer is anything else - a different UUID, or no
answer - chrc->ccc_handle is cleared instead of written to.
register_notify() already handles a characteristic with no CCC
correctly (gatt_db_attribute_get_ccc() returning NULL takes the same
path), so this reaches that existing, correct behaviour instead of
writing 0x0100 into an attribute the peer never claimed was a CCC.

Cost: one extra FIND_INFORMATION per notify/indicate characteristic
whose sole descriptor was synthesized, the first time register_notify()
is called for it.

v2 of the patch attached to this issue fixes a real bug the first
version had: unverified_ccc lived on struct bt_gatt_client, but
discover_descs() only ever runs on the root client, while
register_notify() is commonly called through a clone
(bt_gatt_client_clone(), used by src/gatt-client.c per D-Bus consumer)
- whose own copy of that queue is always empty. The result was that
the verify step silently never triggered and the original blind write
still happened. Fixed by adding root_client(), a two-line walk up
->parent, and using root_client(client)->unverified_ccc at both call
sites instead of client->unverified_ccc directly.

Tested against real hardware this time, and traced end to end. Built
and ran as bluetoothd itself (not a test harness) on plain Debian, no
containers, connected to a real Cync device (F4:BC:DA:39:03:D4) whose
notify characteristic's descriptor discovery skips 0x0013 exactly as
this issue describes - discover_descs_cb() finds 0x0004/0x0016/0x0019/
0x001c as 0x2901 and never queries 0x0013 at all. Calling StartNotify
on that characteristic with v1 of the patch reproduced the original
bug unchanged: a WRITE_REQ to 0x0013 that timed out after 30s
(src/shared/att.c:timeout_cb() ... 0x12) and tore down a connection
that was otherwise healthy - which is what led to finding the clone
bug above. With that fixed and the identical scenario repeated:

  verify_ccc_cb() handle 0x0013 confirmed is not a CCC descriptor

StartNotify's D-Bus method call returns success immediately, no write
is sent to 0x0013, and the connection stays up (confirmed via
Device1.Connected afterward). This is the same device, same
characteristic, same daemon build, same session - only the
root_client() fix differs between the failing and passing runs.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy <proxy-alt@proxy-alt.dev>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
