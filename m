Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDA2264CA
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013816; cv=pass; b=pAprHLUn65xTNc0GF76T4ZcCGoANAW0UbWSVfTWc9Lm7tAaAT2yLV/Zd3QjAzaasXTP5a9evZgd7ng/UR38aYJoRPmtyiiu6Ml1OxTamn/GLCBiJZNTZyQQLEm/PSdL8+hPmc42ZsNlVKJ+2b6E8PwWJAtJ9tvyR/lLjRo/bW/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013816; c=relaxed/simple;
	bh=UjcTRURDNiOJnXfeE+oDXnmiyoWqQl68AvT3nesTijM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T22leLlFvxPKBG7KNPETD7A3S+hI5u2b+wes958USU8THpln2Pp0PFpRbwfjLgfYo6E0eSKFOv2kXBpaOyA0FrEMb3TSjKLosJ5gLTEqGsgwFIIzCFnpV0n7Gfun8IY0Zd7BJ16rgnL0vdv3q6eAG/RnK+tl+hMl+KaS7ETsoxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ymj9R4bR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ymj9R4bR"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gJHJ40JD3zyQn;
	Sun, 17 May 2026 13:30:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1779013812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YrqkQakRqnUSimowr5dBV5/dpDN6WSZMdmsBWlczq0=;
	b=Ymj9R4bR/MJeIILmjK6DFI/LhB3fqcwamF6G6VhGNJuFrtwHzZX78MCDkm/fUh6rJhA578
	iJA876OsEsCcT7hZSUx0sPl9PXeOupTqB/HEsKcegZg6RYWUZjlNghg+yXriPJSlkj/t0p
	s1Q8TfIRlh3NJFyoGjPMes/6CaV+Gwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1779013812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YrqkQakRqnUSimowr5dBV5/dpDN6WSZMdmsBWlczq0=;
	b=TQ+11eQKjmzBRAI9lYafFpSLYRWrArJ0XBFmxT6dZeF5oRirG/cz7QKuMRz73e9IIbE2Wg
	MRp+5aQRq3d0hdqSW25NUg5uNhg+Q9o1ptXQC2h4Z3cxLUxIzJbiadu2ZKEVToxCjyEoqR
	WzxGUG9Leb0KYyp6+XGIdi7UdoRxOn8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1779013812;
	b=aoJKetgmxUTXem7IEEi8jKvf/HgOxCl86Vuf+wJOv2MLydlCWVHCXwC6V71Eh0pRDSdjMD
	nzfZri1R7qQifcYmfrN+WyELK0jgx22QOd9U9BsjkO7FQt1pfU/t/czXD+vteJCLgMsUwQ
	rusEtina58OvZnPN12n5fGZACYE+cGI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/rap: fix use of uninitialized value
Date: Sun, 17 May 2026 13:30:08 +0300
Message-ID: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix error handling in send_ras_segment_data
---
 src/shared/rap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index b554726b0..145da2060 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -1096,7 +1096,6 @@ static void send_ras_segment_data(struct bt_rap *rap,
 	uint16_t value_max;
 	const uint16_t header_len = ras_segment_header_size;
 	uint16_t raw_payload_size;
-	bool ok;
 
 	if (!rap || !proc)
 		return;
@@ -1128,6 +1127,7 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		uint16_t seg_len;
 		uint8_t *seg;
 		uint16_t wr = 0;
+		bool ok = true;
 
 		if (index > total_len)
 			index = total_len;
@@ -1180,7 +1180,7 @@ static void send_ras_segment_data(struct bt_rap *rap,
 						wr, bt_rap_get_att(rap));
 
 		/* Try sending to on-demand characteristic */
-		if (ras->ondemand_chrc)
+		if (ras->ondemand_chrc && ok)
 			ok = gatt_db_attribute_notify(ras->ondemand_chrc, seg,
 						wr, bt_rap_get_att(rap));
 
-- 
2.54.0

