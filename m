Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0603BBFC2
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563723; cv=none; b=cUnPp3gnzt6iXRa3wMMkdN0ZfkQXjfe4UoQuwh4dFYZ6v92zYqereCpu+tq0xVFxMGQmiDPZOeqGY14lqRnBRP3PN/h7UtnKrma8z3fiYJpI1TK88r/j4VQa50YX3VgbuOsTCa+bMuy8tLv1b5Ltna7Lt58szak5RhfWqa2GeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563723; c=relaxed/simple;
	bh=mfG/ZVUG+cY9DiFmK+1iMi42Y9hAeds0b1Lcvc5xzVM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WEUL4KwM6xSDR/LiTbtNbL189s+pDSEpa1LJgJfsJrTMy0xa3gL6CAAryERcmyclRdMUXmJU+9L/5RNxgM9T26GFeDOHW61ROapOMMy1KUGbk1X09QwHC6WWhnkBMOVqwlHU+RgPorotZCgxkGHPg6MyuzxVY302cQUcY+EIKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e3lNdrtA; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e3lNdrtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788563720;
	bh=oCpOTlG041B1ThIGkZWvv9cFWgB0ZsVj68b2PP986qA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e3lNdrtAye6thSIuRMzJK4y57F4e8apuS2HbY0zA0oAcl1nYFHwpoWme52jzHn6jE
	 l93A8ElZrrgADHbpr4GAWZAxzFIq9ztSlxM5p2sQaUPkVmhPk3cxtfN0Ara/tLY0Bu
	 /iNNvkyTNp6pHMTGhktZoxR5f/MOVwD76P77OE2w=
Received: from github.com (hubbernetes-node-c128fa5.va3-iad.github.net [10.48.139.43])
	by smtp.github.com (Postfix) with ESMTPA id AA5C57803F3
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:15:20 -0700 (PDT)
Date: Fri, 04 Sep 2026 16:15:20 -0700
From: Proxy Alt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158378/000000-063d77@github.com>
Subject: [bluez/bluez] a678fa: shared/gatt-client: verify a synthesized CCC
 befor...
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

  Branch: refs/heads/1158378
  Home:   https://github.com/bluez/bluez
  Commit: a678fa2d00fa989b073d882a87149a65907df8b7
      https://github.com/bluez/bluez/commit/a678fa2d00fa989b073d882a87149a65907df8b7
  Author: Proxy <proxy-alt@proxy-alt.dev>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: verify a synthesized CCC before writing

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

v3 fixes two real bugs v2 had, both found by actually running it
against real hardware and then a real unit test rather than trusting
that it read correctly:

1. unverified_ccc lived on struct bt_gatt_client, but discover_descs()
   only ever runs on the root client, while register_notify() is
   commonly called through a clone (bt_gatt_client_clone(), used by
   src/gatt-client.c per D-Bus consumer / by profile implementations
   like bt_micp) - whose own copy of that queue is always empty. The
   verify step silently never triggered. Fixed with root_client(), a
   two-line walk up ->parent, used at both call sites instead of
   client->unverified_ccc directly.

2. Once (1) was fixed and verify genuinely ran, two more bugs showed
   up together under unit/test-micp: the CCC write could get skipped
   entirely, and requests the client issued after it could go out on
   the wire ahead of the (still in-flight) verify - reordering ATT
   traffic relative to what every existing caller of register_notify()
   was written to expect from a synchronous write.

   Root cause: bt_gatt_discover_descriptors(), which the verify step
   uses, is not tracked in client->pending_requests the way
   bt_gatt_client_write_value()/read are. notify_client_idle() only
   watches pending_requests, so it considered the client idle - and
   fired every registered idle callback, letting application code run
   - while the verify FIND_INFORMATION was still genuinely outstanding
   on the wire. That is what let a later application write jump ahead
   of the CCC write register_notify() had not had a chance to send
   yet. Separately, resume_after_ccc_verify() used the same
   "notify_count > 1 means someone already wrote it" check
   register_notify() itself uses - correct there, but not after an
   async gap, since other callers for the same characteristic can
   (correctly) queue up behind chrc->ccc_verify_req and bump
   notify_count before verification even resolves, with nobody having
   written anything yet.

   Fixed both: notify_client_idle() now also checks whether any
   notify_chrc on the client still has a CCC verify outstanding before
   firing idle callbacks, chrc_has_pending_ccc_verify() added for that;
   resume_after_ccc_verify() no longer rechecks notify_count, since by
   construction this is the first and only place that can write once a
   characteristic was ccc_unverified; and verify_ccc_cb() calls
   notify_client_idle() itself once verification concludes without a
   write, since nothing else naturally rechecks idle for a request
   this codebase's idle-tracking never had to account for before now.

Also fixes a real leak (3 struct bt_gatt_result plus their backing
allocations, confirmed via LeakSanitizer against the same test):
verify_ccc_cb() never released the reference
bt_gatt_discover_descriptors() returns, unlike every other discovery
completion in this file (see discovery_req_clear()). Fixed with the
same bt_gatt_request_unref() pattern.

unit/test-micp.c is updated to match: three subtests
(MICP/CL/CGGIT/SER/BV-01-C, MICP/CL/CGGIT/CHA/BV-01-C, MICP/CL/SPE/BI-01-C)
drive a real notify-enable through a synthesized CCC and now expect the
FIND_INFORMATION exchange this patch adds before the CCC write. With
v2 (before the fixes above), this test reproduced the original bug
exactly as reported: a WRITE_REQ to the synthesized handle that got no
response and would have hung until the 30s ATT timeout in a real
session. With v3, ./unit/test-micp passes 7/7 with zero leaks under
LeakSanitizer.

unit/test-mcp.c and unit/test-bap.c hit the same class of pre-existing
mock-script gap (their own CCC-enable sequences need the equivalent
FIND_INFORMATION step added) but I have not finished updating those
yet - flagging rather than shipping a partial fix for them silently.

Cost: one extra FIND_INFORMATION per notify/indicate characteristic
whose sole descriptor was synthesized, the first time register_notify()
is called for it.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy <proxy-alt@proxy-alt.dev>


  Commit: 063d77929b6c5e39516f066399c8edc1c1041bc2
      https://github.com/bluez/bluez/commit/063d77929b6c5e39516f066399c8edc1c1041bc2
  Author: Proxy <proxy-alt@proxy-alt.dev>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M unit/test-micp.c

  Log Message:
  -----------
  unit/test-micp: expect the FIND_INFORMATION the CCC fix adds

Companion to the shared/gatt-client.c fix (bluez/bluez#2383): the
lazy-verify patch adds one FIND_INFORMATION exchange before the first
CCC write to a characteristic whose descriptor discover_descs()
synthesized. MICS_MUTE's CCC (handle 0x0004) is exactly that case, so
the three client subtests that drive it now need that exchange in
their scripted ATT sequence, right where register_notify() actually
issues it (after the value read, before the CCC-enable write).

Verified: ./unit/test-micp passes 7/7 with zero leaks under
LeakSanitizer, against the corresponding shared/gatt-client.c fix.

unit/test-mcp.c and unit/test-bap.c need the equivalent update for
their own synthesized-CCC subtests; not included here.

Signed-off-by: Proxy <proxy-alt@proxy-alt.dev>


Compare: https://github.com/bluez/bluez/compare/a678fa2d00fa%5E...063d77929b6c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
