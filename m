Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1D84FAD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923795; cv=none; b=qNSS+7rwyAeJJR8y2PguEspl8o7rqBnLaxB+eOEVJ/pSGCief/tQUHHI6ZsUfDPxTX8PmoMu3oGJ0Kq4u30rOuqOrsZSTzknJLHpk9jk/gm/sieQkMssgC1rZ+04uh9PX2P0ETUTFg2zAtoyF0wiz7h1fU6eeM6EbAHylfOV0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923795; c=relaxed/simple;
	bh=G4p0/fuWFdXjr4ZCJaGQzjrNhR/DhfMj3W0rbpX8cmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDwgGW6l/+Ml1dUnRtQqxyFaln6huJTjToN11fGqY+0JDiaUZp34kyBsMaPWkMkd6x/YuBfMLn3x8XOkDNFwCXHteTjY4Qcy849DWDuyhtWZDeb+IGqRu60uFjgdCb/GnjwNlg3EygilNn3CCwU0Trx7FHV+MJtMuxU+nuvu09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d7fToIOz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d7fToIOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742923791;
	bh=G4p0/fuWFdXjr4ZCJaGQzjrNhR/DhfMj3W0rbpX8cmo=;
	h=From:To:Cc:Subject:Date:From;
	b=d7fToIOz9Ntcrr5OQrNHHOMp/w1ujbaj8wX/gTWZBZLLpoMykTM/rJ2yLi4mgW9qG
	 qC+NMep9k7XrqZj4d0TwX/Xs/4cMlzt2fTG+gnfwKKWVKgmA1VSOvgrSvbIJ2UUDvQ
	 dYnrZ9ccAgq5MtJFufjcR1ieML8sPgfadTV27pLRw8vX6bAlYO/w68o/KQNZd+0+i3
	 1+Sc4VTQuBrlBN7uO2VUlE/K3gVSAPwfrIzoe7fkhjGX5CpzVbQ84mE01EaX2GfFMj
	 H5hMqtLQGpwrnAg+G3AZZnF6rMqR+Ej7e4Fr10rrydwL+2zxdZvv0/qKaEgLPOVz1c
	 rz4nyfb0vk2YQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C90C017E0599;
	Tue, 25 Mar 2025 18:29:50 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 0/3] Fix wake_allowed reported error and not being set after pairing
Date: Tue, 25 Mar 2025 18:28:43 +0100
Message-ID: <20250325172846.139431-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a new HID or HOG device is in range, Bluez reports the following error:
```
src/device.c:set_wake_allowed_complete() Set device flags return status:
Invalid Parameters
```

Also, a side effect of that issue, when pairing a HID or HOG device, the
wake_allowed property doesn't get enabled by default, as expected.
It requires a Bluez restart in order to get that property correctly set.

This patch series addresses those issues.

Ludovico de Nittis (3):
  adapter: Preserve pending flags when setting the Device Privacy Mode
  device: Preserve pending flags when setting the wake allowed
  device: Try to set the wake_allowed property only for bonded devices

 src/adapter.c |  5 ++++-
 src/device.c  | 19 +++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.49.0

