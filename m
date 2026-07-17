Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECC3B7747
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276652; cv=none; b=IxsOqbq0prLv5N6soGQkVX4psFgDw6B66FAfNmjxcpdn3xJPtDeXCw+hBN6j9jzoMKTZuQnxbG5FSaDmgJsq61Pw00q+xZx6lG2qUJPo/oqC6HIxOZZz3WQY4EQac5GwdcCA/vDe5VLkala/Ux3W36UwME02m0eT4UsCeePMVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276652; c=relaxed/simple;
	bh=73a/Z4iLGvKKuswT3OmA8mWhuw4n4Ny7MJAGkmqUBrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcwoF/OSeF6zhV6ZEOqbFTPSlIyrEyXbClWLEJL47zEAD5EAP1sc6ENFuT3rATI1WxA2dmLWiFnpeze/EtbYWHcfFfER4HR4PgVLeFMndL7ZkOaca9GBKc241rnRIRJMyJoLVSzjf53jbqYDnAxLUgdrkagWKV+UDavDwY7tDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com; spf=pass smtp.mailfrom=pipobscure.com; dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b=qStEtWX0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b="qStEtWX0"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h1jcG5G98z8tZw;
	Fri, 17 Jul 2026 10:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipobscure.com;
	s=MBO0001; t=1784276639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9l1njqM926e3qGNEjsBrFZ+9acahsFaZNJPjHCdoM0=;
	b=qStEtWX0e+9jC7YyI+W7d73wX9AFCIWLpDUyUDy0KUDX9x3Zjf2hG15JiHQLP+KiiHmkOv
	rXh1dzA2WGwOHZ5APKsQ4ftoTTTyTuyExGkvo4OK41RcWgePfgyo2isOH6fh/zWHk034aY
	Z1feAevnG95TT2zaX+5geKgsoC5DWFO/ZTsi+rz+JGkN50HEVdNAPTpyDhT3RA1S8dM6Sf
	KIkqTpyyF3Fg5ZrEdZYqiUqwRAi1d0hk/I/2MHl4uz8sbuoAYDyZwWtHuI1byDfulsf3/I
	6o7bZefOWrbDj+OVNGCA0aeyu70XXuzc95zNCTBi4qki0GgsGCcHhp5lSbgabg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of pip@pipobscure.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=pip@pipobscure.com
From: Philipp Dunkel <pip@pipobscure.com>
To: linux-bluetooth@vger.kernel.org
Cc: Philipp Dunkel <pip@pipobscure.com>
Subject: [PATCH BlueZ v2] adapter: Infer BR/EDR only at public LE addresses
Date: Fri, 17 Jul 2026 10:23:47 +0200
Message-ID: <20260717082347.8429-1-pip@pipobscure.com>
In-Reply-To: <20260716204514.79356-1-pip@pipobscure.com>
References: <20260716204514.79356-1-pip@pipobscure.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h1jcG5G98z8tZw

