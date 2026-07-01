Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1D244692;
	Wed,  1 Jul 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920819; cv=pass; b=WYTbTUcGGChIKwDXMDyn+APoUGI6XqVZcPNUM2/3GDgFrwCthpXse7zT0WhrbEBTDVIASBvcUM4O9j130lJ3DOxnJXWXnkNnbgO3B5x7Et/05g3UtikgcNxh/e9E1V6Y+TNGU4C7mjxmS51u+Q/mLSbHPY3IS8EMN7+YlvepMbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920819; c=relaxed/simple;
	bh=WjvG8PsRYbDOu5SaZmGMCwznJL4bt9UxECSB6ppFLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXZQWaE7fl23yRpC3H9DiY7XsMVo+z5Hxf9IYlah1FsFq9qn15wTakpAuI5XyMHf2aaI9Yyh0IVSztvas5JY6FW2tZCHsw5akn/RPf0GUDJJCwhEBCuOJ8K7aglSJwF5mktb2FyTwDKuNOrIv3NiXsMomi9yg5sSIA8y5bFhhZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gnyTGC8G; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gnyTGC8G"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gr4Bd0lhGzyf2;
	Wed, 01 Jul 2026 18:46:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782920809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obJAgbKCExRSYXtL9XNsghMfX0L9lmc746F2oIEBeuM=;
	b=gnyTGC8G06rtC32oVnT2rfFCATgQho35bDU14RaJu1iMeh7/6BU1BpzqB/UcFd0YMZjMxA
	myvqpnWewKAxXUGY/6pWd3Pcoc03xaHv4n88+rJOo+ZVFjKX+lGpWVnp0E3eyMTvyhh0RZ
	bQ3ijmVblBs85RO5YtgmlDhgWUxowRw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782920809;
	b=HpO9suF0FxCwZH1TUq5OxMc7hccGqsXuaYHiCJnu/7lv3h/R6nmUkFRyC0PJv9x7lZkkqR
	8us54Yy1fviUBVQJC95fQl5nfZV7leqNv2000bDuW+sttIZyCyOwEnWmvDm2cBYTrZuAeL
	Uf36U7Ogjz6H09iRftAr2X9HrElbD5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782920809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obJAgbKCExRSYXtL9XNsghMfX0L9lmc746F2oIEBeuM=;
	b=qm0E3i3yC017ISZwNGz/P033VZF7clJwm2VF97lmEpGhk6wy5CBA2s/qwcjtZ720Kg/Kqo
	l73Kj0LRFeOs5B6TCTdKIetMJ8WGUn7zM0MA29xIiKK+wvfbmJfg12NP4BsZlAy8nzkdQw
	6IAeEgxOgoQz1LoqB5T68dgJNGYi6Zc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	devnexen@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length
Date: Wed,  1 Jul 2026 18:46:39 +0300
Message-ID: <f3372d2d8a03a1d408a75c6036a1f4a8372e57a4.1782920668.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
References: <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

slen contains ISO_SDU_Length (12 bits), RFU (2 bits),
Packet_Status_Flags (2 bits).

Exclude the RFU bits from hci_iso_data_len. Also add masks to the pack
macro.

Fixes: 4de0fc599eb9 ("Bluetooth: Add definitions for CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 38186a245f14..50f0eef71fb1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -3413,8 +3413,9 @@ static inline struct hci_iso_hdr *hci_iso_hdr(const struct sk_buff *skb)
 #define hci_iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
 
 /* ISO data length and flags pack/unpack */
-#define hci_iso_data_len_pack(h, f)	((__u16) ((h) | ((f) << 14)))
-#define hci_iso_data_len(h)		((h) & 0x3fff)
+#define hci_iso_data_len_pack(h, f)	((__u16) (((h) & 0x0fff) | \
+						  (((f) & 0x3) << 14)))
+#define hci_iso_data_len(h)		((h) & 0x0fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
 /* codec transport types */
-- 
2.54.0

