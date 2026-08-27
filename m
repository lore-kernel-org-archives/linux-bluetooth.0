Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212E47CC8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844480; cv=none; b=UCGenoi8vlpRrL4EkediKNup3mjMsULlfI3D35UWmB3k+AuRITti6UvnROV/lC6pFJbNfo++VfNKrofqhTNAg2Ib6VnI6AfSCvMN4xLOl0nsjNJrz1UebSoe8iEp9FYW3+f7/+HizDn8N2tJ2U/YHXtszbQuEpQUs8j84be8djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844480; c=relaxed/simple;
	bh=9GKHD6IFx8yKoOWkQtzTvfIkCKuP1/1b3eFZpMaHOxM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KVFS9qNEwHyyWlkp9LYx5tTDdn7gOWtw3Sn1d6GtL3+6GJ+HvETpLV4OHXZucJ+bgN4OI03R7AlqviW70hmPbVBkW3EVpiIThO/55fJuDpWk0JT/fOTeEhClr2K2lICSiwi4Y6voXG31/goO/VXxkRBXVaPTLpyWgz69jIu6aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B/HyB0bI; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B/HyB0bI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787844478;
	bh=bZ4TjZJZbmTDVxeBQvQz8OMOkLgaKQv78CnF2YzYxlE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B/HyB0bIIrc+99nwHEwzipFHqS5AmquA6+aoTVLswDM9kGnUJY157QGC8DIQIHmyz
	 7fm9vgzkM0qmG6X47T3jh5x66xY21a2O4kdOS9S0/raS1ezIaR+YsTfqtHd0tHmTCk
	 oPbw+X8r4pMf9TKvKTSUWL53ktEr9GQti8E6R2Lc=
Received: from github.com (hubbernetes-node-63e25fe.ac4-iad.github.net [10.52.85.58])
	by smtp.github.com (Postfix) with ESMTPA id 6F96E40702
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:27:58 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:27:58 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152690/000000-ce408c@github.com>
Subject: [bluez/bluez] ce408c: bap: Fix stack buffer overflow in BlueZ LE
 Audio B...
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

  Branch: refs/heads/1152690
  Home:   https://github.com/bluez/bluez
  Commit: ce408cacdb61d3137360268227f5c4aa31fce899
      https://github.com/bluez/bluez/commit/ce408cacdb61d3137360268227f5c4aa31fce899
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser

A stack buffer overflow (CWE-121) in bap_sink_match_allocation() in
src/shared/bap.c allows an attacker within BLE range to write ~195
attacker-controlled bytes past a 4-byte stack buffer in bluetoothd
with no pairing, no connection, and no user interaction. The BAP
profile auto-syncs to any device advertising the BCAAS UUID.

bap_sink_match_allocation() copies the value of an
Audio_Channel_Allocation LTV (type 0x03) into a 4-byte uint32_t stack
local using the LTV's attacker-controlled length byte as the memcpy
size, with no upper bound check:
	// src/shared/bap.c:7767
	memcpy(&location32, v, l);  // l attacker-controlled, no upper bound

A second identical instance exists in bap_sink_get_allocation() at line 2558.

Per Bluetooth Assigned Numbers, Audio_Channel_Allocation is a fixed 4-octet
bitfield; any other length is malformed.

https://github.com/bluez/bluez/security/advisories/GHSA-9683-2chf-hfw9

Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
