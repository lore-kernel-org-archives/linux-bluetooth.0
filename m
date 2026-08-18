Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DC3D79FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050726; cv=none; b=UbbKfKbcyzh0atPt3vB8vWzDaBdzW/bg33AdZNO9xffa0mAAZd3zqmZ9kodOcsa3Iiv2e3xrSvHSVyT0wP9jjtpiz+R3o5mZusP4L/8Hu9z3e4sync7vhVeBEXj0RxG84XKI4tGuNqQ2Gbfr8wzeO8pDepQTKJ5Gk2o0SO5W70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050726; c=relaxed/simple;
	bh=l5uJ+FqrIZxVY114n2V0iQ2cMeR6YX4hiLW35O4StlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZEJzCAAEufzVM2mpIceSqbBGtsguao7Wkfqx3DrV2FqNiKLFtvPbHM1mHU9bTfn7LaNzHbfyNOvA6M1jahJxq3Kth6v7J/eQyNrP9ln95MU+fh3QFgQAFi7vTrtdYUxIPOTKIdyY0UsRNMbdcuiOfRD35v1Y60L6AwyUbxv0qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 129833E9B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 10:58:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] avctp: Fix typo in comment which contradicts the conditional below
Date: Tue, 18 Aug 2026 12:58:21 +0200
Message-ID: <20260818105827.600893-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEXAnxJabMAZCofs6D+KoFNz2JeFxG1r4HdAGfbLyd0W1eDtKQCMHVJPXbhezaNXW0LCTxYg2atK6quz+8C4i43pcdmyKNzIe4eS2RZvkQ+ZBSnrXHGTRsZdevKFlTDeScfD9Ve+M9BfWFqf7rbjtkdXLbh5W0Km+XyviamPirs+/AqdyJ+Qk7LdIT6S2J2B6oB5h+nksmGqQBTRJkW25nY9W/wfRYQpUIhd+gzNEH7Jxxue3LWWlZIMzJBeCYCqSYmBSzUZlwACE2uUiHbGqR3mU+Oja6PtI4OpgolHo7W/a1DlL44RnxYB3LlqIjUB2Y+Z/CxrOqebW9gkzAL6tVxhvMeMbnXPJWN1iLsCC7DyGb4YmFngdPxKsitkVI9tUgUQN78qY//RfJGE1xptfcXPjZXlW5VM8gFqE9r31BuqWZku5D28nfxZtuCQBexi6G8HBpHI2UPuhpmLLRizdQSd1Y5UWoi7LakRZeJKlsP7tVarFT53l+EVgkRMLl0ZI/0vqsaNCpAcPeRH3HzjKcKfgsvgU8tR7uxSOUdd6v9aNBgDOcq0JVHlbzWGW1PNywn+WnSaodXvhnaytutjBKMS4eXH+X/mZ7d5DZb1Yv9xe6JVMbkJHOQ/NQ0/ktpkyJpeHWp5YlndPtIU0lgeXR6HfnflQTalqIfIX5woTC9OA
X-GND-State: clean
X-GND-Score: 0

The comment says "If the request set a callback send it directly" but
checks for whether "the request did not set a callback" using
if (!func)
---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index f20e08c00ac8..336511bf9612 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1632,7 +1632,7 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 	if (control == NULL)
 		return -ENOTCONN;
 
-	/* If the request set a callback send it directly */
+	/* If the request did not set a callback send it directly */
 	if (!func)
 		return avctp_send(session->control, -1, AVCTP_COMMAND,
 				code, subunit, opcode, operands, operand_count);
-- 
2.55.0

