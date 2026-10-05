Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720F4D6C46
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224050; cv=pass; b=LHdY35gk87nIxJEvR1L2M2xWBPjXRfBT6stOXmqqHDkeD0RfTcgkh9lUUg8xBEJKcgGl1PMEeiqU7RGwqvQtM14NpVfyy1t9N7pG0xuxykw0372XPEE9D+pr51sIAZrGDbTlnrBw6GyDMqjrBZgPfVyx8txiO8PNRn6e56Q4waQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224050; c=relaxed/simple;
	bh=mzbT1wspTm878mfZHURvZ5hkJ2SY5dO1iCB3i1cfgis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFBOWgYXcpKwcJP1NCup7WdExq3COiJWrgrsS89qXw3yj4LEC3EcVl9LieY2f+s0lCpxlHdj/Smt0fkKp06KoWBv/fj53gFofZ4VGzMv7RYFpPl4Rl2wQwJtNKD0onThtXNKvkgfOgV8GhtTo6oZvFBziCLiCacQnh3h8E3ou1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qBZ+9/3/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qBZ+9/3/"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hz6w96jz8zyy0;
	Mon, 05 Oct 2026 21:14:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791224042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AO/tooLFaOi/sG885UanNaqCzPeGNtZntf7rm+GCmUc=;
	b=qBZ+9/3/nj0E9F70q2P0tVWsBnHk9uOGdzXLjYlNJDkNql7QSMwLO/1skv54KexTsZHw1a
	pTjxpPY2UfjWbZR1xQVkPO3XQBN77Na+D1XwSAcbhs9Nz2KddFacNrdEsU5JV7Zpoupu4j
	KRrpzRUXuC4Fr4x4R5EZkQeVaABJQ7I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791224042;
	b=T4WQf16ciI524m96BOqNvqdEr0FrIRScww5RPp8MsEE/4w4O/63DkoK63XQzYxQ7iqaHxm
	K3bmi+O/2horsXi4jNDgvcccJj4QC5nhzylGJngCRyacKRul13py4AujJsH1ZsFVyzpXKg
	XirMqhAZMgQWK9spNq8Y2LLoPgsMOP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791224042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AO/tooLFaOi/sG885UanNaqCzPeGNtZntf7rm+GCmUc=;
	b=qyVjiGuo83mpaMW3fw7YhBHsQaX6/7FivHLoUFj1a4OtkjFhUWYSWkDvvkS7mpq0XBuvOz
	LBFyFSkJ59Se+HDiUCKkDk5coaEnF9INKjW8YEiE2kX2i9aWxyLqGZn3SnX5wh4WXg7/Sr
	FxbsBgl1bgDOJKmbfi3V6G2UYXY0hmk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/2] Bluetooth: hci_sync: fix mesh adv timeout units
Date: Mon,  5 Oct 2026 21:13:53 +0300
Message-ID: <cover.1791223958.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For mesh advertisements = adv_info::mesh nonzero, the time units are
milliseconds instead of seconds like normally.

This was forgotten in hci_schedule_adv_instance_sync() and
hci_enable_ext_advertising_sync() which scheduled 1000x too large
timeouts.

Fix that. This is the cause for the mesh-tester "Mesh - Send cancel"
failures.

Since the timeout units depend on the adv type, make
hdev->adv_instance_timeout to just bool indicating if timeout is active
or not.

Triaged via LLM. I wrote the patches.

Assisted-by: opencode:qwen3.8-flash-next

Pauli Virtanen (2):
  Bluetooth: hci_sync: fix mesh adv timeout units
  Bluetooth: make hdev->adv_instance_timeout a boolean

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         |  6 +++---
 net/bluetooth/hci_sync.c         | 14 ++++++++------
 net/bluetooth/mgmt.c             |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.55.0

