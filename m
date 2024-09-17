Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009E1369B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558949; cv=none; b=d30ZSh82rURbetl0dWnTxoJ+Hf2BIBI9QbzD+6w6W6jof8wKPs3gYvW968UHn3jv9tD7HY45dRdElO8fddY2kCJBGXpmgpK7e+Js6+veryKckxLX+k871b0Rde4NdKwfb5gSKUKsx8xSyFJtkGgSHmnjVDeZcy4xybSiO5Khtxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558949; c=relaxed/simple;
	bh=KyXHPQhbfxMjsY5nY7xzypclw3Ln+IpXPBFsSSOVa4M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=i2+MqUNqQ+C9usKXOy9rNTywRAC4mDDKsVU1Ak+8jaOkY7jM9Z4KnjCWYg4LFMrNsRPZfMSOef+6YTE4qKKvbhyjtyCKBwoL1z18WJ1UdqNG91Xp9qco9C5xSe8s8Qvx3DBSer+TfROHsJye0u3MzyLbpp1y1Po4SdXepb7PK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G/E79eqT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G/E79eqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726558944;
	bh=KyXHPQhbfxMjsY5nY7xzypclw3Ln+IpXPBFsSSOVa4M=;
	h=From:To:Subject:Date:From;
	b=G/E79eqTCsubIr7rTk3BUEfhREgtOG9vWo88xXck4rxr9cmX/vBkKzUK2xecQBryh
	 8H93ic6uqkPZw1yJW/BqfDtvOAawHy/GckIcLVmmzvLi4WgkAToyMbixeBWMWkoMen
	 2GJDAgE9qMqJTRQDry31MpmKIHDcX1JqoSL/1wDTeiE9/AoRASCpLS8/Bq2t56MS95
	 2FvDgFd2yezp1wB5iv6IrZwkEIKPq+jUZpbVXxw9DFpu8uW/23+JbW0f8tjVqiBxXK
	 /3vmaa2nFfADNpnydn4oKVOkZvE+Inave55UIV9av2+qyfi0/DduatKb/lQ4yH1eNj
	 8JdQJnl5czHTw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DBAE17E0FD4
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 09:42:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/5] Add BIP for AVRCP covert art OBEX client
Date: Tue, 17 Sep 2024 09:42:12 +0200
Message-Id: <20240917074217.231677-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If AVRCP Target supports Cover Art download its SDP record contains an
additional access protocol for OBEX with an LCAP PSM on which the OBEX
client session should connect to, with the specific OBEX target header
7163DD54-4A7E-11E2-B47C-0050C2490048.

Once the OBEX session is connected, the AVRCP track metadata will contain
an Image Handle which can be used to get the associated image using
GetImageThumbnail or GetImage with one of the description property found
with GetImageProperties.

This has been tested with iPhone 14, iPhone 15 Pro and Samsung S23.

v1 -> v2: Parse integer properties as integer instead of string
          Return GetImageProperties values as aa{sv} instead of aa{ss}
          Get properties for GetImage as a{sv} instead of a{ss}
          Set new properties and interface as experimental
v2 -> v3: Rename obexd/client/bip-avrcp.[ch] to obexd/client/bip.[ch]
          Update the AVRCP Controller version in SDP to 1.6
          Add commit to support for specific headers in obex transfer
          Fix memory leaks
v3 -> v4: Commits 1-4 has been merged
          Change org.bluez.obex.BipAvrcp1 to org.bluez.obex.Image1
          Change GetImageThumbnail to GetThumbnail
          Change GetImageProperties to Properties
          Change GetImage to Get
          Add possible property values for the description dicts

Frédéric Danis (5):
  obexd: Add BIP client for AVRCP cover art download
  obexd: Add Properties to org.bluez.obex.Image
  obexd: Add Get to org.bluez.obex.Image
  avrcp: Update controller SDP record with cover art support
  doc: Add description of org.bluez.obex.Image

 Makefile.am                   |   9 +-
 Makefile.obexd                |   2 +
 doc/org.bluez.obex.Client.rst |   1 +
 doc/org.bluez.obex.Image.rst  | 118 +++++
 obexd/client/bip-common.c     | 800 ++++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h     |  24 +
 obexd/client/bip.c            | 440 +++++++++++++++++++
 obexd/client/bip.h            |  12 +
 obexd/client/manager.c        |   2 +
 profiles/audio/avrcp.c        |  12 +-
 10 files changed, 1412 insertions(+), 8 deletions(-)
 create mode 100644 doc/org.bluez.obex.Image.rst
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h
 create mode 100644 obexd/client/bip.c
 create mode 100644 obexd/client/bip.h

-- 
2.34.1

