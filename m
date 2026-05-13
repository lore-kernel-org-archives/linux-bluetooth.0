Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427D4C9570
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689068; cv=pass; b=pKiuUUIDrqNNIzYaUW+DkwfcsbFxN+6XC2VqzRzOD11OC4I/YMF3Q675D/IaXxLswcyKU4K3CL19dFDS3hh/oCemAnn8ZhAJNz9uFhwOXJnMbs3nagRUWZpYmuTbj75h2vL+44hjuUZBnA8+ktMEKcmE6kWe/De/1eyNFAfdfck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689068; c=relaxed/simple;
	bh=yQipiOOmtEn7Wv9EwnFo3GH9BXr4/NzVXJEDBehxOls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tl5x/Fk2IAXG9lJQScdrPrc9V1LQ/iQyQ25r6B1qHFgUNgOAGQta4HzP1bbQQMy9FVC1/OonifAIYGeA2L3KK1aVxu25cKHPsCsoIVnr41wxYXKne4n3VNu1fe06K9cUV2HPU26oABhE+w5/JUhDg1h5pyGsE/oLxw+rI1YXXMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=O5R9NnOG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="O5R9NnOG"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBn3SH7zyVG;
	Wed, 13 May 2026 19:17:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beAA3SjkSdsXdrFTZGeeDSSQFAisBZeq4BPYMYsnXAk=;
	b=O5R9NnOGcL1chEbr34clX0tGPg/b8kOtHufHprOy8CNKIUKfIo8WHhUxlXdVLokJfAuVqX
	RTUVrgcGHe+ymvmECAHSXABZz79UqK9Cy8Y7Fqkq/RqUoRtPIpD3hQ39CDG6pss6kMQdbd
	+4ewmDtgfN4A8IcD9jFAvl0kfVvdqRo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689057;
	b=HMrSpTfldZX9vF8/PO0gmQUy1Zo5TJcktSdpALcPJ1b8z8SPCQqm4HTXPwK8fn/m4jUyPW
	4AqqWZU/bsE5u1+NUzj0jFtRkmoR8//zg8CDH7z6YssRYa5M2sP8mu3jypQFYnMrO8TP4f
	vnli7Vp/sybaquFEkwJUbcf8EEnKZcg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beAA3SjkSdsXdrFTZGeeDSSQFAisBZeq4BPYMYsnXAk=;
	b=sBfI04Fj6TQKN77vSx9n4GNwAn5SjJ9b9gw2wyZakzDGX+smlEWVwIAbdT+sKHOTWuEfOv
	FZkYUu/k24Ukke8D+8cnfOI4zeBMrm81vELO9spBTJTfdW+AHBIxYanV7CKO+qSedTZti0
	ga5watdNuc+I+4jj2dkSf4kDt4FhUVU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 01/16] emulator: btvirt: check pkt lengths, don't get stuck on malformed
Date: Wed, 13 May 2026 19:17:18 +0300
Message-ID: <685f40f012bc71f7313e2dc19a21d6597d29cf91.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.
---
 emulator/server.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/emulator/server.c b/emulator/server.c
index fa2bc07be..f14e14cd2 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -136,12 +136,20 @@ again:
 				client->pkt_len = 0;
 				break;
 			case HCI_ACLDATA_PKT:
+				if (count < HCI_ACL_HDR_SIZE + 1) {
+					client->pkt_offset += len;
+					return;
+				}
 				acl_hdr = (hci_acl_hdr*)(ptr + 1);
 				client->pkt_expect = HCI_ACL_HDR_SIZE + acl_hdr->dlen + 1;
 				client->pkt_data = malloc(client->pkt_expect);
 				client->pkt_len = 0;
 				break;
 			case HCI_ISODATA_PKT:
+				if (count < HCI_ISO_HDR_SIZE + 1) {
+					client->pkt_offset += len;
+					return;
+				}
 				iso_hdr = (hci_iso_hdr *)(ptr + 1);
 				client->pkt_expect = HCI_ISO_HDR_SIZE +
 							iso_hdr->dlen + 1;
@@ -151,6 +159,7 @@ again:
 			default:
 				printf("packet error, unknown type: %d\n",
 					client->pkt_type);
+				client->pkt_offset = 0;
 				return;
 			}
 
-- 
2.54.0

