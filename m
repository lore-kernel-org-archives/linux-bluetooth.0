Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754D40B6DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817209; cv=none; b=OK7OaXHKpIig3855nm+2xRe65gwT8f4MXVFRYLwFeTdYyrVqttlNEydgt8ezyGN7mTbyqDLFzDLid2LlxD0PY4jJagbSVqEwXps9Zi5r+Ku1CZ4//WcpFXSFkd0ERCIBlss8eI4u+C9qOPB99NVc42hEVCb1OJa9B9yEZ38wRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817209; c=relaxed/simple;
	bh=tF0kJisBMoEzpbgZA3r6oxeM40gOMObjrk6NdqMwW0c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i+nqF+hwOIHkjP2vKBBbh48q8Rj0KbnmhKnsVI3cRobyJNUQxlxQO5Xj9c0Dbh5qlfknv1p/fXsx9ju/IIjP5WZfEiY3afPGyd0W111QoNh1EPrgnNdMxWriWH1kIAcMRARe/ydq0CNmReI7tu4MplF1nszuL0TyrZ+iJx6r1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QHgyHz/0; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QHgyHz/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779817207;
	bh=XTRe/RIF39aZ3aErIJHQhvciBwsczs0ZoNsJpDSSgPc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QHgyHz/0HTbsz7wcR3RTV7ubNvkZFBSWcKeVYWe8Ym1opnu7d4W1PsmHgDGpWWL/N
	 oFftQYAPiLyQ57/xLNirQQ+LTaLmSVY538C3LkwM/iE0P3n2qbySP2CH03wGybp12a
	 9u0bWu1WPx1VrDwN1sOP6Y7Yh+QRJCkOj8h44aWA=
Received: from github.com (hubbernetes-node-f3b0d3b.ash1-iad.github.net [10.56.182.35])
	by smtp.github.com (Postfix) with ESMTPA id 724FA840C87
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:40:07 -0700 (PDT)
Date: Tue, 26 May 2026 10:40:07 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1101147/000000-c81b48@github.com>
Subject: [bluez/bluez] 633d91: emulator/btdev: Add LE Set Host Feature V2
 command...
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

  Branch: refs/heads/1101147
  Home:   https://github.com/bluez/bluez
  Commit: 633d913df34b169a102b873ae55495852947361e
      https://github.com/bluez/bluez/commit/633d913df34b169a102b873ae55495852947361e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-26 (Tue, 26 May 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator/btdev: Add LE Set Host Feature V2 command emulation

Add emulation for LE Set Host Feature V2 (0x2097) command which
uses a 16-bit bit_number field (vs 8-bit in v1) to allow setting
extended LE feature bits. The command bit is set at byte 47 bit 4
as defined in bt.h.

Assisted-by: OpenCode:claude-opus-4.6


  Commit: c81b48b8a7195b1cc00d1d562a4de2e294da240f
      https://github.com/bluez/bluez/commit/c81b48b8a7195b1cc00d1d562a4de2e294da240f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-26 (Tue, 26 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for LE Set Host Feature V2

Add decoding support for LE Set Host Feature V2 (0x2097) command
which uses a 16-bit bit_number field to support extended LE feature
pages:

< HCI Command: LE Set Host F.. (0x08|0x0097) plen 3
        Bit Number: 32
        Features[0/0][8]:
        00 00 00 00 01 00 00 00                          ........
          Connected Isochronous Stream (Host Support)
        Bit Value: 1
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Host Feature V2 (0x08|0x0097) ncmd 1
        Status: Success (0x00)

Assisted-by: OpenCode:claude-opus-4.6


Compare: https://github.com/bluez/bluez/compare/633d913df34b%5E...c81b48b8a719

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
