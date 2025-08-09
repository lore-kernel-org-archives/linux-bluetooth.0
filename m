Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D82638BA
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728595; cv=pass; b=bX4sT6kzjMJI7N8hjVMGeNRaiobPzRm4W2anWvVHn3CSnVO5HYKRry1oz5+4C5OHej5qCYIzWWm+t2Sp4vS8OmvVX6i5pxr11eaqVhlvR/RtA/J1OGe+ur4EeoS4ZJph0Q25aNzEbJd/lgKT8WWlbxAvCN7Siz0jDmyU9M4rlbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728595; c=relaxed/simple;
	bh=MdVX1IooYf2rpG5xmqCQlgNIdH6ShVsVp/wF2Y/lorA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGICoa0HTSOqKFHXSan5/WAX0KNFXJjNu9R7Tv9o9fbItYiQfpIq6sZ7nEw6Xkkidt8o0UjMprOudZ0zaHKTtWztQVZm4Dpue1VrcBlTCxDTBIUdp6mBfwoTNyffsm/Nj+UH6IVyQtXcleB1wumGMPRRALGiWQjnktOIjAlmjks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DchFV11q; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DchFV11q"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bzZ4S2WSBzyNC;
	Sat,  9 Aug 2025 11:36:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1754728584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjApTae9mgl6QuMSzf4U+Kc6etXGE2tv4G3fhCrj31o=;
	b=DchFV11q0lEda4JhCDFyBm1FcpQrJ5Yf/opj5dutB4WEEwRfc3HMOERdOdSOA2j9GaQjMR
	fCYmhy2LjkcyYQp5T5bcZOY6n02kEm8D2sky8HUiF0DPkqg40JcqeueYH5gIEyvpXHQ9Jr
	mCi+z8P5JoweqnnwZW6WvaIfTHlXNH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1754728584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjApTae9mgl6QuMSzf4U+Kc6etXGE2tv4G3fhCrj31o=;
	b=vPB1Pjm6lyryPHj26wz65TZafsyvzpPuLqTpiaI0x6ragg/qgc8ma7SFU+aokuTTD+o+Dd
	EiPbihQ8JcTEcEIcypt+gCZzgTTlzD/3vbMYPM2maLNu1zclslW6cjdD7yPjkLrqPZRKhY
	p8FIVN5z5TxHGgWCTBvfb8Cq+GZm2ys=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1754728584; a=rsa-sha256; cv=none;
	b=EeV+3KpPhMSTMw7hFp5Xs9DaOSAeY0BH/U296CXpfZAW0SmkFDMwLJKkNjLJFKb79VHwaP
	TIjGMX/MhHr5D2TR0P40rd05atIwz8sfA1b4aIAaGMFaQCRs3MgInUZ6kqi1Jr0uzN52jt
	tlw4+UhbWZjFOKZgQPjtDO/CckrefHA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established
Date: Sat,  9 Aug 2025 11:36:20 +0300
Message-ID: <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BN == 0x00 in CIS Established means no isochronous data for the
corresponding direction (Core v6.1 pp. 2394). In this case SDU MTU
should be 0.

However, the specification does not say the Max_PDU_C_To_P or P_To_C are
then zero.  Intel AX210 in Framed CIS mode sets nonzero Max_PDU for
direction with zero BN.  This causes failure later when we try to LE
Setup ISO Data Path for disabled direction, which is disallowed (Core
v6.1 pp. 2750).

Fix by setting SDU MTU to 0 if BN == 0.

Fixes: 2be22f1941d5f ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4f0a6116291e..fe7cdd67ad2a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6745,8 +6745,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 		qos->ucast.out.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
 					  1000);
-		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
-		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.in.phy = ev->c_phy;
 		qos->ucast.out.phy = ev->p_phy;
 		break;
@@ -6760,8 +6760,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 		qos->ucast.in.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
 					  1000);
-		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
-		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.out.phy = ev->c_phy;
 		qos->ucast.in.phy = ev->p_phy;
 		break;
-- 
2.50.1

