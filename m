Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FC346FA4
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392816; cv=pass; b=Fk5ADz+y6IM2/PjiXDXW1pyGosAPG9MmUvZM/kr9nbIT9J0m0/bsTEuTGNi8JxS7zWui7z4iwuCl6I0nHJMz084wVADv1e2Bjy719h0QH1jwp/LLhXgeZDUYVghdMB/MoqcY8vMK+UCOjYWa4TGMuorrBHjtFp561ooMwwNiN7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392816; c=relaxed/simple;
	bh=rBas2CTtC7uZdPRNmZieZGAJpo3pTgwWL+2jVPGrEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tlh6uZt11iz7x4szhRLaqVlvqA7sR/Zq7+M7Iw7+EOzMn+UEvFTFjfUYieTuJzvSUhMIx0z7HcjWvZ+36DNMp9K+XN6ghsMQkI8WD0/Pf/jiuKs6O4Vov+GiKmvudiMPsdFhkmxzjN2otDVjqJBbKMaOyF1jc1nn0i1J4y3FboY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pFuF1yHg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pFuF1yHg"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9M5hjXzyxJ;
	Sun, 05 Apr 2026 15:40:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=pFuF1yHgWFqCSewjV0Bqx07k29HkgrBsuups4PATolSkTuFQMnAniF1H4ZZ5h48oG3Oj5P
	eyPopXDtNkPE2AAH4YTjXVat+rAZzmqeCNjdjW2zfS3Z1qnmMtDagklvCXnB1QhA4VbYz5
	UCazdwt5wZ7qqDw+wofe99HUUh3ynBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhhQbQzFUc4xsOqmtbsQ/8NMoxxnzpWr9BWGabb1kxg=;
	b=YkCXW+l23Bsa+5MeaeMYT1XzssroglI6ryLqG9pYYv2isKFzpTa97Nr/+C4Kkhpi1wozAw
	ulyfV3k8mgaCM0y9kcA3QnABa6pkaFlm1je6Wu5//G9wbYSBlZc9gDUSkZ/b2mVfbg0wf7
	ul5NzeXISCZa9j1H2YIpkdTkthQkDxc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392808;
	b=gTz1dcG62x39CJlwhHhWq8zV1IYO0Du/skatlzTDIu7Y+i/CmXFpaHyQoCqAvo53WtZug/
	kJJy4r5RKhKuulUxyti4wlUzT1ALUyp1UXAEmHX+FEM3Yt37LsDk5Me3CSi0wZnXdDmhO6
	I+OLswduu3GyRWaWIfzvgKjU7UW/zDY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 03/20] emulator: btvirt: support SCO data packets
Date: Sun,  5 Apr 2026 15:39:44 +0300
Message-ID: <7695defcbb1d25ed4e6b082a39e45504f713f240.1775392680.git.pav@iki.fi>
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

