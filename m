Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B3253F3B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386350; cv=none; b=kO/fzZs7xJtPOQnmQKYBfMx4v3Opfk1BWF6YIW1Etiz2i7ljTf3DrpVJhm5JKjdXhf7uR45Qmywmh5Zo1cSVwWKa3JtQv6OkHgIKbugK3Gh0RGFbbUmoKtRsknJ3zFZTnzdb3bNuxOyeI6mX3H6wZdiTOFOox+xEzIJcNSSavw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386350; c=relaxed/simple;
	bh=P03TerpUo2C8H3Y3oaoU0O0hXqkJDomP8ZmsY3vscXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZYHRX8q2tlegG46YdtbO6qDLOtKk9D6nvuSG6KJ26b54FTgo5Cux0N+5z2laZ6pz2YheZhInA2CWSNzkuqV3Lnns0PUc+Tnc4dYyFr5BGm89OcEnDb6Azp/f9z8G6PXup/x6bko+szDBMHAXZeR42XSV/7Gb39Ef+s4vXlZvmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b05GHfdh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b05GHfdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742386346;
	bh=P03TerpUo2C8H3Y3oaoU0O0hXqkJDomP8ZmsY3vscXA=;
	h=From:To:Subject:Date:From;
	b=b05GHfdh+k3gU5iRA+QjZtB4ioIwGwEt9AKG6pkMJPSmdK6uTJ6cqYRxAnT7gxKHr
	 4S5qhZOua21QAfk2jWwkzei6yv3cspKJC9kQRlwsEH2uhhFuS1hX1wA6ovD5gUkerr
	 islEE0spompzBNwSd8GERaXdE54gii0ppeI0UNTkS0gms3jTlhO5rrUD3EO5f+pVRo
	 QvDCENaeDG/be7Y1kR/Agwnny8GyP16EgfskAjj7+cDttdE4UZbRaDb86NPD16Faog
	 fQWIQ9eVZCBtDlpL5IfFd2K7hmAHV1rCWgr2Wyi/fqZNzaFOK97i6iJ/WyHtWZ6HCQ
	 t8XGJgIw35sQQ==
Received: from fdanis-XPS-13-9370.. (2A02-8428-AF44-1001-9F24-9328-Ec9D-4c39.rev.sfr.net [IPv6:2a02:8428:af44:1001:9f24:9328:ec9d:4c39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CFE6617E0848
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 13:12:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profiles/avrcp: Fix PDU for SetAbsoluteVolume with top level bit set
Date: Wed, 19 Mar 2025 13:12:18 +0100
Message-ID: <20250319121218.166878-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is required for passing PTS test case AVRCP/TG/VLH/BI-02-C
(To verify the behavior of the TG receiving a SetAbsoluteVolume
command with the top level bit set).
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 65f1adbdd..8d1e03b93 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1793,7 +1793,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 		goto err;
 	}
 
-	volume = pdu->params[0] & 0x7F;
+	volume = pdu->params[0] = pdu->params[0] & 0x7F;
 
 	media_transport_update_device_volume(session->dev, volume);
 
-- 
2.43.0

