Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A242EEC8
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283104; cv=pass; b=UMeDoPls6WmtiU4W9B7jtk2hSZsU0TJx5gdPZp6ebfohwUC9myeUXryDWIv6gz7mpzimru4/OTR/LN4En3/vcvrf5yQHWiLOTJQfNvkQSKGjA/N2YV1EmvTftdRvgMmU/n2gfD7FmaDdKkGt6rxycnAiQ8v2+5E8yNYaXEnD/QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283104; c=relaxed/simple;
	bh=19XJKeZfYj3+QoTHJaVwkXUPh+R0Bq1s2EKkwvvQ880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjCgLoR289MFpU3wTsOSvbpM2t/1eDLfkilZT747w0yGXLzLYpmzq7od5ty4EEVyb46ybfv9lZYJGLfjcxhXOxJb9LjtSsLYmeqZHeMi050zYz9Rv5lKDXi+gGqcqTQCDE5Seb1/JOWqQv3F6sypthMOupIjjJXZWY5CVjQq5TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GOGer0Sh; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BeGUQgc3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GOGer0Sh";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BeGUQgc3"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fNQ761L9nz49PxJ
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 14:51:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772283090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=GOGer0ShMVzuxhIhgAqQ2OOpO6DLy0NcpHqIUYzETGi+SaDrnpyxxWoGYpyT1shdaGqZcP
	Q3gYNcX5kKQMOsKh0q6qMO0sLIXpBeDwlku6n8sTxLvzl/6y7rKvIMX7w5Ev6i9EiQMzBV
	x3Bykej4jjM0wtC5QTfiRyfVR1j+8O0GBJ1R+7d3WL9ZQzglRc2MEvs0yPHKLKUVUr03zG
	iS2kCKwbQcnOWJZMBXxh8L6ugl5gUgzA6RjL85NT3wlV7ehyqVQr+U2o3EDSgSv8z7ru3y
	4KICnZt9OXBV7H66HMnf+tB2jh/UCVG22FzGiUSWNUrL5RoUm/lKcach/FiTtw==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ6x4L1ZzyZ1;
	Sat, 28 Feb 2026 14:51:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=BeGUQgc3qEvCaj7JJXEjIATqveO+ay2K6VLJQeOrMVrxJ3NYzHGJuunduPmmrNYbtxsoBJ
	rqxl+4pHJ9kCzcgd/1AkmT4qpqd1+93LyFYQ+pSdoMGTqEFV+A0drDug8zGuvr3i9UR+45
	3gHNJmPLQcc/+rv4ZFeyJ2YWY+1+bho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEg5XwN4AClHnpJNIWTBuEmtoxA1419CCyGBs/R1dI=;
	b=o0AXqVFcYsZqK76rvRnse9ZBxXOH537Nc9bQIxn8xOSzSWDNbVMpBFwfEYg1S0O46q1TGB
	RCwpIRU3aDi7L/i5NzuNJMrWb2j/8yWqYZkikd8ZxJG5jv9vWiqK8XNUX1fsSvYFTM84xa
	BHTB17lDvOXAjJG7EZsIY8Yp79ogh3c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283081;
	b=zKX9W68CkVYA0piqX9t30sRbppEHWyHuAmFPiZQmyx2x2n4nnPdk3jFbvE7gJc4mfmmGqw
	Rx46AmlxC3pocp5gjTjIvvhZFwMDfhcCpr+R2NVGg2dHLCx/n/T8LAYDjoaRhpdfTNqgcv
	NMJzLE99I06l7J4dzVbufeVImuqHsQY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 01/11] emulator: btvirt: check pkt lengths, don't get stuck on malformed
Date: Sat, 28 Feb 2026 14:51:07 +0200
Message-ID: <7c616372ed18c98e892c0e8f322cd90f34810568.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
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

