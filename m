Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA31AB911
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088786; cv=none; b=IH7BGlUAFK5Ysx2ne3G7R0kjCdmr8yqzv/dXCQXTTEiIZpVRCmR4nJ/aJdxx/1gcbMze4i8hjY2y6xcTgS70WZKa2PR1I6SJ5AOmu1nl8k1n9ZlaKt3CnfQjLz59js4lvI6VCaASnHjZLnhc62Vv169jgU58PssPWQ068wvkzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088786; c=relaxed/simple;
	bh=U4KEV9TgE6LjgN4RoBixXnh2IWZFkli8ThUMjKtBNkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyLFEgFL5aBEZtaDJWcuxUfvo4U2clJZcY3N4CUrbrjSIabAlalEgyiyonpbLAvpQseuBjDfzFm95LLXIZPJ1tXAQnK0Kff3H/Oirckqi8bNjPefEVGI0jRM3xoVX9YsrszDgKSeJy9upmOBl3bDHq6EFNyY+hC0IShvsnXbOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68613240011;
	Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 10/12] mesh: Fix integer overflow due to cast operation
Date: Thu,  4 Jul 2024 12:24:41 +0200
Message-ID: <20240704102617.1132337-11-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def15] [important]
bluez-5.76/mesh/pb-adv.c:174:4: cast_overflow: Truncation due to cast operation on "size - consumed" from 32 to 8 bits.
bluez-5.76/mesh/pb-adv.c:174:4: overflow_assign: "seg_size" is assigned from "size - consumed".
bluez-5.76/mesh/pb-adv.c:177:3: overflow_sink: "seg_size", which might have overflowed, is passed to "memcpy(buf + 7, data + consumed, seg_size)". [Note: The source code implementation of the function has been overridden by a builtin model.]
175|
176|		buf[6] = (i << 2) | 0x02;
177|->		memcpy(buf + 7, data + consumed, seg_size);
178|
179|		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,

Error: INTEGER_OVERFLOW (CWE-190): [#def16] [important]
bluez-5.76/mesh/pb-adv.c:179:3: cast_overflow: Truncation due to cast operation on "seg_size + 7" from 32 to 16 bits.
bluez-5.76/mesh/pb-adv.c:179:3: overflow_sink: "seg_size + 7", which might have overflowed, is passed to "pb_adv_send(session, 0, 500, buf, seg_size + 7)".
177|		memcpy(buf + 7, data + consumed, seg_size);
178|
179|->		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,
180|							buf, seg_size + 7);
---
 mesh/pb-adv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 385d81d65731..7a1dd87dc210 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -166,7 +166,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	consumed = init_size;
 
 	for (i = 1; i <= max_seg; i++) {
-		uint8_t seg_size; /* Amount of payload data being sent */
+		size_t seg_size; /* Amount of payload data being sent */
 
 		if (size - consumed > PB_ADV_MTU - 1)
 			seg_size = PB_ADV_MTU - 1;
-- 
2.45.2

