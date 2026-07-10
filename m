Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95462882D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709602; cv=none; b=N92Wn2yIZ7eyYkSeTy0sutCSSWfrdq/VUcoQKBnXTS7KmepxWCVwOqEvcZX9c1K7YVwJO+Oeyax/chg3XupLIVszqSv7+eevVnltPV6Sk2YCgkfTA4nRs+W1dYJOJhLHPDuzEE5bfqsDtYFJ3dBUgK+wn3aTJIly1brM1I0ZKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709602; c=relaxed/simple;
	bh=OkyFj/gU0IajBdrl6b/ppVzWnLIbV78LK3ClyMpceJs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PPVQbk6onzDdpubZ7RNAZSDEwKzb8VSWW76hnOBCcJh9LQLH82GziX7XxlZbJ+7FlvX9uQyilG460hBKm6zoxY7DB+985QIEy55hUTijPqQR2WAzUV1KoXTf6yKA7p/PbZMa3Bh0nhnJ9+v41J+BeAoK7vlyrVCK02SeIO8uyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B9RUjoEX; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B9RUjoEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783709600;
	bh=I1RTUHIv16YbnjPI5EZdhUE4troE6Mmcv62JRmNa9ok=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B9RUjoEX+2Vpebjihm3Y+Iw/ThXwGVRAaoHCHPxTvwUKaFnIj7bm92DsZJR7jK3DV
	 x7KUZ/lPnb40bE3BIYBmCRZpnDi1XLXKtbS1omfufCpzxBRJmAXsGEYYCDYBzdxnHw
	 s5sxjFAt3DIjiAPzNli9tWJyM2ACkZtjkPI7Ny7w=
Received: from github.com (hubbernetes-node-ee6454e.ac4-iad.github.net [10.52.131.23])
	by smtp.github.com (Postfix) with ESMTPA id 3031E320D0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:53:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:53:20 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125549/000000-00500a@github.com>
Subject: [bluez/bluez] 855382: lib: add iso_data_* macros to hci.h
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

  Branch: refs/heads/1125549
  Home:   https://github.com/bluez/bluez
  Commit: 8553822b49f3204a59f942c60d00f32d5a38c10a
      https://github.com/bluez/bluez/commit/8553822b49f3204a59f942c60d00f32d5a38c10a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: add iso_data_* macros to hci.h

Add macros for parsing ISO Data Packet header items.


  Commit: 00500ac0cd55ab2a46075475bdc620538783c657
      https://github.com/bluez/bluez/commit/00500ac0cd55ab2a46075475bdc620538783c657
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix parsing of ISO packet data header and slen check

Check PB flag to see whether timestamp and data headers are present.

Check bounds before accessing data. Bump handle_str length to fit
maximum.

Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
SDU length check, as we are not tracking fragmentation.

Fixes: https://github.com/bluez/bluez/issues/2292
Assisted-by: GLM-5.2


Compare: https://github.com/bluez/bluez/compare/8553822b49f3%5E...00500ac0cd55

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
