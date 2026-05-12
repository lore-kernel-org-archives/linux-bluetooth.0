Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD4963CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575080; cv=none; b=WDAIIbSqbmKQDukq6Qw7vGXses97s2LqxjhBgkYLEXlm3fH1/Pp6vkpS+2HrSi2Iiqjp1jz2TcFOybkUS6UILuTn/Ih3QmjEcEmfQFte1MtwOIS/EIBaLz2FQDsvVaeIXFyg7/cWrlDMpF39Vaa5RREc8+x0sDeVEpmrmD7o4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575080; c=relaxed/simple;
	bh=sy4ht4L0rTUf6RWlAI5TkElE3qVVD0wDz2hHv+qg+s0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAgAJRIcGbMJdxFPnsE5u0g/+C2jemmYCPf1DZd5ol+YewO1KloYSwEIEE+ygvRemV1bgTovmM5VwmTzmZZdSU56+30rX0r4UcwRuV/opXZVGKBLyPgscFKDLyriE6Ynjew+zN+vkczvnvgud3bL6XJYEALUF14INAXAq4HZBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T+v7okhG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T+v7okhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778575076;
	bh=sy4ht4L0rTUf6RWlAI5TkElE3qVVD0wDz2hHv+qg+s0=;
	h=From:To:Subject:Date:From;
	b=T+v7okhGXKEBc/c+I4mFCmsQ2msVaOYBIYBMmq3zTiwxZHaIVHy2SRLKIaXyHGOTZ
	 +nSY8Iy6uoxonPNxRURroQc1RF43bD2msJ6LXX32kIpZuh2z686TTQxaQ6GTnm7KN/
	 C6XoM3pMEmB2T8/8z//opQVmoPYErf9zZLvUzEDyEMGqt2PgoRpAYIOTOIXO3z3nuI
	 CXL8o87K5iJNa3ZdBxcHreZUhopfed0gQMT6w7vdgnb/POv8S2tYemk5hL5u/BgSOR
	 eVBFKIHVCa3UGUeWCfASHFSyf4Ojte8edeAAjlrMwZoMqEc9eDiN79kV2+qL7Ku2zk
	 1r0C55rExPnBA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C47BB17E12BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 10:37:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] pbap: Fix not checking Database Identifier length
Date: Tue, 12 May 2026 10:37:50 +0200
Message-ID: <20260512083750.178053-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Database Identifier is supposed to be 16 bytes values.

A paired Bluetooth device acting as a PBAP server can overflow the
heap in obexd by up to 239 bytes into adjacent allocations by returning
a DATABASEID_TAG application parameter with an oversized length.
With both length and content fully attacker-controlled, this enables
standard glibc heap exploitation primitives (tcache/fastbin poisoning)
leading to remote code execution in the obexd process.
---
 obexd/client/pbap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 0f575e61e..ce5e6cd5d 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -330,7 +330,8 @@ static void read_databaseid(struct pbap_data *pbap, GObexApparam *apparam)
 		data = value;
 	}
 
-	if (memcmp(data, pbap->databaseid, len)) {
+	if (len == sizeof(pbap->databaseid) &&
+			memcmp(data, pbap->databaseid, len)) {
 		memcpy(pbap->databaseid, data, len);
 		g_dbus_emit_property_changed(conn,
 					obc_session_get_path(pbap->session),
-- 
2.43.0

