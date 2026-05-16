Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE53D411A
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930104; cv=pass; b=iEF+0rFL99MSoqQoo3xOcEOuKC9EH8/035+fv3exn7SFKz4hXCbB4mN2o4bfWGzeZM2RZVwrw+dGUjO9+NWyqo80H3RUWB1QlQ+YemND8EAiQYbUmtslqi3tgLqUfYLNZ18XaVRWzcMJ884RICVzWIVxataSrJVOlgvH+24bBxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930104; c=relaxed/simple;
	bh=Ku19p1MdrG5UrWuRAdDYiGWv4nowoiyp6vfoenLIIL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImWMPDD6hkRCgqDoW16yqvSrzBF5g+8i9brQRfhiYfhH7Uvq3jCn8AwW4KFAtpVFb45UDUlknq2C44FxckucsySmivNICsh0RXowxjQka2JiLgn3H8NVFiFj2a70m50TK+ZkerTqpXqnJYU5d5j6tfCCyvu/DV79k4d16bwsl84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dKMyu2Fi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dKMyu2Fi"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL46rTWzyPp;
	Sat, 16 May 2026 14:14:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Jcw0M61MrzS15TAjMp38mYWKVVvmolWvIFw3uM5ceE=;
	b=dKMyu2Fil8Xss2euiQHfeJ5mo3Sno849Bi3Q7T9s5lWPaQwwdOPOGC2WggEWl4TkUhGhE2
	03RMccTe4zr9jadPKsu/sfSoB3zHkWgR+o1n6ve3cHuDfqdcl3zl4XUTo8qjwnTWNG6avz
	R4UMBb0rqQeHB/GQheWM31J4e0GuhLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Jcw0M61MrzS15TAjMp38mYWKVVvmolWvIFw3uM5ceE=;
	b=UmE3oRzCgrBljx5CPiONDZlpKhYcEHF9fbEYhcFxkwlVIBjmK1GBYAjFpMDuPvZBTdeRc2
	xmWDFwbI5qwSNoEqIt1Ih0TNt17x+r0Oqd9HfguIUMcZqMrkLg1adpuAKecb/125GZY3Om
	5rq5v3j4OV1Rt/AS7Z8QOd0K5hnKH/M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930093;
	b=ZH/HSnn5A/poIhhQXUaRaMf8S/ULF3AJxZM871YGwPONduKC2X4XicdbJ6Zw0A13GDznd0
	1mf7Zqj34FLQIegyiCHYyR8U8xPVpB7Kghg5wmmfvnZwHoOG/1oPIeNdWmO+uTlY+SATui
	t6KK5gLrtqhQduvUP+bI3f8xlN16Qdk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 0/5] Bluetooth: enable context analysis
Date: Sat, 16 May 2026 14:14:32 +0300
Message-ID: <cover.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up compiler context analysis that generate compiler warnings on
problems that Clang -Wthread-safety can detect:

https://docs.kernel.org/dev-tools/context-analysis.html

Clang 22, and probably Clang 23 [1] will be required.  Sparse locking
analysis support was removed in commit
5b63d0ae94ccfd64dcbdb693d88eb3650eb3c64c, this is its successor.

This series enables the analysis and adds minimal annotations to silence
some false positives.

Also, one patch to fix what looks like a legitimate locking issue in
iso.c.

In future, it probably is a good idea to make more use of it and add
__must_hold, __guarded_by etc annotations.

Kernel test robot appears to be checking for these, but not sure in what
trees [2]

BlueZ testbot doesn't check these currently but it's possible to add
https://github.com/bluez/action-ci/pull/4

[1] https://lore.kernel.org/all/CANpmjNN4O=W70sAc5gaVkTAFdrGGOW+XBMyuehfz3_QMiT=uCw@mail.gmail.com/
[2] https://lore.kernel.org/all/202605060005.JYWpZXr2-lkp@intel.com/

Pauli Virtanen (5):
  Bluetooth: af_bluetooth: Add minimal context analysis annotations
  Bluetooth: hci_core: Add minimal context analysis annotations
  Bluetooth: ISO: lock same hdev as what is released
  Bluetooth: L2CAP: Add minimal context analysis annotations
  Bluetooth: enable context analysis

 drivers/bluetooth/Makefile   |  2 ++
 net/bluetooth/Makefile       |  2 ++
 net/bluetooth/af_bluetooth.c |  7 +++++--
 net/bluetooth/hci_core.c     |  3 +++
 net/bluetooth/iso.c          | 14 ++++++++------
 net/bluetooth/l2cap_sock.c   |  1 +
 6 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.54.0

