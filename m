Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9ED2EFD95
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533630; cv=none; b=UaQuG8EY2SGDAAErYbUm1lcIMEcYYmtVU/Y/sXN3ws4EWItmsRxl5MBQt1m8A7Jis6Fn+3zV/QfEmxEShqy/bIcngSwkCID8aqA73lOwVoPPbw/77s3GeC/gM6HDwQ4yjsmHr3xV5Od/44nyL5XME2Q19z4m+vWPW4YCqNNHvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533630; c=relaxed/simple;
	bh=S02Upr38hsH7U7b0ov8r04YK7WOvYgLDQInorkpFce4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CVX+8eTs2MCdOQX9VntpSzA2FUY/25vdNCJ0r2OQ2+mAqViAPc3qYfOek4Lq+NwSujKRhD5faYuG5UWaoGxz9NklT8chcQ/cCWWbEi0P9zCr93JRK7U7Wyll+lPSBM+mtP9A2X4kT/UOS6iOi0oRueSBAr2nCMmvMVP7PJOs/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ho3T6+j9; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ho3T6+j9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784533628;
	bh=jxg/d6/QRYG0FmOA18CE0C64j/wOyvlnCGenQzq4H9g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ho3T6+j9I7orMvLZoqBl58OfKaI1RPzavUuF66M5NNxjvzYeR7NjAO/BORmpm25Pa
	 SlTV2Oyg4aMV318pMQ0yQF7mfjW2kXJTKQikke18Uy53F6op7ZFk+WLaZPuRb4q+23
	 n9HWQ99mB3/ChFTu1ROXdOhis6aRCvDdBSnRoyDk=
Received: from github.com (hubbernetes-node-085bb01.va3-iad.github.net [10.48.73.63])
	by smtp.github.com (Postfix) with ESMTPA id 390A8180851
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 00:47:08 -0700 (PDT)
Date: Mon, 20 Jul 2026 00:47:08 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130548/000000-0108e6@github.com>
Subject: [bluez/bluez] e7eb72: doc: hci-protocol: Correct mtu to &mtu for
 getsock...
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

  Branch: refs/heads/1130548
  Home:   https://github.com/bluez/bluez
  Commit: e7eb72a78a583092ea1ef189e56a8d6c6f968d22
      https://github.com/bluez/bluez/commit/e7eb72a78a583092ea1ef189e56a8d6c6f968d22
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc: hci-protocol: Correct mtu to &mtu for getsockopt BT_RCVMTU

For getsockopt(..., BT_RCVMTU, ...):
Correct its parameter from mtu to &mtu.


  Commit: af8eefea1472de84ef159b89a3b2bc0e650b6b3f
      https://github.com/bluez/bluez/commit/af8eefea1472de84ef159b89a3b2bc0e650b6b3f
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc: hci-protocol: Add sock option BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER

BT_RCV_VENDOR_PKT was introduced to support vendor HCI frame.


  Commit: 0108e6e2a4fb4afdab2c3bfd6bb13502e15094ec
      https://github.com/bluez/bluez/commit/0108e6e2a4fb4afdab2c3bfd6bb13502e15094ec
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M doc/btsnoop-protocol.rst
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  monitor: Add generic support for vendor HCI frames

To show vendor HCI frames.


Compare: https://github.com/bluez/bluez/compare/e7eb72a78a58%5E...0108e6e2a4fb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
