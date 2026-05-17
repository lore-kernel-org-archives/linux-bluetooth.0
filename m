Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE326F29C
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014406; cv=none; b=K/2mDIVIqL+ayUD/YhJD24xikBmBfe/EMR9E1fJ2I4p69i2Us6o77zK9WpIVtToijmvX8QuRnUnVrbUZ7rgHujEObdXHGgl3Ec9w0cNuK+V4u+imr1hXBYjnjICGvyiJhLn29R9Gz3thKu5owEOYLcW+c25oB3nUyYPCgzUTovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014406; c=relaxed/simple;
	bh=RwKu4Z1k/xQaqSxXtjmM3WvfTAaD+rORgN10J4M37Ow=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XGsWPUs1wVbJm7PMglZSuk8UkBL1nqUjW9onEiMh+OR5KbljLNpJOq94zG4uSHIfaiei4/WWIzNtgx9I9xEC7h05hyOZ+KP5v5m/5uz/Dbhwl8ilzEHEIRH7wt7ORY+rzpIj48uEzGTUOjMt98a/6Wgtfane7JP57Fp6GaHyIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lvpW02xT; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lvpW02xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779014404;
	bh=rPFiZEfkWaX9hiei3O3VCw21egVJegtYpy0PXx4fHVQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lvpW02xTESdeYAf1kGlmBwV/alCf8eM1izzStT6BK3zkpfRYjrecjRGmqtO2gdL5A
	 hv54AruzPKjRsYJAIwX7rziz+wBouwukVfLpoPkYChz1zFG+hucZRb7k3R4ixQHW/X
	 Lgt/mrL0s86VFa8jAu/VtyJnIQBicW31waNKj+C8=
Received: from github.com (hubbernetes-node-d169943.ac4-iad.github.net [10.52.138.44])
	by smtp.github.com (Postfix) with ESMTPA id 1C41274105E
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 03:40:04 -0700 (PDT)
Date: Sun, 17 May 2026 03:40:04 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096012/000000-a02319@github.com>
Subject: [bluez/bluez] 37aa6d: shared/rap: fix use of uninitialized value
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

  Branch: refs/heads/1096012
  Home:   https://github.com/bluez/bluez
  Commit: 37aa6da047764ef9b07542002bda84ac551a92d6
      https://github.com/bluez/bluez/commit/37aa6da047764ef9b07542002bda84ac551a92d6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: fix use of uninitialized value

Fix error handling in send_ras_segment_data


  Commit: 688a13363b7ddcf8c4bf7039cd2270f60ec7b18f
      https://github.com/bluez/bluez/commit/688a13363b7ddcf8c4bf7039cd2270f60ec7b18f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Fix integer overflow in sdp_extract_seqtype

Check uint32_t value does not overflow int range.

Link: https://lore.kernel.org/linux-bluetooth/ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org/


  Commit: a023198770010606a847fb1a49afb97ad7c1ed9b
      https://github.com/bluez/bluez/commit/a023198770010606a847fb1a49afb97ad7c1ed9b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  main.conf: fix unintentionally set value

Commit 31e4fb1498f ("monitor: Add decoding support for HIDS 1.1 flags
and attributes") unintentionally set a non-default value in main.conf.

Restore the value back.


Compare: https://github.com/bluez/bluez/compare/37aa6da04776%5E...a02319877001

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