btd_adapter_device_found() records BR/EDR support for any LE device
whose advertising Flags lack "BR/EDR Not Supported" (EIR_BREDR_UNSUP).
The address type is not considered:

    if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
                    !(eir_data.flags & EIR_BREDR_UNSUP)) {
            device_set_bredr_support(dev);

When the advertisement uses a random address the device gets a BR/EDR
bearer whose address is that random address, and start_discovery_cb()
then prefers SDP over GATT:

    if (device->bredr)
            device_browse_sdp(device, NULL);
    else
            device_browse_gatt(device, NULL);

SDP requires a BR/EDR ACL, so bluetoothd pages the random address. A
random address is not a BD_ADDR and cannot be paged, so the attempt
always ends in Page Timeout, and the failure tears down the working LE
link:

  connect_failed_callback() hci0 5A:B4:98:1F:CC:04 status 4
  bonding_attempt_complete() hci0 bdaddr 5A:B4:98:1F:CC:04
      type 0 status 0x4
  device_bonding_complete() bonding (nil) status 0x04
  browse_request_cancel()
  btd_gatt_database_att_disconnected()

Nothing requested the connection ("bonding (nil)") and the LE link was
healthy. Any LE association that outlives the page timeout is killed by
it; measured on one host, applications get about 4.7 s from connect
before the link disappears, of which GATT discovery already takes 2.3 s.

Current phones advertise Flags 0x1a (LE General Discoverable plus
Simultaneous LE and BR/EDR, with BR/EDR Not Supported clear) from
resolvable private addresses, so this triggers routinely rather than in
some corner case.

The Flags bits describe what the device supports. They do not promise
that the address it is advertising from is a BD_ADDR. A dual-mode device
uses the same Public Device Address for BR/EDR and LE, so the inference
is sound only for BDADDR_LE_PUBLIC. Restrict it to that.

The other two device_set_bredr_support() callers already require the
device to have been seen over BR/EDR (bdaddr_type == BDADDR_BREDR), so
they are unaffected. A device later seen over BR/EDR, or whose RPA is
resolved to a public identity, still gets BR/EDR support recorded there.
---
Changes in v2:
- Commit message only; the code change is byte-for-byte identical to v1.
- Dropped the "Assisted-by:" trailer, which checkpatch rejected as a
  non-standard signature with an unrecognized email address. The
  disclosure is kept below the --- instead, see the note at the end.
- Quoted the two code excerpts with spaces rather than hard tabs
  (gitlint B3).
- Wrapped the bonding_attempt_complete() log line, which was 76 chars,
  onto a continuation line to fit 75. The text is unchanged.

This patch was developed with assistance from Claude Code
(claude-opus-4-8). It was reviewed line by line and the results below
reproduced on real hardware by me before submitting; nothing here is
inferred.

Verified on a dual-mode controller with ControllerMode=dual, against iOS and
Android peers advertising Flags 0x1a from resolvable private addresses. A GATT
association that includes a ~7 s user prompt, which previously failed every
time at ~4.7 s with the Page Timeout above, now completes:

  before:  connect +0.0s, GATT resolved +2.3s, first exchange +2.7s,
           Page Timeout +4.7s -> LE link destroyed, transfer never completed
  after:   same host, same peers, classic still enabled, transfer completes
           with the user prompt taking 7.0s of it

Setting ControllerMode=le instead of applying the patch also makes the failure
go away, which independently confirms the mechanism: with no classic radio
there is no page to time out. The patch achieves the same without giving up
BR/EDR, and A2DP/HFP continue to work on the host afterwards.

make is clean with no new warnings in src/adapter.c, and make check passes
39/39.

No unit test is included: src/adapter.c is linked only into bluetoothd and not
into any unit test target, so btd_adapter_device_found() cannot be exercised by
the existing harness. Extracting the check into a unit-testable helper looked
like scope creep for a bug fix, but I am happy to add that if preferred.

 src/adapter.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4ffa32a..30e7679 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7415,8 +7415,17 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	 * older kernels send separate adv_ind and scan_rsp. Newer
 	 * kernels send them merged, so once we know which mgmt version
 	 * supports this we can make the non-zero check conditional.
+	 *
+	 * Only infer BR/EDR support when the LE address is a Public Device
+	 * Address. A dual-mode device uses the same Public Device Address for
+	 * BR/EDR and LE, so in that case the advertised address is also a valid
+	 * BD_ADDR to page. A random address (static, resolvable or
+	 * non-resolvable) has no defined relationship to the device's BD_ADDR,
+	 * so recording BR/EDR support against it makes the device look pageable
+	 * at an address that can never be paged: SDP discovery then fails with
+	 * Page Timeout and takes the working LE link down with it.
 	 */
-	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
+	if (bdaddr_type == BDADDR_LE_PUBLIC && eir_data.flags &&
 					!(eir_data.flags & EIR_BREDR_UNSUP)) {
 		device_set_bredr_support(dev);
 		/* Update last seen for BR/EDR in case its flag is set */
-- 
2.55.0

