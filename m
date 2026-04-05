Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EA34753A
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392816; cv=pass; b=NrEYlqx9DmumoEvDIklGZOEf1lVR5btyaGmUysN4WYmCKkTg/4N+GXrqgLyAQmU24QLvT5PScYSPpwN7trivbl6HYk/24s5HjOQNAW6ggjNVzmjhmhSDEE00UGnuri1KtmhfHgC/MZCJLEyOUbp+PAsWdnOv+18qkz7QXEhK9zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392816; c=relaxed/simple;
	bh=19XJKeZfYj3+QoTHJaVwkXUPh+R0Bq1s2EKkwvvQ880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ophbiwW0z5b2JhpMN2H1hOOwhVZVtmUmrmpOhhP8J6EK1Pqs1iajzoA+67hNg+piDxbvs18awh8AuYrA1yd4iPBW9nhDbONgpCB3oW8ZY3Ikqq2gfTJMe8tBaRfL6+Pzsl5NNaqNlqQAXD8LWKojWHzTo/3j3km7Cch5ZjES1wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=F2w39b4o; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="F2w39b4o"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9L6cZDzyZR;
	Sun, 05 Apr 2026 15:40:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=F2w39b4o/Y4sBAc5NZcZS2HzlnBvVinyz8amcq/2PZaqmSuazlXUKUhZB3H/ICEuq+uTTg
	Yt2Z6JdFEAgJX2Xzkx2z9hNL3A7+rhg+gVh1z0k3Ir+4RpIHf53XRq2XjX1LN63Tjk68SJ
	u89UkQtC2WADOtqTqNUb/b+SUR6GCR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=FJOruaAprOecu4K1ApeSNvT3ROFZrfMPiyz9Wf6UxMHT+kOQRY7aoWUVKBSOOphFPlbcFi
	A5eNe4i1z1vZHuCRa6APFZtMAAK1t3aX8nofCIUqvbk1I8AKvqdP0ljDG2gM3hES82u1Z6
	4jprF7M9uBZVcPUS+0q5CT/dtMKYIvY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392807;
	b=gep2fYOZ4QVa3Tj2564KEht3AQDxlrhgNkwFhvkIDtt0NwtO1vXy1Lc3c+rcRmgLZyTLPs
	HVfZoVgwTbMJ02sIK+KrPqfcVvUc7tEp9eFvlPMWWp3gEUmAkkV4VU4lkxV0Z+aYol3ORl
	BtAF37DCZP+CQpORTVQzBni2iefbCrM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 01/20] emulator: btvirt: check pkt lengths, don't get stuck on malformed
Date: Sun,  5 Apr 2026 15:39:42 +0300
Message-ID: <8b539120d408fbc137ded20cea06e179c1928430.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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

