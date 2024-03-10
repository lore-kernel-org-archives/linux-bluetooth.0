Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8461427B
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Mar 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099648; cv=pass; b=szHwP/1MdOSElU6SeSgzs7bLekhR8gNhc6U3jXRWUMC/sTyHlRzY66LyBLEG9X0c//JFwiuHft2XAhjaE/A4DTr0SIuzpiaFfnxcd3R1BnA1N+uHJMhSG/WIugnNIzlM1+lFqFzo2PhMSfpn5SsU/jDm4jNseMP06pxjlJAJVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099648; c=relaxed/simple;
	bh=1gJ6eD7jHqF/9cpcmV4U8c6aHmntJah8j4QRPjAr8mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs0XQpB9fJs2QwNY30T3NRtjnzyeSv25NRWpXSCryl3F9WPdjAD3Kx3DendX+z8z0yaj6VuGr0CH6o/CJrf1tejziPdtkrhbx3O76DaiTwrXgnDwnsC4RDEEaZUaayqMSnZNgDq0MudEj87ZVBTh0VqwDWQ3xUWsUMgnCYimtAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pGk7UoZ0; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pGk7UoZ0"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Tt9HS2fwtz49Qk5;
	Sun, 10 Mar 2024 21:40:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710099636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BND/3M2iOrI7hoH0XOVmp7ZpLj2z/R7OfosAY3u/lK4=;
	b=pGk7UoZ0b8mRnXE6OIwVo6WZoRqKvqLLBoxFbeXMOgdOwQd3PACwSOc3fAsAs4ZC6fDb1Q
	9SOrqtpizZDRTRANKPWXPwwusB6SyDENb/NCqHPZH70N26HuYi6pS2WHBsQnvgwZhv4pal
	PS/1uWWEnKr5HxgSAoMMQkOFJnSsfOtIGV2OarB/BWmpWyVyu329tBtQ2X6Nip3JIyrtiO
	bXHgp9XRw1uizK7LTp4WJZK6ELf9rD1MIikIfjNJ8CSyj3OFU/VYu3YKFnzUvd6RWD+h2A
	Kro6uf5w1mpZoG+LiS+rsI3kqV9Aminv3QQmCMSYntBbObfhSnGCnrr2wtWObA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710099636; a=rsa-sha256;
	cv=none;
	b=jfgs5vDULfIS4VO/vJst17QtG+AGQ4xRoe0XkdUTuKJZ/zn3ouqLZT9xdVXLzN+0+9ldLb
	lc/TEtby0v49pAqKucVxPxUq5AR4jlu5K2yGDw2uK1r1L7ep5G2igpXgugeLB2a5/rpr6x
	+cTzlmSX7upTBiVQm/HgvtZfMc8/EbMyPF7HUJx1SJtgv84W5GUuKky5H34P9VTeG1geaT
	xsBHjYt3PcVv57+I5iXvd/mMY/k7KaVBUsDeR5Xl4J5zMTk6F3O+guXJ+XsZzlO+wwwOS8
	josdn7n0au/2ENsrSP7dY8o2C1QAnoxhZYyqpMu+Kn0WSIOFKo1AJfSlQyvwhw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710099636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BND/3M2iOrI7hoH0XOVmp7ZpLj2z/R7OfosAY3u/lK4=;
	b=BPTxfQRnvjw9c1QiZmwVXmOhooXqPtt/UvdxAz6UOXfuZ8QSSdK5bNPDlPkiScgjEu4H05
	WwDWy/ifFgLtHB1fK+AG8bdWuRykUe2N8ZbPn451T1+Gt2OhhezkUqr6lQRPkYIrN7c57X
	zXnXv/rINnpld9g/JQIF/X3un1hyFJdXeu3COuguJOlKcUmRZrUCLkH18y4kvNp3Nq3HBj
	JPcPjjTo95JYvlPlrh3nP6UBzb78g00Tv393gjpjTLPX9Q6hxyC1T48L/EgK6JhlSGMIvk
	sIxh+eEve1q92ZXOUnbhlBJoypGDwu+8Ne6n+2dEUTOgsKDk7wM7ZxkIcZBdQw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix setting io on linked stream
Date: Sun, 10 Mar 2024 21:40:33 +0200
Message-ID: <09755693e7900757286d3dc9fd181f8591c21a19.1710099560.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the second bap_stream_set_io call to set the io on the linked
transport, as it's clearly meant to.

Fixes sending duplicate stream stop/start requests.

bluetoothd[588207]: < ACL Data TX: Handle 2048 flags 0x00 dlen 11   #492 [hci1]
      ATT: Write Command (0x52) len 6
        Handle: 0x0098 Type: ASE Control Point (0x2bc6)
          Data: 04020505
            Opcode: Receiver Start Ready (0x04)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x05
            ASE: #1
            ASE ID: 0x05
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37fc1de4e..fd99cbbca 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5603,7 +5603,7 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
 	if (stream->link)
-		bap_stream_set_io(stream, INT_TO_PTR(fd));
+		bap_stream_set_io(stream->link, INT_TO_PTR(fd));
 
 	return true;
 }
-- 
2.44.0

