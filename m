Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D336897E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041081; cv=pass; b=URK5OEVFNp0uDLG9w6m4nCH68luMdXnCUMTa1ReX/+pGbiaTJzARNJNNTUTIZXqyeWZFvKUA1cvfVWq5kA13PwKf/YpCE5GLUBqrEHTxorGiO7OlJGENfU/fC2pJ6A56PcX5BNpUCp10AmzQkVmYgqZJ8Bom5zfu045q0coTh4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041081; c=relaxed/simple;
	bh=rBas2CTtC7uZdPRNmZieZGAJpo3pTgwWL+2jVPGrEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gotTrkreyv8WwlPAxidko65GvTI923T0lEkrPj2ZnlK/J/O26AYKMdr0NxI4F0NFbolWt9H3CpTOdrDJGQFW20EY6TcvK/PsvcNkTiR17yVM4P5H/B5wjkqfVE8G3HksJDI6Ece39RaFWBSca4dWr6wsdmtu2sYkFy0EQwH15Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Vv2pfg1M; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=W+DWsV3s; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Vv2pfg1M";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="W+DWsV3s"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fcwGZ5YKrz49Q5V
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 23:11:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774041078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=Vv2pfg1M+SI6iNINw6muO0SFZai5Y1rAf05S2bio7sE8q+1b5KN7vC2R2G2UXdXIkBnRc/
	/xhkmwNo66ajRyDh5X8g4S2iSSXESdwoRPeGvHWrgVbkyNdoHidTOmxIJLC0iDDTiMa+fH
	4wMD1PHSXmg2DtRL8ypc4+VjB3Xi/e/3uTMLyNH5W1LhrMKZY2VFElS+WirL373Os5ws1w
	Cl05sPQVKPxvFSfhzIbySi48cuBohmbi52G12iq5bu8CM/bQR28sWMvoq+SWSMBOOljtCr
	4a4hou+oSE//r6386Fy2X99tTbT3SWkqjfmeEt4258DQcBUn10ydj5JxgrOk1w==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGQ6bswzygB;
	Fri, 20 Mar 2026 23:11:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=W+DWsV3sIw+UjGBk8O+WbAOCElbvFHy6h56zsnA2jaYshAI5wiLguiNDROIaquvkl0CfGW
	tROpfIQ2t0+U0QCZh5CMd+t4zwRrohJrrNa11OzaYE01Mhn3PE5/NedabZm9b+aIS+zJYh
	TZy39+BJ/ShkagpsEkYLRPzywgum4bI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041071;
	b=DahgnxnFsdQh5yS86zorFexcodekIAXG2RA8GxlBQbA9Knk04zibHHlzIBOsntm59lVjoz
	xs3JtudUwllE5tD96bLpZ0754hjIva7xmFiCuqapqp+3dK4LaNTIuu8necIZyvDRZrt3mn
	HePy+7Xn2MtzZ4lfi6PAhVlv9kmEnak=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=Zfx9Xj8wmVPi+TXAQXzwx4THA4ycje0itla0xMU9JMJpAZkU2XZ/3RwBqdATXTR31G9Vdp
	tY7/YKrWUtithQPIwQ1RKOS6j7p7vl33JcJpA8BBEn1rxoXe8DMHUAkswfP3uvnhMfYfa5
	THmMkwvGT2H5++U36BEQqTd6hD/5oRE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 03/20] emulator: btvirt: support SCO data packets
Date: Fri, 20 Mar 2026 23:10:47 +0200
Message-ID: <c82fd6dcf6d25997499ec4734770b84bbc4cb4c9.1774041047.git.pav@iki.fi>
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

