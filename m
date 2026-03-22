Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63936B07B
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215021; cv=pass; b=UJYxiA1HXFyDiZ4Znnfc9KeT97ZYntU01L/7Asxq+8ncVct8xUzwNePLPl68UA2R7ehw/5GAI0hHCPKQ/ZzX3eh/Ef/2IqEy4WRgUfLoFMPv695tzj7PFkqvlSQka0V4eb5JFhCa+MXRBNlV8WK5jRXqNBNY/Okg6UA6geNzgl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215021; c=relaxed/simple;
	bh=rBas2CTtC7uZdPRNmZieZGAJpo3pTgwWL+2jVPGrEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quiLAZSLKl9+UVYC0htaNFMlrdpVskHGNoF8u0R6slDbrpI8Krumi7NpfvJ2giWG6sbb8lMpYQwKozGUeubWsnjUESbcOqxsPVYKH+pHA5OQXivmTKrttsLWfk7zzfbK25HoY7b+5Kg2OjqgjJsF0OGYh/Wz+sBuiHYTlwTnpQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pKVezhaG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pKVezhaG"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bS6FMSzyw4;
	Sun, 22 Mar 2026 23:30:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=pKVezhaGa77QnTMjnoTzryJ8b6JAXHyB8IVuLg10bgvJ7MfSMMc7Z4cZJghM4+QMAk7M4+
	35zKBQ0PczMaQOIZLKnPeWiZmXL547+PfLtp3hy1pCMZQtZK1kuVf5hmpFPl9ac8dBzSRd
	7Oz6bjQaI+Hs4PrQrIssY5M5LxIk3kY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215013;
	b=m7NKQ6k4bTENWkeVCabbFAumQXQCDTolRa1/9ntDUJwb+8OImm8fHN+RvYfFe4Cor0ZXRL
	t8SIou2ChC8K1a9zmb36dO8ynu3j3/gp2Z3FkDRalnyXiaAlQrL8An5NVDiKTJ3LqwP85C
	O/jQkyVuGIWzDUDuNU5QnL61zPQv5TA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=SR8gO+APgOafCiDxnK37K8diO2g2nqnR5JWsEe676EL0IsH9CgWUg97f/j6TocRcGU2PeN
	han2H/AYWXwf8/lcV+SBOcnQCPT/nTCrVXEFCzdHBzjdyEf5IpkgEA2t/5ASgaon4uqr6N
	d1Nt+qU0R3SoVNOIEa8wDUF/saQSFmg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 03/20] emulator: btvirt: support SCO data packets
Date: Sun, 22 Mar 2026 23:29:52 +0200
Message-ID: <c82fd6dcf6d25997499ec4734770b84bbc4cb4c9.1774214693.git.pav@iki.fi>
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

Support also SCO data packets in btvirt.
---
 emulator/server.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/emulator/server.c b/emulator/server.c
index f14e14cd2..7790867b7 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -119,6 +119,7 @@ again:
 		hci_command_hdr *cmd_hdr;
 		hci_acl_hdr *acl_hdr;
 		hci_iso_hdr *iso_hdr;
+		hci_sco_hdr *sco_hdr;
 
 		if (!client->pkt_data) {
 			client->pkt_type = ptr[0];
@@ -156,6 +157,17 @@ again:
 				client->pkt_data = malloc(client->pkt_expect);
 				client->pkt_len = 0;
 				break;
+			case HCI_SCODATA_PKT:
+				if (count < HCI_SCO_HDR_SIZE + 1) {
+					client->pkt_offset += len;
+					return;
+				}
+				sco_hdr = (hci_sco_hdr *)(ptr + 1);
+				client->pkt_expect = HCI_SCO_HDR_SIZE +
+							sco_hdr->dlen + 1;
+				client->pkt_data = malloc(client->pkt_expect);
+				client->pkt_len = 0;
+				break;
 			default:
 				printf("packet error, unknown type: %d\n",
 					client->pkt_type);
-- 
2.53.0

