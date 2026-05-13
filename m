Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B54C9577
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689067; cv=pass; b=G4pqulWePG3Wmd1iOaKXCIoQvlZuaHR3OLhIhqZlEqL5qpGNy4pcWwlqxJg3j0yI0b84iQ8zrr/hcdne/bZ6vJA7ws/OXVqAe8Blbuj8q089NaUk1yirAfcKibf4ywj8CDGHOQMYtiu7uE+277YjZv6xoChgu2dnwMpqeiXSs4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689067; c=relaxed/simple;
	bh=ftAjS6NVLpx2XuGwazQ+wdVdTM5MVIPkciYKzEA6RUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFC1nZEENcfKokaPLdhAn8dUegn26Y1k6G92DDFISMM1uWipnFrGBzRxrZGf8OlL6l6X6y4UnCJaCgiP7QURWIpkprKFB04+oBoUB3r8sUdacK5V8ep40SBtqLusktvmTvLX9HYf3PmACwK29HyitPXBuG76sjP/3MzkrqqPiiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Jd+mDYSg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Jd+mDYSg"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBp0rg8z106R;
	Wed, 13 May 2026 19:17:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2cINonf2hO7faBZEug1j8IPOsKI/gVprU6evT7qN2Y=;
	b=Jd+mDYSgNGIM/krQA2XkAhXIzqADga5hkRIPauvzCWeJP9IRaURxh08GPginF8DGfuMDNC
	FJsU0FThkxkem/5L8ZIi62CjnKNelq8iMh3lA4jvl0exgaVIrrxY7gPlQxF+TIxbuPzIrh
	NTey+umcHcyFEiTkZDxjdWXcC4MMA0g=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689058;
	b=taBIhiEpXGIVhA/nj3LRs2SSHM/MWtcMH/dBZfG9eohRygW1Tr1eskbvFxSrYT3Ta7sx5z
	MXiH1cI1ZLmIJF64hBONIhV5DDSMNcgscra3kE8K7XZV4inOls94/zngRT1w8aPSfcMcA7
	WSxnLQTmzTBLxsEhda5PVG8KgNirAaI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2cINonf2hO7faBZEug1j8IPOsKI/gVprU6evT7qN2Y=;
	b=JodMqjnvgVrgFfzwzRwFjxSa11iy0woVi+6T4UxuhYIBENSEPjvS+dqEQ8U7bCP/UVRsgM
	tB5fcIv/96OzoPPqoH+nR8xOfcg1XsS9ubolrXPAdZbFbnvrgpjsIZUNJGKTpR06Zmerax
	b717FIiEHp7ZRHc/Pg2fklpqRNoEN5Y=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 03/16] emulator: btvirt: support SCO data packets
Date: Wed, 13 May 2026 19:17:20 +0300
Message-ID: <f1e759a2f934bf9faa972fd748d98bd8860e68be.1778688966.git.pav@iki.fi>
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
2.54.0

