Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722952EEE8A
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432833; cv=pass; b=BqCM9JSfta/BVdA0n0nlWWefMd6WS7VKPiMxZ+EnP5QjFhQ4N0UffG6tkfb7w5faXqYspwE4yIq0aFDTf95k5pCY3VToJlB1d7tQVCR1XwnXSr1CzMOP2A8daTuR82n64b3oDdCghvklhVOT8W/wwB66EmMc6/1oM0A7Vp/gmt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432833; c=relaxed/simple;
	bh=WGGgF4v5uVU/wQhsgs/SzOcMhpYXobOw/Y4WZNZcnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VojkDSDWH6Z+ZaXJmtJTPF/kO+Hafj3dDdQObUcSwfaid3SrQ3M3mW554BfQJbPyJJTRU0bduHg05/qS1E11uFX+meYYtRQuhP+Bu9XPCn+StONOUII2ES9ozB+G7RN9xAEPunhW74+r1BNvQu4hi91PiQYN+oGLlvym2SXCSA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qrVJZwUi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qrVJZwUi"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvd36t1zyRl;
	Sun, 14 Jun 2026 13:27:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NcGZy37L1HwJSEsdCrXwlExE7hXuSDTdqni5Y4xmG6U=;
	b=qrVJZwUiVhbLWIcnMtl/2rTxaLJDFWL/chVmhj0R9f5XnaYEe9mWlr4zgCQcdg4Ggv2heh
	PQe9+vRAXTTHA860xV5gDbhp//cU7IJ3lmz3FdI4zfRmwvn46Ha6FkgKUF0byaaYzhO0+r
	4jnQBwKZcZPwc+FO4Mr+ERAgKPif1HU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432829;
	b=Ox52vW0DSN5GUa3CCVhvyNPUNM6D8NSiiF6LvP/geDFWbS2FAo5uVazGgRxQ+cef/hjfjH
	uWLfQSLgSt6PzbSm1rBQwamjn3BMu+vS7EYWbXF7KjJlRChEXT6Lkn0NJ1vT0S6JA9rSQr
	2LuZQ+PosqdkY1cQVWgXIFz2l2+gMUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NcGZy37L1HwJSEsdCrXwlExE7hXuSDTdqni5Y4xmG6U=;
	b=rfqorzLd9OOLazTkvPhwza6YnhiNmTOwL5MaiftIvcbti60ZPsaxKI5o5mIAmx29uDH4th
	eshO54psZ9fXd433SUERbbuntWo0yf3WozajdPNViiNB8cZiMjHxM+GFEfqkkAkA1iASYh
	hbsmINsh+Zk9M2iQIq8e0dYAkNok0og=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 0/5] Bluetooth: enable context analysis
Date: Sun, 14 Jun 2026 13:27:01 +0300
Message-ID: <cover.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Add annotations to RFCOMM
- Enable analysis also for BNEP, RFCOMM, HIDP

***

Set up compiler context analysis that generate compiler warnings on
problems that Clang -Wthread-safety can detect:

https://docs.kernel.org/dev-tools/context-analysis.html

Sparse locking analysis support was removed in commit
5b63d0ae94ccfd64dcbdb693d88eb3650eb3c64c, this is its successor.

Clang 22 is required, and likely in future Clang 23 [1] (unreleased, use
snapshot eg from
https://mirrors.edge.kernel.org/pub/tools/llvm/files/prerelease/ )

This series enables the analysis and adds minimal annotations to remove
all warnings.

In future, it probably is a good idea to make more use of it and add
__must_hold, __guarded_by etc annotations.

Kernel test robot appears to be checking for these, but not sure in what
trees [2]

BlueZ testbot doesn't check these currently but it's possible to add
https://github.com/bluez/action-ci/pull/4

[1] https://lore.kernel.org/all/177996424926.1039918.344230591161201072.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/all/202605060005.JYWpZXr2-lkp@intel.com/

Pauli Virtanen (5):
  Bluetooth: af_bluetooth: Add minimal context analysis annotations
  Bluetooth: hci_core: Add minimal context analysis annotations
  Bluetooth: L2CAP: Add minimal context analysis annotations
  Bluetooth: RFCOMM: Add minimal context analysis annotations
  Bluetooth: enable context analysis

 drivers/bluetooth/Makefile    | 2 ++
 net/bluetooth/Makefile        | 2 ++
 net/bluetooth/af_bluetooth.c  | 7 +++++--
 net/bluetooth/bnep/Makefile   | 2 ++
 net/bluetooth/hci_core.c      | 3 +++
 net/bluetooth/hidp/Makefile   | 2 ++
 net/bluetooth/l2cap_sock.c    | 1 +
 net/bluetooth/rfcomm/Makefile | 2 ++
 net/bluetooth/rfcomm/sock.c   | 1 +
 9 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.54.0

