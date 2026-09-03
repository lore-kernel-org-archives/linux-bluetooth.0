Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF170380FEB
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434003; cv=none; b=F2824vQjnS7OJGo78TssyRi54vwW8fdr/850pEwgQaF8Hbr0toQrWiI7ADhGr+QPTghHVrsDZhcHhJRtT2+ybKXkLizisGasX0C2HleINM+3Hom6V6awzLERHTNCFS6G77PobV8BmRbXk5FYIKgnjL1tMd5SdkTMmx6XeDvL9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434003; c=relaxed/simple;
	bh=+FkrJDHLMcFqpP8NB9iM0cYb79hZfWVfoGIVWUnylaM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OsTNpXSmaXvsOjAtj+s03EfzQsrQsE0MYRTQlMiRor5IjDl+VzlyaiuEpubiKyP/frgQ9OEhyuXUn6CqV61pI7DoaczLrBrX3b9uabEf9ZWPvGnyy4VSH29avayZitE04+tCB4vFToIpVdQODP72ZA6+hIeVezxTB+fMhJ/rapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T30Pok9l; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T30Pok9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788434000;
	bh=3OGNLYWwv2/Cn+gIkvXyYpJocVMkVwIXF9cuAySQTDA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T30Pok9lsbjD100+v85qGAkI9VGqJVLqU55CI+0rOHWv0oq5Idu55XmSytr1/uED0
	 WcMv7jAd/2LZocyrFJbfPNK76HxbVIW5BrZvS9/tHITjB7Y9WafvT6UqbW0Vc3tVEI
	 m1YCqm8gw2RvYRTBYcpregH6jeSJ44IGu4imOtFQ=
Received: from github.com (hubbernetes-node-9ca5e60.ash1-iad.github.net [10.56.146.40])
	by smtp.github.com (Postfix) with ESMTPA id 8E1DD84034C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 04:13:20 -0700 (PDT)
Date: Thu, 03 Sep 2026 04:13:20 -0700
From: ni-thib <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156908/000000-ae77eb@github.com>
Subject: [bluez/bluez] ae77eb: adapter/advertising: fix mgmt endian bug
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

  Branch: refs/heads/1156908
  Home:   https://github.com/bluez/bluez
  Commit: ae77ebe6659c0520101792d8961a53cdfa9774cf
      https://github.com/bluez/bluez/commit/ae77ebe6659c0520101792d8961a53cdfa9774cf
  Author: Nicolas Thibert <nithibert@gmail.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/advertising.c

  Log Message:
  -----------
  adapter/advertising: fix mgmt endian bug

Several places in adapter.c and advertising.c write a native-endian
value directly into a __le16/__le32 field of an mgmt command struct,
skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
else in this codebase for the same purpose. This is a no-op on
little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
no-ops), which is why it has gone unnoticed, but corrupts the value on
big-endian hosts.

Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
sends key_count=2 (2 blocked keys), which the kernel's
__le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
0x0200) since the wire bytes were never actually swapped to little-
endian on the way out -- producing "expected 8706 bytes, got 36
bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
dmesg/bluetoothd logs.

add_advertising()'s cp->duration and refresh_extended_adv()'s
cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
is inert with bluetoothctl's default (0) duration/interval values (0
byte-swapped is still 0), but A/B tested live (patch removed vs.
applied, bluetoothctl's advertise submenu "interval 100 100" set
explicitly) confirms this is not just a theoretical correctness fix:
with the bug present, the device stops being discoverable by a real
BLE scanner the moment a non-default interval is requested, and
becomes discoverable again immediately once patched. Any application
that sets an explicit advertising interval or duration hits this.

v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
requested by Luiz. Retested live on the same MIPS big-endian board
(blocked keys + explicit advertising interval): behaves identically
to the v1 fix, no regressions.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
