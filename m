Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622426;
	b=B+OOpZOosUyczcKhRsVz2bhaIP2Cws4iq1GZMBWy0fA7c4+gmYB6ve9YwJu34+VQ4qDg
	 pN7z09IE3zhZ+GDKvolN2GEv6ZLQerLUfJkCqu4fr+VcK314Keme0fm4qsprqYanvOsA2
	 Frp0SyRrBl/MzIamsU33WBUlGl7FFnFWWBLC3wG7Is1uayiDv7R37sylqeFQvi+c8Xelr
	 dKT9GpYXLfmYXF2c4pZLYaHH2A7XMHffCJfKURb2iP41fbjxlSv25gsvtWC63hz50N8s7
	 sOqiosCblhQ/BJTHyuI+3B8qviMgySakvZco0vm/JAA+G6XXMnFDhMyTdm65Lb60N8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622426;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=wRViPCCWPkyWIWjTy+EA8YExn4JIBlEFrfijjRvKkqI=;
	b=4PXizGUNv+Y2ZUZYYuuK6CF1FdUubt8iHEC33XOD7GSDFMRTGvQiF8Cp+29l+w3G3GwX
	 9Pp+Z1mJ9vpwZFrNRh9Q6OD9580LZCnCiIcO64FvC9PuFfo4H2LELpoendfk6bjyFzQSh
	 56dbSolOQcaB6/gHSiUrojvztNdtNLDe+rz3tWz4Jj7zYbNy7tMNjxWUcpcxTRyGpRkA/
	 sFmTj47yIhqLAYP/8RNSag3HRop4Ao3pz3yIqrOttXASFiYMqAV7GDWFG3rAimkLroHFM
	 ctJC4AaP0xbNRb+NzaJJRAoNcUM3J9RVK2n2iNpDqCNRZpqMp7yiQT4mcUpJqpsvbhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gMprAT+6;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FD606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976FD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gMprAT+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795622423;
	bh=bRHDzr80qEiqeVTmmJ/+WYeyZuBUlS1HG0AGnjG+ngo=;
	h=From:To:Subject:Date:From;
	b=gMprAT+6AuNpF3ieyAs4IgMXIkQczj5QCt8BuRtprgdNiPEEvXqOf61nNwzsKKSbs
	 7HKh0eBk/P/2x+LI3JElHY4ym2/98oIpaS9uyF1jC9PAGNgoaOQPdG25+2g+IF3R4k
	 cHI5dTpPIGAfuYwyOkArvbpmEAZ/Sg3h/5TFpD24xwM3uRxtzeupIV/1o9vb+S1ldO
	 GHICAy7FuQpyAQ7CqfrxjNGpkux6ES3b75ZXOYZOKvpk1AscfdO4y6N7MqHA1Si4O1
	 OOa1I9yBalV7JhGbffVZazbFMHTPesWN2Av40BD22af+PtS3C02kLt6KmLh8Yy64F1
	 iJys1PIAcFeXg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 92D4617E08C6
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:00:23 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/3] client/btpclient: Security Level reporting
Date: Wed, 25 Nov 2026 17:00:15 +0100
Message-ID: <20261125160018.590013-1-frederic.danis@collabora.com>
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

Frédéric Danis (3):
  device: Provide Security Level props when kernel supports them
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

 client/btpclient/gap.c   | 75 +++++++++++++++++++++++++++++++++++++++-
 doc/org.bluez.Device.rst |  8 ++---
 src/adapter.c            |  4 +++
 src/adapter.h            |  1 +
 src/device.c             | 13 +++++--
 src/shared/btp.h         | 11 ++++++
 6 files changed, 105 insertions(+), 7 deletions(-)

-- 
2.43.0

