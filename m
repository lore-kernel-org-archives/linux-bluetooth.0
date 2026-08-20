Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183554189C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223167; cv=none; b=tSezKK4JwfqawlCcYVKMmxX75phxQbL7Z8YRhtxX5rvMDY7Avep4QU+cSjWDzm2uucIWxKY/xy7Bhv5F9jwxf9VfZSRRb6uTvmG+QMJb34BKI5f8iB1CT3JVdd8O9kOf6rSmb4jl/Y+LRoK4GCjQRuGnMIfDNczNDiNgiXuN99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223167; c=relaxed/simple;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPqIJAia3bhKF2mdDbRn6Wtd0GkFZiwh0Avj+gzeJtKAgLiCUZf/EFyz9+2MYE/usjNb238JppyIPHWA56SN0vGALRzF8DZJ/f+kQNhNbOOVXQf5jDNvqAEveNYbnzPj33qk5eMFDxkCnT6t2iwYsHLlhj5CTTqkyVlt5sgfWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b2+pwPlk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b2+pwPlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223162;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b2+pwPlkJzLwDtiVYjxC6cn5YhPRI0uKwQgDD18xK1IijE3NPKOAJ9zZzjcYJnINc
	 2CRLZxqqmMC88srMxwLgYdZm/vo1ziZuu/+ZOpyiFQIr51QRey2eGMIoLembYCHp2s
	 wc9uuZgf7XCoeITsPoAvoJ4kgMBIAyCtme8KX2RrEU4B795Tt9Ecgm986AOuZ/0yqx
	 Cq94/eAF36QD4dgJinnXHj5FfD3ynEIjejizEGUSSjo/ooVEDfenR706N8u1xhvqkd
	 YN+svMTr3lWeqAbjvCqJnhAXfr+9J2D/14utvJ49eW+Svm53J/R42jFaRT814dRMIL
	 xRNM691yeTjpA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5EA8817E11F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] client: Display SecurityLevel in device info
Date: Thu, 20 Aug 2026 12:52:34 +0200
Message-ID: <20260820105235.1190318-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820105235.1190318-1-frederic.danis@collabora.com>
References: <20260820105235.1190318-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 069e20485..0531c9de1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1918,6 +1918,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
+	print_property(proxy, "SecurityLevel");
+	print_property(proxy, "EncryptionType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.43.0

