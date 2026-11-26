Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683140;
	b=zV/DpGIGKTgef/IMy6K7HhnOfC0KOx4ALPIzrMTV0mOY7RmytkrU0BtEDt9HmobETyes
	 Y2qNiPfr3/lBOvT8jT/qg/ZRIePJ93bFxVVz9UhLgMjoosaFcL5pPH81xiU8F64HI2rgc
	 mDPgmJ6djat2f3PRcUz+Ws9wNdj3y6tlgA4ptyBozoeKnX456+tE1S8OfpRTIiD0TLY8b
	 ZRJKc4Sebi7ehPr0Xj2xuki8Zt8Ns+e+11IMR6ib0E3fFBCAUmwQ6ZUuxulHTo1FG4oYk
	 u8GdYOFMNC4AhLm0X76Bqd7g357OVjKoHT4WdnmyzJ0TfmqzuJ+B/ia/ImznW9Gfiwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683140;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=aaceKmA/8UMGj3Ea9OWyPLPmcCW3CMZi5vEh+Kn7wxk=;
	b=NY4gRsny3rFf6uaPezji79cLgLCcIMH7qdJ2tFDDZj54oyXKjBYbH1WlLF+pugrQZkpq
	 YfxhvZIXc0kCImb2oBNlcnPw6W6r3u9jmj2y4sxKaBHFG3wppEno1Z9DLdgDM5fMKZ2TP
	 e+OFrREqOD7EsayMBbaj8S2aTvN0R/QNnJgTjGKTMPI3MEQGNrrI83pC39Kclwd5ypwaI
	 538KG3iqHyewjwe0dAlwLhLaXA7wOZqltBdWfnpNYbUQZ7trKSfd3PzuJ84f+5iWF6vs+
	 PnX8RQ4ctMbzyEv8pnrO7NeIQCvbWx++NHXcK/vBmy+5fWUsSkHB15uenDkQUOhjzhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Iev6I2hR;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD865606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD865606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Iev6I2hR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795683137;
	bh=mql9GbKmpeZftfWpI+lDVjlj5OhiXY/GlTgSLC5ZoCc=;
	h=From:To:Subject:Date:From;
	b=Iev6I2hROF6JpXeKJdHyTRbXvWOQdr9lvOdjb9pPVIxvH4ONe2ubFjF40WHq+1tBl
	 EeNbxdho3beJSBWfMuGoMeV5MRkygM/OKqCoPJSqSGnxx+lWeyVWEwL9C2JeYK4XvG
	 dz79IUZRfdnOg8UQGGvEjuW944E6tjH9QEG8iSGRZkyyX3S9jrrkEbE7cz8mnHfp5L
	 6XlTRRyIkzO23UoewTsIrPuKdZtKVfzI8IF8m0o+xZQvG5SM/ukJAiDK7T1zXm6A1w
	 mLj1Ls7Rk6OH58ViqhuZBcqFwAFUWkVnB0ebQ5VNrtI4A2uzw/87vLoKVUNi2i2M7p
	 oyxL4wJIAVsWw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA3BE17E0183
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:52:16 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 0/5] client/btpclient: Security Level reporting
Date: Thu, 26 Nov 2026 09:52:06 +0100
Message-ID: <20261126085211.80204-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Set org.bluez.Device SecurityLevel and EncryptionType properties to
optional so application can access them only when they are meaningful.

Send BTP_EV_GAP_SEC_LEVEL_CHANGED event from SecurityLevel property
changes once the device's services are resolved, matching the BTP levels
expected by auto-pts.
This reduces connection time for the BAP tests.

v1->v2: Retitled patch 1 from "device: Provide Security Level related
  props when supported by kernel" (subject line was exceeding the
  mailing list's 80-character limit with the series prefix).
v2->v3: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): only read and
  report SecurityLevel when ServicesResolved becomes true, so a stale
  cached level isn't reported as a security-level-changed event when an
  encrypted peer disconnects.
v3->v4: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): fetch the
  device's Address/AddressType D-Bus properties instead of reading the
  btp_device struct fields directly, consistent with the other event
  builders in gap.c.
v4->v5: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): also check
  EncryptionType before reporting BT_SECURITY_MEDIUM as encrypted, and
  refresh the event on EncryptionType changes too. Replay the cached
  security level when GAP registers, or a device proxy is added, for a
  device that is already connected and resolved.
v5->v6:
 - New patch 4: reset SecurityLevel and EncryptionType to 0, with
    a PropertiesChanged notification, once the last bearer disconnects,
    so a later unsecured reconnect doesn't report a stale value.
 - New patch 5: track the last BTP security level reported per device
    and skip resending an unchanged value.
    Reset the cached value on disconnect and on each GAP (re-)registration
    so a reconnect or a new registration still gets a fresh replay.

Frédéric Danis (5):
  device: Provide Security Level props when kernel supports them
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
  device: Reset Security Level and Encryption Type on disconnect
  client/btpclient: Suppress duplicate BTP security-level events

 client/btpclient/btpclient.h |  1 +
 client/btpclient/gap.c       | 88 +++++++++++++++++++++++++++++++++++-
 doc/org.bluez.Device.rst     |  8 ++--
 src/adapter.c                |  4 ++
 src/adapter.h                |  1 +
 src/device.c                 | 31 ++++++++++++-
 src/shared/btp.h             | 11 +++++
 7 files changed, 137 insertions(+), 7 deletions(-)

-- 
2.43.0

