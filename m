Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77D7261C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148662; cv=pass; b=C4oqUZfegt0VByyJ8b2q34Aolk3YkrouVifBN9sYt3YPalzkzw6pKycTJ+P1CNF6CV9VCeRPIznpc9wsFS/EljRnTEk8blBN35R25WWDdpxmtaT2DxtKA4zhgJPAYp3GRTL4uaGBRsDDkUN08VD0nXu6cIC+ty7mRhh+psoPJ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148662; c=relaxed/simple;
	bh=T/ieIF5MReSxpuAcpepVkYHQzAVn26ke4O4gFTsilA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOZVxiwJqjS1p040lgfM2C5m97Frqnjw/jTbs7AXzu4orEa94Yd7pXMIEhD1J4tuphrTXNZxXvt7bWVMB186I409TXrouFnYBqs8XeMUWuNrjVjpLDYC8W4TzIEgSdBgMr1xD3SkWeFtu3n8Dlh7kxXJ3KegHXKwjuBZGJs6fqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=QmWt93Tm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="QmWt93Tm"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4f5DmC0J6JzyTm;
	Tue, 03 Feb 2026 21:57:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1770148651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JlzEdPZ9xWnchylwjJQ7AfvWRqiQo4RCdgb6ErPJ5Zc=;
	b=QmWt93Tm9AjsNQCGgPoZxrUDnk1GffBFfX8CzWkGHDULYIk01Wi1My9fIk9dEXYni7hUsd
	jNSnzu26JmH9zizkwfqfO4Lxe44HcHHbScLdr9Rtgmmrl/Inn3vZxcQvjCOUufv1b9NxjI
	IoNr7skfiu2sJfGqflWxztRSne5b9ww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1770148651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JlzEdPZ9xWnchylwjJQ7AfvWRqiQo4RCdgb6ErPJ5Zc=;
	b=DfBcyjkjl1X2Ml62s98mBycjSGunQUyKKrgkxMKVr+bjaJNuwYrTJI3HDPwPzHyQ20+4X7
	+YKjn1nwmQDtPxtKNTqKw4cqy4Q5Pl0U/CQZbFYnf8RmqtscjR04K+eM1zWh2d8N0eqDFB
	0bpSRXvx1utiSBDwfmccGa6XiqF3W6k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1770148651;
	b=ZMcWoUpHPYlnVOXFApNC2RAtq5MRNKI22PKgUknvxVRBrVjVWHWXO/SFs2axKoTMGcw6co
	X8Ich80f1fpHmw7P4c0hdUhKmIjU/ZlgQVetXPosaWKJXgK9DOdt1a6xjdb3lsBTI4+jw4
	r3lEqWv/+7Ohp6SylV5RE+TYkv9xrwY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
Date: Tue,  3 Feb 2026 21:57:21 +0200
Message-ID: <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some controller firmwares (eg for MT7925) continuously send invalid ISO
packet, which result to "ISO unknown handle" error spam in logs.  It's
not important to show all of them to the user.

Rate limit these ISO error messages, similarly as we do for SCO.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b069607b145b..eb32802f6296 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3917,8 +3917,8 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	err = iso_recv(hdev, handle, skb, flags);
 	if (err == -ENOENT)
-		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
-			   handle);
+		bt_dev_err_ratelimited(hdev, "ISO packet for unknown connection handle %d",
+				       handle);
 	else if (err)
 		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
 			   handle, err);
-- 
2.52.0

