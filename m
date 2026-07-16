Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D673C5849
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237912; cv=none; b=SZTTGl+6pHCI5nyB/sJDxKIfSZqG+0egd4aMafXPVGLJGhL86ph+lBF38S/KhyBlQ7LoXkna6PhrtYaSYlOIzZiIPw+K4VM6IT7wFIPOK43OhkO4rK9x0iphdvfvVEB+0mA3UON60vyOMG1XHEbFvbjrJiguUpxDD5JurY7r3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237912; c=relaxed/simple;
	bh=6X7jcYk8pkv79+jcBPY7SnyMnQXGZlX0NgtYt46f/gs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C5tO0k3axdpD7wqhj/XE9sCdeSZPk5mcvzw1BX0XXsx5ErlhWN7QpXRFhotoSJhYJh7u+qBCy8h/K0RAg6plv87rIik8SAojfCptQObimUG+/e5QUtT+NZ+l5pF+neNytYM+jQeY890XCFpA2V+zWT0K4ryb1xxiq5nY34IoifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dm60wRte; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dm60wRte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784237910;
	bh=jpKINc8XrJ6b9brncz6YQMpSutEzTquNVrBEoagRSaY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dm60wRteFuX6DovaqWw66jF0K0Gf9RKfVugOsmZ31lBxbfKef9JaTjHEsvg2SFOh4
	 wY0clGV/cvSyMX4gRnofvjraKyZLHQIjJfPqi2MrBzAIhp+FTzPzOW97AiFgJ3Na7c
	 YWhLX0jhVgQTyMSb0oSgIkw5Aa/OuSa88H4LqrmU=
Received: from github.com (hubbernetes-node-268465d.ac4-iad.github.net [10.52.153.34])
	by smtp.github.com (Postfix) with ESMTPA id 87A0E74097B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 14:38:30 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:38:30 -0700
From: Philipp Dunkel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129094/000000-b555d9@github.com>
Subject: [bluez/bluez] b555d9: adapter: Infer BR/EDR only at public LE
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

  Branch: refs/heads/1129094
  Home:   https://github.com/bluez/bluez
  Commit: b555d9dbac2ef9a5d1670c08d1600103b211f709
      https://github.com/bluez/bluez/commit/b555d9dbac2ef9a5d1670c08d1600103b211f709
  Author: Philipp Dunkel <pip@pipobscure.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
