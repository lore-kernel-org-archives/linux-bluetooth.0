Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154822FDFF
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610086; cv=none; b=u8bu5c0vzLzaGRZmi1AmqsBZ33iURZ3dYR02+RdQrjK6uEkuzbYP296MeWOPsNA46crUwNTk7H2d5nwj8zNwLv6R7jf9iUWX/OpKZXJcnl3dBBJ7vqmqp+5AchO7HKsFkWMHwLnrKCRifHFG5Ude26C3zyAoKscTG4dr7gvNmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610086; c=relaxed/simple;
	bh=Q8lgsnn0cKqw0nnp0XJKoWC5quuZ97fv34wn+kawBvg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pYkofcCUXpMM4wfUE4GdZg4pWU7mV69qxrqXsFp/CuXAX6nLyeVlD6t3t2uxgQNUSwjPnWBLoa8+a4K//f/I33G2MC5H322qVVOI0yi/SvQr6NvdGrwUcMwhVlvebSIpnYSClggX+909e9CFJ5yYOqE7GlZxvqx7YAQHUfYlKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aE0Mj2Pd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aE0Mj2Pd"
Received: from github.com (hubbernetes-node-d4fedfd.ac4-iad.github.net [10.52.210.51])
	by smtp.github.com (Postfix) with ESMTPA id 44F7E640D77
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767610083;
	bh=Qe9c80sPDTlkFVt13rwdXs/moCTbliHT5rMpArd3glE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aE0Mj2PduYssqi43BEbGouyVAA4rUdhZV+4DdfwACcQqnAZ+zjsLA2Z8Gyd+07tbO
	 IVpxeuD+pIPfg4aWV7eAfRRG1YIMfIrWO5opInXd6+gSaXDs8SxRv35yeD2PWgXHI3
	 d3gA9ocovsgmbmQbLgxdR+HsQyA7z2s/EbIghpmE=
Date: Mon, 05 Jan 2026 02:48:03 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038430/000000-192876@github.com>
Subject: [bluez/bluez] 192876: gatt-client:Implement error handling for
 DB_OUT_OF...
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

  Branch: refs/heads/1038430
  Home:   https://github.com/bluez/bluez
  Commit: 1928767236f82346c2bb0e0c7cd6884797748546
      https://github.com/bluez/bluez/commit/1928767236f82346c2bb0e0c7cd6884797748546
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-helpers.c
    M src/shared/gatt-helpers.h

  Log Message:
  -----------
  gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.

Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
received from the remote device. The recovery mechanism:

- Detects DB_OUT_OF_SYNC errors during GATT operations
- Extracts affected handles from the original request PDU
- Checks if Service Changed indications overlap with those handles
- Verifies database consistency using Database Hash characteristic
- Automatically retries the original request if DB is consistent
- Automatically retries the original request if handle is not affected

This may prevent some application-level failures when the GATT database
changes on the remote device.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
