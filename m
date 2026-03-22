Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641022FA0C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215021; cv=pass; b=L0Y8Q7BEm7WmEAox7D8vzlMnMkqZR4OoAkruh6itgAHhsXVSmFRuyqZ7xUbLNaLjXJfBDqMbq0QpjiywHWzF9GEWtsouNly+EVPugSNdWPcy1l4wBwLHOqcYdAUk+q5LtsqQrCOAKJdQ0LcauvKoCDtvGTUNwPlayg4IvoW+c14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215021; c=relaxed/simple;
	bh=19XJKeZfYj3+QoTHJaVwkXUPh+R0Bq1s2EKkwvvQ880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOc7YNOiZcbP9AzGkqCC1juN3T6eJogy4v/2Ew7XQeD2HzQiVSBvSszSVVazBTkcfONQU3OFV6aEdYceHvXTG9uxzOuxghRybv9k8EVB+fCf3abSZGztykO0oEtzW8WZlbLtd6C4A9J8eNacD06hTaXAicoPsxoK0ZgnpNrBJso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eTHp/27t; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eTHp/27t"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bS1xnJzyc9;
	Sun, 22 Mar 2026 23:30:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=eTHp/27tWBBB1hXge+V4dX39E4BKrZpU4iNRg53+1ZQShJqCsNFr+i5alUKXEh1wW9exNP
	RkCHBphBBeRcY5qUXpYqJ2dCveknjWHBJXKtC1xiENQ1FuMTwoY6c1u5Y7FNxdrjKrJ7Rq
	fAjjzD1HSlrMoPz4drHSLiLZ8p6kvrQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215012;
	b=jV7SU8eQywS3KlOQh7ID7OMwtl8pAH28JIOSyJMiDObyggzRXrUTUZbln7stffEKE0a4Qc
	FOCny+67V0winlhd5GDmsD/JFOMmq6K8flFSWjhvFXz2ogEhjZipkWlNmBXIo8bRYNEPCp
	tBc25gzl7b+vJWSA6WPFrByQntOER+o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=IQPFxiWTShwn1myl0wQz3GJL2dbm+Cbt4kHOSpx/x/7N6mJYskShgg75kVf4kWbLHfFesJ
	04qho/vT81w9BNr7Il6ljRn+x28nxbUpIflR6F6JFzMUcqXPOYx60bt3sB9fxYch8suZET
	O30Bj/v/4sFPNynn25a17QQvsdxJ9e0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 01/20] emulator: btvirt: check pkt lengths, don't get stuck on malformed
Date: Sun, 22 Mar 2026 23:29:50 +0200
Message-ID: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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

