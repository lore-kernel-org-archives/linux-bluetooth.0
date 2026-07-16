Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D312045AD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234745; cv=none; b=iTF403kdjBS6OUpUe/UDrtOAUFgHhne4LGMX7xK4+wxBEFA+w0aUkBea+KyOIp679AxI8B59amw6/cn2hGvzrnwAQUGrt+t+jy112ogzrC24+yAvmcxr9pVnneMI7jgTH/vPnRrSRG8ONJffciUMu87vE5hto7E26F/+MQP25qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234745; c=relaxed/simple;
	bh=twOHjCxoitnGwRYI/AUxDt8iOeHEeVRQUD9TgTIe0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGZMNJMX8IDskgtf6E4gCK9srXGcDimIyLmWtCavmQYLbDnuQ5YtrmCaxT005qNwn5kieeeuSvicPitqgkW7DVnM5Esa5Q80qLaoXrc6pm7uXtEJHKSW9iWWo7gWucU616AVDsTsn4Nk3WVjJ8cqq67cUjiWwckc8I0KezP7uwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com; spf=pass smtp.mailfrom=pipobscure.com; dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b=zFwJjEj9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b="zFwJjEj9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h1Q6R41xVzMlGh;
	Thu, 16 Jul 2026 22:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipobscure.com;
	s=MBO0001; t=1784234735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PW4V2qWsVmcxH5O9W22LQskpn5EIppMIWJUx8GzGHpM=;
	b=zFwJjEj9VT2BcZX+8x1xpexV78rRnBCILCxQASjxZBHkUL5YHe2HG7Pz+JMW+3Lv5BAce1
	7woaUftaDWOGbbuOYkSjjbtnoLOhwiiYA2vMK78QwruuLCxUPIBsu8avidzuZ7/Nwg85Es
	CYo7Xfl5yC6e0W9xlQ2XUtVCWUZXylutD0n4j259QgnhVsiWFtg0gnMB6/nTmlg/zgnwbH
	LmaMCSZcN6dgPqJPwdbjEjcysrYmBz8B/9dgDE0qFIn6d1SvK2DhHkxAMwQunkHoJpVYZJ
	QAGGYvVFKUSUc6kvQhe1/b+P/v82h33vM9bLhI5AdgnQ+s9EiVEM0VAYuZWL+w==
From: Philipp Dunkel <pip@pipobscure.com>
To: linux-bluetooth@vger.kernel.org
Cc: Philipp Dunkel <pip@pipobscure.com>
Subject: [PATCH BlueZ] adapter: Infer BR/EDR only at public LE addresses
Date: Thu, 16 Jul 2026 22:45:14 +0200
Message-ID: <20260716204514.79356-1-pip@pipobscure.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  bonding_attempt_complete() hci0 bdaddr 5A:B4:98:1F:CC:04 type 0 status 0x4
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

Assisted-by: Claude Code:claude-opus-4-8
---
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

The patch was reviewed line by line and the result above reproduced on real
hardware by the author, not inferred. make is clean with no new warnings in
src/adapter.c, and make check passes 39/39.

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

