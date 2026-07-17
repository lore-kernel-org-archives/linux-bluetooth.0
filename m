Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E23EBF01
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283298; cv=none; b=cxAP7+90wriwnLS+hAnSRTyYewSleEdNpKJ7flc16IF2BiZm7cNyKdDiyEdrCvWqa8yPoqGLp4EAyPmbe3ytkpAmnmAjejWkNrC3rYRksjbR8ctCLs23m4KVQQ3WIx2k5nGfFTbRFIc0wly43/PPnFUsTvLsG4y5vcgez6ii87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283298; c=relaxed/simple;
	bh=GH56lN2ZcaxIkLort01rkGWg8Lp8tLBtcfM1IrK7ZpE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Tf+GEjMIYRP4abjlp10L349oSnF8LQfgbQwW7t6Y2G8QR/qHbktsoy25OZXSM13zJCq8mGXleUCa/4VzGb+704qfexvcK5ZEhOXb7cv9CcG3ODxBC7en29aG9EN2nLjaDtbgh1Sxk7lhqvUmJwt6k1xbd3Qa9JyuPtk5StYf8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KlpDUJNR; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KlpDUJNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784283292;
	bh=CddmIMKvtmrkmvsWedhoKlneV98tUp4BGHjiFCowrz8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KlpDUJNR3nYZNVpUzh4iKaqRmxMIydw1a0neKZ5DBcyOhoAKpGFPevCZhXlk8hqG9
	 SdqErf/SZTKXCr7cLx4DIPERObgx0XHP00Z0pDuWfgJzdU8QyhvExWkvHg9sj1GVo6
	 zpXCa+1dANpioQYwt+xsHnc1mWKWuQFI5t+9Peno=
Received: from github.com (hubbernetes-node-8dfbe14.va3-iad.github.net [10.48.73.93])
	by smtp.github.com (Postfix) with ESMTPA id E03651812B1
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 03:14:52 -0700 (PDT)
Date: Fri, 17 Jul 2026 03:14:52 -0700
From: Philipp Dunkel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129413/000000-0e25b2@github.com>
Subject: [bluez/bluez] 0e25b2: adapter: Infer BR/EDR only at public LE
 addresses
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

  Branch: refs/heads/1129413
  Home:   https://github.com/bluez/bluez
  Commit: 0e25b2b3c57c5d086e3f08aae50444c9621361d2
      https://github.com/bluez/bluez/commit/0e25b2b3c57c5d086e3f08aae50444c9621361d2
  Author: Philipp Dunkel <pip@pipobscure.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Infer BR/EDR only at public LE addresses

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
