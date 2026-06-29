Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC22E7364
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764827; cv=none; b=HMB+u0xKfHKAXLfGmrfrKFroD4/yhX8iuz7AjhEj4/fEVpOE0T+MYsSwttj503sgm9Z/83wrM4EmZU/4yFiJcswvKDlykfIr1QBkdPOOT2L8JtrHr8OJAR6GyrfLD2Su2AQlzHedWt8f2edHb+si8vzfgpkjcufcMntSzZ3euYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764827; c=relaxed/simple;
	bh=TxvH6kdNS/7zUygrjXrYssVuU7fL8FLlljONPm53+Fw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GFqinzZHcoy1Nxbu9fcVqTDnaqJDKYHIcEs5nG3LB0rm0/2PQr5MtehxE4ADqwAtd1hXR9DKcnBcS02d0ywIkYPURUSBaDLFad0PON+shp1Uyga7rA1FYL22ReJuNww1SzAglLGpfGS47CbY1hkZw9hlAa0jGcWxd0t4hOB/vMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BIF3AXNl; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BIF3AXNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782764825;
	bh=Re4LEd0zfJef8Nz/XSyPng1Xfkk23QmEAWWgQvMM+5E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BIF3AXNlO+tsZN7dsCOTKtrpjaQroOl4Cvo+52Rnz9WCVmeaGB0mzWP5CkJC7ehC7
	 IRMJoKE7Xlhziq4IYWXFVATFcx8CaxnCIJx1BibMZSgdz2pzDCAlu1JS3EhbMJfqir
	 8ovuMYF6c9ihAErEBQ8UlER0ft2HL192l3wgT12E=
Received: from github.com (hubbernetes-node-5fac825.ash1-iad.github.net [10.56.225.13])
	by smtp.github.com (Postfix) with ESMTPA id 7DEF318C976
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 13:27:05 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:27:05 -0700
From: Matthew <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/eb9b35-220f10@github.com>
Subject: [bluez/bluez] 27a4c4: bass: Fix possible crash on
 bass_update_bis_sync
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
  Commit: 27a4c48b048113576925adad4477aee02c8119b6
      https://github.com/bluez/bluez/commit/27a4c48b048113576925adad4477aee02c8119b6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix possible crash on bass_update_bis_sync

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.


  Commit: 2262e371564994b429b045cdd34f53eee0cd0c13
      https://github.com/bluez/bluez/commit/2262e371564994b429b045cdd34f53eee0cd0c13
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Check if stream is valid before attempting to release

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.


  Commit: c0fec57e9fa28692dc36e12616c5b74e4fa425ec
      https://github.com/bluez/bluez/commit/c0fec57e9fa28692dc36e12616c5b74e4fa425ec
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't transition to IDLE inside bap_bcast_set_state

Remove the recursive stream_set_state(IDLE) call from the RELEASING
case in bap_bcast_set_state. This call re-entered bap_bcast_set_state
while the state_cbs queue was still being iterated, causing a
use-after-free if a callback unregistered itself during notification.


  Commit: a9b6c8a2ea624a62101df16dde5735f4bde1631b
      https://github.com/bluez/bluez/commit/a9b6c8a2ea624a62101df16dde5735f4bde1631b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use queue_foreach to notify state changes

Use queue_foreach to notify state changes since that is considered
safer as it does attempt to detect list modification while traversing
the list.


  Commit: a2c7bc03b75969f784d1ea1feacc78773063025c
      https://github.com/bluez/bluez/commit/a2c7bc03b75969f784d1ea1feacc78773063025c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Protect bap_stream_notify_connecting

bap_stream_notify_connecting may encounter callbacks that remove itself
while traversing the state_cbs, so this attempts to prevent to cause a
crash by prefetching the next entry.


  Commit: 220f102c8db9888bd113d0d53cd246ece3012696
      https://github.com/bluez/bluez/commit/220f102c8db9888bd113d0d53cd246ece3012696
  Author: Matthew Cash <matthew@matthew-cash.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M profiles/midi/libmidi.c
    M profiles/midi/libmidi.h

  Log Message:
  -----------
  profiles/midi: Fix zero timestampHigh

BLE-MIDI timestampHigh can legitimately be zero. The MIDI parser used
timestamp_high == 0 to decide whether it had already consumed the packet
header, so packets starting with 0x80 0x80 caused the next running-status
payload byte to be consumed as another timestamp header.

Track whether timestampHigh has been read separately from its value so
packed MIDI events with zero timestampHigh are parsed correctly.


Compare: https://github.com/bluez/bluez/compare/eb9b35c8d13d...220f102c8db9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
