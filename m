Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154536896D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041082; cv=pass; b=ILtCS6UltMDg1kdj2dtvimCr87lhRIQtM6yKAhaW6WAO5gp312CpsSR5ohfOahVaDK3przbs0p7R7QieCjwY/ItCzb78D9rAPOd95EmRWSSI/dlKII4vnnsSM1amqTEh438ylTxClHjqCk7s4Woz2qzz8ku4i+ipxRVWGZg0VLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041082; c=relaxed/simple;
	bh=19XJKeZfYj3+QoTHJaVwkXUPh+R0Bq1s2EKkwvvQ880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btzu5Qt+xUrZYWxog9tn7+kQbcNekBwjM/1YEYbQydXjo3Zb9B82cGO1cxUDqM6GJtV5ojxqIwhAEW1Xc1RYT9g6v77kkHAtgoFEhXAtQ/f+ohkyjWLSwtJ+g5/6WxEBK1paIFRCkxK/cm1rBbR5XwDfIMKA4IZqWm02+AKLggE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jeoOHDaA; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zR7FnPf7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jeoOHDaA";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zR7FnPf7"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fcwGY5yQtz49Q5T
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 23:11:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774041077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=jeoOHDaAOjIpI1dK2Zdjsf6h3GwjzsTjSebxhiOrm3kju9js2JfOVFeJNvs4QbRpNfO6sm
	HwyfXkJr0lA1TWiEv5TmtNNZJV6kZDy9uoZ2SBMAQkIxfacrlV2pzfPywFHQUQFhRkwbPy
	41d9qR74P5DfU5SCJwaWbCs9Mt9C6swXcaLKW4xCXyUJNuo0l9NT8n9Eyy9fIWx26H+Ur5
	ZsF+3samFdEOX8JyMgeEy0p3aCklj0xWn0ziI8v0lB4tUsoyUEVSeeHzbuBGe16DcbhwNz
	cyON0v2Cju9F9ltAn7l5QUjWmGO+pFiBBJ0YDId2iXdIpQQWunCjZZVg6isqhg==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGP0tkBzyd7;
	Fri, 20 Mar 2026 23:11:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=zR7FnPf7b2H9voNyPYHKNs/dbkSlPNowLsHUtJwXCMhFHc7zrXBMxYlyA8Av1eqGO3tmtL
	HqoyYQce/RpJG5JsE5pgW3n3ugpb7Ov1ECIi2vXuVBfA9FZjzf8DGcUoexZ/YnwwBaNqQJ
	EO2XS/73UyzGiwt/8aL8zTwyKkRwKGw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041069;
	b=Il0np0EIWv+LU34BWSZqmAOlJJ2/IYmt/s+K+bJHF8pfQrq20jA2GTOUtnwnK4stSsgL8w
	FdO2Bcx6TLGWQhNtjbc89gvFIPWldTuFgQ4/bjjvqy4aEMh1MhgWILepdu/PNPYffLynl3
	yodwjIZ5R8e/i6n9ku8A1/xzlXyBBy0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=VUuOF27ozD4kD4vh6EQuP+Eu6UBnPr7U7rDORSfrFt+LaCfIx6Wf/qou5sSCW5MUHto/Yo
	lxkzfUHI59jSXkQ8EUm3gjjIqfTw64CuQ42ROwh9CR1yn/T6MWm3y762bRHnnxDotciVmp
	dDdJ29oWo3RbkcuNtGnaU/GipSfYbdA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 01/20] emulator: btvirt: check pkt lengths, don't get stuck on malformed
Date: Fri, 20 Mar 2026 23:10:45 +0200
Message-ID: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
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
2.53.0

